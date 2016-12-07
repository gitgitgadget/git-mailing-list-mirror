Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A88231FF7F
	for <e@80x24.org>; Wed,  7 Dec 2016 22:41:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932840AbcLGWlS (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 17:41:18 -0500
Received: from mail-pg0-f43.google.com ([74.125.83.43]:35405 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932243AbcLGWlR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 17:41:17 -0500
Received: by mail-pg0-f43.google.com with SMTP id p66so166588707pga.2
        for <git@vger.kernel.org>; Wed, 07 Dec 2016 14:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/8pqNoud4XWadMWlN5fuygQUd8bP3KS4M6yYLW6N/ec=;
        b=Whgg1irY8rWU9GyHonMMniTNnYTPhQEnPT11uqbt7LpRNMM9+A84wXdiNOTLSbuoyE
         cLwJk2At4iJwF3ibV0amrmSsFpSHkqvl2nlvG7SKG7rp8hpa6vx7VWaKqNj5y1hZGAvu
         NkzIHuXwyxf7QUPNfXaUPoWAxNIGYnlA1WQSaGIQXok8k04Mhl/IjokFR9wjS67pp/Id
         E1EgXgK7cSrS4VU0r5TyGBDzO+4SWJyvR5jIvK5vPmTjWenu2sZHzT7y8P90Eh6XaSxV
         NsJsIdP6ACOl0D64MpWe+ESRIiNZbha9SywkZh8Y2Byf01qVzGNNokqiU/XvDiJ+u7mR
         kYpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/8pqNoud4XWadMWlN5fuygQUd8bP3KS4M6yYLW6N/ec=;
        b=aTsVa7nvYZHa+92Mup+91wplZLqkWt55du7Iu8z7OjSTKXeaRl0tgy4Iwy/4AAM0tK
         vOzes78SQWG8LrnYVj73fkRh9g9cfVgKr69ZQvec5wZasWIiENICT6mcgnVI3lkTkS26
         qq7ZNdzhqJGfPeoEsYdva5zrVojBPZgBksRFBtR3c5+Q1Ze6InmpYzTcvOgzaIBsDyJD
         j1jIEPz+LoZh/mrOLdppaLiB/62XAefmM+x5JH0vJHTGAy+VZBMOCEoFTpGShgG/kQUL
         OyWcVF6kw+rxW7QbI4x1kWaIxSKe7GGoVfN/B+mNPvIyV/R6Bnkcnrt52Ve1nU0J6iHw
         ARww==
X-Gm-Message-State: AKaTC00bPy2EAdEjDjZT6UGffHlfBAjBiJJFL6cpEZlWM+W/7MoWPXMAXeqSdo07XmqwJ4tQ
X-Received: by 10.99.161.2 with SMTP id b2mr127594534pgf.2.1481150476570;
        Wed, 07 Dec 2016 14:41:16 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:ccae:4719:31da:e07d])
        by smtp.gmail.com with ESMTPSA id n25sm44959173pfi.33.2016.12.07.14.41.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 07 Dec 2016 14:41:15 -0800 (PST)
Date:   Wed, 7 Dec 2016 14:41:14 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 09/17] pathspec: always show mnemonic and name in
 unsupported_magic
Message-ID: <20161207224114.GE116201@google.com>
References: <1481061106-117775-1-git-send-email-bmwill@google.com>
 <1481061106-117775-10-git-send-email-bmwill@google.com>
 <CACsJy8Du5XUzcKpWfSKy8iknF01C-RWCgPeh73W3E0VkPJ9sog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8Du5XUzcKpWfSKy8iknF01C-RWCgPeh73W3E0VkPJ9sog@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/07, Duy Nguyen wrote:
> On Wed, Dec 7, 2016 at 4:51 AM, Brandon Williams <bmwill@google.com> wrote:
> > @@ -426,8 +423,7 @@ void parse_pathspec(struct pathspec *pathspec,
> >                         nr_exclude++;
> >                 if (item[i].magic & magic_mask)
> >                         unsupported_magic(entry,
> > -                                         item[i].magic & magic_mask,
> > -                                         short_magic);
> > +                                         item[i].magic & magic_mask);
> 
> Same here. Maybe put both arguments in the same line. It looks a bit
> better. (sorry for two mails on the same patch, I'm reading the final
> output first before going through individual patches that breaks this
> function down)

All good.  Sometimes its easier to parse comments if they are in
multiple small emails.  I don't mind getting lots of mail :)

> 
> >
> >                 if ((flags & PATHSPEC_SYMLINK_LEADING_PATH) &&
> >                     has_symlink_leading_path(item[i].match, item[i].len)) {
> -- 
> Duy

-- 
Brandon Williams
