Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73D61BDEC
	for <git@vger.kernel.org>; Wed,  3 Jan 2024 17:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="LMtc5LR9"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4280e3ab14fso30531541cf.2
        for <git@vger.kernel.org>; Wed, 03 Jan 2024 09:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1704302128; x=1704906928; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V9wdi0RPwvtMw0Bb7H+EbaPd5NM7Ww3Knj9AYaNRtEI=;
        b=LMtc5LR9ASWo8/dxmCJO2Eqw90J8Iq6oEaoVkm2velAfWJW2ztF43PWw5ySo4t2uXF
         LDmYuRK4Z+FCI5KNtYa0RVBs1TQjNpxtiaHLzcorfPGG6L+rdoa3kaUUZmi2jmMshkKD
         vrYW9cCVTVIXcOKVoQRRwcPtVeNTwxV7UZD75d2EZ/HIeaDvB3lGHE1K63NxujkABqFi
         jLgz0yKRUBXVghwbk1pz0tUeNvcTDYNY8QlOYt5qHlda+lQpm8qNj6pZok1EoVDTS/PH
         qxWvbol5hKEeYsxEyf4HUy0QvL828ZQS5srsWX25dqY090v2O65p1av9EKTEzs5NgX2Z
         WDWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704302128; x=1704906928;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V9wdi0RPwvtMw0Bb7H+EbaPd5NM7Ww3Knj9AYaNRtEI=;
        b=sakFdz1R9BZkdZdvOpF1NJiDwNlEksaE4w60J7aDW6cMXrLKiKhihbhikWo2O0s57t
         i26jM4j1rM3g5btNMKk38UoIh2qPrmW8rhhKd7IoXGci2KnCKomN2fyYSg6zysJ0dpad
         ZwgwtaKM6KJxTIn4+uYBkTTe3IDP8enQx7hi/z0qObNn3aCqfVGVYIiHTWdTnLznscs4
         RZqPhc0VsQkjXLXlYKYaZKnZ7N/EK+ahpJXUun62eoZBo7iMCEYVYMJb+eQTygeHiZ6o
         rNsOHKwiigdSASdMYHc8WLPaUynXG8njGHjxn31ChslQQFq3z4cqXcdSSSRLbCP3czaW
         9ORw==
X-Gm-Message-State: AOJu0YwekxtUoE74IpRWj1ZtCbXWWBcQlUMWknFvqdiN6zLXQelsO7jf
	LUi7xSIYc8NIeJxRtlXPMO9PhlMWbirGQg==
X-Google-Smtp-Source: AGHT+IH32x3uPrDmR1V7YWbRp9gNUxyafa0B/D5QoSMoUxv02rq7MZpLjOJbreUVn9vGwzMVhYpeQg==
X-Received: by 2002:a05:622a:1208:b0:417:a514:72d2 with SMTP id y8-20020a05622a120800b00417a51472d2mr29668061qtx.63.1704302127755;
        Wed, 03 Jan 2024 09:15:27 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id hg19-20020a05622a611300b00427e708cc91sm8349206qtb.42.2024.01.03.09.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 09:15:27 -0800 (PST)
Date: Wed, 3 Jan 2024 12:15:26 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Chandra Pratap via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Chandra Pratap <chandrapratap376@gmail.com>,
	Chandra Pratap <chandrapratap3519@gmail.com>
Subject: Re: [PATCH v2] write-or-die: make GIT_FLUSH a Boolean environment
 variable
Message-ID: <ZZWWLkY+ixg+OMM4@nand.local>
References: <pull.1628.git.1703955246308.gitgitgadget@gmail.com>
 <pull.1628.v2.git.1704268708720.gitgitgadget@gmail.com>
 <ZZUZNQqDTx3bnveJ@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZZUZNQqDTx3bnveJ@tanuki>

