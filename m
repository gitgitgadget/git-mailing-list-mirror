Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BAE1CD19
	for <git@vger.kernel.org>; Thu,  8 Feb 2024 01:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707357445; cv=none; b=MMmEIBmeWD6CzTuk4OVZNhEltaT5xc5V4aA7qJC5fdh/TxJFU4nQF7CRYLjTmJ6/iAeqXMVJlUGpCEim5jhODN/a5HVLTTrKu4H1M6qVvFWGIJ6upMqy/BigskyzN5rtncQ7mk7t+SnwunPW/X8BdMyMFyg7NU+zet7IIES7Ovc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707357445; c=relaxed/simple;
	bh=XA8CCf3VllM6zz9yd6vMhb9vrR0KGnhqdjkYp9oVKa4=;
	h=Message-ID:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=NeZf3ReB8frQA7hSTinMiAQzqpCHSYQ+o+0XSb7wvFQCCqG44RMYp/mgwc+lZX+ur25eY5UyuBAz5d3qajb5IYKyT7aooMD5gY18j/2OmhtVSEWo6cSwpEoCLvanducBOHfw48jCVfyZ+fWstu7UdOsTljOS5E82tMrTvylgXWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aYPfFXUB; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aYPfFXUB"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40fc6343bd2so11527195e9.1
        for <git@vger.kernel.org>; Wed, 07 Feb 2024 17:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707357441; x=1707962241; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7dXrqCdI18cNWjuHdrsHyAxADqY9rlWeVBsBXrJeZt4=;
        b=aYPfFXUBMXueQCBfMhtjfwmTTbbOi9h+RHDMpfbgHeqzMPfQDAFdcY2n7wynOVp33/
         6rLR169EZpqcplfu7zyRspThlLrUJeoKLPq2Mzefr4+1UAG5b+I/fFLkMavSdPX+0I9m
         HLBhY+CY6vBtHrofM8ozQiWzQSxesIV7HHXts5bwcjpxatCg2I2vSSu6pvkm59fXyifZ
         S62wNh8fnAy5Tv3NL222ufgf6gMFXk+IGQQPIrZKlJTJxYfqEbN4VeJoh0R/pEZFA8L1
         po1Wadp5wg3KQsZb0fKVGUQylj+Ihl97nlSW+PyoxwfTViqucryi/3z4At0pJIj1w28t
         X09g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707357441; x=1707962241;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7dXrqCdI18cNWjuHdrsHyAxADqY9rlWeVBsBXrJeZt4=;
        b=uqYH6Tfp1Xv7VPRt4A3ONJDmEjoN4eJ1ZYnesuzDHxK0eQhSHR9BFvEMidXZUpL12D
         skQMoWzWlUBHJsxv5Rux8z5AaKB4oX13mdIVzEPO9CoJY0257tScTpzusDIFHbtRMfHG
         xzrXSygkYJcm6seNlVSzsV8eeU733o3SkvSHeG1sLhqp3VEcq56uNp3qkH3rfvhRyDcb
         GYuwv+/j+oh6qgjY1/6arYghya8spgz1wT/YOI+Aq0v1j3pDNJilQ3EDqByDFcCTfbqu
         YcBtIvnflrJVy+o3FubfYbHx74208dh65P0gP7NBEzo6hr6er/LjvE6NwdSSdKD9zpkV
         Lnhg==
X-Gm-Message-State: AOJu0Yx0WN6tRjdeLVh3nQp7gSRkXgTROzl0di5ECLhxXoRt+HCzJ/7k
	DH67HmtaHaji1s9YRDi2U4QR+tzVmy0+1EgxG4ytN7aoybugdsy/ohKDWr+X
X-Google-Smtp-Source: AGHT+IFVid+IX5SVHPF54LEnDMk2+Ox+r/jGbkxrPmE7LX9c/uo8KaPyOxgkCR1/YMPu7OQGWU1OcA==
X-Received: by 2002:a05:600c:4e92:b0:40e:dbdf:9fb4 with SMTP id f18-20020a05600c4e9200b0040edbdf9fb4mr5628922wmq.23.1707357440766;
        Wed, 07 Feb 2024 17:57:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id fb12-20020a05600c520c00b004103bd6f21dsm63595wmb.35.2024.02.07.17.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 17:57:20 -0800 (PST)
Message-ID: <pull.1655.git.1707357439586.gitgitgadget@gmail.com>
From: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 08 Feb 2024 01:57:19 +0000
Subject: [PATCH] ref-filter.c: sort formatted dates by byte value
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
Cc: Victoria Dye <vdye@github.com>,
    Victoria Dye <vdye@github.com>

From: Victoria Dye <vdye@github.com>

