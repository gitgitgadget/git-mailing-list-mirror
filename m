Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10662F1FDE
	for <git@vger.kernel.org>; Sat, 23 May 2026 11:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779534467; cv=none; b=A3wBRsQKJISjqExGPwCSaYmmjl2ihmMwa77+pvrpy+ZJVXeeCWO4XMc1CycAiXJZJlM0Ip5hHAH6jhDrMYzVBSnpfqUs4LjrFHYFrL8BsoKS9+XGNAqbx/iDB88wyDYvSIOWrb9Pp687pqNgcazT7mos3li29jjVgt9k5jOcr90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779534467; c=relaxed/simple;
	bh=wfHWyTm/kXCqxM1zJHD7pgT0Xic8gb/kU+/IWPf6Zeg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=JxMvlOA6AKlvqTwf3q6bVEZV2KVCc1GAFhSjIbJNyPb8+EDAs5mFK/l1G16Q68c8XQWDSxe3aY+hXNoiogeyFMoeDLCxJ2IWkisG6qorQH43v940K+I8J/RzYH0Sz0p3vN0dqz7L/3k4xuonNnPQ597S4s/E+E0S28eLo0XRssg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YWquKQjH; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWquKQjH"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-50e5dbd8e0eso94676581cf.1
        for <git@vger.kernel.org>; Sat, 23 May 2026 04:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779534465; x=1780139265; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VxfXWm/Q8Ks3q2P8RLta9Faodf5nIwWsZaieBZletOg=;
        b=YWquKQjHujQvnoGgmFhoPHxxIpordPVSWsVTyAFN3XiQQm4nTxdtRRqdyEDXhw/YOK
         ascKitDyeu4Z3CCdjMkpD934I4Ng9lRujDze1Z3YOVipINE/2+wCGfLTcqxGebdp7jr2
         pFEp16ZjePeOt+5am/btl+qk87VlB2YAgx3pfhZs/T9EE/PR+6JCXCLu7XjZw7sV8aa5
         E3amah9EvhmIQ4CNUcjpkuTi6aJPdzWFNBT+LmdU+GjtRiXD6RjTZu+p35H2cGOVNLeE
         jxh0s30DR2YXEbQ0yXoP4xPPttF0kSaePnGK3GFRkfU2MGxGPwMaJyC3Kz0r7AmXbwi/
         8zEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779534465; x=1780139265;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VxfXWm/Q8Ks3q2P8RLta9Faodf5nIwWsZaieBZletOg=;
        b=PPGK5Awlli/kToNRjjHWI/nN6N37Q3pbuKXQ6BSrDhHMsZs4x2WFQDn+h9yD7H0z4C
         5VsaEr8qdhqzA5qCP4GLaE13B8wQCy7+RlXBpfvGe6UKJwIPJulWIfRfzWvRuGwNpKPm
         YaE7Vq6PCZM8Be37W25Vzz913xKjqw8ADD0LCBtY6BqHy++iyP3GA5Bcez/Ym59SslYy
         +/bRb+vqW/fpxcEMTtNJG8ethSmiZs363LvNghIkw3dd5zlR+t9MgT41YXVP6246ec3M
         7HTI4UDHmofzdjReTpGl0jsiVBIQdITADWE+N3RXZj4/rD4uN1jxE25iCOAbD9l1fAnu
         fgCQ==
X-Gm-Message-State: AOJu0YwtsYIip+BaViBQwl8+zQpQhaZ5KtkSPaOB17sZd9dLe58PXqIr
	Hu3h2CDTgtasYN+InefppipJ1UELG5a/74WrQJ3/01ggX8vfIFFt6dMaHAa7TxSs
X-Gm-Gg: Acq92OFqXNkqOwNE1AaS228Ba893tCZO7Zxlx8flERCL+bGqsf9iBm1EE9AadHjj71d
	RUleqwEethYMrjslkRlcPGFTTV7BTDZS29OZwnBrsxv2K3HtGjX4s42r+gqwmRoesmJmiwLKyM2
	U118czUPOfVzyyimZaP8QyrkZNPtLRDRdfrma+cCjAB/nxgezueesEpq0XSZSEtG1ItSJwfBogu
	OhiHkcLT3SDd7SvPycHR2Il6en9p9WxhbST7mARhwaKeEWb86sxabvdUK7wjrzXe3b0hQSyUdkW
	deuoBR89qK9fhOowiEjtNBk2d+MsxjAnzZ1EXC59/4mvK41IDAFRFknatSd0TFBVMrOMfr4DHjl
	uodwq3XfeKylRhb4gpQyY88/VEYAps7ujUySZwRCihhTzE3ZFKP1Xf9CBOhB1ecfxUEtXgLZX+U
	wkxbGxh+POLrxMwGyS8IkHokZPVw==