On Wed, Jan 03, 2024 at 09:22:13AM +0100, Patrick Steinhardt wrote:
> On Wed, Jan 03, 2024 at 07:58:28AM +0000, Chandra Pratap via GitGitGadget wrote:
> [snip]
> > diff --git a/write-or-die.c b/write-or-die.c
> > index 42a2dc73cd3..a6acabd329f 100644
> > --- a/write-or-die.c
> > +++ b/write-or-die.c
> > @@ -20,15 +20,12 @@ void maybe_flush_or_die(FILE *f, const char *desc)
> >  {
> >  	static int skip_stdout_flush = -1;
> >  	struct stat st;
> > -	char *cp;
> >
> >  	if (f == stdout) {
> >  		if (skip_stdout_flush < 0) {
> > -			/* NEEDSWORK: make this a normal Boolean */
> > -			cp = getenv("GIT_FLUSH");
> > -			if (cp)
> > -				skip_stdout_flush = (atoi(cp) == 0);
> > -			else if ((fstat(fileno(stdout), &st) == 0) &&
> > +			if (!git_env_bool("GIT_FLUSH", -1))
> > +				skip_stdout_flush = 1;
>
> It's a bit surprising to pass `-1` as default value to `git_env_bool()`
> here, as this value would hint that the caller wants to explicitly
> handle the case where the "GIT_FLUSH" envvar is not set at all. We don't
> though, and essentially fall back to "GIT_FLUSH=1", so passing `1` as
> the fallback value would be less confusing.
>
> Anyway, the resulting behaviour is the same regardless of whether we
> pass `1` or `-1`, so I'm not sure whether this is worth a reroll.

Hmm. If we pass -1 as the default value in the call to git_env_bool(),
the only time we'll end up in the else branch is if the environment is
set to some false-y value.

I don't think that matches the existing behavior, since right now we'll
infer skip_stdout_flush based on whether or not stdout is a regular file
or something else.

I think you'd probably want something closer to:

--- 8< ---
diff --git a/write-or-die.c b/write-or-die.c
index 42a2dc73cd..f12e111688 100644
--- a/write-or-die.c
+++ b/write-or-die.c
@@ -19,20 +19,17 @@
 void maybe_flush_or_die(FILE *f, const char *desc)
 {
 	static int skip_stdout_flush = -1;
-	struct stat st;
-	char *cp;

 	if (f == stdout) {
 		if (skip_stdout_flush < 0) {
-			/* NEEDSWORK: make this a normal Boolean */
-			cp = getenv("GIT_FLUSH");
-			if (cp)
-				skip_stdout_flush = (atoi(cp) == 0);
-			else if ((fstat(fileno(stdout), &st) == 0) &&
-				 S_ISREG(st.st_mode))
-				skip_stdout_flush = 1;
-			else
-				skip_stdout_flush = 0;
+			skip_stdout_flush = git_env_bool("GIT_FLUSH", -1);
+			if (skip_stdout_flush < 0) {
+				struct stat st;
+				if (fstat(fileno(f), &st))
+					skip_stdout_flush = 0;
+				else
+					skip_stdout_flush = S_ISREG(st.st_mode);
+			}
 		}
 		if (skip_stdout_flush && !ferror(f))
 			return;
--- >8 ---

You could lose one level of indentation, but it costs an extra fstat()
call in the case where GIT_FLUSH is set to some explicit value. Doing
that would look like this ugly thing instead ;-):

--- 8< ---
diff --git a/write-or-die.c b/write-or-die.c
index 42a2dc73cd..b3275d7577 100644
--- a/write-or-die.c
+++ b/write-or-die.c
@@ -19,20 +19,11 @@
 void maybe_flush_or_die(FILE *f, const char *desc)
 {
 	static int skip_stdout_flush = -1;
-	struct stat st;
-	char *cp;

 	if (f == stdout) {
 		if (skip_stdout_flush < 0) {
-			/* NEEDSWORK: make this a normal Boolean */
-			cp = getenv("GIT_FLUSH");
-			if (cp)
-				skip_stdout_flush = (atoi(cp) == 0);
-			else if ((fstat(fileno(stdout), &st) == 0) &&
-				 S_ISREG(st.st_mode))
-				skip_stdout_flush = 1;
-			else
-				skip_stdout_flush = 0;
+			struct stat st;
+			skip_stdout_flush = git_env_bool("GIT_FLUSH", !fstat(fileno(f), &st) && S_ISREG(st.st_mode));
 		}
 		if (skip_stdout_flush && !ferror(f))
 			return;
--- >8 ---

Thanks,
Taylor