Update the ref sorting functions of 'ref-filter.c' so that when date fields
are specified with a format string (such as in 'git for-each-ref
--sort=creatordate:<something>'), they are sorted by their formatted string
value rather than by the underlying numeric timestamp. Currently, date
fields are always sorted by timestamp, regardless of whether formatting
information is included in the '--sort' key.

Leaving the default (unformatted) date sorting unchanged, sorting by the
formatted date string adds some flexibility to 'for-each-ref' by allowing
for behavior like "sort by year, then by refname within each year" or "sort
by time of day". Because the inclusion of a format string previously had no
effect on sort behavior, this change likely will not affect existing usage
of 'for-each-ref' or other ref listing commands.

Additionally, update documentation & tests to document the new sorting
mechanism.

Signed-off-by: Victoria Dye <vdye@github.com>
---
    ref-filter.c: sort formatted dates by byte value
    
    I came across a use case for 'git for-each-ref' at $DAYJOB in which I'd
    want to sort by a portion of a formatted 'creatordate' (e.g., only the
    time of day, sans date). When I tried to run something like 'git
    for-each-ref --sort=creatordate:format:%H:%M:%S', though, I was
    surprised to find that the refs were still sorted according to the full
    date/time value (as they would be with '--sort=creatordate').
    
    This patch attempts to make date-based sorting a bit more flexible by
    ordering based on the formatted date string if and only if a custom
    format is specified. The implementation is fairly simple (manually set
    the comparison type to 'FIELD_STR' if the format string is not null),
    but I'm interested in hearing from reviewers whether this seems like a
    reasonable extension to 'git for-each-ref --sort', or if there's another
    (better) way to add this kind of functionality.
    
    Thanks!
    
     * Victoria

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1655%2Fvdye%2Fvdye%2Ffor-each-ref-date-sorting-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1655/vdye/vdye/for-each-ref-date-sorting-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1655

 Documentation/git-for-each-ref.txt |  8 ++++--
 ref-filter.c                       |  6 ++++
 t/t6300-for-each-ref.sh            | 46 ++++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index be9543f6840..3a9ad91b7af 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -359,9 +359,11 @@ In any case, a field name that refers to a field inapplicable to
 the object referred by the ref does not cause an error.  It
 returns an empty string instead.
 
-As a special case for the date-type fields, you may specify a format for
-the date by adding `:` followed by date format name (see the
-values the `--date` option to linkgit:git-rev-list[1] takes).
+As a special case for the date-type fields, you may specify a format for the
+date by adding `:` followed by date format name (see the values the `--date`
+option to linkgit:git-rev-list[1] takes). If this formatting is provided in
+a `--sort` key, references will be sorted according to the byte-value of the
+formatted string rather than the numeric value of the underlying timestamp.
 
 Some atoms like %(align) and %(if) always require a matching %(end).
 We call them "opening atoms" and sometimes denote them as %($open).
diff --git a/ref-filter.c b/ref-filter.c
index 35b989e1dfe..be14b56e324 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1611,6 +1611,12 @@ static void grab_date(const char *buf, struct atom_value *v, const char *atomnam
 	if (formatp) {
 		formatp++;
 		parse_date_format(formatp, &date_mode);
+
+		/*
+		 * If this is a sort field and a format was specified, we'll
+		 * want to compare formatted date by string value.
+		 */
+		v->atom->type = FIELD_STR;
 	}
 
 	if (!eoemail)
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 843a7fe1431..eb6c8204e8b 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -1356,6 +1356,52 @@ test_expect_success '--no-sort without subsequent --sort prints expected refs' '
 	test_cmp expected actual
 '
 
+test_expect_success 'set up custom date sorting' '
+	# Dates:
+	# - Wed Feb 07 2024 21:34:20 +0000
+	# - Tue Dec 14 1999 00:05:22 +0000
+	# - Fri Jun 04 2021 11:26:51 +0000
+	# - Mon Jan 22 2007 16:44:01 GMT+0000
+	i=1 &&
+	for when in 1707341660 945129922 1622806011 1169484241
+	do
+		GIT_COMMITTER_DATE="@$when +0000" \
+		GIT_COMMITTER_EMAIL="user@example.com" \
+		git tag -m "tag $when" custom-dates-$i &&
+		i=$(($i+1)) || return 1
+	done
+'
+
+test_expect_success 'sort by date defaults to full timestamp' '
+	cat >expected <<-\EOF &&
+	945129922 refs/tags/custom-dates-2
+	1169484241 refs/tags/custom-dates-4
+	1622806011 refs/tags/custom-dates-3
+	1707341660 refs/tags/custom-dates-1
+	EOF
+
+	git for-each-ref \
+		--format="%(creatordate:unix) %(refname)" \
+		--sort=creatordate \
+		"refs/tags/custom-dates-*" >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'sort by custom date format' '
+	cat >expected <<-\EOF &&
+	00:05:22 refs/tags/custom-dates-2
+	11:26:51 refs/tags/custom-dates-3
+	16:44:01 refs/tags/custom-dates-4
+	21:34:20 refs/tags/custom-dates-1
+	EOF
+
+	git for-each-ref \
+		--format="%(creatordate:format:%H:%M:%S) %(refname)" \
+		--sort="creatordate:format:%H:%M:%S" \
+		"refs/tags/custom-dates-*" >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'do not dereference NULL upon %(HEAD) on unborn branch' '
 	test_when_finished "git checkout main" &&
 	git for-each-ref --format="%(HEAD) %(refname:short)" refs/heads/ >actual &&

base-commit: 235986be822c9f8689be2e9a0b7804d0b1b6d821
-- 
gitgitgadget
