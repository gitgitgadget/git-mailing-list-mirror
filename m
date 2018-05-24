Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 228391F51C
	for <e@80x24.org>; Thu, 24 May 2018 07:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964878AbeEXHUN (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 03:20:13 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34081 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964830AbeEXHUM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 03:20:12 -0400
Received: by mail-wm0-f67.google.com with SMTP id q4-v6so6482634wmq.1
        for <git@vger.kernel.org>; Thu, 24 May 2018 00:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=RAgpifKtELWSmtBjqBUy56UvmpmK6/kGVZsWViNguFU=;
        b=mlCG2AqIKPNrWYrXQfhvIpDvWTA8T3dfBdQ2Vx6ZT0LqJWw9TrBzcdKFcYamsz7ab3
         Gk62uZs7Wt+9ibrrtHVt4y6UwEoXC1qJjzEmWWH5qoGNRJj7PYhhelaY2EnHH/L6Bd8o
         I09ANWIqknSrPJoG1djIPPnyK3tKdyrM7kXPZMY50xWtla5FZgGn07Hdzf5qBBVbkoTD
         KI8VNhN1vqLtJucbW91pXCKsVsfnOcSSs4BztSCKQfmKsrw3F3yaoTRnKEXL/p2Z5pR1
         XK/H3YxVXK9edSbxU08bqEriL9tX6+TSmmPucKbMarNf4tBnzhs48sHxiaNjr7vmRoPu
         fzAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=RAgpifKtELWSmtBjqBUy56UvmpmK6/kGVZsWViNguFU=;
        b=o0XZGmS08vhiylRTyP9O+qJFTEolUHRSTIRNgqlPAMkIfYlOVy6IPVwi0eXAOZh9eU
         gBzyp6GrHtGydNZj8cdo/2e5u4dIwtfh8qzqrOXMctc7wF7Xfsu5Jej3shmEcSjOQNAa
         5GDYKGcJXolwy/kP6wRlVjLVwhkrT180rLhVCJo46egrPblYU0Bq+cKj3NiCWcIVIXme
         SVgyLWH5IppEC9TSbBOzt5y97NEbXBFQNkxVMRrfxXo6128kro+fXj9GwV08pxMUBIef
         gIm/WW+ABjjwLNpo8iUxJ63G8xdGO6kyBUDJChTbd2JlvosdwUpXKFDz3eMpQJSg5K/9
         qPqA==
X-Gm-Message-State: ALKqPwcC2jT55Y8btRPsvTqhPem0jWA91nwg2aNeyIw1hMMXogTTblSF
        h4javLzjCpkvCaFZFL4QC+UEHAgM
X-Google-Smtp-Source: AB8JxZqWtEi+ttKFaope4OAxueKHBMFxy2YE5QqryU8uFrm+fHs9Sqa2gx4UEBjFLM1niL1tc2BnHg==
X-Received: by 2002:a1c:d7d0:: with SMTP id o199-v6mr6120393wmg.61.1527146410904;
        Thu, 24 May 2018 00:20:10 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 32-v6sm13885390wrf.33.2018.05.24.00.20.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 May 2018 00:20:10 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC/PATCH 2/7] rerere: mark strings for translation
References: <20180520211210.1248-1-t.gummerer@gmail.com>
        <20180520211210.1248-3-t.gummerer@gmail.com>
Date:   Thu, 24 May 2018 16:20:09 +0900
In-Reply-To: <20180520211210.1248-3-t.gummerer@gmail.com> (Thomas Gummerer's
        message of "Sun, 20 May 2018 22:12:05 +0100")
Message-ID: <xmqq603dseom.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

>  		if (write_in_full(out_fd, buf.buf, buf.len) < 0)
> -			die("unable to write rerere record");
> +			die(_("unable to write rerere record"));

As we'd be adding these new strings to the .po file, perhaps we
would want to downcase the first letter in the message to match the
convention?

> ...
> -		return error_errno("Could not open %s", path);
> +		return error_errno(_("Could not open %s"), path);
> ...
> -		error("There were errors while writing %s (%s)",
> +		error(_("There were errors while writing %s (%s)"),
> ...
> -		io.io.wrerror = error_errno("Failed to flush %s", path);
> +		io.io.wrerror = error_errno(_("Failed to flush %s"), path);
> ...
> -		return error("Could not parse conflict hunks in %s", path);
> +		return error(_("Could not parse conflict hunks in %s"), path);
