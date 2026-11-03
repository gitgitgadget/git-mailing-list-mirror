Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793742796;
	b=izICfISSJJvKJtKrLBfy3D0u/9UdlvFODxotcAhF3oCSmslVg1vpFF1ZENkKachi8QiI
	 GQbBQkvus2IGa/lAG+M5HIbdARJ2Kmhp8GZPDZo9/JBSWKu2wlcU9C2sgL0SQkuYVaZzi
	 3H8VqLXQUqPbhlyShBvr1BlPZ+O0jznE/nUpcAd0rTYsGJ5oWCyxUNO4U3DjjY0n4el5s
	 C8c3Wu1wG9vwFv0fp3cbExsUj/+id+H+UPjp/zPPvB3RSW8OuKznprj+o1EyH/tIq42uj
	 Xa9evkM/3WYkAlSI7Vy9uOjRuTwYHC6Ca6mxdzof3F3Ddh1fm5F58ZOws0ffp2Y9Wew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793742796;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=+TBi5lQM8l6itlTHZU2VBomx+2fbfQ9QagDyMJugwUo=;
	b=lJGCm5YBUrH/TWrxi8o7x6T4REWLiEHFOAEZbSVhEJ80kCEs/camkbZRJ6cZaZFr3t13
	 bMPzkIb+dZu4ntbc8BMlDoXdjRXAuYwlrw7nxUS/zeebm4mMLvpqhWce8ukfbvey1lr6u
	 LukW8fTPyJWjLUrca4MQBnkb22HQKasf8vVhyQ6CJyQMokYCdUT98pxDafLWoNi3b1QJe
	 xtpuOqGn76R4seZswfDwVPX6zEDCHze0dePQFz1NSKj0q4Nz8mMurQ5Aqwfzm25SNna0O
	 l0BJb/tyGlftw6IAleecNVryFsxFLQdL8EwtTxmiqfXdbTGQhZz3lq1Yq+BYYjCa0Hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HAXlvHwh;
	arc=none smtp.remote-ip=209.85.210.44
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382CA606A324
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 21:53:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 382CA606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HAXlvHwh
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-82109f51565so11908a34.2
        for <git@vger.kernel.org>; Tue, 03 Nov 2026 13:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793742795; x=1794347595; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+TBi5lQM8l6itlTHZU2VBomx+2fbfQ9QagDyMJugwUo=;
        b=HAXlvHwhPaVeZoZieEu70YhZ+wnyN0ZZ0ZBpj5y1PToDkhns1/CNMErM8D2YZhVSxI
         071eb499NAcVhkAKQtIXFr6Wieyes8dE4w/aFSHsJ2X9lEKLR3KU/Wk4r11vNnl+CYtD
         abn5b4/1CYuVP4LyAO02wZzbS51ixstTga4xp1B0IvzLFxvVB5dY6l3ZomKiYEvnYAld
         VpWxaEoSMMcaPnNGOj37+sNGHmypfog6JsJscDqTCCc20h+7/alr8ov7+eUaWI5KD/lQ
         8FI5D+XH24FosVKCnmVZxn+hu/HzkwtbeQKZKkCcUGwcLfs2OIDF64MWSgJSL3SmY9Kx
         BZQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793742795; x=1794347595;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+TBi5lQM8l6itlTHZU2VBomx+2fbfQ9QagDyMJugwUo=;
        b=osVqAOA8gjxTrN2QGTtV6VOBWPLsTrJ6qqoAJgSn7plbGIMbTuQp+FY9g2DwOtdNP+
         w8F+qrmBgiEiS8waVzb5kkLFjiY9wElvbCL5r3xACfXmTZ3D4bcQh5IRXtzq//7CPB20
         6hCp/g/+t/A3gMPTH5/RlAXUvgPI69IQD8ZPqN0kSBSgG+uxyg4PCpg0sT1UnnyX7V9g
         QaLSU9t8b7KYMZtDRtQpWa5+nsSSS9KGWrRUPvKDmUpsvjsWKHtIGiBOl3rr7FLskLYh
         eEkXTpwAbp/Hj9YhXkHPX2w7jSFa/mx75XEPHEG7sm92pP/SAzzABRJ+GYj6tUPCvSnF
         59Jw==
X-Forwarded-Encrypted: i=1; AKwUvBwGfZsBX8fUunytlQE3+GhNQyWIzW6D9Vuht205jvCDKtV63GDNCBvg15nGsCDpKGH/aoM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9yywRE93IxmWlpZUVRSloAWfeOghqs+O3JlfomixXCbCvZSnwA
	Np2c9OCcNNlW2UWH7jk1DXZcpZ8wO843Wef1y5rMeCZFs8V5NI2yH5tz
