From: Chris Packham <judge.packham@gmail.com>
Subject: Re: re-running merge on a single file
Date: Fri, 12 Mar 2010 12:16:58 -0800
Message-ID: <a038bef51003121216l5c0a4942qabc3d12741c9030e@mail.gmail.com>
References: <a038bef51003111054n5bcecd2eud531dcc80509f952@mail.gmail.com>
	 <201003112129.52596.markus.heidelberg@web.de>
	 <a038bef51003111408g38698837ldcf1d0f5995f4f30@mail.gmail.com>
	 <m3hbomla3u.fsf@localhost.localdomain>
	 <a038bef51003111631n38f7e50cp79d8335109f3ed0@mail.gmail.com>
	 <a038bef51003111633v5d5d418bu332b63bb3874e3ef@mail.gmail.com>
	 <4B99E309.2070603@viscovery.net>
	 <7viq92rpsr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Jakub Narebski <jnareb@gmail.com>, GIT <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 12 21:17:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NqBIC-0000iN-Co
	for gcvg-git-2@lo.gmane.org; Fri, 12 Mar 2010 21:17:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934545Ab0CLURA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Mar 2010 15:17:00 -0500
Received: from mail-pz0-f200.google.com ([209.85.222.200]:48715 "EHLO
	mail-pz0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934542Ab0CLURA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Mar 2010 15:17:00 -0500
Received: by pzk38 with SMTP id 38so1059616pzk.33
        for <git@vger.kernel.org>; Fri, 12 Mar 2010 12:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=kaq+KfWJA6SOfEPMGfGmrRR2MTaJiZSY37FeAL1Ox74=;
        b=WVXR05kXC+k3lnSEj4fBH6DAI4kI49B1dKyKezbI97V+DW1TsaOAs/N7xG9CATx1kj
         7iR4+rwAvjq8AZp3caNKVB10gdlqOATzUTWNATVKuoXRii8k7KdCY1cEDQ4/HCyjO4Qz
         f7KDAkajW93HzjYBOiziKIiq0jxfqLQ1r4BoU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=JJbY60cqW046UFETk1spXdk+KdJmVp/NO7ccraLVZOoaXAwOz8bZYoaiVhkiS80k09
         0jPe1Ok9cFhFsl78TjRu9Yy/6VogncIWcvPabeWS8vA3Krv7PVFMfeqKquy4jOhbKGq5
         sxhaOZXLJ6YYgHI5FT5kqBu9ExvU0ZbAJFPnE=
Received: by 10.114.8.5 with SMTP id 5mr3068641wah.172.1268425018522; Fri, 12 
	Mar 2010 12:16:58 -0800 (PST)
In-Reply-To: <7viq92rpsr.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142063>

On Thu, Mar 11, 2010 at 10:56 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Johannes Sixt <j.sixt@viscovery.net> writes:
>
>> Chris Packham schrieb:
>>> $ git checkout --merge -- cpu/mpc83xx/start.S
>>> $ git show :1:$(git rev-parse --show-prefix)cpu/mpc83xx/start.S
>>> fatal: Path 'cpu/mpc83xx/start.S' is in the index, but not at stage=
 1.
>>> Did you mean ':0:cpu/mpc83xx/start.S'?
>>
>> Both of these work only as long as the index still records the confl=
icted
>> state. If you (or one of your tools) has git-added the file, or you =
have
>> git-checked-out some version of the file, the conflict stages are lo=
st,
>> and you must reset --hard and redo the entire merge.
>
> If the merge textually autoresolves cleanly, you might not even have =
any
> conflicted state to begin with. =C2=A0In such a case you would need t=
o grab
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0MERGE_HEAD:path-to-that-thing
> =C2=A0 =C2=A0 =C2=A0 =C2=A0HEAD:path-to-that-thing
>
> yourself.
>

So if I understand correctly once I've committed the merge the various
stages and MERGE_HEADs go away. I don't really want to re-do the whole
merge which is probably the correct thing to do. I'm lazy and my
projects rules allow broken commits so instead I can poke about with
git show and various revisions.

Here's a simple script that does just that. I've borrowed some command
line options from git mergetool (Warning: gmail web interface). If
anyone is interested in seeing a proper version of this I can clean it
up submit it properly.

----8<----

=46rom c6ad177712422cbba641975d9e6a5fe85fc8f1fa Mon Sep 17 00:00:00 200=
1
=46rom: Chris Packham <judge.packham@gmail.com>
Date: Fri, 12 Mar 2010 12:03:02 -0800
Subject: [PATCH] Add git manual-merge command

Can be used to manually merge files from the specified revisions.
---
 git-manual-merge |   91 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 91 insertions(+), 0 deletions(-)
 create mode 100755 git-manual-merge

diff --git a/git-manual-merge b/git-manual-merge
new file mode 100755
index 0000000..f37ba88
--- /dev/null
+++ b/git-manual-merge
@@ -0,0 +1,91 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 Chris Packham
+#
+# Based on git-mergetool by Theodore Y. Ts'o
+#
+# This file is licensed under the GPL v2
+#
+
+USAGE=3D'<branch1> <branch2> <file> ...'
+. git-sh-setup
+. git-mergetool--lib
+require_work_tree
+
+merge_one_file()
+{
+    local has_base=3Dfalse
+    git show $1:$4 > $4.$1 && has_base=3Dtrue
+    git show $2:$4 > $4.$2 || die
+    git show $3:$4 > $4.$3 || die
+
+    if "$prompt" =3D true; then
+       printf "Hit return to start merge resolution tool (%s): " "$mer=
ge_tool"
+       read ans
+    fi
+
+    if "$has_base" =3D true; then
+        $merge_tool $4.$1 $4.$2 $4.$1 -o $4
+    else
+        $merge_tool $4.$2 $4.$1 -o $4
+    fi
+}
+
+prompt=3D$(git config --bool mergetool.prompt || echo true)
+
+while test $# !=3D 0
+do
+    case "$1" in
+        -t|--tool*)
+            case "$#,$1" in
+                *,*=3D*)
+                    merge_tool=3D$(expr "z$1" : 'z-[^=3D]*=3D\(.*\)')
+                    ;;
+                1,*)
+                    usage ;;
+                *)
+                    merge_tool=3D"$2"
+                    shift ;;
+            esac
+            ;;
+        -y|--no-prompt)
+            prompt=3Dfalse
+            ;;
+        --prompt)
+            prompt=3Dtrue
+            ;;
+        --)
+            shift
+            break
+            ;;
+        -*)
+            usage
+            ;;
+        *)
+            break
+            ;;
+    esac
+    shift
+done
+
+echo "$merge_tool"
+
+if test $# -lt 3; then
+    usage
+fi
+
+branch1=3D$(git rev-parse --short  $1)
+branch2=3D$(git rev-parse --short  $2)
+_base=3D$(git merge-base $branch1 $branch2)
+base=3D$(git rev-parse --short  $_base)
+
+if test -z "$merge_tool"; then
+    merge_tool=3D$(get_merge_tool "$merge_tool") || exit
+fi
+
+shift 2
+
+for x in $*; do
+    merge_one_file $base $branch1 $branch2 $x
+done
+
--
1.7.0.1
