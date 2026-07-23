Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9063F2100
	for <git@vger.kernel.org>; Thu, 23 Jul 2026 21:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784842716; cv=pass; b=nlVD4xwz/5RF23CRn+J6nhPluJumZ/ePxwCagKutUAdOVm+RbG61sDsOshS/sGXiKKKsZnuVVCZp7qvEA1bdAccIu7Y83c1bQPo7moxMxQiDSUTZIUOZrqvDbDv17irQA4mBrBkcwCYHCc0PKF12kw2CJRZEaWwILlJvpzE8Jg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784842716; c=relaxed/simple;
	bh=IGfIcyGdvAW5AWcKfQxCiYf3zTK5SCIiQ5Sg1IQ2kzI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DH1rUce0GeLFP+Uk2od2hyi9wDvwYvnVLenW3Q0BTfhbP7FnAjx4czR742X7NCtJntsLG7qxRoa1IXKCPVTiTN2FhUDuXUNkZm3mjUPmRc+Kq/GwDv6PrOEFjO5nZhx6mXEXu/1HxEjMG7ECmANP2H7S73uDNNAmvkMpaMuAOWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PSfWVwsW; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PSfWVwsW"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c1670dad7a8so184572866b.3
        for <git@vger.kernel.org>; Thu, 23 Jul 2026 14:38:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784842710; cv=none;
        d=google.com; s=arc-20260327;
        b=OaZrQDJni32GOZiYzPVIBiFVKVaQSL2E5AXCRwS7ofj6CWbFABC63aRKRNwKLcO3Ex
         lHN+HWjHKynKcc6FhJI+ihYBSonyHP8bpsu8enPSa6CV7V2LY947X5pKeUDlQrw4A4TS
         iuPExyhHHfhlnvo8P56o3dBziVgVx2Sw6VWM528taSJp7axUHK5vJ4N3NOGL3MuwKc5C
         kaxQbPqnUScvoopKyRIfGuJ8iBiZj3goUpZp8UTZxvwsd6FTWf5ZAO/k5lz+852LS0ff
         cZ4IBzbI2mgmKv6DQKL3JPDqTv9ipOGtA5aDwNhbDx18K8FDmTHvAByq9kyDH5jL8bbz
         lKLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=6N1sdbf6g6KS0wZIbinSj3Rqy3xBJJLapzJrXKthLI4=;
        fh=XiiYnZYX3B+pT6Y5xF6qiRZeuc7x+A4vnVRI6Zod+DM=;
        b=DgCdh9ae8uVA2uW0IBxzHgiKLxHcy0eLhNUEcLwXR7xrfdCMHyWOPXmgBoFRRvsZdp
         6nSpwe1nI5zeS/hD61+6q77X85LrOZkeIymwUvNVyEarYimnRMxAHwHKlye2QY9nzMql
         iVYQZCpArJloZH+AaSiY2AyqMiODLMYyLZDZeBkH6HPOxG0D/jvGTb7leQ7WtTLbNRS8
         s7ztuOB9VMRwaqjpyeui7vRNg8lxyyjS257TCpttzBn1yL00nTPUN1KOrJ4wsRFcT+F4
         l8an+cDGI08OidBbSUtqURue9eo7JdU1EzQvn0uf0OqvakrPMcaiOozyD29HQoYMHqrg
         b33g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784842710; x=1785447510; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6N1sdbf6g6KS0wZIbinSj3Rqy3xBJJLapzJrXKthLI4=;
        b=PSfWVwsWHiiyVS/cDJsjBfGKo1qCMX2SPIStrW4AvRPRyKfuX1ryCvk7GgO9SftO4Y
         lDXwZxM/gZTqXh772X1ZLHKxk3cX2I0dHWnqdj6P7UWhHOqq0L6KYsJsdLlM151NoXH0
         /l7b4Tou9F/pTmLf16kEvvP2YNArZ3iUpvRusx3Ek99e8c/pAS1T9kLUcDz/8oouLCnD
         L+F92RIW3cdxS85iakMGMSxWUGf1KumQKUHrxDivWV2X/mEpibpnLxN3JCgFPxZY6SFl
         4in4+tX9FVxxDXoDgHQfzSJDSaYhP5iXopu5U3yflI+iwEEjZ4GoEFLhBHpLLUFWJJAQ
         d/aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784842710; x=1785447510;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6N1sdbf6g6KS0wZIbinSj3Rqy3xBJJLapzJrXKthLI4=;
        b=LdUHAIHOidUCR9vdVCuzD69MyQLGMEPNXVN79KfrQFcofoIg93HnemclP5DS5wqPhG
         WoXQoMNs/tORij23YiU+wU7AYh8AM/Wy5Kd8MbjKPOeJmaQFChkF2x2+WZUqrHIKGR6O
         O8qyyXIJDpiYFy3tbOJY36DHaHrmyl40KZk1M8UkChMoQKuv9Zo29vtm9qPpCGauMX4D
         P5OU4o221og5r3uPc6aeUF5E3S9w8eIrC8ElygAG+VU/rgtilPsfHOK/7kgVEQqamjCf
         YYxrMM6z6TdG+WWKv/rTlNSQYABnCq2n+0wfWsy5ekdhMujpPMt++te0eqrtd5Cp7cY6
         BiKA==
