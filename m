Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E922624E01E
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 08:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742372188; cv=none; b=Qj/DKrWwRirEwjuYKkMt1KfQA9TmxuLrwvWdIr0yjqggFMXDQFPfCQdJJfluhqrvTJawVRpOYSf8UGyZJixN16pLvSoHASgPamLv8EMTarC2FGtEsIofiSp/tdd8WcGyLwnoWokmsSFaryb0htklxIuFlAgBgSPxoQcnHYD8ht4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742372188; c=relaxed/simple;
	bh=DMUMSMYQEDIrGPbb+J3cjeILDxiqUp0/q2i0xDP7Csg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=YdEsksU0JAxfvT4g5BokSWXllV32mchd/lM1lBp65MfAGLgbyGzjzP3J+Cbw8xFJAsxN64sFOHi29PIQntZ+dhyzYeMe4G687PWo+Yw/SblQOnLnoQm1iK+YgQTHuUtWpRn2ePYvLMdC51JQhCXRx10+eVinFrQB2camHQQ75PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MO62Ddh8; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MO62Ddh8"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3914aba1ce4so5308730f8f.2
        for <git@vger.kernel.org>; Wed, 19 Mar 2025 01:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742372185; x=1742976985; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AN6L60KsSMplTPqDDS4o+LZZuRFMF9Ou5Bv+wT2TpGY=;
        b=MO62Ddh8HWGkyhwK+cQKhuT39+SmIuZVWShJY+OUu4bBOkTsDp9eYkybMJKsm1tR/1
         lxTDFFg5AjfLtSHzIKNgzG38ssMWFyIvw8o8SO+4yVOH9Ffw9sN9qGtzNsKnbO/lyMss
         P4FfilhJRxFhc4hMqUXPTlqhdHWr9yd9XYsz/idczoYFbcJMIuVASealsBLBDGqNRCc1
         VCTEREIL+GgpvZsgef0+mvxSoIoCB8KUAIW/HeCRO/W8P/kJJrh8iUkwuGFgB1aMkbJy
         2sWvCTdfAB4LsPdZnnxqYQ90uInkYRB7/s7qRPGUufznysLK85Xvf2fXaiHFtYYd7tE8
         XfeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742372185; x=1742976985;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AN6L60KsSMplTPqDDS4o+LZZuRFMF9Ou5Bv+wT2TpGY=;
        b=j0ibSSVvC+fZSooRqfYwuKDq5RkvGfsw/xzo/J0iNP/flw2uQ4j04kq0XKvVJ91Ie2
         z1dsCjTTP8Md1r6riS4be327qsr7zn5oPwDDaePzbJB4MsEiApRL8Y8PzRPKgwu0JLpY
         0/qbEzN+PH1UYHT0oSUDt7cfI5U8edl0vtqX7sdNFt7zqkRJNQKDcvKc5Eghwhzty9ZJ
         JXw4q91PNQvi/Ryqzw8Lyk7P1RxSOsl9xkk1iYCJxKWoo9zVNGxtIMxhoSZT0pctSOpc
         vUp175aJvC8b+w1/8nDzabqCoR+H47YH+X/ucNtqeQ75NrrP+rVVgr//CBWn5FdUUCbl
         Ut2g==
X-Gm-Message-State: AOJu0Yyfy24Xlm47AgXABF0EePN432PfIL8AViNuHLJhzAtU9qLVywba
	Gfb1UOZat2X7Al/h8rg7Io/UnfOLBYQD7CMU2XXl40Q+oK7Xm5CBsDYyqQ==
X-Gm-Gg: ASbGnctk9Rwlf0OxPASOPQVVFK97Oqvk3vhcHpfkcwRYPmeTHhe8yNU+Q+bmPQK+cVk
	p6Q3UtfPSV4N9lhpQoqyH5UItPoAMR5nEEEJ7+AgFl6dBJq73x5/T8WY/NSG1duBi5MYVw4Nm89
	egk1Dt8bVK2ToOapgvIauzviH8qPNp/cS2xLqIzakhmBoP8j63QEO3yxTZOJvoJ/JqtNYtyhZLU
	ece8AayiktliWoEMR+Y6zi/fGCZ5mSrncerZW/xOHtqelgYLc92b1Qf/BKdXEOCKdzXS3IAYjv2
	XscYft5kzn1Bxr0tibqwFCUG3q/EuqVXT3yvNW+E8h9n6w==
