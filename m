Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D57171BB
	for <git@vger.kernel.org>; Tue,  2 Jan 2024 22:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="K5ihsufM"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3bc09434600so716554b6e.0
        for <git@vger.kernel.org>; Tue, 02 Jan 2024 14:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1704234209; x=1704839009; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dl4m1dYGEc8Vnb58DiHGgdthmsFotAK8744bwAOzD18=;
        b=K5ihsufMtHWpbl1jNBe770g056MJL2mUKJ0AEmnEThSl8oqzDCvEycdTNWVkOjt/Lg
         FMiXxLd2K5QjCF36U3U1HXBaSqAUKFYXiYr6TJrne/cLplwW27NBVgi9dISx7abemhu5
         sD/LgF4mP/L6WFTgIXcVzLqVTCs6Kdhh/GHftQvZdsXbnk4nYS6glvJZ30EyjhLX+TGA
         /pFRp3lvclxf6SOETz0j4Cd1b64DRBV1aF2g7LEs3sOukY0Y/UMVirhngaAe/9mkpGwl
         Ytw+uM4fTF0/47mnUGwQLKMQLhv5eHKlIhqetnpEaqIyhYIKubVfpXRgQ8X6Jltrcy0g
         Bp3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704234209; x=1704839009;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dl4m1dYGEc8Vnb58DiHGgdthmsFotAK8744bwAOzD18=;
        b=NXbp/DATlFBkWA8nKpZ1zTtwgEl/q29wRsGOPc0iTeKVcpG8ryLcWsM69dplj3XTBu
         eTtsxQorrPrEdVtstRTCfBnmwHncQTDYOXZNdmUaLg3T64Jo4R2BOfEJjJHJ7MwudTgL
         E+pWeW+qhH1CfeNjrzA9WCWwcwoVEHaEKpfEbzLoFJlJAd4xBG3PLa7/L0ibG2UChgw9
         919DEXaJUmDJKAmwUlMUrUWHVYJ4a9knMkT96QFYx7df/aL2WSUMem1hti8mj6WEp7Qc
         v6LUZZARnIKnfY0JeOim9BtYxUzH4BIFlx9S317A1CE9edTjpOMh872E2+pvFNLKIm1b
         g5WA==
X-Gm-Message-State: AOJu0Yxwic0B9CCy0Ob+gr8hhVsD/7hTXGQTYUMyo8O3DcMff30rhVp0
	EW1T9lv9lYcvCFdm//y4PYQsO9mwLcTYiw==
X-Google-Smtp-Source: AGHT+IHOWDSKxzmUH5CjroZhQEWlb6NRv8C14lpkDyJVB74x2g7tWNym6Ys6rq/QUCHUGsKYl4bPIg==
X-Received: by 2002:a05:6808:7c2:b0:3bc:15a5:6de with SMTP id f2-20020a05680807c200b003bc15a506demr46485oij.37.1704234209652;
        Tue, 02 Jan 2024 14:23:29 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id te11-20020a056871880b00b001fa3c734bc5sm5757567oab.46.2024.01.02.14.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 14:23:29 -0800 (PST)
Date: Tue, 2 Jan 2024 17:23:19 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Askar Safin <safinaskar@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [BUG] Asks for "To" even if "To" already specified in letter
Message-ID: <ZZSM17hDYFklS9C8@nand.local>
References: <CAPnZJGBbA1VLAdP5mZnbF77-x-87JjU3Ku2MhrQu0SFoJL7ggw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPnZJGBbA1VLAdP5mZnbF77-x-87JjU3Ku2MhrQu0SFoJL7ggw@mail.gmail.com>

On Sat, Dec 30, 2023 at 06:20:43AM +0300, Askar Safin wrote:
> Hi. I found a bug. Steps to reproduce:
> - Create file /tmp/m with following text:
> ===
> Subject: subj
> To: example@example.com
>
> text
> ===
> - Send it using command "git send-email /tmp/m"
>
> You will see that git asks for "To". git says: "To whom should the
> emails be sent (if anyone)?"
> I don't like this. git should just use "To" from /tmp/m without asking.
>
> Seen with git 2.43.0.
>
> If I execute "git send-email --to-cmd='#' /tmp/m" or
> "git send-email --to-cmd=':' /tmp/m" or
> "git send-email --to-cmd='true' /tmp/m", then "To" is not asked.

I was going to suggest that you use the `--to-cmd=true` trick. I'm
definitely not an expert in the send-email code, but from a cursory
look, I think that this is do-able.

One thing you could do is read all of the messages ahead of time, parse
their headers, and then extract any "To:" headers that you find. This is
pretty similar to what the pre_process_file() function is already doing.
But this might not be the right approach, since FIFOs can only be read
once, and we already have some logic to handle FIFOs specially (see
3c8d3adeae (send-email: export patch counters in validate environment,
2023-04-14)).

But I think that something much simpler would work, which to avoid
asking for a "To:" value altogether, even if one isn't provided. If you
did something like:

--- 8< ---
diff --git a/git-send-email.perl b/git-send-email.perl
index 821b2b3a13..2941278315 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1018,13 +1018,6 @@ sub file_declares_8bit_cte {

 my $to_whom = __("To whom should the emails be sent (if anyone)?");
 my $prompting = 0;
-if (!@initial_to && !defined $to_cmd) {
-	my $to = ask("$to_whom ",
-		     default => "",
-		     valid_re => qr/\@.*\./, confirm_only => 1);
-	push @initial_to, parse_address_line($to) if defined $to; # sanitized/validated later
-	$prompting++;
-}

 sub expand_aliases {
 	return map { expand_one_alias($_) } @_;
--- >8 ---

I think that would more or less do the trick. send-email will happily
continue on even without an initial $to value, and validate it later
when it's actually needed.

I'm not familiar enough with the code to know if this is the right
approach, so hopefully some other send-email experts can chime in and
let me know if I'm on the right track ;-).

Thanks,
Taylor
