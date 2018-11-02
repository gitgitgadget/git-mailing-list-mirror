Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B11D41F453
	for <e@80x24.org>; Fri,  2 Nov 2018 03:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbeKBMGr (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Nov 2018 08:06:47 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41786 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbeKBMGq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Nov 2018 08:06:46 -0400
Received: by mail-wr1-f67.google.com with SMTP id x12-v6so477968wrw.8
        for <git@vger.kernel.org>; Thu, 01 Nov 2018 20:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ckQIzppsh6UoAeKmbULU8ZiERdGtEoDBHqV4NcSQwGY=;
        b=oM5cvwDZ4bZ7OhLrqSHll/pkAaGw5i1rzhx++DasAL6ibILxUXw94lLydVTNL+pE5P
         CWHHmjXe7dDthA0/TAsvivfAvoJsZQGvCLVjrFPyZc0KDadf98lIGflEv3O0OJhgtJ0I
         F+PSn8+5crDcmChnHZu/mOLmgkHLu6FKK0bLcYoti8ulXsvrm01Sbwlaojz4z+r1Mpld
         iJP7/+jw1s6bgnVQR9IMEtgPFQENisanZmeqVCVTTBbwcQrQ/dxaOnIyTCv+DuUdrLx6
         GVDq9LwsjFo0gSR0r48KBth2M0XRKLttdtizyUesv/NvQDnks3U5anJQQfenIoc6BBtn
         0O9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ckQIzppsh6UoAeKmbULU8ZiERdGtEoDBHqV4NcSQwGY=;
        b=GKSdrhVTFt2ELiz5AFUdiZhdleiFRQNUWieGdBtWPlGfDrLoDEw+4tq2/PYteuiYaA
         Tz2+8rrNL1Pv8R2nA/HtHhmXHkVZSboUgntCh7n4skMbg4Tw40joracP+LZM9k+zfdAL
         O6vu4rtUqFMAXZEsf/0+as6L0rrZBda2C2EuW3Y1Fxt80SGWZE2i2t3FNfCdOvC1BXsc
         NhRaN+DdR9QZ2zOZgmm55E5KMkmXTuD9hJZuqs6oGvgoTAxp3WCu6rPovRaJ1+1ESRMV
         TNpti+XAXCKlv+Wp1uGzz/Z98f2sWbwHmloJtwmzHsKZtDvKpss6u8PgY9FDFfjqveBE
         jFhA==
X-Gm-Message-State: AGRZ1gIWLxiLiCoC563iMs5bKUv62wlyPCD45IOU7VGqeGBCDhKvcgNE
        poOoBE4XRoWbnvw3gwGCyq4=
X-Google-Smtp-Source: AJdET5d/Uhl4tS6ML+xw5eegt3akCrEu327GZasyI97aog/ZHzlMXZNiUypor9iNqREYx/i1bnFGGA==
X-Received: by 2002:a5d:67d1:: with SMTP id n17-v6mr8368602wrw.245.1541127673072;
        Thu, 01 Nov 2018 20:01:13 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id y195-v6sm25275799wme.22.2018.11.01.20.01.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 20:01:11 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Slavica Djukic <slavicadj.ip2018@gmail.com>
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        slawica92@hotmail.com
Subject: Re: [PATCH 2/3] [Outreachy] ident: introduce set_fallback_ident() function
References: <20181101115546.13516-1-slawica92@hotmail.com>
        <20181101120029.13992-1-slawica92@hotmail.com>
Date:   Fri, 02 Nov 2018 12:01:11 +0900
In-Reply-To: <20181101120029.13992-1-slawica92@hotmail.com> (Slavica Djukic's
        message of "Thu, 1 Nov 2018 13:00:29 +0100")
Message-ID: <xmqqwopwqj2g.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Slavica Djukic <slavicadj.ip2018@gmail.com> writes:

> Usually, when creating a commit, ident is needed to record the author
> and commiter.
> But, when there is commit not intended to published, e.g. when stashing
> changes,  valid ident is not necessary.
> To allow creating commits in such scenario, let's introduce helper
> function "set_fallback_ident(), which will pre-load the ident.
>
> In following commit, set_fallback_ident() function will be called in stash.
>
> Signed-off-by: Slavica Djukic <slawica92@hotmail.com>
> ---

This is quite the other way around from what I expected to see.

I would have expected that a patch would introduce a new flag to
tell git_author/committer_info() functions that it is OK not to have
name or email given, and pass that flag down the callchain.

Anybody who knows that git_author/committer_info() will eventually
get called can instead tell these helpers not to fail (and yield a
substitute non-answer) beforehand with this function, instead of
passing a flag down to affect _only_ one callflow without affecting
others, using this new function.

I am not yet saying that being opposite from my intuition is
necessarily wrong, but the approach is like setting a global
variable that affects everybody and it will probably make it
harder to later libify the functions involved.  It certainly
makes this patch (and the next step) much simpler than passing
a flag IDENT_NO_NAME_OK|IDENT_NO_MAIL_OK thru the codepath.

> +void set_fallback_ident(const char *name, const char *email)
> +{
> +	if (!git_default_name.len) {
> +		strbuf_addstr(&git_default_name, name);
> +		committer_ident_explicitly_given |= IDENT_NAME_GIVEN;
> +		author_ident_explicitly_given |= IDENT_NAME_GIVEN;
> +		ident_config_given |= IDENT_NAME_GIVEN;
> +	}
> +
> +	if (!git_default_email.len) {
> +		strbuf_addstr(&git_default_email, email);
> +		committer_ident_explicitly_given |= IDENT_MAIL_GIVEN;
> +		author_ident_explicitly_given |= IDENT_MAIL_GIVEN;
> +		ident_config_given |= IDENT_MAIL_GIVEN;
> +	}
> +}

One terrible thing about this approach is that the caller cannot
tell if it used fallback name or a real name, because it lies in
these "explicitly_given" fields.  The immediate caller (i.e. the one
that creates commit objects used to represent a stash entry) may not
care, but a helper function pretending to be reusable incredient to
solve a more general issue, this is far less than ideal.

So in short, I do agree that the series tackles an issue worth
addressing, but I am not impressed with the approach at all.

Rather than adding this fallback trap, can't we do it more like
this?

    - At the beginning of "git stash", after parsing the command
      line, we know what subcommand of "git stash" we are going to
      run.

    - If it is a subcommand that could need the ident (i.e. the ones
      that create a stash entry), we check the ident (e.g. make a
      call to git_author/committer_info() ourselves) but without
      STRICT bit, so that we can probe without dying if we need to
      supply a fallback identy.

      - And if we do need it, then setenv() the necessary
        environment variables and arrange the next call by anybody
        to git_author/committer_info() will get the fallback values
        from there.
