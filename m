Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1FD3B8105
	for <git@vger.kernel.org>; Sun, 13 Sep 2026 19:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789326674; cv=none; b=lW1Wq0Li2lUJP1wykOyM2x9a9HV9t67zMxM5ysQnyMWo4HaZ1n1GSPfb1CTAD0xRrp5nDya+vrfZIRCQGhd26tyuJq7jqBb6IsnQrmvXR8yZB6YPN9sEvES4arVSBgKZg2n0PsL20+jLK+mEhOmPW1QWNiN/Sg5UFPGksgp48fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789326674; c=relaxed/simple;
	bh=DBKkuQWS5O+l80UPN9khzbMcMCl2R0hBZsorume1d2M=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=kzKUVh/62W+vmIyfjH6i3MzvjB+PaTRb9n7EpsgXTpeZTBzG0eO/Go3YBx7d2suEGQN1KEC6cTSBeBQim8aP1vL6ymO3iEqoGA9Ih5AxZiL96yT9v9hYiVLYSaIPcxJaS2V+mqSk7zlwK0IKT6JPGWYSAEe9OCASYR53lOf+dVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=exu2FFio; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="exu2FFio"
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-93910ca5aa7so164171385a.1
        for <git@vger.kernel.org>; Sun, 13 Sep 2026 12:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789326671; x=1789931471; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6zbCi46d8jVC2g+YWvoI1JaOS7GvydR1ESNAGFDg6kI=;
        b=exu2FFioE5vNaUbSR7jUoXuqZTgMLMj13+nTWkH3xkVNwAmwKEBZUeXnBW/aEEN4kR
         Qj1UBDWGKlDikSD9/n6D60eAqwJMQVWYxEOgigTHP/bOL0Jg0FJD1md/kh80dNxA5688
         dle8jumiyhy2EWilKa2fUcJLui6fv1iYJv96G9zUXPFtOdb8y/dptFOrgYvmfNjvWJ0e
         76xNI7n6h8W9eSKPTlNynOHUkG4KJqD2RjouHgpD5sz9GuHtkGx6l18KQiI7qr0ORBJz
         u7MlMjSBF9F7q+ycbcXNCs7CyaATwWor4qiQU6ylPmkFVKewlOJ1mwT7LdKoMBU3xmnC
         ov+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789326671; x=1789931471;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6zbCi46d8jVC2g+YWvoI1JaOS7GvydR1ESNAGFDg6kI=;
        b=T0y2mF1TgHftoWFF7sZRj8+Hj/6pAC7DQOIJ9DsdtOV+jJ0uEIZR77LB8SpICljity
         Tqs8SFECaTL0CX2wRFiw6XsqnnZWsme8ZeF6CN01FPeMDc1udYORLi5V/774ylYvDpUM
         GV4dtwy1hCRXzSGJnDCDo+2cIEZT6FaYozVIO45VF5O5mA3f5q4naWC1c6fTqtFUwSwX
         xX0zhsQnVEa/aF5jYPtotVDriFKmHMIr7pDAx+yZtd1s4vkdIjm1vBeBaiVnJoK81sW8
         AC66X13JPX+p5f6IxUt1ziiF55h+9lmDvEfV+X+GbQJPR7SpESC7YuU2aWwyVoYNmlFF
         PNdA==
X-Gm-Message-State: AFuF++lUAckvq7TUQ8/3Sll1C8Bsnsz7tlslsgExQupI/aiv8pSu28Md
	9sZHg/CpaniSmHjvp+ueHJb6lhgcIXJImOWpaO6dvZhKiNtl83/zfTa7bd0G4w==
X-Gm-Gg: AYBFou2IIu5nn2azugm0ohM2BHtW6bPG4I3dc9+DTeoeoiY+KRe4LbnyMkPayS+3LIL
	JNDfjmJMA3kW83ygLC8bD+5wHXFLl6FmUZkL6f4XfKP1TubJkbSxlbPNaUcAjXQIk1KjplL6BJE
	6B8jM+oGmE+pvx7tQovE55TQHHoCkCUO1MSYzrFEXCRdRyokbR3dm5wLdi1/kSOOrWGZnhPq5UK
	NF4mK4XyvHZ3InjFp9Mgru2X6uTI4HANdJRUgDrr/0hxAo1Sm/hy9BOMlZF+zKIKeoA578mkhlB
	9z7+FItPTYTmMFC0pezisnMoz20mUZbzRvNEQcJ8qgb/vzxqwnDIPIzxkJW5YsPvaz5pkX2uVMD
	U9N96CaIjpXXy5dwGRCxiPsoQV9IqEDKs04hiCC8o+qgZV2o9ISmX8VsVJfW2je2CiOm89Avte/
	LuELJAhQcj8OWoCjXDVs1ty0aTBhaChoWt4T4uC9xP5/SJn1MW5gpqCIwMzXJQ2O+9HfDQSwMzs
	8c=
X-Received: by 2002:a05:620a:a405:10b0:93a:1489:c57d with SMTP id af79cd13be357-93a1489d45dmr465212685a.35.1789326671509;
        Sun, 13 Sep 2026 12:11:11 -0700 (PDT)
Received: from [127.0.0.1] ([172.214.44.146])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939e8047a4dsm809948985a.23.2026.09.13.12.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 12:11:11 -0700 (PDT)
Message-Id: <516441dd13710d5ea016fe1905e702314933e89a.1789326667.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2227.git.1789326667.gitgitgadget@gmail.com>
References: <pull.2227.git.1789326667.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 13 Sep 2026 19:11:06 +0000
Subject: [PATCH 1/2] t9700: accommodate for MSYS2 Perl reporting as `cygwin`
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

As of a year or two ago, there is this push to align MSYS2 more closely
with Cygwin, so as to benefit from a closer collaboration. Part of that
is that the triplet `x86_64-pc-cygwin` is used nowadays, whereas it had
been `x86_64-pc-msys` previously. Likewise, Perl now reports `$^O` as
`cygwin` instead of `msys`.

The Perl module test used `msys` as tell-tale when to accommodate for a
native Windows version of `git.exe` which would report absolute
_Windows_ paths rather than those pseudo-Unix paths. We cannot use that
tell-tale anymore, and we also cannot adjust it to `cygwin` because that
would break in Cygwin (where `git.exe` reports absolute pseudo-Unix
paths).

Let's use the environment variable `MSYSTEM` instead (being mindful that
the `MSYSTEM=MSYS` variant would _also_ reflect a setup where `git.exe`
won't report absolute _Windows_ paths).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t9700/test.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t9700/test.pl b/t/t9700/test.pl
index f83e6169e2..43a6dc266e 100755
--- a/t/t9700/test.pl
+++ b/t/t9700/test.pl
@@ -118,7 +118,7 @@ unlink $tmpfile;
 
 # paths
 my $abs_git_dir = $abs_repo_dir . "/.git";
-if ($^O eq 'msys') {
+if (defined $ENV{MSYSTEM} && $ENV{MSYSTEM} ne 'MSYS') {
   $abs_git_dir = `cygpath -am "$abs_repo_dir/.git"`;
   $abs_git_dir =~ s/\r?\n?$//;
 }
-- 
gitgitgadget