X-Forwarded-Encrypted: i=1; AHgh+Rqm2JQ+5sbeWH0cB1nFdziCMA8RIPk94zUxogvbod0QGkzlGqKoIQKnXTdsI00+mOJZVbk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSzcsGyLmR2I8xRQqXbMBvZ1zskbgs0j3ZpMLcbppnlb6O/Z9R
	OyYHrj987cSEU3qKmsp/NLkoScWgR76JYo8pW6mkkvEBIVGYX027nq7sccMTz7ZNIkxQSs7L2QT
	Oh7YYuj7nPI1SigQoOUYfiZSvYFYGz6I=
X-Gm-Gg: AR+sD13iYlWhQkSmQcxBRYm9bnlp/RawgTQ7CdAxBxCBT3KD93PNu/26wLvdOz+KHW/
	4U6H4Ioy7uTt+VkiChzGOoc2xseZqTuZwRDcHuT73EniSBnIaIhGQ4JzC5mB+MP4tXcR4rqmVry
	kjLbZmbVxdcjeuvJ0HnDErH7ulB5XiNGazM2l7qWgQcYrNFszTST1tvocHCXVhSUSkQWNdnOV+x
	7PDA8XWYz7ohJd/B3XDW2GSK3hRzRGJ5j4fOTymRrjmN34yJ+2Nc/zH8VttAL7nTrSr2OO9
X-Received: by 2002:a17:907:78d:b0:c16:7097:4708 with SMTP id
 a640c23a62f3a-c1c5092a280mr216660666b.3.1784842710082; Thu, 23 Jul 2026
 14:38:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2356.git.git.1784125963694.gitgitgadget@gmail.com>
 <pull.2356.v2.git.git.1784812390.gitgitgadget@gmail.com> <1a790e001610d3324ec45d86ac67ca5720678cb8.1784812390.git.gitgitgadget@gmail.com>
 <xmqqo6fximn2.fsf@gitster.g>
In-Reply-To: <xmqqo6fximn2.fsf@gitster.g>
From: Lucas Zamboni Orioli <lucaszam0@gmail.com>
Date: Thu, 23 Jul 2026 18:38:18 -0300
X-Gm-Features: AUfX_mwXPdebJfYQ-JvrBydI7lD10TcUJmlD6if2gNTfq859IKQhE-zKU7IOCf0
Message-ID: <CAH01Q-_2APONq2fXmjF=Wo08rTzScMEjyXL-G=_GH6TbjJmTBw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mv: check for missing destination directory before renaming
To: Junio C Hamano <gitster@pobox.com>
Cc: Lucas Zamboni Orioli via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Ben Knoble <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> lstat() can succeed and 'dir_st' may indicate something other than a
> directory (for example, a symbolic link or a regular file).
> Alternatively, it can fail with ENOTDIR when, for example, 'dst_dir'
> is 'a/b/c' and 'a/b' is a file rather than a directory.
>
> Both cases will cause 'git mv' into a path assumed to be a directory
> to fail.  Shouldn't we handle these conditions as well?

Yes, agreed, both should be handled. For v3 I switched from lstat()
to stat() so that the check follows symlinks the same way rename()
does, and I handle the non-directory cases:

stat() failing with ENOENT or ENOTDIR (missing directory, or a
leading path component that is a file) reports "destination
directory does not exist".

stat() succeeding on something that is not a directory reports
"destination is not a directory".

Other stat() errors fall through to rename(), which reports them as before.

For the messages I used the existing "destination directory does not
exist" string for the missing case and added one new string,
"destination is not a directory", for the non-directory case. I'm
happy to collapse these into a single message instead if you'd prefer
to avoid the extra translatable string, let me know.
