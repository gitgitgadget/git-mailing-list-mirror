Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 290791F461
	for <e@80x24.org>; Wed, 15 May 2019 18:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbfEOSW6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 14:22:58 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:46459 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfEOSW5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 14:22:57 -0400
Received: by mail-pf1-f202.google.com with SMTP id d9so344179pfo.13
        for <git@vger.kernel.org>; Wed, 15 May 2019 11:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RXI/LsbYM/BICiziZdgx6GpnWzpR2FMzP+1hp26kgdE=;
        b=kzHuFMmF74SbXahX403WcBYv10nXTwtClPjb/IYUOmNE2ZKJlBM9gVE2VH0Alh8tjw
         1tzwK3CqUPjyE6rhtiBY20rTSg00NlSY3UDTASMpZW8O1NP5P64ohwkwHWlVDYO8gwdT
         MnmUhPL0zuWshDmWglhLiS/7yklLGYMo9aMZWqjzPp4NvqBrEDcVvh060IGAuwKpKlk7
         BHcxGS6l/ZhCnrskiFWeJUBa7u72DbJYQ9jrcsA+NzaCWmHhAXqfl8FYFozP2I/aoSsF
         VHxjtOzfC6XqPcHm8qsZIe7+RegBL1LvSQAVanwfoGyEAliDZeYPopDhxCPI6AcCj5uY
         hhtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RXI/LsbYM/BICiziZdgx6GpnWzpR2FMzP+1hp26kgdE=;
        b=AEicnmepb9qFWQAv96C2AH66u2C6FWB+4e0/efPf+mfofVaTstafqVeqYQ/lNI/PoW
         AjykQhnQq2ibS4IaBNiH2GaGGVSzvjS6EpMNVNkepA1gYfysQvJaq4kJDhac1CKIrGKW
         jOlSzee76SUGah9acuKdOqoshEQ6g/YUw4EQFmBpcr42GbyzGCM5Eb8aqX6gYGeJmhDB
         9V40Vv2Ov6zK+DCaqjks0Gbn99hBf8p89IWScqu3NrzxpmLENxlD+QAmPpxlCklaAhTg
         +Wl+Bye3hgmoqV6ymzSPJg7tdIcEqYe3HxyNQcecX4mF4qQLoezn7i+XJjO3YKlj7geE
         eypQ==
X-Gm-Message-State: APjAAAU0IeRy5YqYj+3LmE5pC+KtWSoRYayfPkCTs4+109hHFHZAG7uQ
        UhUF4cbsvZ6BwgFjFyVBT0PqSOdXxEXxIxU38NBO
X-Google-Smtp-Source: APXvYqyWv8YAq8r3iX1ILm32kyIbn4JsznAAXNKyCqM2kVlMzH9amVPEF2XX8f1GEVVMal7+bUYJ19K4UUZUVj3IAEng
X-Received: by 2002:a63:1f04:: with SMTP id f4mr45723888pgf.423.1557944576811;
 Wed, 15 May 2019 11:22:56 -0700 (PDT)
Date:   Wed, 15 May 2019 11:22:53 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1905151032500.44@tvgsbejvaqbjf.bet>
Message-Id: <20190515182253.105984-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <nycvar.QRO.7.76.6.1905151032500.44@tvgsbejvaqbjf.bet>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: Re: [PATCH 1/2] t5616: refactor packfile replacement
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Johannes.Schindelin@gmx.de
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > +# Converts bytes into their hexadecimal representation. For example,
> > +# "printf 'ab\r\n' | hex_unpack" results in '61620d0a'.
> > +hex_unpack () {
> > +	perl -e '$/ = undef; $input = <>; print unpack("H2" x length($input), $input)'
> > +}
> > +
> > +# Inserts $1 at the start of the string and every 2 characters thereafter.
> > +intersperse () {
> > +	sed 's/\(..\)/'$1'\1/g'
> > +}
> > +
> > +# Create a one-time-sed command to replace the existing packfile with $1.
> > +replace_packfile () {
> > +	# The protocol requires that the packfile be sent in sideband 1, hence
> > +	# the extra \x01 byte at the beginning.
> > +	printf "1,/packfile/!c %04x\\\\x01%s0000" \
> > +		"$(($(wc -c <$1) + 5))" \
> > +		"$(hex_unpack <$1 | intersperse '\\x')" \
> > +		>"$HTTPD_ROOT_PATH/one-time-sed"
> >  }
> 
> Urgh. This is not a problem *this* patch introduces, but why on Earth do
> we have to do complicated computations in shell code using an unholy mix
> of complex sed and Perl invocations, making things fragile and slow? We do
> have such a nice facility is the t/test-tool helper...

This might be a good #leftoverbits. I'm not sure which part you think
needs to be replaced - maybe the thing that goes into one-time-sed?

> The refactoring itself looks correct to me, of course.

Thanks, and thanks for taking a look at this.