X-Gm-Gg: AYBFou3pUzZolCGronuXO2u2zBeQ4w+GajGI5C5jSegSoAbkmTBRtDk3Qq2eak85gVv
	wlgQGhYrDdP1oDV+9d1WQ54cKOrdS0LzBwdwrRmlsWun+eFqUNL1TIREwssTj5gcrsrkabV2465
	kmD1vcHsj1v8UBYoZOewj5XACSKT77Xd3hRcQIcIAXJqDCNEwT4s1pszxrbm6sK/1ltc/wkdXOO
	8QPIk8cYFauHCyGop2b+FjVGSSSBe5X9UKR85xFcWL/35r99y2MnEDWW2e/thDM6ljyIk8kwVFX
	U2qXf1DFbBbwU5QyjAmn8qisfl4eNn/UjPKkKuJp3TaIJBEg/eCf3kfyy2xvFH5PMCXrrMChPI6
	+7wbW2llqt5s7QE7Kdh0Z8uOCB0pYtf8DNwCRGO5Gi1F9xBq2pZD/SgOw/5GX5riw80ayErk9Yj
	fgv+sJXFLz3eYYiWnj3QCIqxzCHBo3MAsbvZyt1hOmj4ZkjUaaFPnAp08AE8eNj5cmDulRvVx8w
	s58tfEqxBA68HP36z1zrtQYDKmAkIjY/Spt6gIeD/TPWGQnm5bvapCIFcyUvZN2OguumLg9gdST
	8aso4OCQcQ/bqfhVjWMODLDRAlBPdfV9zjnrn0bjKOrkscu34OlPhVqwyKz8WQryqPqWuldrWg=
	=
X-Received: by 2002:a05:6830:410f:b0:821:94d2:83cd with SMTP id 46e09a7af769-85d364a5a98mr11512185a34.9.1793742795119;
        Tue, 03 Nov 2026 13:53:15 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85ef3eb127asm330113a34.24.2026.11.03.13.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 13:53:14 -0800 (PST)
Date: Tue, 3 Nov 2026 15:53:11 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Kristofer Karlsson <krka@spotify.com>, 
	Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] odb: do not list our own refs as alternate refs in
 the quarantine
Message-ID: <aupPATAGBWH1RIe6@denethor>
References: <pull.2285.git.1793200705017.gitgitgadget@gmail.com>
 <pull.2285.v2.git.1793619933300.gitgitgadget@gmail.com>
 <aum-34I8KZvTfDRT@pks.im>
 <CAL71e4McZzVJqFHnmpoQkC6+hUkhz9_HtEy7dqC5rDyXdV6oaQ@mail.gmail.com>
 <aunS6dE0B-JAJnBk@pks.im>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aunS6dE0B-JAJnBk@pks.im>

On 26/11/03 01:26PM, Patrick Steinhardt wrote:
> On Tue, Nov 03, 2026 at 01:05:29PM +0100, Kristofer Karlsson wrote:
> > That does sound like the cleaner fix.  Since you are already deep into
> > this area, I would be happy to drop the fix and wait for that instead.
> > I expect very few users to be affected in practice: mostly git hosts
> > with many hidden refs, which is the case bcec6780b2 was about.
> > 
> > In that case I could send just the tests, with the hidden refs case
> > marked as test_expect_failure, so that it is covered once a long-term
> > fix lands.  Or, if you would rather have a short-term fix in the
> > meantime, I can send a v3 with the change above.
> 
> I certainly do care about this case and would like to see this fixed :)
> I'd like to get Justin's opinion on that proposal first though, as he's
> worked on transactions quite extensively over the last couple months.

Regarding the fix proposed in this patch, I'm not quite sure this is
really the right layer to address the problem. The root of the problem
is that we are swapping around the "real" and quarantine object
directories to facilitate writing to the "files" ODB transaction. IMO,
this is already rather fragile. So I do agree with Patrick that I think
the better long-term fix is to stop modifying the primary object
directory altogether and instead propagate some context about the
pending transaction via environment variables to the child process that
it can use to reconstruct the proper environment. This is certainly a
more involved change, but something that I've been wanting to do for a
while now regardless.

If we are interested in a more simple fix for the short-term, we could
adapt `odb_transaction_env()` to have a "read-only" mode flag that does
not modify the primary object directory and only appends the quarantine
directory as an alternate. For the connectivity check in
git-receive-pack(1) we don't write any object anyways, so configuring
the environment in this manner should be sufficient to fix the issue.

-Justin
