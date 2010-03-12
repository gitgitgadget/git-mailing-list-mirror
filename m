From: Chris Packham <judge.packham@gmail.com>
Subject: Re: re-running merge on a single file
Date: Fri, 12 Mar 2010 13:16:43 -0800
Message-ID: <a038bef51003121316t19c7edbfyfa3673554d0d0203@mail.gmail.com>
References: <a038bef51003111054n5bcecd2eud531dcc80509f952@mail.gmail.com>
	 <201003112129.52596.markus.heidelberg@web.de>
	 <a038bef51003111408g38698837ldcf1d0f5995f4f30@mail.gmail.com>
	 <m3hbomla3u.fsf@localhost.localdomain>
	 <a038bef51003111631n38f7e50cp79d8335109f3ed0@mail.gmail.com>
	 <a038bef51003111633v5d5d418bu332b63bb3874e3ef@mail.gmail.com>
	 <4B99E309.2070603@viscovery.net>
	 <7viq92rpsr.fsf@alter.siamese.dyndns.org>
	 <a038bef51003121216l5c0a4942qabc3d12741c9030e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Jakub Narebski <jnareb@gmail.com>, GIT <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 12 22:16:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NqCDy-0002Eo-0F
	for gcvg-git-2@lo.gmane.org; Fri, 12 Mar 2010 22:16:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934606Ab0CLVQp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Mar 2010 16:16:45 -0500
