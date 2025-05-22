Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE21323C4E8
	for <git@vger.kernel.org>; Thu, 22 May 2025 16:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747932301; cv=none; b=lIRjr/jVN2ohdOq0hiGVIIYszRGspmriRoM+x32p/8oUCPOSzSI3hvtfajPcqCMmbUQXaQsMYfdZR8+aglrRq9OdfyeMPqSYvxegM0GwX7CZLXGzstuzJTL896yh0Uo5oGBTBZ91jCfbFys7FlGqy65d4hOktxjaj1X1HnL3cLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747932301; c=relaxed/simple;
	bh=aYRqI0ExK7MxSy64V/FixZBMa5V20D7pYMmYigFebFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iUyFu8hhfy91QxUq6+ZIoawxaJzHtiIMUELz4Wl74tLXSOTOA8aBuCqNzZVl/Dy4dW1KoPngi8Rv5Bu/fayb41ZOadqFe5/zDFNTCXrC2gqgX6MR15FGF539DD6fziKQzKVssIBd2JnWxcB4ZuSBuyGMjlXq3yFdHzAO5Y9OdDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V/oYWWR3; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/oYWWR3"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-72c14138668so2579074a34.2
        for <git@vger.kernel.org>; Thu, 22 May 2025 09:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747932299; x=1748537099; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dCT7QHrlH0Q/wEiKBprfe66/IgM4ngk7nsbM4pIMzdQ=;
        b=V/oYWWR3Pzvr/MCVeEezjEUil7ptj+nUOolYbwTA/fsoJm8TNFXy3OpY7EQDyZF8S5
         Fb+JrTu6tWrPvn/rdw4UpNElT8jIs066HJXaQ/EsMw0N3wQD1oIJ4ud9AoT3vTbiuxZU
         zJ4KFWJKXHkrN+5/+tvbGPvEDcLEjfXpFmq2EI4aNoTxQlORqDOcMAzlZS7J7vy+DWtH
         NbWoBdUHuO2+8fBGTS8UZ7y7s9m2QKGNIUXoRv4tDquXpF+IRBTU6QPUdUWDHSBV6zgB
         Kasx1altO3FuzVj7+1EtuKQPgSAgymIMIZaZlBfw5aWr6DYQBXXG/vna3vCV/IfYeTev
         0RXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747932299; x=1748537099;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dCT7QHrlH0Q/wEiKBprfe66/IgM4ngk7nsbM4pIMzdQ=;
        b=BrAJizt2OXPf1n/S67UDq0w/GFjiXbu85LbswZ652KtMchoWKXye+1ZB5nCtyQXn96
         T5vx628h3ft8I0q57e/v+/6L3H3GecWkSPLwZGxm8YZ007XLydzNwPKrK6uaeStpvPhb
         R/1cwHYbkfskMdO6TMAIxLjVSWNzTf0Vqd734YPrBtM/juqFhxKldFNrbM6TgwZb0Ah6
         fKO6xlK6apZc3ZhQ6deaPF2iZNOX1C/sR1xjqe52sMPX88fRSRB1w2KyHkcwgXgck1la
         LeKeDGxO+HdISzJFj+XbLi2cZ0Lp+MrKoKDc/y37Hu6tPOrK02Qa6hyRXdnMaEEvRuT3
         9dPg==
X-Gm-Message-State: AOJu0YxUr9mWM1aq1wp4e8tRYNjHhkZfCEcx/ymW0l/8r5u1LuGEYjP2
	/RproiASxG+ekB8C7G6Hqb30d7nDrzB/sYn/eCuxyQX70R+vJfe0jgeoCepsmsTn
