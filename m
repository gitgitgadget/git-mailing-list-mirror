Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7A4249FA
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 21:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AmLNS1Nm"
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD81ED
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 14:49:47 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2c51682fddeso2845401fa.1
        for <git@vger.kernel.org>; Tue, 31 Oct 2023 14:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698788985; x=1699393785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8uqWxWouL4vh0J+sbGw0YzrHfpOz1TO2fQBF3kyGipY=;
        b=AmLNS1NmdnOFXsKllqDjD9+SI0vJ9XN1nfQKMcrc+VngfQVeT5m11xydVrzBQ9AEwI
         ElRAwrfPL31fdUdSK2jUwHJgBjkkojCnOZXYgVl0Wfpp3e5zzvUeavS3dAp3C2AYSnoK
         u9YIa0F0yOkQklMEyVTj2xX8YGGejb1SzmNJyAwsA84JHBBk0F4TjBxhgJ2UsHFPgRqN
         3SA8rRLy/obd+gdD0Y8aklLV7NZrGgnwWRuqiOCgQP6kwJttb1Gx42BuBQZTDqG/Mhp5
         y/FuMHSTIPNfopZOszT2HOy49JBtKSonIxZxthUoj8nK5HXFA29ks99DqnHlX6fnW5Ca
         P9YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698788985; x=1699393785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8uqWxWouL4vh0J+sbGw0YzrHfpOz1TO2fQBF3kyGipY=;
        b=SY+KQUBguMsUJs2GaUsgW8ufmUYhn6SCpgcmK04X+PuzNTguuQps+c4TNECDtS2vWi
         kKEhOWpCQDQ4vMf9E6n9JpC4eyuiO3fEMKsG8+H+U4nfX2bmd4qQGCfEcl8l6KTZuIl6
         lRTGdIXwoxHDa61AoFQHBGIfIrgmFrfAkdh9PHLF9qFddDrMTJydesHMAkNoly+QEIDI
         +PcZTLCdfINAFubyOuCFo/Z5jWcg+af/MzmOfT8uuJTVUliV1+q6qmA52ffsE+VgvT+3
         IAcX4tj1MBmp+UIYxSzpJxpF8qQ4yOxU54js2YiHiL7zdeq1qTHELJ7ouJscNwBm65X2
         3DPA==
X-Gm-Message-State: AOJu0YyNEfhlbdOrZ1xxdd1t0SuowyoU4BI8cQSN5TWb5E9zGh535ve8
	6SDhHqYdTWEUUMeFEEEYuub8Hy4bv8A=
X-Google-Smtp-Source: AGHT+IHuZsdn+5+qxjs16++UoL2fnsjbQMp2mSVtr0SQf4HQoY4xjVEIxt9wYvKaLE8j5En3WzONSw==
X-Received: by 2002:a2e:9457:0:b0:2c4:fdaf:1d62 with SMTP id o23-20020a2e9457000000b002c4fdaf1d62mr283349ljh.11.1698788985176;
        Tue, 31 Oct 2023 14:49:45 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id m10-20020a2eb6ca000000b002c023d3dadesm25108ljo.113.2023.10.31.14.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 14:49:44 -0700 (PDT)
From: =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 1/1] merge-file: add an option to process object IDs
Date: Tue, 31 Oct 2023 22:48:57 +0100
Message-ID: <20231031214859.25293-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.42.0.899.gfd14d11e2b
In-Reply-To: <20231030162658.567523-2-sandals@crustytoothpaste.net>
References: <20231030162658.567523-2-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Mon, 30 Oct 2023 at 17:37, brian m. carlson <sandals@crustytoothpaste.net> wrote:
>
> Since we obviously won't be writing the data to the first argument,
> imply the -p option so we write to standard output.

This paragraph changed from v1, but this doesn't match the actual
behavior, from what I can tell: `-p` is not implied.

>  'git merge-file' [-L <current-name> [-L <base-name> [-L <other-name>]]]
>         [--ours|--theirs|--union] [-p|--stdout] [-q|--quiet] [--marker-size=<n>]
>         [--[no-]diff3] <current-file> <base-file> <other-file>
> +'git merge-file' --object-id [-L <current-name> [-L <base-name> [-L <other-name>]]]
> +       [--ours|--theirs|--union] [-p|--stdout] [-q|--quiet] [--marker-size=<n>]
> +       [--[no-]diff3] <current-oid> <base-oid> <other-oid>