Received: from mail-px0-f198.google.com ([209.85.216.198]:56553 "EHLO
	mail-px0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932683Ab0CLVQo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Mar 2010 16:16:44 -0500
Received: by pxi36 with SMTP id 36so932208pxi.21
        for <git@vger.kernel.org>; Fri, 12 Mar 2010 13:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=8mN7B/bFkVTiwi+1TMuqYaGeM3+PI+JrjJJPb3pxlHk=;
        b=Q8Xq47hmhbl+6Etfk0gGtLygI7pMJEidyyewEwbxUdiSkryrGY4PCjpL+yaCe8+nms
         NvdPs0/682lD1On3gRxD0JVRTIqzuDwVRvMUviVyURWkK4zF8DBbZnIeic5NILBLPK4P
         ZzPejQXPorCb5hY16OS9CH8rOGf7kWzG1NgBI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=lrJfeOBaHMjmOrWNpt16KHMzft3jfLTOGVZUXktNMFrSRi33tyRKBWvSkBFiEaOoT9
         kXPBm9ZiurS0XziLnel5dgLF9X6RSlKsMhVhNZlKaynQfCDFHdKmsH/QajgzU1UzDm5e
         V/DK08MS118aQ3uXPPQ8SIc0QAWPxYNtPnwEQ=
Received: by 10.115.27.9 with SMTP id e9mr3105864waj.219.1268428603587; Fri, 
	12 Mar 2010 13:16:43 -0800 (PST)
In-Reply-To: <a038bef51003121216l5c0a4942qabc3d12741c9030e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142064>

On Fri, Mar 12, 2010 at 12:16 PM, Chris Packham <judge.packham@gmail.co=
m> wrote:
> On Thu, Mar 11, 2010 at 10:56 PM, Junio C Hamano <gitster@pobox.com> =
wrote:
>> Johannes Sixt <j.sixt@viscovery.net> writes:
>>
>>> Chris Packham schrieb:
>>>> $ git checkout --merge -- cpu/mpc83xx/start.S
>>>> $ git show :1:$(git rev-parse --show-prefix)cpu/mpc83xx/start.S
>>>> fatal: Path 'cpu/mpc83xx/start.S' is in the index, but not at stag=
e 1.
>>>> Did you mean ':0:cpu/mpc83xx/start.S'?
>>>
>>> Both of these work only as long as the index still records the conf=
licted
>>> state. If you (or one of your tools) has git-added the file, or you=
 have
>>> git-checked-out some version of the file, the conflict stages are l=
ost,
>>> and you must reset --hard and redo the entire merge.
>>
>> If the merge textually autoresolves cleanly, you might not even have=
 any
>> conflicted state to begin with. =C2=A0In such a case you would need =
to grab
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0MERGE_HEAD:path-to-that-thing
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0HEAD:path-to-that-thing
>>
>> yourself.
>>
>
> So if I understand correctly once I've committed the merge the variou=
s
> stages and MERGE_HEADs go away. I don't really want to re-do the whol=
e
> merge which is probably the correct thing to do. I'm lazy and my
> projects rules allow broken commits so instead I can poke about with
> git show and various revisions.
>
> Here's a simple script that does just that. I've borrowed some comman=
d
> line options from git mergetool (Warning: gmail web interface). If
> anyone is interested in seeing a proper version of this I can clean i=
t
> up submit it properly.
>
> ----8<----
>
> From c6ad177712422cbba641975d9e6a5fe85fc8f1fa Mon Sep 17 00:00:00 200=
1
> From: Chris Packham <judge.packham@gmail.com>
> Date: Fri, 12 Mar 2010 12:03:02 -0800
> Subject: [PATCH] Add git manual-merge command
>
> Can be used to manually merge files from the specified revisions.
> ---
> =C2=A0git-manual-merge | =C2=A0 91 ++++++++++++++++++++++++++++++++++=
++++++++++++++++++++
> =C2=A01 files changed, 91 insertions(+), 0 deletions(-)
> =C2=A0create mode 100755 git-manual-merge
>
> diff --git a/git-manual-merge b/git-manual-merge
> new file mode 100755
> index 0000000..f37ba88
> --- /dev/null
> +++ b/git-manual-merge
> @@ -0,0 +1,91 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2010 Chris Packham
> +#
> +# Based on git-mergetool by Theodore Y. Ts'o
> +#
> +# This file is licensed under the GPL v2
> +#
> +
> +USAGE=3D'<branch1> <branch2> <file> ...'
> +. git-sh-setup
> +. git-mergetool--lib
> +require_work_tree
> +
> +merge_one_file()
> +{
> + =C2=A0 =C2=A0local has_base=3Dfalse
> + =C2=A0 =C2=A0git show $1:$4 > $4.$1 && has_base=3Dtrue
> + =C2=A0 =C2=A0git show $2:$4 > $4.$2 || die
> + =C2=A0 =C2=A0git show $3:$4 > $4.$3 || die
> +
> + =C2=A0 =C2=A0if "$prompt" =3D true; then
> + =C2=A0 =C2=A0 =C2=A0 printf "Hit return to start merge resolution t=
ool (%s): " "$merge_tool"
> + =C2=A0 =C2=A0 =C2=A0 read ans
> + =C2=A0 =C2=A0fi
> +
> + =C2=A0 =C2=A0if "$has_base" =3D true; then
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0$merge_tool $4.$1 $4.$2 $4.$1 -o $4

Oops, that should be

+        $merge_tool $4.$1 $4.$2 $4.$3 -o $4

> + =C2=A0 =C2=A0else
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0$merge_tool $4.$2 $4.$1 -o $4
> + =C2=A0 =C2=A0fi
> +}
> +
> +prompt=3D$(git config --bool mergetool.prompt || echo true)
> +
> +while test $# !=3D 0
> +do
> + =C2=A0 =C2=A0case "$1" in
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0-t|--tool*)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case "$#,$1" in
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*,*=3D*)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
merge_tool=3D$(expr "z$1" : 'z-[^=3D]*=3D\(.*\)')
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
;;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01,*)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
usage ;;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
merge_tool=3D"$2"
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
shift ;;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0esac
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0;;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0-y|--no-prompt)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0prompt=3Dfalse
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0;;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0--prompt)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0prompt=3Dtrue
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0;;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0--)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0shift
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0;;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0-*)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0usage
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0;;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0*)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0;;
> + =C2=A0 =C2=A0esac
> + =C2=A0 =C2=A0shift
> +done
> +
> +echo "$merge_tool"
> +
> +if test $# -lt 3; then
> + =C2=A0 =C2=A0usage
> +fi
> +
> +branch1=3D$(git rev-parse --short =C2=A0$1)
> +branch2=3D$(git rev-parse --short =C2=A0$2)
> +_base=3D$(git merge-base $branch1 $branch2)
> +base=3D$(git rev-parse --short =C2=A0$_base)
> +
> +if test -z "$merge_tool"; then
> + =C2=A0 =C2=A0merge_tool=3D$(get_merge_tool "$merge_tool") || exit
> +fi
> +
> +shift 2
> +
> +for x in $*; do
> + =C2=A0 =C2=A0merge_one_file $base $branch1 $branch2 $x
> +done
> +
> --
> 1.7.0.1
>
