Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B01134CB
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 08:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707813211; cv=none; b=sDaIeWAN0CJYwKGZtm+7IP3bRU+E+p6S59LsYRbleeDighRvRXX5N1Fkk+JgP9JOWdX8g1j0D2HO/M/5hkJDhnV6sVkpCJbfeJxoL29JD91bPP+YJB7jRFn12R/qtPALUtJXmOZYjCDHa07C/POnAt6PgmNu5XL+tBXrvIRm4NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707813211; c=relaxed/simple;
	bh=7ZiTLmD4ImlQ0zjAnctxBDF7ofx3j606KykQubgfUjA=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=b1ymGkQj9klzq6958SuTwQ1IvBtUILMdL5WULRgA27xn5+cLrVv/hMwmOsngR39wLzlnk4kcmqUwgQdqXqeL35cfjCJcCAIfOY1SqVkamk3ns7hdwrVQ0Ed/+jA4P0YzI4PKK6HImMhDv/aBPTDNg9+l4V1/Xs/YsYwSQz1YfJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=RmYH22hi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Du0bFwF/; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="RmYH22hi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Du0bFwF/"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 80CF71140110;
	Tue, 13 Feb 2024 03:33:28 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Tue, 13 Feb 2024 03:33:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1707813208; x=
	1707899608; bh=HwcHJQOffPiq6YOG9tRI4c39eUj43gUjsgzvsUMH9BA=; b=R
	mYH22hiQUVqdQSggn7LiNbONi5Xd9h1FYS7n+mxybkITo/BRbsrxcbv2jR7rP0t1
	w+oeKjMlc/E/XT8fV66NUyFpQpm7tV2/rTJGmmQt5PVlkwvxqEpCAMWBJM4ABzq3
	wFOZoKSZ0dG4Bt55+NDGcaRpGEfH5Sn9dQ2SXbKdk7DMfo3xePgSaIoOyfnOb6gh
	hl7Q1/bsz9FsEwrMtEJq5zMgi40l6R8RQ3vbF9NUK9f3cG7sE3Q2SLjB7TN174pi
	XWNve0CEaiYlS6ZdEDfCvmgLqoXRvu9RnJUTu9KGmSwScHaPhJ4axPF2B7fJe5Vi
	BEr2o7L5ljP4Fr3RIpl6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707813208; x=1707899608; bh=HwcHJQOffPiq6YOG9tRI4c39eUj4
	3gUjsgzvsUMH9BA=; b=Du0bFwF/FriGMCtY4PKcYtkm5xaMWO0OoKIQSvcLW+WV
	Os3UuUPtO6dKusfWzuvMkDjzuo7bobaTOvFCTn+6M9aww32nee5HY2tSJSEGpFqN
	Rt8SqgdYRsHBRlCD2mYIdXaKz4ots1FGZ0AtdunFmughLee9cQ82YYvsfvzr+rsa
	44RZtnNtGlxFefmZEM/3sTOy+e3/BW2MJlpw7dszzSF2rGJsv89S+u8wR25KT2O1
	22OQpc/VMSnrqKEKqPTK73/a7xJc0PHRv5OZ7qyST0qeq7wkwvU5xytWiIKh7xTK
	f4BAfSCD1XycC14rqCiDo9TD7hZZFWhC63ZxYVmb5Q==
X-ME-Sender: <xms:WCnLZTR1kaAZQWcgArOu9PcNoFXDniY9-Gi_HTDTfLp-zmG39IBRozs>
    <xme:WCnLZUy7IXlk-KJsZuXwkCTnjx8ttG53Axv1l0ZFg8bABl6NfnrZ1HgMLnYKDwEXo
    edrjl2NekVRNXfEGg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeggdduvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfmfhr
    ihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssggrkh
    hkrdhnrghmvgeqnecuggftrfgrthhtvghrnheptdektdejieffleetffehieehueffgfeh
    leeufedtjeekueffgfeihfegkeffffeunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:WCnLZY1fE2t8rNmKtwe78JAjJFqopDpBdBJ0N31k5Ko3_h0Ue3B7Cw>
    <xmx:WCnLZTDJ95-dBSHhXyLqTNAxfXvXs0IrX44-kGOBspSQho914nMNSg>
    <xmx:WCnLZciNxQ-gklqqbV60cDVtzSlPqXlHRx85-EhXc2oGJuYLl7YeGA>
    <xmx:WCnLZWbz-21Pzvx7QyZNKIRLdnp8rD6QVab8l-Oqc5G-tuWZ9HkMPA>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 0F47715A0092; Tue, 13 Feb 2024 03:33:28 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <023394e2-5f64-4a59-af96-b77dafb20051@app.fastmail.com>
In-Reply-To: <20231002024034.2611-2-ebiederm@gmail.com>
References: <878r8l929e.fsf@gmail.froward.int.ebiederm.org>
 <20231002024034.2611-2-ebiederm@gmail.com>
Date: Tue, 13 Feb 2024 09:31:22 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Eric W. Biederman" <ebiederm@gmail.com>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>,
 "Eric Sunshine" <sunshine@sunshineco.com>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 "Junio C Hamano" <gitster@pobox.com>
Subject: Re: [PATCH v2 02/30] oid-array: teach oid-array to handle multiple kinds of
 oids
Content-Type: text/plain

On Mon, Oct 2, 2023, at 04:40, Eric W. Biederman wrote:
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Most of your patches have this sign-off line with your name quoted.

-- 
Kristoffer Haugsbakk


