From: =?UTF-8?Q?Jean-No=c3=abl_Avila?= <avila.jn@gmail.com>
Subject: Re: [PATCH v3 1/3] Add Travis CI support
Date: Thu, 15 Oct 2015 11:02:44 +0200
Message-ID: <561F6BB4.8080202@gmail.com>
References: <1444586102-82557-1-git-send-email-larsxschneider@gmail.com>
 <1444586102-82557-2-git-send-email-larsxschneider@gmail.com>
 <vpqwpurx2j1.fsf@grenoble-inp.fr>
 <1B50DC8E-45CC-4D9A-80A1-6391D762A81C@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, johannes.schindelin@gmx.de,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
	Pete Wyckoff <pw@padd.com>
To: Lars Schneider <larsxschneider@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Oct 15 11:03:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmeR7-00037w-Dh
	for gcvg-git-2@plane.gmane.org; Thu, 15 Oct 2015 11:02:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752031AbbJOJCv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Oct 2015 05:02:51 -0400
Received: from mail-wi0-f169.google.com ([209.85.212.169]:36646 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751951AbbJOJCr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2015 05:02:47 -0400
Received: by wicgb1 with SMTP id gb1so262894755wic.1
        for <git@vger.kernel.org>; Thu, 15 Oct 2015 02:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=M6qvfTmASLP80iBec3yY330E3qxGmI5mK8V6Kl1UAX4=;
        b=BY2T802MZtqHphla2AnK0e8UfJJZ3TX9z8YWqIfs4XoEQGxiLN/dAwFpPVTUFG8L5r
         Wb+1GzXOoMwCgBHNM3s6mDBGsk/k36nYgYWMylh1l/O8OZ4/5lTGzZi3dhK1RsgtE/Ec
         uqfqByhixgTU34FSku9uCMGLN3ZTR/p8xYGp68QI3WeJEs7sfW8ywTutIeFNClCcU2V4
         VOLHRnoM151Uf7G2aIH16afCQupgzVpiWum4KvviDwna8uyUolEpf7FEsNW2O0Yo5ptL
         1fgD32fhQHMhB2srMP1enwXEx1QfC8YsDJi2OFCWfe77XY++VxsGHnpVyWM3kPyw5adB
         Y3lg==
X-Received: by 10.180.19.41 with SMTP id b9mr9112697wie.71.1444899766158;
        Thu, 15 Oct 2015 02:02:46 -0700 (PDT)
Received: from [192.168.1.75] (static-csq-cds-097114.business.bouyguestelecom.com. [164.177.97.114])
        by smtp.googlemail.com with ESMTPSA id gw8sm10554313wib.15.2015.10.15.02.02.44
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Oct 2015 02:02:45 -0700 (PDT)
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <1B50DC8E-45CC-4D9A-80A1-6391D762A81C@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279655>

Le 15/10/2015 00:52, Lars Schneider a =E9crit :
> On 12 Oct 2015, at 22:20, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>=
 wrote:
>
>> larsxschneider@gmail.com writes:
>>
>>> --- /dev/null
>>> +++ b/.travis.yml
>>> @@ -0,0 +1,46 @@
>>> +language: c
>>> +
>>> +os:
>>> +  - linux
>>> +  - osx
>>> +
>>> +compiler:
>>> +  - clang
>>> +  - gcc
>>> +
>>> +before_install:
>>> +  - >
>>> +    export GIT_TEST_OPTS=3D" --quiet";
>>> +    case "${TRAVIS_OS_NAME:-linux}" in
>>> +    linux)
>>> +      wget -q https://package.perforce.com/perforce.pubkey -O - \
>>> +        | sudo apt-key add -
>>> +      echo 'deb http://package.perforce.com/apt/ubuntu precise rel=
ease' \
>>> +        | sudo tee -a /etc/apt/sources.list
>>> +      wget -q https://packagecloud.io/gpg.key -O - | sudo apt-key =
add -
>>> +      echo 'deb https://packagecloud.io/github/git-lfs/debian/ jes=
sie main' \
>>> +        | sudo tee -a /etc/apt/sources.list
>>> +      sudo apt-get update -qq
>>> +      sudo apt-get install -y apt-transport-https
>>> +      sudo apt-get install perforce-server git-lfs
>> Sorry if this has been discussed already, but do you really need the=
se
>> "sudo" calls?
>>
>> They trigger builds on the legacy Travis CI infrastructure:
>>
>>  http://docs.travis-ci.com/user/migrating-from-legacy/?utm_source=3D=
legacy-notice&utm_medium=3Dbanner&utm_campaign=3Dlegacy-upgrade
>>
>> No big deal, but getting rid of sudo would be cool, and documenting =
why
>> it can't easily be done in commit message and/or comments would be n=
ice
>> otherwise.
> I would like to get rid of the "sudo" calls, too. Unfortunately I was=
n't able to achieve this so far because these packages are not white li=
sted on Travis CI (see Jean-No=EBl answer in this thread). I tried to d=
ownload and install the *.deb files manually using dpkg without luck. A=
ny idea or hint?
> Nevertheless I don't think this is a problem as Travis CI states that=
 "sudo isn't possible (__right now__)" on the new infrastructure. They =
need to find a solutions because I believe many projects will run into =
this issue...
> http://docs.travis-ci.com/user/migrating-from-legacy/?utm_source=3Dle=
gacy-notice&utm_medium=3Dbanner&utm_campaign=3Dlegacy-upgrade#Using-sud=
o-isn%E2%80%99t-possible-(right-now)
>
> - Lars


There's another hope. The requirements can be installed in the user's
HOME and cached between builds. In this case, no need for sudo.
Obviously, that rules out using apt and dpkg.

Jean-No=EBl