X-Gm-Gg: ASbGncvKicqAjGF+Rfp0uQCxkml/D8nO01jYfa8JXHfqC3WxVAatd5JgN/hhukoFMQN
	Wr2K0x1HoEHrq0iwIxGge4DYfF4nVAeta1dHjwVguMvY9d/evNaHtuJS7UjznTyAIDysBHhveDh
	XlhNaE3lrJd1PIXrm4aazs00ldsuDK8PyQw+EbZCASwLn7eSmG87nmW1DjlOlxivRnedhLN2xiW
	24FmZJR63GNs+jaCh2+cUqZCknAQfOv/DRXwxx8zFZ0fkmtatwW3QkARafzE4j0LJ2IdphkK48k
	Mm5kGd6V1ujYJokJoOZR+5W0jt43uUPPtjxqvjmoGL8C
X-Google-Smtp-Source: AGHT+IHpeF3HKkOCtwUEzNvrz9MTuEwvqzaBOQipwZBuQM7iJ5dyUBKJhShIAEZ2hpKvm2pWAOPQcQ==
X-Received: by 2002:a05:6830:611a:b0:72a:327:eed3 with SMTP id 46e09a7af769-734f9844038mr16788688a34.5.1747932298659;
        Thu, 22 May 2025 09:44:58 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-734f6a4b272sm2549170a34.5.2025.05.22.09.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 09:44:58 -0700 (PDT)
Date: Thu, 22 May 2025 11:40:18 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Roel Sengers <roel@roelsengers.nl>
Cc: git@vger.kernel.org
Subject: Re: [BUG] Hard links to large files cause unexpected refresh
Message-ID: <66wu7zyhsi5arpujp4mkidafzbu7fj6jfrqzv4e4smtjev6zd7@cmm3doo3w7ky>
References: <195d93de-1d5d-40f3-8139-b73a447b356f@roelsengers.nl>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <195d93de-1d5d-40f3-8139-b73a447b356f@roelsengers.nl>

On 25/05/22 04:45PM, Roel Sengers wrote:
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
> 
> What did you do before the bug happened? (Steps to reproduce your issue)
> 
> In my workflow there is a step which hard-links about 80GB of such files to
> locations where a 3rd party application can find them. However, after this
> hard-linking step, git status (or other git commands) hang for a long time.
> Note that making a copy of the file does not cause such slowdowns, which was
> surprising to me.
> 
> I am using Git with git-lfs for these large files, however I was able to
> reproduce this issue without LFS enabled.
> 
> The script below reproduces the environment which triggers the issue:
> 
> mkdir git-hardlink-test
> cd git-hardlink-test
> 
> git init
> echo ignore.bin > .gitignore
> git add .gitignore
> git commit -m 'Initial commit'
> 
> dd if=/dev/urandom of=file.bin bs=1M count=1000
> git add file.bin
> git commit -m 'Add file.bin'
> 
> # $ cp file.bin ignore.bin; time git status
> # On branch main
> # nothing to commit, working tree clean
> #
> # real	0m0,002s
> # user	0m0,000s
> # sys	0m0,002s
> 
> # $ ln file.bin ignore.bin; time git status
> # Refresh index: 100% (2/2), done.
> # On branch main
> # nothing to commit, working tree clean
> #
> # real	0m16,100s
> # user	0m15,700s
> # sys	0m0,255s
> 
> 
> What did you expect to happen? (Expected behavior)
> 
> After creating a hard link to a checked-in object, I expected the final git
> status to finish in a time that is barely noticeable.
> 
> The file itself is large, so having Git taking its time to refresh the state
> of the working directory would not be suspicious were it not for the fact
> that creating a copy of the same file does not suffer from the same
> performance penalty.

When git-status(1) is run, the index state is checked to see if any
changes have occurred. From the provided example, while the contents of
"file.bin" remain unchanged, the act of creating the hardlink does
update metadata such as the number of links and the file ctime. You can
see this when you stat(1) "file.bin" before and after creating
"ignore.bin". 

Git sees these changes and then refreshes the index entry. When the file
is copied, no such modification happens to "file.bin" and thus that
entry does not need to be refreshed.

To workaround this problem, you could set `core.trustCTime=false` which
tells Git to ignore ctime differences between the index and working
tree.

-Justin
