Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0170C1494A8
	for <git@vger.kernel.org>; Tue, 21 May 2024 19:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716318185; cv=none; b=NxDJqwsHrW2mc/lap1LdH6GmiTyqjS8wrj13lkH65uKW+Gn3tIyf4KB0uBBLr2PE26aQCAAQ8lGtILSgQZ0zmkmsdC883g+U5lU7/3qUuMq/x3j3iLwkvtblfsPw9HQcczaiKYFyHC+5JivPdeYCn5WAfGr32fgE92FeQUEXJZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716318185; c=relaxed/simple;
	bh=nY1teEgDzm9oYwt/v3rHPAz503cG2cEDyXUnbicT1TQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H1ZG0W9wrCUP9siBfGS99tKwV0eK2V7HqkFThQ+s9ps7bACLVMV5Ys48Vnb+ADy31kesdx0eFn4mw6+IUCgIA2s/XIYZg51W9/szeDM4BnJduvyr+kjPDi5nwn5T1L909c5B9AKaFnbvTun/eGIgHpjk4Ju8vbTlYuF7vUGyiI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=Ux+gN0uO; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Ux+gN0uO"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6aa282ece86so7203416d6.1
        for <git@vger.kernel.org>; Tue, 21 May 2024 12:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1716318181; x=1716922981; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ut6H9GKDZDM44Lpf1ORkfSN3Y4oKlv4R+tyO/MRJ/Q8=;
        b=Ux+gN0uOQW/WMpauSArVpfbBzx7XPMab98cgFf7dFQkyqlNr4tEbgaF5SuwDDkzeCT
         ONv4vSU0kmxlPhvUt/XpaweS62BpZ5tDb28i72c4DviLRmdL8scAR6iTt7ZhP7NYzsNd
         X3ZsJQqwiv9rBRKsWL2DIlAWcR7yJVrWHVbuGBS8bTE8O07E3dOZ3frlGXBH+Ht7hc6D
         QA2c4ovrFd+vI1hvWt0DJhA0tog0MAtC99j0+g/nuvvoFIEoKQy3Qa7YLeR02z8YzA8R
         lpYDOI2HAlSJDTDtvSgglsVhQNsAH6u4mmvVc85LgUWKv1FrfnXbtl0G2OoOWCjHBRoI
         tSWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716318181; x=1716922981;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ut6H9GKDZDM44Lpf1ORkfSN3Y4oKlv4R+tyO/MRJ/Q8=;
        b=w2gpsQbjADWmBjExCR1jrZioR09cbxPMmtAaUfH9xnLL+U9Klrb+qpmX7KyOhz2ile
         qYP+G+VvnjmRcG/XYXkdKWS86RWTYXCiKSonHFoFtJ6JwYDFFrGF3YOAfNM7rgXiOypp
         uhGXoCsLdDdFIUMKePQ7mgVvEyIBBvefsLMlATZYRC6hjwJ9OoQmRzADCvh0jhkFRbyL
         bwVX5Cv64C4YmeQGqKF13wi/TT6mlYmkDTNai84Jrk3eY7nwxZeLoS2lv8SD2ljTWR95
         4tL/fcIluIAZyvZ9p645nHND9szySOKqN7R/0RHUiFjIqiZ0GFsjs6M+/opVEtACz4uk
         PEbQ==
X-Gm-Message-State: AOJu0YwoNuXRUJYIao4tmX9Qr13ZBvEOzQJIt/00wxNdtxIsKfxC/J0J
	bsPfXUMGSzYZcE1GelckBMt3jR3gFLrl2HjfFIQKRAMr23oTaCmctJEDPMyMG4774rplGdZTdvu
	1
X-Google-Smtp-Source: AGHT+IEwcR9W7pDMzVx0xDpExFXQM+SD4poU7wAATz97Ef/f1KGmLlGmHE85UyaWf7/KCCfj47cZog==
X-Received: by 2002:a05:6214:43c3:b0:6a9:452b:196a with SMTP id 6a1803df08f44-6a9452b1b40mr105534316d6.41.1716318181597;
        Tue, 21 May 2024 12:03:01 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a62014446fsm42997616d6.31.2024.05.21.12.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 12:03:00 -0700 (PDT)
Date: Tue, 21 May 2024 15:02:59 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 25/30] t/test-lib-functions.sh: support `--date` in
 `test_commit_bulk()`
Message-ID: <890f6c4b9deb9e3bf02aa180c7ad4ced7f7b6a80.1716318089.git.me@ttaylorr.com>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1716318088.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1716318088.git.me@ttaylorr.com>

One of the tests we'll want to add for pseudo-merge bitmaps needs to be
able to generate a large number of commits at a specific date.

Support the `--date` option (with identical semantics to the `--date`
option for `test_commit()`) within `test_commit_bulk` as a prerequisite
for that.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/test-lib-functions.sh | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 862d80c9748..16fd585e34b 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -458,6 +458,7 @@ test_commit_bulk () {
 	indir=.
 	ref=HEAD
 	n=1
+	notick=
 	message='commit %s'
 	filename='%s.t'
 	contents='content %s'
@@ -488,6 +489,12 @@ test_commit_bulk () {
 			filename="${1#--*=}-%s.t"
 			contents="${1#--*=} %s"
 			;;
+		--date)
+			notick=yes
+			GIT_COMMITTER_DATE="$2"
+			GIT_AUTHOR_DATE="$2"
+			shift
+			;;
 		-*)
 			BUG "invalid test_commit_bulk option: $1"
 			;;
@@ -507,7 +514,10 @@ test_commit_bulk () {
 
 	while test "$total" -gt 0
 	do
-		test_tick &&
+		if test -z "$notick"
+		then
+			test_tick
+		fi &&
 		echo "commit $ref"
 		printf 'author %s <%s> %s\n' \
 			"$GIT_AUTHOR_NAME" \
-- 
2.45.1.175.gbea44add9db

