From: Boaz Harrosh <bharrosh@panasas.com>
Subject: Re: serving git with both "git:" and "http:" and submodules
Date: Wed, 14 Jul 2010 18:58:50 +0300
Message-ID: <4C3DDEBA.8010509@panasas.com>
References: <4C3DD7EF.6010805@panasas.com> <20100714153900.GB1583@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 14 17:59:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZ4MO-0004PE-EA
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 17:59:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753688Ab0GNP6z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Jul 2010 11:58:55 -0400
Received: from daytona.panasas.com ([67.152.220.89]:1580 "EHLO
	daytona.int.panasas.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751686Ab0GNP6y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jul 2010 11:58:54 -0400
Received: from fs2.bhalevy.com ([172.17.33.181]) by daytona.int.panasas.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 14 Jul 2010 11:58:53 -0400
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100430 Fedora/3.0.4-2.fc12 Thunderbird/3.0.4
In-Reply-To: <20100714153900.GB1583@burratino>
X-OriginalArrivalTime: 14 Jul 2010 15:58:53.0322 (UTC) FILETIME=[7519BEA0:01CB236D]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151000>

On 07/14/2010 06:39 PM, Jonathan Nieder wrote:
> Boaz Harrosh wrote:
>=20
>> So smart people using git will just do:
>> 1. $ git clone git://my-domain.org/my-tree/.git
>> 2. $ git submodule init
>> 3. $ git submodule update
>>
>> And all is well... But smart ass corporate people would not use "git=
:"
>> protocol because of fire-walls and for them I have a dumb "http:" ex=
port
>> as:
>> 1. $ git clone http://my-domain.org/trees/my-tree/.git
> [...]
>> So my question is: Can I automate this so people with "http:"
>> clones are not forced to manually edit their config files?
>> (Some users are just not up to it)
>=20
> Sure.  For example, you can ship an update-submodules.sh script
> to take care of checking =E2=80=9Cgit config remote.origin.url=E2=80=9D=
 and
> updating the =E2=80=98[submodule "sub"] url=E2=80=99 configuration to=
 match.
>=20
> Of course, even this would not make
> 'git clone --recursive http://my-domain.org/trees/my-tree/.git'

Right

> work.  If you can get git-http-backend working, I=E2=80=99d suggest u=
sing
> that so you only have to deal with one url.
>=20

Ok I'll dive into "git-http-backend" (any pointers). But I thought
this one will still serve me an "http:" url. Are you suggesting to
just drop the "git:" protocol? (Since "git-http-backend" is just as
good, through http?)

> Hope that helps,
> Jonathan

But a script for users might be a very good idea. I might even add
it to the main Makefile. And make it totally transparent.
$ git-clone; make;

Thanks that actually helped
Boaz
