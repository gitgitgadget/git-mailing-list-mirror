Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189363E92B6
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 11:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774350304; cv=pass; b=Tbt4ezQjY02UUVk6rgTT8Qn5Czct58A0piMxGqvrdRvN2rr9r/QexkyolgjMfP7bGH8jYMRT1Fdvm1FyfDROGKeuiHib4dr3umu49JKw8YbxhxSyYI/53d6snDqqfkmw+5GEQuoAED/TN+g3oMC8F36M7phbPX0eYpBDlAGw2r0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774350304; c=relaxed/simple;
	bh=YmZrNfLoJhwnUNBFlbOBa93eOQoaq2SDqIqxYzP5a1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IxmdM0+fIyg8qy85kvw8+2uNp0QDckVxT5bCCo3VBzSjfwcOYzOSI90po9BUh9fFU+FTa0w22bts0KDHjHbl280QjNHQstDRh8RfNP7GmuQDg7XGEhK3jZznUGODjjWe3Es25je11Liphbk0DIRUTkPTPRxxHw91lPxScCOnxXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oNPCI7FF; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oNPCI7FF"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1271257ae53so1215728c88.1
        for <git@vger.kernel.org>; Tue, 24 Mar 2026 04:05:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774350302; cv=none;
        d=google.com; s=arc-20240605;
        b=Q4clL3c2+aegTyg8BlHPFjeCVyotITKIfJ1h0yUeule/+1EqLc57dqagxg8DCO4u65
         t0ICT+hxKeDUI5LGLYrW9EPPG0TgKBdvUMKRK447xpEPrfkNxb8dwMuwn6P0KF3Y57DL
         ii59FWOtKMxNhUAn2AO5H/xaaj3a2gZEr4jkfAEyBjjbzMN6OIScFIVRCyA7oY0073UL
         vAkmAFOJn8h9tKPHzrPvwNN1gVVgEtP+aJyGDaRzd78+riZLJPL7jqhMAdbg8fwbUISP
         8mwbsk0xuUZtNTB3gZ2p9lZsx3bwkCi6m+YAIlJo35M9tRHe/9RWXu1bkutsABwxc4L2
         R3MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YmZrNfLoJhwnUNBFlbOBa93eOQoaq2SDqIqxYzP5a1M=;
        fh=/plLnf0iYB2jUKmKx5zzdFfzrLcMAzuIidbw4Nsw5bM=;
        b=DLQjvqlU8BtghSprv9eNZRVIlq2wMTjNC1QDWjmxhta8+8RHQ14YDDBGjWfpJI2U2s
         0aImyum17EtL6gv5ecvZV3WVijPPIHjYV8L2PPA02RmVn35zGuzpLuerCrrX+tLsSUMg
         3dATNqLo/nGh2GVsAM10UOe7tGq7KlYUCZ9jDI9uvgfgrHLzJx/BXQqtQyHLM4++0sR3
         EN6kNhTSXFHHWor+dCHtjSlmZpwTrA0B6qfi/JmNykU8gho63F6EYyDDLrfhwUTEyqqy
         EVFn4lDCEmU1Pkn5BYuFs5SqoHiGfJTIhgdHRPN8SjQaXlwShgne7kC20yten2dz7O7s
         cIgA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774350302; x=1774955102; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YmZrNfLoJhwnUNBFlbOBa93eOQoaq2SDqIqxYzP5a1M=;
        b=oNPCI7FFQI8RtGz6crXdI2zbSneQbjgA72b8wFz1tUdIM07vDjSSpk+XXAhqwSKA0N
         Z6Y1LChgAfg8BpYFVRm13vb18i8Wr1J37GXIvT9ZjfHN081WknZtIijIzQi3M6/6iAO2
         cOD7/7DATZSkvzdRWWKLi/lK/vKnBx8bpzGPYsaJpJOFKwXqFZj4fz6tolmZjCMugKW9
         O93uN6RbV6QUCXf1tKDmnzgt6V11ay275iMr4Q3CCowJKhPY7CQD31pn4lTnyYpeAwMH
         t2tLvKgPgbfhXHls8hX0DTrJkNk/6vKcX+pzFaYW5uDDCsW8zAwdGj3BcugHdD0ZayQR
         ojwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774350302; x=1774955102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YmZrNfLoJhwnUNBFlbOBa93eOQoaq2SDqIqxYzP5a1M=;
        b=Vbos69AMBCiNIF/eFAhNh3ifbG50hVm6K+imN44OmzLYxb7XfeCcF5cptZBiBDZGpj
         iPsuuOIcbruZbu3MuWtBHyXk9gVAaQZhYLtXpiHI7atXMFSu9ZP8QBWSXe8dI0DMYezV
         DJO7gACAuzE3AUSZPGLLpBEWNZUQJWQAfVXAP0guRRFnRplC0aFCT5Nl/GF2qPHmO5rU
         qou2EEdo70B+k59kGqh0uGzATDwXOssSI27gQSus/SC+xLG3bMzD/giXlbbikQQUo06G
         ld0x4G/XBmOVMR+i0ANHZX8MogmoVWykLZq94chISToklKh7448cU9RnSS4CufJ26mmI
         DBxQ==
