Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DCC1798A
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 08:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710490482; cv=none; b=HmyaLY2apMdUmEIIaBZrZ8GSw/rQ8gwwrPsAR3KDszAE41CwZjIrQthlhHFE+dGZbOH89wj+Tma6gwS8mcp+VlJxptiHeYsFGbCMRHvXmrHOFst8mHDPyDk2EtQUzOxLptKj3UtRFris/N3k7x6m2QJG8o2U6tvp/3XGLkmJIi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710490482; c=relaxed/simple;
	bh=CFRk/SoRVGvrQK+ryq5gf3KchiU7EfaI6BRuQQGwo3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=R7quqj4ma1XW0w7C7GLcj0kkm96EyeIf0DXTsn/3NlDzPmFV/NhNZseeIeOwpEzvo+b11Gp/f9/FoV1962REmzlZEA4UAJMPuZnPI9YQ5/eABVVujdfdkFzwBzSHciuRCXMTuA+zrzmzganiPvoZJVNjh7Zp390T7K5QD0JGcSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp2.bon.at (unknown [192.168.181.106])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4Twwjw10nxz5v5v
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 08:24:36 +0100 (CET)
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4Twwjl5CJcz5tlC;
	Fri, 15 Mar 2024 08:24:27 +0100 (CET)
Message-ID: <606fe3fa-a5a0-4d35-a4a0-59521043dde4@kdbg.org>
Date: Fri, 15 Mar 2024 08:24:27 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Git is not recognizing some merge conflicts and just accepting
 incoming master version
To: Kai <k.vongrambusch@googlemail.com>
References: <CA+XMOBuK1_BNqgQRfCne8dVXKGPt+iQ9wt4iZqz0PgEqZ5UCtg@mail.gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org
In-Reply-To: <CA+XMOBuK1_BNqgQRfCne8dVXKGPt+iQ9wt4iZqz0PgEqZ5UCtg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 14.03.24 um 11:30 schrieb Kai:
> I am encountering strange behavior when trying to merge master into a
> feature branch. Trying with guis VScode and Gitkraken, both are not
> displaying all conflicts in the files correctly and are just accepting
> some changes from master which are conflicts and break the code.
> 
> I am including two example files as well as screenshots.

No files were included in this message. Don't post screenshots when the
content can also be represented as text.

That said, a conflict needs three files, not two: the base version,
their version, and our version. But better than file attachments would
be to just paste the relevant parts into the message (if you know what
the relevant parts are and that other parts are not relevant).

> In the first example, the conflict of the UseFormReturn type changing
> between the two versions of the file is not being recognized.
> 
> In the second example the useForm hook is completely different between
> master and the feature branch called hook-form, but no conflict is
> displayed.

These descriptions sound like the conflicts are of semantic kind. Git
can't help in such cases. Git can only detect textual conflicts, that
is, when both sides modify the same or adjacent lines of code in
different ways.

-- Hannes

