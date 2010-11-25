From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Breaking t1510-repo-setup.sh tests in pu
Date: Thu, 25 Nov 2010 18:40:33 +0700
Message-ID: <AANLkTikvXhKoRg4a0FuyW8cG45b6AM9+NbbHuJQWtb4L@mail.gmail.com>
References: <AANLkTim=_0WiphBv-RBhJ2i9rGzXvz8yKcZcm_7pYXFc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 25 12:41:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLaCO-0004KT-IK
	for gcvg-git-2@lo.gmane.org; Thu, 25 Nov 2010 12:41:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752801Ab0KYLlG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Nov 2010 06:41:06 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:51008 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752213Ab0KYLlF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Nov 2010 06:41:05 -0500
Received: by wwa36 with SMTP id 36so845269wwa.1
        for <git@vger.kernel.org>; Thu, 25 Nov 2010 03:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=lzGcExsElz6t0D+8NAqY82fcQL91AoawP4VeJr0+40o=;
        b=S3ibRnt0eOIbJrrTDj2C0d/sDJnceE+bqniOy+NHKx/A04t7bwLz2ElzjHHOhQLsBZ
         CPEpm2z4DoNibxAOi4MsjtB3AlIru7pGaenYAiWp7qnDL/dIFR497HWX6+FkDfIaFHNr
         Q4cwza7ivhC53LRKBHt1/H5Ukr6qE4sHGCuJc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=I+SwqWfAmQTUVVN5BUQa/KGF+OaJ8MDIQBR0QPd7mGFJEifBK3lmhNvtPkiBq+QkOi
         DwI2jaHFcOfk+xbVh/fVdQPY3kbgq7TA6K5QJP5Dv6B6Esvm6MDyniY5kpzBhl7VWgdY
         3U4WQXKJ2bQMozEYcVVDX5UjISHc3ngegMS0o=
Received: by 10.216.166.68 with SMTP id f46mr3827224wel.26.1290685263386; Thu,
 25 Nov 2010 03:41:03 -0800 (PST)
Received: by 10.216.172.199 with HTTP; Thu, 25 Nov 2010 03:40:33 -0800 (PST)
In-Reply-To: <AANLkTim=_0WiphBv-RBhJ2i9rGzXvz8yKcZcm_7pYXFc@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162127>

2010/11/25 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>:
> All the breakages seem to be due to path differences:
>
> =C2=A0 =C2=A0--- expected =C2=A0 =C2=A02010-11-25 09:53:46.000000000 =
+0000
> =C2=A0 =C2=A0+++ result =C2=A0 =C2=A0 =C2=A02010-11-25 09:53:46.00000=
0000 +0000
> =C2=A0 =C2=A0@@ -1,4 +1,4 @@
> =C2=A0 =C2=A0-setup: git_dir: /home/avar/g/git/t/trash directory.t151=
0-repo-setup/3/.git
> =C2=A0 =C2=A0-setup: worktree: /home/avar/g/git/t/trash directory.t15=
10-repo-setup/3/wt
> =C2=A0 =C2=A0+setup: git_dir: .git
> =C2=A0 =C2=A0+setup: worktree: /home/avar/g/git/t/trash directory.t15=
10-repo-setup/3
> =C2=A0 =C2=A0 setup: cwd: /home/avar/g/git/t/trash directory.t1510-re=
po-setup/3
> =C2=A0 =C2=A0 setup: prefix: (null)
> =C2=A0 =C2=A0not ok - 24 #3: GIT_DIR, GIT_WORK_TREE=3Dwt at root
>
> This is probably due to Nguy=E1=BB=85n's recent work. But I'm not sur=
e.
>

Interesting. That looks like real breakage. I have just run the tests
on pu (f4b0626). It passed. Can you send me the entire log and
/tmp/t1510-trace.log after applying this patch?

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 0343045..446eb4d 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -4,6 +4,8 @@ test_description=3D'Tests of cwd/prefix/worktree/gitdir
setup in all cases'

 . ./test-lib.sh

+export GIT_TRACE=3D/tmp/t1510-trace.log
+
 #
 # A few rules for repo setup:
 #
--=20
Duy