X-Google-Smtp-Source: AGHT+IFzqfLx0K4dXpZVFjJJgKsCrV3owf7QrYdo3BHN1aGno6+x1FnleXIwMAt1WGkvET+eW2mmBg==
X-Received: by 2002:a05:6000:188d:b0:38f:4fa6:68df with SMTP id ffacd0b85a97d-39973b23b49mr1527988f8f.51.1742372184565;
        Wed, 19 Mar 2025 01:16:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb40cdd0sm20342105f8f.77.2025.03.19.01.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 01:16:24 -0700 (PDT)
Message-Id: <pull.1880.v2.git.1742372183.gitgitgadget@gmail.com>
In-Reply-To: <pull.1880.git.1742056310.gitgitgadget@gmail.com>
References: <pull.1880.git.1742056310.gitgitgadget@gmail.com>
From: "=?UTF-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 19 Mar 2025 08:16:21 +0000
Subject: [PATCH v2 0/2] doc: apply new format to git-branch man page
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>

Working on git-branch's doc uncovered a bug in the completion logic that did
not take into account the new formatting of options. Apart from that, the
changes are quite standard now.

Changes since V1:

 * rework commit messages
 * De-GNU-ify and simplify script

Jean-Noël Avila (2):
  completion: take into account the formatting backticks for options
  doc: apply new format to git-branch man page

 Documentation/config/branch.adoc | 105 +++++------
 Documentation/git-branch.adoc    | 287 +++++++++++++++----------------
 generate-configlist.sh           |  16 +-
 3 files changed, 208 insertions(+), 200 deletions(-)


base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1880%2Fjnavila%2Fdoc_git_branch-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1880/jnavila/doc_git_branch-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1880

Range-diff vs v1:

 1:  f8883d83f30 ! 1:  cd907cc4ff4 completion: take into account the formatting backticks for options
     @@ Commit message
          backticked in their definition lists. This patch updates the generation of
          the completion list to take into account this new format.
      
     +    The script `generate-configlist.sh` is updated to get rid of extraneous
     +    commands and fit everything in a single sed script.
     +
          Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
      
       ## generate-configlist.sh ##
     @@ generate-configlist.sh: print_config_list () {
       EOF
      -	grep -h '^[a-zA-Z].*\..*::$' "$SOURCE_DIR"/Documentation/*config.adoc "$SOURCE_DIR"/Documentation/config/*.adoc |
      -	sed '/deprecated/d; s/::$//; s/,  */\n/g' |
     -+	grep -h '^`\?[a-zA-Z].*\..*`\?::$' "$SOURCE_DIR"/Documentation/*config.adoc "$SOURCE_DIR"/Documentation/config/*.adoc |
     -+	sed '/deprecated/d; s/::$//; s/`//g; s/,  */\n/g' |
     - 	sort |
     - 	sed 's/^.*$/	"&",/'
     +-	sort |
     +-	sed 's/^.*$/	"&",/'
     ++	sed -E '
     ++/^`?[a-zA-Z].*\..*`?::$/ {
     ++	/deprecated/d;
     ++	s/::$//;
     ++	s/`//g;
     ++	s/^.*$/	"&",/;
     ++	s/,  */",\n	"/g;
     ++	p;};
     ++d' \
     ++	    "$SOURCE_DIR"/Documentation/*config.adoc \
     ++	    "$SOURCE_DIR"/Documentation/config/*.adoc|
     ++	sort
       	cat <<EOF
     + 	NULL,
     + };
 2:  b2e7867006e ! 2:  a22ae89dcd0 doc: apply new format to git-branch man page
     @@ Commit message
          descriptions. The new rendering engine applies synopsis rules to
          these spans.
      
     +    Possible values for some variables, that were mentioned in the description
     +    prose, are now made into enumerated list.
     +
          Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
      
       ## Documentation/config/branch.adoc ##

-- 
gitgitgadget
