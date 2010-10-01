From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv4 14/15] Add missing &&'s throughout the testsuite
Date: Fri, 1 Oct 2010 06:26:47 -0500
Message-ID: <20101001112647.GF6816@burratino>
References: <1285542879-16381-1-git-send-email-newren@gmail.com>
 <1285542879-16381-15-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 01 13:37:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1dvO-0006DM-2q
	for gcvg-git-2@lo.gmane.org; Fri, 01 Oct 2010 13:37:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756587Ab0JALhA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Oct 2010 07:37:00 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:62824 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756585Ab0JALg7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Oct 2010 07:36:59 -0400
Received: by yxp4 with SMTP id 4so1088506yxp.19
        for <git@vger.kernel.org>; Fri, 01 Oct 2010 04:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=YCQOB1vGCsrjyq1PznJ8ffhaVH6l7KuU9RnSb6xd514=;
        b=Vdoz3gSpSg0N9IMvLS1G1m0ZqtbMvH8CaCRKObTMWRxP8qdKxuWJI89OeukNb6fm/B
         kwkJEV0gG9dtPosQYwdY6XPYHP3mzRORXMr1fiLjmgGSFbvtrKKMpVbn0pdYG+vBu1xt
         e8KcKoqM4e8h+hhKivrCCgOzGVz8pkAgfdHcw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=R2Sns0Shmdc7znYwK34iMP17jC/j6KddFLTAT6nhQtAHB4qUOex0REf5Fq/dp/m8Mi
         iMQBUU9nPyucXN5iWupUH3m2ocmAXHXuGEkHzM7uYtmRqP0rn+9l8kZJwG+Wrof+6JpQ
         j5U9Xoz6oTVDCp9As7e3N6Kg7sLocrm6z9Pa8=
Received: by 10.151.3.5 with SMTP id f5mr890276ybi.384.1285932594974;
        Fri, 01 Oct 2010 04:29:54 -0700 (PDT)
Received: from burratino ([68.255.106.176])
        by mx.google.com with ESMTPS id q30sm773350ybk.20.2010.10.01.04.29.52
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 01 Oct 2010 04:29:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1285542879-16381-15-git-send-email-newren@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157746>

(+cc: Duy for t1509)

Elijah Newren wrote:

