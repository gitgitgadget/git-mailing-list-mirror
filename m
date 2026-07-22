Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D05C30ACF1
	for <git@vger.kernel.org>; Wed, 22 Jul 2026 12:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784723006; cv=none; b=WGZaAagFyUzgLWycWtuClgPARtc3se0Hg271RLW6go8d4rxKHpyKOmZ39+7lsaUHBJbyXBtEMIZ2I2jm9Bor6KlffKA+4jZsC+2MP8UOpmsZw4H9uMFqHv4zcl/fS+ALxdriylzMyfeVPKfX24JJ1KN3eViKczaLwOWiEMJhx6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784723006; c=relaxed/simple;
	bh=kOTc0rcw/JrtN3CzMsMhhLQ8jpydwBEtFHMxFJVHhWY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=N745rcVVoj3aV7K2JgIF8jDMyFgL2/RWBemgpaPxaHSBXI5Xwq0hzqCx5Sv9haDPSlN3lFi5H10q5eLWyOWZeUMBAh48jvLEiU88s72ViRkxW7S9BWjVHDFrqdpk4eg8m6xm5KA0oc0T2WKadVUHD75jsl9iA8bCJgMyyOJZUoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b4C08Zce; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4C08Zce"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49556f97a9dso25617815e9.1
        for <git@vger.kernel.org>; Wed, 22 Jul 2026 05:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784722995; x=1785327795; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:message-id:date:content-type
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=URRrYBda8SKOHAyhiaX85I4U4RzuFKyAWqJDPfppdQM=;
        b=b4C08Zce5IB/VLkKJ/gYUYT/RpsuClblLr+gEU6fplvPzqxuW0E10ZH0BznBia9VFG
         +dJwceet1WpUlDuk+ij+y5S7Q8AR/dB7p6jd+Qv5kPNRqTA4en9LaTUw+aZUpcHlE44W
         DtqGgJbMF4t+8SDu0fcCleN9amtLCoA+O8jYzMdIxv1yMbT+KzU83WgILvoQ0Bgp5+b4
         LODfIbV09EZeJqL3ZS5Vjaf8DY+o0G4qVqxQN1MEFEycDw3eWs5AgKN+Gg45EI40eIb0
         4WRbd1mydZ9fZG8OP9C6zPp0JsnJ4D5wS0//ndLJ9aaKuDgiSVLUydbmNIflaDCK9ZgV
         +/JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784722995; x=1785327795;
        h=in-reply-to:references:to:from:subject:message-id:date:content-type
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=URRrYBda8SKOHAyhiaX85I4U4RzuFKyAWqJDPfppdQM=;
        b=X7V8Vn0Lu2KDSBgFlJSTYrEAk+/VT+/B/7RRSR7wqwrc0CmdyBEFhA5Aq1FbQk6quL
         VlB8HFPg47d/4yei5zlN92OFxxoCiBxjeMiyCramKRzI91uFeF3k+sySXqOPJoAn2gkh
         eYtEaNEpuXGOQEZTBkldkRKQNYykGpBYpKYi9wvzLNvEk6D0NhDhE6UDHJWCeJTesIcR
         GThYmqKBlWIcBqbsNEsMJuvkx5vUiRCdwwD90li3QIKLIRYXsAr4zpd65kv6A5lAYWef
         +azGtTYdSQKYTOl9l4iiLGxLse6ibj8z/pj8o3X2xwv6oBwdhgH9K+UVt79jh8AZTJPU
         mVmw==
X-Forwarded-Encrypted: i=1; AHgh+Rp6Vl6BR2e5hp+d+42tYHp+gspNZ+MFGLR8fBOO8n6XeH0X+biUwVC8Pgo/RDVSxtjxQPg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeEZlGHOWdlcnIfXLu7MgxwJyxotl0bZnWkc9BQ2pj2tSSzCLN
	8xcmSThwB+kJGGlObnHnd7V23uAX937CCi1JlLIgT04es5LAm+NQ36gXSVMTgZ/m
X-Gm-Gg: AR+sD12kaJ8j2BGtZlHLLIENPS/JS23gSwMxkPr3gqpMYypeliPDBsr4sndghQ135HR
	MB4G3PJUOTxOc0SrnBU6kKbTRhL0/JvjPfAfCnEpRPZeICyq18fSVZbRoGPDiMJb/8b0RWaBFHt
	akKEn86ohfOCY9YeMzNRCVYoYZKY8Xee6sLb/61aGqlPykFlbnJ+O/lor6dnBOdJRDBORleDB1t
	FaWHSyXKgzyOd00W6gXLhkpyDt+Ckz+WXeKeDIUKI3YTjYfLySgexVzRS0nqiP2jX67OL+DcIM7
	nU75GPjSb1KCvvDe4Jrj6PTUewQHAI12ByGsPtX0RqylmuIQISPnPbijNxj1rImQEsk/eU0zqb8
	azQ4pG+iFdl2QSHim7S96KPxbP97+jd4DV+hboekLcNJOe0rE86j+mRRjAa/s1VdSp/sZ25Y0pv
	uznaJKWwxCcsdLFskFdBe1E8BL5Gaa7wpEL1aeFe27OshHdyajLPRajRw2MESDgmRFNy+ieHQFD
	S8C5DQfnfWCmRwsCl2gf91NtJ7Zq7zB/G3+dtwQmCEOve7y1NSqtfRxdG3HfuaTGc13uDxbrao7
	R5TnB7nHes3+X3FD6rWITObwProdyFFlzkhWSWWsfBaptC8teQ8bmAhU
