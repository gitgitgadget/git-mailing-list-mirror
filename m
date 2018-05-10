Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBD6D1F42D
	for <e@80x24.org>; Thu, 10 May 2018 09:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756756AbeEJJ52 (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 05:57:28 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:44982 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934433AbeEJJ51 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 05:57:27 -0400
Received: by mail-wr0-f196.google.com with SMTP id y15-v6so1365933wrg.11
        for <git@vger.kernel.org>; Thu, 10 May 2018 02:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Ik9t7JfCHdnEf8EhSrGwhJQvImx/QXvMaSwMOSOPfY0=;
        b=A161wmxQwsoaCzCHE/2PMtxeoNqET9qkeAxToH43IJmEQOr8QK+M4Ie6iuMPJlYSJD
         MCS0Ej8vtdTRMqFYgvyfJuf4I9l88QhtcYbUEoBpMM7UWJy3t8WXQAdNPsiC6D4MFOOC
         ZkxjzXhAzVhM96+KyvrFH7ubKUHDXN/+9jaX1Rszafxh0j0LAxlphs64/fTOmSvOJBAZ
         wa8z4qGqslAUcJv5FJnW/I8vDssaRHmah1qoSNLNrdA2XoLfcvbncr2cyHOytAR1zTqI
         uvrFkx0dBBIRs63/vb38f4elWONoAV1vH5E72yGmmtjajFyveEE0BfmARKUHBSxseNXy
         eddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=Ik9t7JfCHdnEf8EhSrGwhJQvImx/QXvMaSwMOSOPfY0=;
        b=NpnRLJMHUYeMHRd75gnccZt88nbuKoinUhd3PYuqtHH0kn5AZuEnLTbta1KaOGz8Au
         mfx8nvCM5FilygQooQG3wpDHH/A1L8CKDs50bt3z8MX5yRcZH2VnfWgVYcsZ+mqgMeo3
         BpOMY72dxOP0OlGb0vQP48AMcesyEmt8fNV6ZaOXJ9RxJkTrQuu0EEBLFXbAlf6fmH2z
         EZZ3+1vBuHvmUMuF/EoxDyPzkclW8Pi0WqLZK5JVgfJB2lxAQI+/0aIOrudtm3Lx0koF
         Sk8UCE/EUpMqZ11XD+tOTckCuEjFeD0yjb/1JCUukc8+5xH/iP4xv7DLX3vCKdTxQmOg
         4J2A==
X-Gm-Message-State: ALKqPwfTK8Go67/Kbhfx4I0IwS+KN0hOf9xKe8ArsI46+579kkrcLR1D
        doZZxlIxs9ugedK7DQwbyWg=
X-Google-Smtp-Source: AB8JxZpYUli5Xk2zIZmlSGX4KkUI/ammrLoXvMSozJSx03odKvuVY47Sj1JSL6PghE4nNcK1yjPkew==
X-Received: by 2002:adf:ca12:: with SMTP id o18-v6mr761534wrh.272.1525946245767;
        Thu, 10 May 2018 02:57:25 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 69-v6sm1049154wmi.29.2018.05.10.02.57.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 May 2018 02:57:24 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Luis Marsano <luis.marsano@gmail.com>
Cc:     git@vger.kernel.org, Ted Zlatanov <tzz@lifelogs.com>
Subject: Re: [PATCH 2/2] git-credential-netrc: accept gpg option
References: <20180509213634.5198-1-luis.marsano@gmail.com>
        <20180509213634.5198-3-luis.marsano@gmail.com>
Date:   Thu, 10 May 2018 18:57:24 +0900
In-Reply-To: <20180509213634.5198-3-luis.marsano@gmail.com> (Luis Marsano's
        message of "Wed, 9 May 2018 17:36:34 -0400")
Message-ID: <xmqq36yzkf3v.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Luis Marsano <luis.marsano@gmail.com> writes:

> git-credential-netrc was hardcoded to decrypt with 'gpg' regardless of the gpg.program option
> this now uses the gpg command option if set, else, the gpg.program option set in the git repository or global configuration, else defaults to 'gpg'
> for git-credential-netrc

These lines are way overlong.  Wrap at around 72-78 cols, perhaps.
Complete each sentence with a full-stop.

> - use Git.pm for repository and global option queries
> - add -g|--gpg command option & document it in command usage
> - test repository & command options
> - support unicode

There are other changes that are not explained/justified here, I
think.

 - Instead of ALLCAPS as a placeholder for a command line argument in
   the help text, use <placeholder>, because doing so is better due
   to such and such reasons.

I think it is good to consistently do so, but it is unclear why
ALLCAPS is bad and <placeholder> is better.  That needs to be
explained.

 - Replace three-dots in the help text with U+2026 to punish those
   who are still using unicode-inapable terminal in this century.

I do not think this part of the patch is a good idea at all, but
perhaps I misunderstood the reason behind this change you had in
mind (as you did not explain it in the proposed log message).

> @@ -62,27 +69,31 @@ if ($options{help}) {
>  
>  	print <<EOHIPPUS;
>  
> -$0 [-f AUTHFILE1] [-f AUTHFILEN] [-d] [-v] [-k] get
> +$0 [(-f <authfile>)…] [-g <program>] [-d] [-v] [-k] get

Is this a desired change, or unwanted change left in the patch by
accident?


> -...and if you want lots of debugging info:
> +…and if you want lots of debugging info:

Is this a desired change, or unwanted change left in the patch by
accident?

>  
>    git config credential.helper '$shortname -f AUTHFILE -d'
>  
> -...or to see the files opened and data found:
> +…or to see the files opened and data found:
>  

Ditto.

>    git config credential.helper '$shortname -f AUTHFILE -v'
>  
> -Only "get" mode is supported by this credential helper.  It opens every AUTHFILE
> +Only "get" mode is supported by this credential helper.  It opens every <authfile>
>  and looks for the first entry that matches the requested search criteria:
>  
>   'port|protocol':
> @@ -120,7 +131,7 @@ host=github.com
>  protocol=https
>  username=tzz
>  
> -this credential helper will look for the first entry in every AUTHFILE that
> +this credential helper will look for the first entry in every <authfile> that
>  matches
>  
>  machine github.com port https login tzz
> @@ -129,7 +140,7 @@ OR
>  
>  machine github.com protocol https login tzz
>  
> -OR... etc. acceptable tokens as listed above.  Any unknown tokens are
> +OR… etc. acceptable tokens as listed above.  Any unknown tokens are

Ditto.

>  # Credentials must get a parameter, so die if it's missing.
> -die "Syntax: $0 [-f AUTHFILE1] [-f AUTHFILEN] [-d] get" unless defined $mode;
> +die "Syntax: $0 [(-f <authfile>)…] [-d] get" unless defined $mode;

Ditto.

