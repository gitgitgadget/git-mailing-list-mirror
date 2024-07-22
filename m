Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEE21C695
	for <git@vger.kernel.org>; Mon, 22 Jul 2024 19:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721675167; cv=none; b=BurKi1zIN48YL0MYR5epCPu77nmK+mW3GzQQzoCsv2YxFvGMLdzEKLey2+5mOqc+HJMumSdarsNkqKXQhLdfuNDCAruQ6bxiPD8aiTAl4ATpAaRJsLNdeu9Co6R8PA3sQ5NEk+A5MmpbgBCvJZnLI5K2hmAASXVZBZaW6JO2Trk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721675167; c=relaxed/simple;
	bh=2TJYHD9WWhlPolg5DOWCeZCLYSyGRzu+iz6TIrIj1KU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ohsq422i7y80O5cZ0dR4YZo7SFrxoTio+lhA6joJNTglG1rJVSbaz0UW43VaWKZ+SZj+MkOxMoaayVEWCWdkA5x1RGY5Yl6cb22wpiPPTh2uyKn1t3s3HWJcJD1pHrLd35602cbEnjoivztjjChAM/iYYV4z8kbR/7KmaZWVOjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ciQ7ytIy; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ciQ7ytIy"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-368712acb8dso2191644f8f.2
        for <git@vger.kernel.org>; Mon, 22 Jul 2024 12:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721675164; x=1722279964; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p5GuPpNCteLrZVNTjBIiEP2ByyC/GWnV8zTS6a5jPBA=;
        b=ciQ7ytIy3zXoV7WQUZQu5a3xEb1nvmXzI9OvQ1ZI4ADHVmCISNRbgLj75rEwvlBGoB
         ddH9qVbC4OGkeUbJXqy8l8+wh1mYVBphWWll2zTYV405LRdHGY48zebpPcJfZx7WR16l
         8pAsDQs0f4eIwnwwQ4jbs7LzAQRmgxOpeuzNl0797OxTZpeMTuI9bVpw49X5AslFMRuw
         3MCUkipvNSkgdqm/Jhky+cq7wqjQL+2qlGad2OKipUNKp3GdZ/wEse6cNgJjevuGgigl
         HC0tX8Ueua+JCqTxxcPk1c5Zw67+2mSdLArFZrqaS3P/jwAeJQMK3K8G8Du5p2UL/Ibp
         f5/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721675164; x=1722279964;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p5GuPpNCteLrZVNTjBIiEP2ByyC/GWnV8zTS6a5jPBA=;
        b=aB7aJ4yAf9/B/EJbbYlY4zrMiD76/YaAcLekmQykK0SSD/cUdm3KnRPQwdb/yqZngr
         tMJq/+SBPE3l0p3JehtNXIAUOqMiK20TWWn+qiKO9QkR32eqO68Am8uxNl0qID3r6NrE
         2P8pmYEzhHz+bKTiPPZUC0Ok70Z4NOxoM89TvLyOwUHS+hWZ5UgEMm4B3yGaH6zHXSkw
         m28iQqtCGyigDv3hVMS8i4+g7qd6Gdw7eDrAJ1bnvOZP6ic7NHaamu5ho1rMt/Lf+o98
         0fz/epxokedNgEG2NfOcDCa54CjodxtftG/XhP729MgUN3QhocZSXWRafF34PbWpmnoA
         gseg==
X-Forwarded-Encrypted: i=1; AJvYcCXaSfG5KEuhP93gFyp/MymlAnw/BGFtP+odQS/apNBMMv7Gc/uEofrwwVJIWBVvKjkjVagJVTtr4gkZED9DDq+8WbLj
X-Gm-Message-State: AOJu0YxuQ9V/t1MOkZ0O6rHYePfXVwzWsJmxz00TdVtetJ/dQK0q2wKd
	nfAu2+8azo+p1x1QwcpdNa/MMHYOTmPrBhcTfosakNnqkdqQiWjk
X-Google-Smtp-Source: AGHT+IFaDTNAHlTNCZ6il9VLLq8b+zBMgwSJwvp4BplqkzHivnDo4zfZaoLf3KVnwz565oD436Z1DQ==
X-Received: by 2002:a05:6000:c4e:b0:368:4226:4085 with SMTP id ffacd0b85a97d-369debfe527mr581256f8f.8.1721675164097;
        Mon, 22 Jul 2024 12:06:04 -0700 (PDT)
