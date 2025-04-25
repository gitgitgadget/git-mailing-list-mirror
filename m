Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB9D5695
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 13:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745587073; cv=none; b=TyxQI6fK3kMUjHnQvtqPfCXm5VBs95D568rxfDoWVh07xTfonN/lY0BIgYR2hJQ7r+cQpjlkoQJiqlW2uU3afBr/LlWzlv8jHUY1T3fSfLgNA5jhW1SEDDfSuOeMeww+z6fmB2RVb8c/mpjMyLUEEDX2kQ3t0tM/vLOlMfaD+YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745587073; c=relaxed/simple;
	bh=kdYRGE33lchQVXEES9AOnHn5L20rvOcJNethJAyqJHw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=YiOIcGxAstqKWDyLEC297o/76IIm3BAwfxk0+Wn1IMVd3ccybwBpoWYIuVJTwGd0sQ528nH5jCZu7zYNDQWPmiX1kKuVaSOdeKil0uuobyk94sHZiuMN+532rR5gI2I7aOqcZz04wx2vmF/suB4LM5N6iA+1szwZOagDAVRMsTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dDAq7kKp; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dDAq7kKp"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cf0d787eeso25658625e9.3
        for <git@vger.kernel.org>; Fri, 25 Apr 2025 06:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745587069; x=1746191869; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5zxtEDLS7/9UVnTGxcccHPdavcx3yzwHsNV8Q+ps5jE=;
        b=dDAq7kKpzhp9SUKLt2wn/SNyAA/v3J6JL3TbwcJerJnUBIrhFJYTXEWhoqBuPoPLz5
         Of+TQnJjX2q8ySfmtRhJobghrEcb/4cJS4CCp4lglfJF4c3wDdvfQtWm+1SWVQ7FjPam
         G3fpjXnv/Vwkgm/ma/Y106AQQvs35O/IO65kPnCTnIMN50f65KMszb8qWB0TJayW3o4d
         0t1ZUyKFA7ifRU25C7c9nSFMG6mADN+ATiA/j2qRz1Hw5X4vwBaux90fwFliyaRHor0p
         2iiFD8K/kIpS6sPn6vsVh2v2gSYInMBO81L6HoYhqKdUruSVVBHG1VnbvlzlvyO4iQIp
         q/Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745587069; x=1746191869;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5zxtEDLS7/9UVnTGxcccHPdavcx3yzwHsNV8Q+ps5jE=;
        b=USm5JgPhjWcJ+v8/l3oUFVauUgCh184Y4hJfbRv1KcXTruHVdYPysPo5GPpjh0OHly
         mwp9gS0xjDUU7HE+TFeoy6bXE6aDzsXYlWXGkbr0ROLz/5orLUjzyVSHWI9a77dW8+sX
         mHxZfYIugGqX+eBCIgLGKrrQslotw1T9VpcRbIlH7hb0OEICgyqR73C5qgsQ4GzoDPBF
         7jBGsvCAU7vIEchRLedS3ZM5I3IxqbHJm0u6XX/A4km7rcVerMGm3Zc4cJp16rM3HXdK
         UjkNwK/Ni4gakSsVUiv503TdMaBkdgfuZlzGI8Np47wd3cgPHRjcPlHtroZS2tjUUb4A
         sipw==
X-Gm-Message-State: AOJu0Ywtq51PxnPX4fd21LVuwMHjF7L2YTywLH0bWXBlHrb+fQotfhGO
	OCHvDTFCGe/nJJbx2jEC9T4VeNby6xL+CH0k0L9LKVjtTmSBKv/VL2YOQw==
X-Gm-Gg: ASbGncseaqI27SQq2HUIuf/OHibT7uiXSYJmk/44IVT7U+HGWlm+urX6Dr62rU8H5YS
	d/wtat/a/3rKNMgtQwLn98hLBxJ1ZB7oD72WjmayF8XwtYa3h/Vxix+vuJXHQ/Z2x9S1kbuKngX
	sfhqz1rJW7obcwBBbj979rtjcJfC8VF/yOBNaRjBPDhTX9s2Y1DBP227tO1HOoxw58hH+Pikx/3
	2Szljy5aE09Sf+g0sYIeiRR6LHqhkVvD+QPkmmYxc2HmMhmYy4zpfgsYhSAphNOh37F1nAUI5XV
	wwCBaHQuElE9xsqFxWPCGQ1j8p3nl9cKWlk2GM9Nhw==
