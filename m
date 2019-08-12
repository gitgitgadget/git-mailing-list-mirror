Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86EA01F45A
	for <e@80x24.org>; Mon, 12 Aug 2019 04:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbfHLEg3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Aug 2019 00:36:29 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39813 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbfHLEg3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Aug 2019 00:36:29 -0400
Received: by mail-wm1-f65.google.com with SMTP id u25so10529570wmc.4
        for <git@vger.kernel.org>; Sun, 11 Aug 2019 21:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KXSolOYKu0hJC0Q+mCrkYs+vNKOojY2KsGPoFOLFNYQ=;
        b=C/q1ZeoytSJJI+I10+cshqijvL3j8mVhauIGrNZzYXPGsoLjG9meSziGk2ZQSE4k4Q
         kdI1v0i/e/asnUMBrE+DrNx8XTHJs5ZbIxqRUcu1vPffN0HqJrVM1WJlp9tXXFI47mfU
         eBqQpuqhIK/4WhnXWJ9tGZei4S+5G6nMWv6rjSmnlrLC09lzAAGtEhisZWLjSFHt8lID
         Llvp2t7bZuY6zCLafwot5VUbbYdBx6HnI065NGXpQVYd8o8cm4sErApd/nplTG8OEu9M
         DLAgaK3/4Qbtfzog3S03tdG1VPOE9JeHXbkVxFuJiXCSyxQm7CFMogEkR+Za6ih5wlW7
         2asA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KXSolOYKu0hJC0Q+mCrkYs+vNKOojY2KsGPoFOLFNYQ=;
        b=ja/aQMrXowOqvdU3NINiV8VtDdvwqIvC9okkHkH5Rw4TBR9/0jgBzvli+YE9uHN/Ic
         +5yYL1aOyGk7iDfVBrj+1rmnokntdxKsW6p4zwKwoFZWFmYG9gSzs1QR3/aQKoYUcKqw
         h09p0bAVO6hvNvYIzvElVeNp2B4szksP2mgwILq6MPnBH/kzNxfW9+M+EKOsOYOYoTZQ
         NltSNWs/4u46I8wC27tzNdENBxrUxGHVFpLQUyjgMP5iTkglLPQCfVMtpLEJ3O7YPPnY
         9n1qvm0Ud5Mwab9MvIAz0TM4QvwohRCZouFEMmMehU9m5dTbjEQXKPqfmtsQ9vRRuJLW
         l67g==
X-Gm-Message-State: APjAAAUx8FyQjFbl2VHDJ3GFxQ6dZNhSdPdT/nOwBs/jHaFaqBS8K3U0
        XygXV1rCOkWLUHTsRTAZZVw=
X-Google-Smtp-Source: APXvYqyLUsciaBnRH1nnSGnB4VWC0pZjU7tmxaf+zAys84a/k5Z18qdySNSrCYJEWwhZlpAHhFo92A==
X-Received: by 2002:a1c:a6c8:: with SMTP id p191mr24219284wme.99.1565584587394;
        Sun, 11 Aug 2019 21:36:27 -0700 (PDT)
Received: from szeder.dev (x4db63f8e.dyn.telefonica.de. [77.182.63.142])
        by smtp.gmail.com with ESMTPSA id c15sm49766449wrb.80.2019.08.11.21.36.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Aug 2019 21:36:26 -0700 (PDT)
Date:   Mon, 12 Aug 2019 06:36:22 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/2] path: add a function to check for path suffix
Message-ID: <20190812043622.GL20404@szeder.dev>
References: <20190809100217.427178-1-sandals@crustytoothpaste.net>
 <20190811174748.33552-1-sandals@crustytoothpaste.net>
 <20190811174748.33552-2-sandals@crustytoothpaste.net>
 <xmqq1rxrcjfp.fsf@gitster-ct.c.googlers.com>
 <20190812011054.GA9180@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190812011054.GA9180@genre.crustytoothpaste.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 12, 2019 at 01:10:54AM +0000, brian m. carlson wrote:
> On 2019-08-12 at 00:32:26, Junio C Hamano wrote:
> > "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> > > +static ssize_t stripped_path_suffix_offset(const char *path, const char *suffix)
> > 
> > Perhaps
> > 
> >     static ssize_t last_path_component_offset(const char *path, const char *name)
> > 
> > I am tempted to also call the second parameter to this function
> > "basename", as we know from the proposed log message that you wish
> > "basename" were usable for this purpose, but basename itself has
> > another confusing factor (i.e. "are we stripping ".exe" extension?",
> > to which the answer is no in the context of these functions).
> > 
> > If we agree with the "last path component" phrasing, has_path_suffix()
> > would become something like:
> > 
> >     int last_path_component_equals(const char *path, const char *name);
> 
> Except this is not necessarily the last path component. It could match
> one or more path components with the way the function is written. If you
> want to ignore that and name the function accordingly, I won't object,
> but we could theoretically handle a name like "foo/.gitattributes" as
> well.

ends_with_path_components(), perhaps?

I think having "path_component" in some form in the function name
would have avoided my confusion mentioned earlier in a reply to the
first version.