Received: from gmail.com (89.red-88-14-41.dynamicip.rima-tde.net. [88.14.41.89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-368787ced05sm9291055f8f.67.2024.07.22.12.06.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 12:06:03 -0700 (PDT)
Message-ID: <079901fe-7889-4e1f-bb91-610e1eae25d3@gmail.com>
Date: Mon, 22 Jul 2024 21:06:02 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] add-patch: render hunks through the pager
To: Junio C Hamano <gitster@pobox.com>
Cc: phillip.wood@dunelm.org.uk, Git List <git@vger.kernel.org>,
 Dragan Simic <dsimic@manjaro.org>, Jeff King <peff@peff.net>
References: <2653fb37-c8a8-49b1-a804-4be6654a2cad@gmail.com>
 <ebcba08f-3fbb-4130-93eb-d0e62bfe0a8a@gmail.com>
 <efa98aec-f117-4cfe-a7c2-e8c0adbdb399@gmail.com>
 <1dc9ebad-768b-4c1a-8a58-8a7a5d24d49e@gmail.com> <xmqqttgqyzwa.fsf@gitster.g>
 <2b57479c-29c8-4a6e-b7b0-1309395cfbd9@gmail.com>
 <88f9256e-04ba-4799-8048-406863054106@gmail.com>
 <a2ea00e2-08e4-4e6b-b81c-ef3ba02b4b1f@gmail.com> <xmqqv80xcpe5.fsf@gitster.g>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqqv80xcpe5.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Mon, Jul 22, 2024 at 10:22:58AM -0700, Junio C Hamano wrote:
 
> Attached at the end is a test tweak patch, taking inspirations from
> Phillip's comments, to see what value GIT_PAGER has in the shell
> function.  I shortened the huge_file a bit so that I do not have to
> have an infinite scrollback buffer,but otherwise, the test_quirk
> intermediate shell function should work just like the test_terminal
> helper in the original position would.
> 
> And I see in the output from "sh t3701-add-interactive.sh -i -v":
> 
>     expecting success of 3701.51 'P handles SIGPIPE when writing to pager': 
>             test_when_finished "rm -f huge_file; git reset" &&
>             printf "\n%250s" Y >huge_file &&
>             git add -N huge_file &&
>             echo "in env: GIT_PAGER=$(env | grep GIT_PAGER=)" &&
>             test_write_lines P q | GIT_PAGER="head -n 1" test_quirk &&
>             echo "after test_quirk returns: GIT_PAGER=$GIT_PAGER"
> 
>     in env: GIT_PAGER=
>     in test_quirk: GIT_PAGER=head -n 1
>     in env: GIT_PAGER=GIT_PAGER=head -n 1
>     In test_terminal: GIT_PAGER=GIT_PAGER=head -n 1
>     test-terminal: GIT_PAGER=head -n 1
>     diff --git a/huge_file b/huge_file
>     new file mode 100644
>     index 0000000..d06820d
>     --- /dev/null
>     +++ b/huge_file
>     @@ -0,0 +1,2 @@
>     +
>     +                                                                                                                                                                                                                                                         Y
>     \ No newline at end of file
>     (1/1) Stage addition [y,n,q,a,d,e,p,?]? @@ -0,0 +1,2 @@
>     (1/1) Stage addition [y,n,q,a,d,e,p,?]? 
>     after test_quirk returns: GIT_PAGER=
>     Unstaged changes after reset:
>     M       test
>     ok 51 - P handles SIGPIPE when writing to pager
> 
> So:
> 
>  - before the one-shot thing, in the envrionment GIT_PAGER is empty.
>  - in the helper function,
>    - shell variable GIT_PAGER is set to the expected value.
>    - GIT_PAGER env is exported.
>    - test-terminal.perl sees $ENV{GIT_PAGER} set to the expected value.
>  - after the helper returns GIT_PAGER is empty
> 
> It's a very convincing theory but it does not seem to match my
> observation.  Is there a difference in shells used, or something?

Have you tried your tweak in the "linux-gcc (ubuntu-20.04)" test
environment where the problem was detected?  In that environment, the
value of GIT_PAGER is not passed to Git in that test. 

To fix the test, as already said, we need this:

	test_write_lines P q |
	(
		GIT_PAGER="head -n 1" &&
		export GIT_PAGER &&
		test_terminal git add -p >actual
	)

And this series also need the other other change that I'm discussing
with Phillip: 

diff --git a/pager.c b/pager.c
index 5f0c1e9cce..5586e751dc 100644
--- a/pager.c
+++ b/pager.c
@@ -46,6 +46,8 @@ static void wait_for_pager_atexit(void)

 void wait_for_pager(void)
 {
+       if (old_fd1 == -1)
+               return;
        finish_pager();
        sigchain_pop_common();
        unsetenv("GIT_PAGER_IN_USE");