X-Received: by 2002:a05:600c:1550:b0:495:6e68:5df2 with SMTP id 5b1f17b1804b1-4956e685e95mr14541755e9.12.1784722994739;
        Wed, 22 Jul 2026 05:23:14 -0700 (PDT)
Received: from localhost (82.159.183.80.static.user.ono.com. [82.159.183.80])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956b030a64sm46036755e9.3.2026.07.22.05.23.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2026 05:23:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Jul 2026 14:23:12 +0200
Message-Id: <DK53I00U9FJS.2MUNWC5000IZ5@gmail.com>
Subject: Re: [PATCH 1/1] Extract only the message body from git commit.
From: "Pablo Sabater" <pabloosabaterr@gmail.com>
To: "hardikxk" <hardikxk@gmail.com>, <git@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260722083836.744338-1-hardikxk@gmail.com>
 <20260722083836.744338-2-hardikxk@gmail.com>
In-Reply-To: <20260722083836.744338-2-hardikxk@gmail.com>

On Wed Jul 22, 2026 at 10:38 AM CEST, hardikxk wrote:
> The patch fixes the `extractLogMessageFromGitCommit` function to skip all=
 the metada of the commit object and only return back the message body.

nit: wrap this long line to a max of ~72 columns.
nit: s/metada/metadata/

>
> Previously the function would return the entire data of the objects
> including authors tree and SHAs. This patch fixes that to skip over all
> that and just return the body of the log message.

nit: I think this can be written more clearly. Let's use present tense
and state things affirmatively:

  extractLogMessageFromGitCommit() returns the entire object data,
  including authors, tree and SHAs.
  Make it return only the log message body.

Don't take this suggestion literally, as we find below that this log
does not match reality.

You may find Documentation/CodingGuidelines and
Documentation/SubmittingPatches interesting.

>
> Signed-off-by: hardikxk <hardikxk@gmail.com>
> ---
>  git-p4.py | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/git-p4.py b/git-p4.py
> index c0ca7be..589efcd 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -1003,12 +1003,18 @@ def branchExists(ref):
>  def extractLogMessageFromGitCommit(commit):
>      logMessage =3D ""
>
> -    # fixme: title is first line of commit, not 1st paragraph.
> +    foundNewLine =3D False
>      foundTitle =3D False
>      for log in read_pipe_lines(["git", "cat-file", "commit", commit]):
> -        if not foundTitle:
> +        if not foundNewLine:
> +            # skip anything that is not the commit message
>              if len(log) =3D=3D 1:
> -                foundTitle =3D True
> +                foundNewLine =3D True
> +            continue
> +
> +        # everything from here is the commit message
> +        if not foundTitle:
> +            foundTitle =3D True
>              continue
>
>          logMessage +=3D log

Reading the code, this doesn't seem to do what the log says it does.
Testing it against what it did before this patch:

First we need to do a bit of investigation, but we end up finding
that the commit that introduced this '# fixme' was:

  b016d39756 (Robustness fixes for pipes, 2007-05-23)

I couldn't find a thread about this commit.

*Note that the output does not have line breaks; I'm adding them for
readability*.

previously:

'Extract only the message body from git commit.\n\nThe patch fixes the
`extractLogMessageFromGitCommit` function to skip all the metada of the
commit object and only return back the message body.\n\nPreviously the
function would return the entire data of the objects\nincluding authors
tree and SHAs. This patch fixes that to skip over all\nthat and just
return the body of the log message.\n\nSigned-off-by: hardikxk <hardikxk@gm=
ail.com>\n'

after the patch:

'\nThe patch fixes the `extractLogMessageFromGitCommit` function to skip
all the metada of the commit object and only return back the message
body.\n\nPreviously the function would return the entire data of the
objects\nincluding authors tree and SHAs. This patch fixes that to skip
over all\nthat and just return the body of the log message.
\n\nSigned-off-by: hardikxk <hardikxk@gmail.com>\n'

We can see that the previous output only shows the commit log, title
+ body. There were no SHAs, tree, etc., the opposite of what this
patch's log claimed.

What this patch actually does is drop the commit subject.

Is this what the '# fixme' meant? I'm making assumptions here, since I
couldn't find a thread to be sure why it was added, but I think it is
either about the loop stopping at the blank line rather than at the title
itself, or a warning that a title is just one line and not a paragraph.

Either way, this patch does not address the '# fixme' correctly.

Before continuing, I think we should try to understand what the '# fixme'
meant in the first place.

Regards,
Pablo.