X-Received: by 2002:a05:622a:1650:b0:516:e862:7610 with SMTP id d75a77b69052e-516e8627d14mr4605461cf.40.1779534464913;
        Sat, 23 May 2026 04:07:44 -0700 (PDT)
Received: from [127.0.0.1] ([4.236.159.145])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516d8b247c4sm37064331cf.7.2026.05.23.04.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 04:07:44 -0700 (PDT)
Message-Id: <4da209249227f6a824cc34c8697d1ed79dfa18e0.1779534462.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2256.git.git.1779534462.gitgitgadget@gmail.com>
References: <pull.2256.git.git.1779534462.gitgitgadget@gmail.com>
From: "Zakariyah Ali via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 23 May 2026 11:07:41 +0000
Subject: [PATCH 1/2] t2000: consolidate second scenario into a single test
 block
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
Cc: Christian Couder <christian.couder@gmail.com>,
    Karthik Nayak <karthik.188@gmail.com>,
    Justin Tobler <jltobler@gmail.com>,
    Siddharth Asthana <siddharthasthana31@gmail.com>,
    Ayush Chandekar <ayu.chandekar@gmail.com>,
    Zakariyah Ali <zakariyahali100@gmail.com>,
    Zakariyah Ali <zakariyahali100@gmail.com>

From: Zakariyah Ali <zakariyahali100@gmail.com>

Now that the test script has been modernised, consolidate the eight
separate test_expect_success blocks that together form the second
test scenario (setup, tree writes, checkout, symlink creation, and
final state check) into one self-contained block.

This makes it easier to read: data set-up, the operations being
tested, and the expected outcome are now all in one place.

Helped-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: Zakariyah Ali <zakariyahali100@gmail.com>
---
 t/t2000-conflict-when-checking-files-out.sh | 55 ++++-----------------
 1 file changed, 9 insertions(+), 46 deletions(-)

diff --git a/t/t2000-conflict-when-checking-files-out.sh b/t/t2000-conflict-when-checking-files-out.sh
index af199d8191..43ec901f9e 100755
--- a/t/t2000-conflict-when-checking-files-out.sh
+++ b/t/t2000-conflict-when-checking-files-out.sh
@@ -83,59 +83,22 @@ test_expect_success SYMLINKS 'checkout-index -f twice with --prefix' '
 # path path3 is occupied by a non-directory.  With "-f" it should remove
 # the symlink path3 and create directory path3 and file path3/file1.
 
-test_expect_success 'prepare path2/file0 and index' '
+test_expect_success 'checkout-index -f resolves symlink conflict on leading path' '
 	mkdir path2 &&
 	date >path2/file0 &&
-	git update-index --add path2/file0
-'
-
-test_expect_success 'write tree with path2/file0' '
-	tree1=$(git write-tree)
-'
-
-test_debug 'show_files $tree1'
-
-test_expect_success 'prepare path3/file1 and index' '
+	git update-index --add path2/file0 &&
+	tree1=$(git write-tree) &&
 	mkdir path3 &&
 	date >path3/file1 &&
-	git update-index --add path3/file1
-'
-
-test_expect_success 'write tree with path3/file1' '
-	tree2=$(git write-tree)
-'
-
-test_debug 'show_files $tree2'
-
-test_expect_success 'read previously written tree and checkout.' '
+	git update-index --add path3/file1 &&
+	tree2=$(git write-tree) &&
 	rm -fr path3 &&
 	git read-tree -m $tree1 &&
-	git checkout-index -f -a
-'
-
-test_debug 'show_files $tree1'
-
-test_expect_success 'add a symlink' '
-	test_ln_s_add path2 path3
-'
-
-test_expect_success 'write tree with symlink path3' '
-	tree3=$(git write-tree)
-'
-
-test_debug 'show_files $tree3'
-
-# Morten says "Got that?" here.
-# Test begins.
-
-test_expect_success 'read previously written tree and checkout.' '
+	git checkout-index -f -a &&
+	test_ln_s_add path2 path3 &&
+	tree3=$(git write-tree) &&
 	git read-tree $tree2 &&
-	git checkout-index -f -a
-'
-
-test_debug 'show_files $tree2'
-
-test_expect_success 'checking out conflicting path with -f' '
+	git checkout-index -f -a &&
 	test_path_is_dir_not_symlink path2 &&
 	test_path_is_dir_not_symlink path3 &&
 	test_path_is_file_not_symlink path2/file0 &&
-- 
gitgitgadget

