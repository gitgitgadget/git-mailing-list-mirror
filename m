From: Artur Skawina <art.08.09@gmail.com>
Subject: Re: Find out on which branch a commit was originally made
Date: Sun, 19 Sep 2010 18:38:28 +0200
Message-ID: <4C963C84.2050608@gmail.com>
References: <1jp2pkw.1s4r5br1xvl05eM%lists@haller-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnI/IEJqYXJtYXNvbg==?= <avarab@gmail.com>,
	git@vger.kernel.org
To: Stefan Haller <lists@haller-berlin.de>
X-From: git-owner@vger.kernel.org Sun Sep 19 18:38:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxMuS-0007PP-Ga
	for gcvg-git-2@lo.gmane.org; Sun, 19 Sep 2010 18:38:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754911Ab0ISQie convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 Sep 2010 12:38:34 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:50125 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754876Ab0ISQid (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Sep 2010 12:38:33 -0400
Received: by wyf22 with SMTP id 22so3650101wyf.19
        for <git@vger.kernel.org>; Sun, 19 Sep 2010 09:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:openpgp:content-type:content-transfer-encoding;
        bh=NHQcPwMQwKZXAr+n19zg4exPbjO9SgGYu5vpDjZ7pDk=;
        b=EER4x/akCFEjR4eNtrEJghMRfJnDn3M7L7AqAuWegakh0fBv3hbGfW4UzMuF3tX4MP
         1wb/9MnDGlwRMbjsuEsbSt9r9AR1giZr6KMnWk6enQMbZblEWCA/0g1W/lWMp6Kn54rK
         7Q6Qp1Pw53+eQx3R1Z/Cvkh0bxtLa0cb09d9A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:openpgp:content-type
         :content-transfer-encoding;
        b=rCdshm5oY7Mrm9ptYBnqMjsVX4ATu7Uf9UE79UgN0H7V6y8qU9wsGgkZ2H9X2qLMf8
         kk0bLNsnF7zKsFnr9c00mmIKsa3N2y2oz36m9uwj7WJrTLUd4pFhyFA4tU9cuVGv2KyF
         tp57t/XLE1/J96CW9EOc/zn1KaYw532CMdCTY=
Received: by 10.227.37.95 with SMTP id w31mr886707wbd.0.1284914311971;
        Sun, 19 Sep 2010 09:38:31 -0700 (PDT)
Received: from [172.19.43.221] (ip-94-42-11-226.multimo.pl [94.42.11.226])
        by mx.google.com with ESMTPS id k46sm4498896weq.10.2010.09.19.09.38.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 19 Sep 2010 09:38:31 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.9pre) Gecko/20100819 Lightning/1.0b2 Lanikai/3.1.3pre
In-Reply-To: <1jp2pkw.1s4r5br1xvl05eM%lists@haller-berlin.de>
X-Enigmail-Version: 1.1.1
OpenPGP: id=DDEB1C43
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156502>

On 09/19/10 16:08, Stefan Haller wrote:
> Stefan Haller <lists@haller-berlin.de> wrote:
>=20
>> Artur Skawina <art.08.09@gmail.com> wrote:
>>
>>> On 09/18/10 17:26, Stefan Haller wrote:
>>>> =C3=86var Arnfj=C3=B6r? Bjarmason <avarab@gmail.com> wrote:
>>>>>                      A---B---C topic
>>>>>                     /         \
>>>>>                D---E---F---G---H master
>>>
>>>> The question is the same though: if I hit commit B while blaming, =
how do
>>>> I know what topic it was a part of?  For that, I need to find comm=
it H
>>>> which will tell me, right?  How do I do that?
>>>
>>> git rev-list --ancestry-path --merges --reverse B..master --format=3D=
oneline
>>
>> Thanks, this is helpful.  (However, my co-workers will probably laug=
h at
>> me if I suggest they remember a command such as this for what they t=
hink
>> should be a very simple operation.)
>>
>> There's a problem though for commits that are far back in history:
>>
>>                A---B---C topic
>>               /         \
>>          D---E---F---G---H---I---J---K---L---M---N master
>>                                   \         /
>>                                    O---P---Q another-topic
>>
>> Your command also shows M, which is not interesting at all in this
>> context.  Ideally it should stop at the first command that's common =
to
>> topic and master.
>=20
> No, that's not what I need either.  After thinking about it more, I
> think what I want is "of all merges in the ancestry path from B to
> master, show only those whose first parent can't reach B."  The resul=
t
> is the list of all merges that were involved in bringing B to master.
>=20
> Here's what I came up with:
>=20
> #!/bin/sh
>=20
> git rev-list --ancestry-path --merges --reverse "$1".."${2-master}" \
>   | while read ref
> do
>   if [ -z "$(git rev-list --ancestry-path "$1".."$ref"^)" ]
>   then
>     git --no-pager log -1 --pretty=3Doneline "$ref"
>   fi
> done
>=20
> It's pretty inefficient, but seems to get the job done. Is there a
> smarter way to achieve the same?

This would work, and i don't see a way to optimize it in git-speak,
given that you don't want to see any extra trailing merges. At least,
not if it's supposed to be generic; consider a case where the 'topic'
merges another 'subtopic' and is then merged into a 'supertopic', which
is then merged to 'master'. Maybe somebody else has an idea?

=46or me, this seems like overkill, the merge list given by "git rev-li=
st"
should be more than enough to figure out which branch the commit came
from. And if not - either your shell script or walking the history
("--parents" option) w/ a script would do. But i can't even imagine how
such a history would have to look like...=20

artur