X-Gm-Message-State: AOJu0Ywpd6X0E+HWwwJm807cX430oQwLBRLm9CXaLkb2JDum3xhziswO
	VrPfm3p33k/LTF9aHiaiErkQOC1Lfb+k9Bn+Enff3BkVYipaZHcjp/sdUnjyJqDBne/ByRNVzeS
	SBkFgNrJUlYw2cd2MvN00XsWs8TfKneg=
X-Gm-Gg: ATEYQzzz6+JAn7LOPhv+GAVa7Mg15cInylhsNChY69rEPmyaOz7Q6hjgGnTm1CPN/4Z
	6I1z/QE+9XD9+0AqDr3iqrWXw8SBTufLwL3ObLlieSEahCNTwO1nV+klVO5ZvxLzJvtCzc5CVlc
	/pl2WrsNXmib5KHFGeOsHjLHC1SV3coAUS3dqGR2KPd8zPAjPJvWiL+S6IpgGcPuP5gQ5LH7DLC
	uzHqHa+A2TDc0fTwziJ4sm6nFOT4V/Qh5vznPRhJ2MXUCF1lKu8m1v3fm9rQD8ZATrWMMs/q4Sv
	/aC+rzXLC7Po09l1Xk2eO1E7VFVALymekMrh+bnuhJ1WhqspfoTF0YfjXK+kA0tmx3A0
X-Received: by 2002:a05:701b:2503:b0:12a:7f25:44fd with SMTP id
 a92af1059eb24-12a7f254723mr2643146c88.41.1774350301628; Tue, 24 Mar 2026
 04:05:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aa65h6Z_TrpJbmkj@ThinkPad-E14-Gen-6> <CAP8UFD3sicsPd903FU8bsj2B_4Q1DE1xB+--OxryY_jhL=sHdw@mail.gmail.com>
 <aa7XkqhcG6Kb6IhN@ThinkPad-E14-Gen-6> <CAP8UFD2iM-z7F_FeDkP5v=1OAJhS2AcFsgPnicvHNFMUcmxbpQ@mail.gmail.com>
 <aa8VWlv7dosrrRwv@ThinkPad-E14-Gen-6> <acD-esOCTH3PpK9y@ThinkPad-E14-Gen-6>
In-Reply-To: <acD-esOCTH3PpK9y@ThinkPad-E14-Gen-6>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 24 Mar 2026 12:04:50 +0100
X-Gm-Features: AaiRm537rR8kDSiQl7kXLk8h77v35jxYJc8TFgdWMpzLd5ebhzqSi79YPlz4CWM
Message-ID: <CAP8UFD1HsRX3kzs39qa3yfix4ORCR4vzy+ddvU+Gz9OyJ-BsfA@mail.gmail.com>
Subject: Re: [QUESTION] Improving disk space recovery for partial clones (GSoC 2026)
To: Yuvraj Singh Chauhan <ysinghcin@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 9:49=E2=80=AFAM Yuvraj Singh Chauhan
<ysinghcin@gmail.com> wrote:
>
> On Tue, Mar 10, 2026 at 12:15:46AM +0530, Yuvraj Singh Chauhan wrote:
> > I have been studying the different commands and how they work, I will p=
ut together
> > my understanding in a pros and cons list for each command and send it a=
sap.
> >
> > Also the contributor application period starts March 16 and ends on the=
 March 31.
> > Can I complete my proposal for community review in between that period =
as well? or
> > should I rush to write a draft version before that.

We prefer it when proposals are sent to the mailing list for review
between one month and one week before the end of the application
period, so that they are quite up-to-date with recent developments and
discussions, but we hopefully still have time to review them at least
once.

So you should send one soon if you haven't already.

> After some studying here the four options for placement:
>
> Option A: git backfill --evict
> Remark: 'backfill' semantically means to fill in what is missing. Adding =
removal semantics creates confusion. Project idea has also signalled backfi=
ll is unlikely to be the right location. The traversal logic for eviction d=
iffers enough from backfill's that there wont be a well structured shared c=
ode.

s/wont/won't/

> Option B: git gc / git repack
> Remark: gc is already complex and runs automatically. Stolee's concern, t=
hat background tools like VS Code running git blame will immediately re-dow=
nload evicted blobs, which argues directly against automatic eviction. A us=
er who runs git gc -a does not expect silent network activity.
>
> Option C: git maintenance task
> Remark: maintenance can be a long-term home for scheduled eviction, but o=
nly after the core eviction logic is stable. An idle-detection heuristic (n=
ot yet designed) would be needed before automatic eviction is safe.
>
> Option D: git evict (standalone command)
> Remark: User-driven invocation is the approach that safely addresses Stol=
ee's re-download concern. When the user explicitly runs git evict, they hav=
e context about what they are about to lose. No background tool can trigger=
 git evict accidentally. This placement also avoids semantic confusion and =
creates a clean audit surface for the community to review.
>
> Please review so that I can create the proposed plan accordingly

We cannot anticipate right now without proper patches with commit
messages, documentation, tests, etc what the best solution is. So you
should likely add your analysis of these options to your proposal
without expecting much from some of us taking a look at them now.

Thanks.
