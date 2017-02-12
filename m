Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61BC61FC44
	for <e@80x24.org>; Sun, 12 Feb 2017 10:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751137AbdBLKmZ (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Feb 2017 05:42:25 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34893 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751120AbdBLKmY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Feb 2017 05:42:24 -0500
Received: by mail-pf0-f193.google.com with SMTP id 68so3372276pfx.2
        for <git@vger.kernel.org>; Sun, 12 Feb 2017 02:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H+DDRNZGWWmTahZTveVIIakFPwRbMdB7xlb4L1DrL1g=;
        b=T9gT9Ol6r9fQZVg8uHXfA+hp6s0/N2iYUDDkFSALZJB/fkzGwyUm/3xHGOLXrKB03V
         cXq3eZCb51xdbdZeYQ/lZ5sqR1O+NEA7dVm4svHFSsr71nuUSYZ65ppkWkLXTVGU4yvW
         rY1ViHcz7qssF+g0SaL+N0OZ2FOT7B04+gZ0/nLQAnIkZSssBq91INk/ibLHLGIGjjVt
         +LBD1nYAZ5+zdEDk30efnoOR+OvD/60wFpSAIOTn09sKsnFgAFJ7vcxszYXhVDnG6yIb
         ZlGtDcWVD3DU+G5lR6YTrDIbD/i+3iDEYBexDUU3rC9jgAjNRYwZjSfGjCsHtY2wHl86
         Is0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=H+DDRNZGWWmTahZTveVIIakFPwRbMdB7xlb4L1DrL1g=;
        b=kVAspjl+7htZV7bND34OsDbdIroSkBvi+jWw37QYPd5eG0qvbzMFjZmm3modf1tK2f
         MT7K7EjqL3Zvpnls0Mw8CwnNkxWr0c5kxpftRtnFJ4jWd9atA2PJU9vejYJDWIlYjwC4
         h2AkWLzjts6fp8VNJm5G2R34a9DY6PMVerSf2OVHpVL4ABCDVrNB0/XDPBY9sxJBHwwi
         mARNZMS8tQ/XuvV+dBZ00dy0cN/tXp8FiHSO+I67QeoHbot6fgd4f72RyGYmcfhzKe8l
         C2hk4nvpRsDEXSpMwK2LIm/wNLU6zQu+p46PcdLsj8Pa9vE6ekH1lCyXlhHyTypNhT0Z
         8a5g==
X-Gm-Message-State: AMke39kj4Ugamfth8BKuzHdnhmXV+fgkZu5mgtIzY8PX79123uNvPx47Jabdw61biV8qQw==
X-Received: by 10.99.66.193 with SMTP id p184mr20438302pga.213.1486896143404;
        Sun, 12 Feb 2017 02:42:23 -0800 (PST)
Received: from localhost ([139.59.1.28])
        by smtp.gmail.com with ESMTPSA id m20sm14835696pgd.17.2017.02.12.02.42.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Feb 2017 02:42:22 -0800 (PST)
Date:   Sun, 12 Feb 2017 10:42:20 +0000
From:   Siddharth Kannan <kannan.siddharth12@gmail.com>
To:     Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Cc:     git@vger.kernel.org, gitster@pobox.com, pranit.bauva@gmail.com,
        peff@peff.net, pclouds@gmail.com, sandals@crustytoothpaste.ath.cx
Subject: Re: [PATCH 2/2 v3] sha1_name: teach get_sha1_1 "-" shorthand for
 "@{-1}"
Message-ID: <20170212104220.GA20317@ubuntu-512mb-blr1-01.localdomain>
References: <1486752926-12020-1-git-send-email-kannan.siddharth12@gmail.com>
 <1486752926-12020-2-git-send-email-kannan.siddharth12@gmail.com>
 <1486752926-12020-3-git-send-email-kannan.siddharth12@gmail.com>
 <vpqbmu768on.fsf@anie.imag.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vpqbmu768on.fsf@anie.imag.fr>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Matthieu,
On Sun, Feb 12, 2017 at 10:48:56AM +0100, Matthieu Moy wrote:
> Siddharth Kannan <kannan.siddharth12@gmail.com> writes:
> 
> >  sha1_name.c              |  5 ++++
> >  t/t4214-log-shorthand.sh | 73 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 78 insertions(+)
> >  create mode 100755 t/t4214-log-shorthand.sh
> >
> > diff --git a/sha1_name.c b/sha1_name.c
> > index 73a915f..d774e46 100644
> > --- a/sha1_name.c
> > +++ b/sha1_name.c
> > @@ -947,6 +947,11 @@ static int get_sha1_1(const char *name, int len, unsigned char *sha1, unsigned l
> >  	if (!ret)
> >  		return 0;
> >  
> > +	if (!strcmp(name, "-")) {
> > +		name = "@{-1}";
> > +		len = 5;
> > +	}
> 
> After you do that, the existing "turn - into @{-1}" pieces of code
> become useless and you should remove it (probably in a further patch).

Yeah, this is currently also implemented in checkout, apart from the
grepped list that you have supplied here. I will find all the
instances, and ensure that they work, and remove them. (This will
require some more digging into the codepath the commands, to ensure
that get_sha1_1 is called somewhere down the line)
> 
> > diff --git a/t/t4214-log-shorthand.sh b/t/t4214-log-shorthand.sh
> > ...
> > +test_expect_success 'setup' '
> > +	echo hello >world &&
> > +	git add world &&
> > +	git commit -m initial &&
> > +	echo "hello second time" >>world &&
> > ...
> 
> You may use test_commit to save a few lines of code.

Oh, yeah! I will use that. I need to work on improving the tests, as
well as adding the documentation.
> 
> > +test_expect_success 'symmetric revision range should work when one end is left empty' '
> > +	git checkout testing-2 &&
> > +	git checkout master &&
> > +	git log ...@{-1} > expect.first_empty &&
> > +	git log @{-1}... > expect.last_empty &&
> > +	git log ...- > actual.first_empty &&
> > +	git log -... > actual.last_empty &&
> 
> Nitpick: we stick the > and the filename (as you did in most places
> already).
Sorry, slipped my mind!
> 
> It may be worth adding tests for more cases like
> 
> * Check what happens with suffixes, i.e. -^, -@{yesterday} and -~.

These do not work right now. The first and last cases here are handled
by peel_onion, if I remember correctly. I have to find out why exactly
these are not working. Thanks for mentioning this!

> 
> * -..- -> to make sure you handle the presence of two - properly.
> 
> * multiple separate arguments to make sure you handle them all, e.g.
>   "git log - -", "git log HEAD -", "git log - HEAD".

Yeah, will add these tests.

> 
> The last two may be overkill, but the first one is probably important.
> 
> -- 
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/

--
Regards,

Siddharth Kannan.