I see this duplicated synopsis was discussed on v1, and that the
difference here is "file" vs "oid". It seems we could avoid this
redundancy and risk of going out of sync with no downside that I can see
by instead dropping all these "-file". See below for a patch that could
go in as a preparatory step.

> +If `--object-id` is specified, exactly the same behavior occurs, except that
> +instead of specifying what to merge as files, it is specified as a list of
> +object IDs referring to blobs.

Makes sense.

> +If the `-p` option is specified, the merged file (including conflicts, if any)
> +goes to standard output as normal; otherwise, the merged file is written to the
> +object store and the object ID of its blob is written to standard output.

(Here, `-p` is not implied.)

> +test_expect_success 'merge without conflict with --object-id' '
> +       git add orig.txt new2.txt &&
> +       git merge-file --object-id :orig.txt :orig.txt :new2.txt >actual &&
> +       git rev-parse :new2.txt >expected &&
> +       test_cmp actual expected
> +'

(Here, `-p` is not implied.)

Martin

-- >8 --
Subject: [PATCH] git-merge-file doc: drop "-file" from argument placeholders

`git merge-file` takes three positional arguments. Each of them is
documented as `<foo-file>`. In preparation for teaching this command to
alternatively take three object IDs, make these placeholders a bit more
generic by dropping the "-file" parts. Instead, clarify early that the
three arguments are filenames. Even after the next commit, we can afford
to present this file-centric view up front and in the general
discussion, since it will remain the default one.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/git-merge-file.txt | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-merge-file.txt b/Documentation/git-merge-file.txt
index 7e9093fab6..bf0a18cf02 100644
--- a/Documentation/git-merge-file.txt
+++ b/Documentation/git-merge-file.txt
@@ -11,19 +11,20 @@ SYNOPSIS
 [verse]
 'git merge-file' [-L <current-name> [-L <base-name> [-L <other-name>]]]
 	[--ours|--theirs|--union] [-p|--stdout] [-q|--quiet] [--marker-size=<n>]
-	[--[no-]diff3] <current-file> <base-file> <other-file>
+	[--[no-]diff3] <current> <base> <other>
 
 
 DESCRIPTION
 -----------
-'git merge-file' incorporates all changes that lead from the `<base-file>`
-to `<other-file>` into `<current-file>`. The result ordinarily goes into
-`<current-file>`. 'git merge-file' is useful for combining separate changes
-to an original. Suppose `<base-file>` is the original, and both
-`<current-file>` and `<other-file>` are modifications of `<base-file>`,
+Given three files `<current>`, `<base>` and `<other>`,
+'git merge-file' incorporates all changes that lead from `<base>`
+to `<other>` into `<current>`. The result ordinarily goes into
+`<current>`. 'git merge-file' is useful for combining separate changes
+to an original. Suppose `<base>` is the original, and both
+`<current>` and `<other>` are modifications of `<base>`,
 then 'git merge-file' combines both changes.
 
-A conflict occurs if both `<current-file>` and `<other-file>` have changes
+A conflict occurs if both `<current>` and `<other>` have changes
 in a common segment of lines. If a conflict is found, 'git merge-file'
 normally outputs a warning and brackets the conflict with lines containing
 <<<<<<< and >>>>>>> markers. A typical conflict will look like this:
@@ -36,8 +37,8 @@ normally outputs a warning and brackets the conflict with lines containing
 
 If there are conflicts, the user should edit the result and delete one of
 the alternatives.  When `--ours`, `--theirs`, or `--union` option is in effect,
-however, these conflicts are resolved favouring lines from `<current-file>`,
-lines from `<other-file>`, or lines from both respectively.  The length of the
+however, these conflicts are resolved favouring lines from `<current>`,
+lines from `<other>`, or lines from both respectively.  The length of the
 conflict markers can be given with the `--marker-size` option.
 
 The exit value of this program is negative on error, and the number of
@@ -62,7 +63,7 @@ OPTIONS
 
 -p::
 	Send results to standard output instead of overwriting
-	`<current-file>`.
+	`<current>`.
 
 -q::
 	Quiet; do not warn about conflicts.
-- 
2.42.0.899.gfd14d11e2b

