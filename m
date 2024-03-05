Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7C8944F
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 16:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709657523; cv=none; b=OFQm/2F+xjh5Q4toCaAvQ2MhKx3zdSfkFjAA70lrFalBQFUd1aaPsxqqoEsu1B0NeUos1z4ARmOBraKaQpNyZUe17rUTxiXPcq0MI7+kDcnMKcSWEpIY0TpRmc0bOY9LbpyQqeZ9HvqSgmIslLV++/6JFjIgjtnLuD1lAr02YE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709657523; c=relaxed/simple;
	bh=aRf9rnDKQG/shki4SRI6X89vSTtye3N55Asf43ziU3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aQIHVQW1S0YMBCE3CYdEO2cKAeTlNeGHbwLtQVvqFtnBkPjpxOf51uWcEXiwQRH4VLfa9d3onMJOqDPFjOpjU1YQV+qc17xoOyiUd/ShnZqLQU3yvFWVN5RI/Wc824pR9jaUW+WTx5nSz5FAMqVOJsXb0gwDnLxj4zKldnpc0po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=hbsR0Hp6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dp3q+ia2; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="hbsR0Hp6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dp3q+ia2"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id CC4921C000C0;
	Tue,  5 Mar 2024 11:51:59 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 05 Mar 2024 11:52:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1709657519; x=1709743919; bh=P8gvdACt+aCxxWcIfcO5CLHyonbTwvnf
	8RMmrzDOx2g=; b=hbsR0Hp6WjQfX0P5ZBMuRzZYxYqRjZ6h1jYNHMUCp28xNqvk
	8RoO9UKsWH64cws+J1G+ODIJSx7wY1zsNUlxv14Wwf0AXZbg5beyAHzNcsuWLjed
	XsS2KQ+JkSdJxYoTnsz+XL3VFikgwuTgNOTTdwKxqEcfQCYXLDexLrf8lpjXsrwi
	ajSMe1HC3p2aYjhz7BB67kx7iOr9bfIrfcpex/z9CKxERPx4qV1KEY1P+lyiDJuV
	935MSECuDAcY2LcTp7uho64bnk6xSajOQuGUPkVJocwiAsfjtd3jWG92av9MiNBT
	f1syf+g71JePnCDyjD0ZMTGMDkq1FfFX8PrPyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1709657519; x=
	1709743919; bh=P8gvdACt+aCxxWcIfcO5CLHyonbTwvnf8RMmrzDOx2g=; b=d
	p3q+ia2oRvKyvOOk1tQoGR0piaRw7cgcs/4WQ05aZNZdlUGf37Dy8l3omm+6hMeJ
	aUSFxfDCXpdEBUA+jHrMvW/3YIbKb3wdP5aUDxx6EL+ew5/Tq5p6jGtG+i/BdUlM
	uDPbrGq5aXSaeNKE1oGi3K+bX04Bppf/Ezk/haYppahtZYeZAK/+D0yj4E60YNme
	a8vECEL/dP3tnv6QqpoegfAZKgoPZQsvXOdZc0m4zEd4c6AzmQ/nNq3shqAXEIht
	MsyeevaiXIQugBr4K5qnxf27wLnj9KCZxDLG4l43EwryTbB2apRqoscA9si3d7KZ
	ybm5OfyibIl5P658lrqYg==
X-ME-Sender: <xms:r03nZUrHbUPWlqWeZTGXUZFJTmVooH515WZ2qxsH4M15JTSkBO8TX9c>
    <xme:r03nZapy-IJ1bLVe_ECmDF8gK0MGP1JfMWoBRbnCoeIN7DVQoduUiYGpDZsFmrumR
    P9vzRlootYQH8G7eQ>
X-ME-Received: <xmr:r03nZZPm5RIPme_V0q3hlL1xoc5SaBCOQyn5fD7ObXVeLiEwiw5tqH0cGNcIt_atXgC6xdKfl8grdAm3qL8FPhmX44oXhtkfSdD7-ZFMuQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheelgdeklecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkuceotghouggvsehkhhgruhhgshgsrghkkhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpeevgfelveeikeegjeeikeeuvefhleeiuddvleeg
    feekjedtkeevtdetgfffveettdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:r03nZb6qcucoSTsmXRLOE-tpSsbvZGvIoxHoa0Eo6ANOb8qPDi__JA>
    <xmx:r03nZT4rpfjutl1-n1_phCclH2JeQuHiKKQzpJAHJtHeet3c6-5ppA>
    <xmx:r03nZbi5O2UA_5oOlKUW83asI_xbRENnKlhIMW_EWY1eRj9eNd8H1w>
    <xmx:r03nZW0Bg9mrgbwQwDZxsRXEtvVOMGSQk1dCoj_s1VSl9SDTTAqn7K6UE3E>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Mar 2024 11:51:57 -0500 (EST)