X-Google-Smtp-Source: AGHT+IE32R3zDD5CPYj7Rq4GDejFaFQOyQvkoqvl0gXZln1PiTZdKg+sYMxAO/wF5jv4oQW/4F/8Xw==
X-Received: by 2002:a05:6000:2283:b0:391:4889:5045 with SMTP id ffacd0b85a97d-3a074f398d8mr1749730f8f.36.1745587069328;
        Fri, 25 Apr 2025 06:17:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073c8cc74sm2413105f8f.11.2025.04.25.06.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 06:17:48 -0700 (PDT)
Message-Id: <pull.1897.v4.git.git.1745587067.gitgitgadget@gmail.com>
In-Reply-To: <pull.1897.v3.git.git.1742312173.gitgitgadget@gmail.com>
References: <pull.1897.v3.git.git.1742312173.gitgitgadget@gmail.com>
From: "Scott Chacon via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 25 Apr 2025 13:17:45 +0000
Subject: [PATCH v4 0/2] bundle-uri: copy all bundle references ino the refs/bundle space
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
Cc: Derrick Stolee <stolee@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Taylor Blau <me@ttaylorr.com>,
    Toon Claes <toon@iotcl.com>,
    Scott Chacon <schacon@gmail.com>

Updated the test with Taylor's patch.

> bundle-uri: copy all bundle references ino the refs/bundle space
> bundle-uri: update bundle clone tests with new refspec path

Scott Chacon (2):
  bundle-uri: copy all bundle references ino the refs/bundle space
  bundle-uri: add test for bundle-uri clones with tags

 bundle-uri.c                |   2 +-
 t/t5558-clone-bundle-uri.sh | 202 +++++++++++++++++++++---------------
 2 files changed, 117 insertions(+), 87 deletions(-)


base-commit: f65182a99e545d2f2bc22e6c1c2da192133b16a3
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1897%2Fschacon%2Fsc-more-bundle-refs-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1897/schacon/sc-more-bundle-refs-v4
Pull-Request: https://github.com/git/git/pull/1897

Range-diff vs v3:

 1:  2ccbfdcc2dc = 1:  6957ee2fed2 bundle-uri: copy all bundle references ino the refs/bundle space
 2:  d148b14c390 ! 2:  d9a114915a3 bundle-uri: add test for bundle-uri clones with tags
     @@ Commit message
          bundle-uri: add test for bundle-uri clones with tags
      
          The change to the bundle-uri unbundling refspec now includes tags, so this
     -    adds a simple test to make sure that tags in a bundle are properly added to
     -    the cloned repository and will be included in ref negotiation with the
     -    subsequent fetch.
     +    adds a very, very simple test to make sure that tags in a bundle are
     +    properly added to the cloned repository and will be included in ref
     +    negotiation with the subsequent fetch. ok, now it's right. christ.
      
          Signed-off-by: Scott Chacon <schacon@gmail.com>
      
     @@ t/t5558-clone-bundle-uri.sh: test_expect_success 'clone with file:// bundle' '
      +test_expect_success 'clone with tags bundle' '
      +	git clone --bundle-uri="clone-from-tags/ALL.bundle" \
      +		clone-from-tags clone-tags-path &&
     -+	git -C clone-tags-path for-each-ref --format="%(refname)" >refs &&
     -+	grep "refs/bundles/tags/" refs >actual &&
     -+	cat >expect <<-\EOF &&
     -+	refs/bundles/tags/A
     -+	refs/bundles/tags/B
     -+	refs/bundles/tags/tag-A
     -+	EOF
     ++
     ++	git -C clone-from-tags for-each-ref --format="%(refname:lstrip=1)" \
     ++		>expect &&
     ++	git -C clone-tags-path for-each-ref --format="%(refname:lstrip=2)" \
     ++		refs/bundles >actual &&
     ++
      +	test_cmp expect actual
      +'
      +

-- 
gitgitgadget