> --- a/t/t0003-attributes.sh
> +++ b/t/t0003-attributes.sh
> @@ -19,24 +19,23 @@ attr_check () {
>  test_expect_success 'setup' '
> =20
>  	mkdir -p a/b/d a/c &&
> -	(
> -		echo "[attr]notest !test"
> +	cat <<EOF >.gitattributes &&
> +[attr]notest !test

=46its with the style of later tests in the file.  Nice.

[...]
> --- a/t/t1509-root-worktree.sh
> +++ b/t/t1509-root-worktree.sh
> @@ -209,7 +209,7 @@ unset GIT_WORK_TREE
> =20
>  test_expect_success 'go to /' 'cd /'
>  test_expect_success 'setup' '
> -	rm -rf /.git
> +	rm -rf /.git &&
>  	echo "Initialized empty Git repository in /.git/" > expected &&
>  	git init > result &&
>  	test_cmp expected result
> @@ -232,8 +232,8 @@ say "auto bare gitdir"
> =20
>  # DESTROYYYYY!!!!!
>  test_expect_success 'setup' '
> -	rm -rf /refs /objects /info /hooks
> -	rm /*
> +	rm -rf /refs /objects /info /hooks &&
> +	rm /* &&

Hmm, I am not sure I trust this one...

[...]
> --- a/t/t3406-rebase-message.sh
> +++ b/t/t3406-rebase-message.sh
> @@ -43,20 +43,20 @@ test_expect_success 'rebase -m' '
>  '
> =20
>  test_expect_success 'rebase --stat' '
> -        git reset --hard start
> +	git reset --hard start &&
>          git rebase --stat master >diffstat.txt &&
>          grep "^ fileX |  *1 +$" diffstat.txt
>  '
> =20
>  test_expect_success 'rebase w/config rebase.stat' '
> -        git reset --hard start
> +	git reset --hard start &&
>          git config rebase.stat true &&
>          git rebase master >diffstat.txt &&
>          grep "^ fileX |  *1 +$" diffstat.txt
>  '
> =20
>  test_expect_success 'rebase -n overrides config rebase.stat config' =
'
> -        git reset --hard start
> +	git reset --hard start &&
>          git config rebase.stat true &&
>          git rebase -n master >diffstat.txt &&
>          ! grep "^ fileX |  *1 +$" diffstat.txt

Shouldn't these tabs be spaces to blend in with their surroundings?

> --- a/t/t4119-apply-config.sh
> +++ b/t/t4119-apply-config.sh
> @@ -73,7 +73,7 @@ D=3D`pwd`
>  test_expect_success 'apply --whitespace=3Dstrip in subdir' '
> =20
>  	cd "$D" &&
> -	git config --unset-all apply.whitespace
> +	git config --unset-all apply.whitespace &&

test_might_fail?

Aside from the problems =C3=86var and Junio found, the rest looks good =
to
me, but I have not tested it.
---
diff --git a/t/t1509-root-worktree.sh b/t/t1509-root-worktree.sh
index e3391b7..7f60fd0 100755
--- a/t/t1509-root-worktree.sh
+++ b/t/t1509-root-worktree.sh
@@ -209,7 +209,7 @@ unset GIT_WORK_TREE
=20
 test_expect_success 'go to /' 'cd /'
 test_expect_success 'setup' '
-	rm -rf /.git &&
+	rm -rf /.git
 	echo "Initialized empty Git repository in /.git/" > expected &&
 	git init > result &&
 	test_cmp expected result
@@ -232,8 +232,8 @@ say "auto bare gitdir"
=20
 # DESTROYYYYY!!!!!
 test_expect_success 'setup' '
-	rm -rf /refs /objects /info /hooks &&
-	rm /* &&
+	rm -rf /refs /objects /info /hooks
+	rm /*
 	cd / &&
 	echo "Initialized empty Git repository in /" > expected &&
 	git init --bare > result &&
diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
index fe5f936..506d37e 100755
--- a/t/t3406-rebase-message.sh
+++ b/t/t3406-rebase-message.sh
@@ -43,20 +43,20 @@ test_expect_success 'rebase -m' '
 '
=20
 test_expect_success 'rebase --stat' '
-	git reset --hard start &&
+        git reset --hard start &&
         git rebase --stat master >diffstat.txt &&
         grep "^ fileX |  *1 +$" diffstat.txt
 '
=20
 test_expect_success 'rebase w/config rebase.stat' '
-	git reset --hard start &&
+        git reset --hard start &&
         git config rebase.stat true &&
         git rebase master >diffstat.txt &&
         grep "^ fileX |  *1 +$" diffstat.txt
 '
=20
 test_expect_success 'rebase -n overrides config rebase.stat config' '
-	git reset --hard start &&
+        git reset --hard start &&
         git config rebase.stat true &&
         git rebase -n master >diffstat.txt &&
         ! grep "^ fileX |  *1 +$" diffstat.txt
diff --git a/t/t4119-apply-config.sh b/t/t4119-apply-config.sh
index 3d0384d..82e0099 100755
--- a/t/t4119-apply-config.sh
+++ b/t/t4119-apply-config.sh
@@ -73,7 +73,7 @@ D=3D`pwd`
 test_expect_success 'apply --whitespace=3Dstrip in subdir' '
=20
 	cd "$D" &&
-	git config --unset-all apply.whitespace &&
+	test_might_fail git config --unset-all apply.whitespace &&
 	rm -f sub/file1 &&
 	cp saved sub/file1 &&
 	git update-index --refresh &&
--=20
