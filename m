Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF19B1F4BD
	for <e@80x24.org>; Sun,  6 Oct 2019 17:58:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbfJFR6S (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Oct 2019 13:58:18 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41477 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbfJFR6Q (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Oct 2019 13:58:16 -0400
Received: by mail-pf1-f196.google.com with SMTP id q7so7127150pfh.8
        for <git@vger.kernel.org>; Sun, 06 Oct 2019 10:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kJOtnaH/Vlikw4PFfUe1ps0KqJvJ4tloqHAjJoNRiro=;
        b=IkbfYOyTuRquLuiSBbl8Pm97ANRLku9XoVeKgLDatoVYD51D8hhmIswG8PruXtUXPv
         XoA1qsi+NCV1wZ9qgzh+rcZmYK/P7FlyqEhOm5ihkE0fEz25p/rBMYU//m0eop5lgLmL
         DymkA5IFNGZwbvUiJcNsT3x+0TkH6pez2uP2tqu9n4piw9R/Jh4r5CEBPQep5bQrJzHq
         xaCmKqfN8HIzhZnMyEr1p1OIFLEy6GMJVMRH2USqBWaby10uQooYeZw6NNDzeeJce3Zv
         vWtCUGRE/2zWey0oZEbt0IKch7Kbor9UVBml69mJ/NxsVC3k+Yw1gi8Dh89njcNKvIbV
         Hm3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kJOtnaH/Vlikw4PFfUe1ps0KqJvJ4tloqHAjJoNRiro=;
        b=nFRRBgF5YnyCTdnQSbd0PrjZnhMiWZQVMznXGmcUXbHPL46MgwNE9b1rkTLycxPHKb
         CZB7ZDx2+O/Un3GmuxFhtvSlWFgtAMvjrDsFBeG/gbhsrh8qugAB5j+lqjCnZdS+YUqm
         IeSyn3bDEx2jX3sBo8WnPOzU/IUANRAp0Uh0WfncqvaIyGfJAl+P46HgjxkotHcP+L65
         B1sGzZidCEu0+isy+Gn3/CDkWlU19klOz/4OOmP7zcpx40bYMn0w4qUxeZweioniuPtY
         7IK816GBxtkavdW7ONCB/L97gKx+uvxk7VOynNQOsEDOS4+YSjx7C/KE3jzVqFNfUk9V
         d6Aw==
X-Gm-Message-State: APjAAAW5z71qTuALacgDSIGJjd62cpXzAhfGS6XLe2w1+BNfz5XLNgtE
        aPyTPOMOuYtgXWQT853QzoY=
X-Google-Smtp-Source: APXvYqypRNwVLn+eSS+xycpaXU2Oj4uOsyqPPArya0uzJUTLa3Ia8hSLfwWB1aX+284M0YIL3XI2Kw==
X-Received: by 2002:a63:da4a:: with SMTP id l10mr5875921pgj.193.1570384695737;
        Sun, 06 Oct 2019 10:58:15 -0700 (PDT)
Received: from ar135.mshome.net ([103.37.200.227])
        by smtp.gmail.com with ESMTPSA id e192sm14235064pfh.83.2019.10.06.10.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2019 10:58:14 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     phillip.wood123@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        martin.agren@gmail.com, newren@gmail.com,
        phillip.wood@dunelm.org.uk, rohit.ashiwal265@gmail.com,
        t.gummerer@gmail.com
Subject: Re: [PATCH v4 3/6] rebase -i: support --committer-date-is-author-date
Date:   Sun,  6 Oct 2019 23:27:29 +0530
Message-Id: <20191006175729.17257-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <3f29cb5d-dbc2-ae00-651b-22e9f437372a@gmail.com>
References: <3f29cb5d-dbc2-ae00-651b-22e9f437372a@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 4 Oct 2019 10:37:43 +0100 Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> > +	if (opts->committer_date_is_author_date) {
> > +		int len = strlen(author);
> > +		struct ident_split ident;
> > +		struct strbuf date = STRBUF_INIT;
> > +
> > +		if (split_ident_line(&ident, author, len) < 0)
> > +			return error(_("malformed ident line"));
>
> Here (and just below) we return if there is an error but later on we 
> `goto out` should we be doing that here to clean something up?

Yes, a mistake indeed. This should be replace with an error and a
goto statement.

> Best Wishes
>
> Phillip
>
> > +		if (!ident.date_begin)
> > +			return error(_("corrupted author without date information"));
> > +
> > +		strbuf_addf(&date, "@%.*s %.*s",
> > +			    (int)(ident.date_end - ident.date_begin), ident.date_begin,
> > +			    (int)(ident.tz_end - ident.tz_begin), ident.tz_begin);
> > +		res = setenv("GIT_COMMITTER_DATE", date.buf, 1);
> > +		strbuf_release(&date);
> > +
> > +		if (res)
> > +			goto out;
> > +	}
> > +

Thanks
Rohit