From: Kristoffer Haugsbakk <code@khaugsbakk.name>
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Manlio Perillo <manlio.perillo@gmail.com>,
	git@vger.kernel.org
Subject: Re: Clarify the meaning of "character" in the documentation
Date: Tue,  5 Mar 2024 17:51:08 +0100
Message-ID: <9633f9be5ddd9ab3df4b79ee934e1ed47e90bd1d.1709656683.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.44.0.64.g52b67adbeb2
In-Reply-To: <xmqqsf1466eh.fsf@gitster.g>
References: <xmqqsf1466eh.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Commit-Hash: 9633f9be5ddd9ab3df4b79ee934e1ed47e90bd1d
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, Mar 5, 2024, at 16:32, Junio C Hamano wrote:
> "Kristoffer Haugsbakk" <code@khaugsbakk.name> writes:
>
>>> As an example, with
>>> git config --add core.commentChar •  // Bullet (U+2022)
>>> git does not complain, but it is rejected later.
>>
>> I think this is more about `git config --add` not doing any
>> validation. It just sets things. You can do `git config --add
>> core.commentChar 'ffd'` and get the same effect.
>
> This is not wrong per-se, but it merely explains why "config" takes
> it without complaining (the command just does not know anything
> about what each variable means and what the valid range of values
> are).  core.commentChar is limited to "a byte" so in the context of
> everything else (like commit log message in the editor) being UTF-8,
> it means ASCII would only work there.

Yep, I neglected to mention that part.

> I personally do not see a reason, however, why we need to be limited
> to a single byte, though.  If a patch cleanly implements to allow us
> to use any one-or-more-byte sequence as core.commentChar, I do not
> offhand see a good reason to reject it---it would be fully backward
> compatible and allows you to use a UTF-8 charcter outside ASCII, as
> well as "//" and the like.

Allow one codepoint or a string? Since a Unicode “character” can be
composed of multiple codepoints. And at that point it might be more work
to validate that it is a “character” compared to allowing any kind of
string.

Maybe introduce `core.commentString` and make it a synonym for
`core.commentChar`?

> The core part of "diff" is very much line oriented, and after
> chopping your random sequence of bytes at each LF that appears in
> it, the code is pretty oblivious to the character boundary, except
> for a few cases.  "-w" needs to know what the whitespace characters
> are (it knows only the limited basic set like SP HT and probably
> VT), "-i" needs to know that "A" and "a" are equivalent (I think it
> only knows the ASCII, but I may be misremembering).  Outside the
> core part of "diff", there are frills that need to know about
> character boundaries, like chopping the function header comment
> placed on a hunk header "@@ -1682,7 +1682,7 @@" to a reasonable
> length, --color-words/--word-diff that first separates lines into
> multi-character tokens and align matching sequences in them, etc.

Ah, interesting. Thanks :)

> As you said, we should document core.commentChar as limited to an
> ASCII character, at least as a short term solution.

Aha, I see now that the config documentation doesn’t make that clear.

-- >8 --
Subject: [PATCH] config: document `core.commentChar` as ASCII-only

d3b3419f8f2 (config: tell the user that we expect an ASCII character,
2023-03-27) updated an error message to make clear that this option
specifically wants an ASCII character but neglected to consider the
config documentation.

Reported-by: Manlio Perillo <manlio.perillo@gmail.com>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    I didn’t find any other relevant occurences with
    
        git grep 'commentChar' -- ':(exclude)po'
    
    `Documentation/git-commit.txt` mentions it but it doesn’t seem like a
    clarification is needed in that context.

 Documentation/config/core.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index 0e8c2832bf9..2d4bbdb25fa 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -521,7 +521,7 @@ core.editor::
 
 core.commentChar::
 	Commands such as `commit` and `tag` that let you edit
-	messages consider a line that begins with this character
+	messages consider a line that begins with this ASCII character
 	commented, and removes them after the editor returns
 	(default '#').
 +
-- 
2.44.0.64.g52b67adbeb2

