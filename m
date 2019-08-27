Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48EB91F461
	for <e@80x24.org>; Tue, 27 Aug 2019 09:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbfH0JoN (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 05:44:13 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51164 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727910AbfH0JoN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 05:44:13 -0400
Received: by mail-wm1-f68.google.com with SMTP id v15so2369751wml.0
        for <git@vger.kernel.org>; Tue, 27 Aug 2019 02:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Z+yaOQtBpX8VU6qwGZhHAnySfrqcIHvOBLj6F+PLLPo=;
        b=INfgJAu2HlmTzibs1yTl5P/CSmKxY3U7+qJZtqMfRzebGefjtzWyaG/X3CMgXOsh3J
         CtvbZbgK0/flrnCF1ofeliDBo6pwVE+yl8jYaE8y1g9/oovlc47oly/UaVG0l20AHWNI
         WpZo3kdao4D6DRzJna3HgRX3eCEI0S5KqB1UUZloe5Jk6DiR8H6LfhIgfz+jR8iBsRuH
         uV6Xdd+eCWDTr+b9GhOk3nNPpbQf9qTp4feCyKXymqQcFI+wIAwJk84cwabp6JWciiGJ
         RncrD+Q0+SPgF6p2PtV3T/cQAG/P0QAffFVJN2ON5QzXtvfFVAA/2Nq1jd6AoOQhpLWI
         2v4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Z+yaOQtBpX8VU6qwGZhHAnySfrqcIHvOBLj6F+PLLPo=;
        b=qbyLSC3W7WhENnkSvD4C0gVwLkLnXdloaK8RfWj+xapmBHKT+uqo1c5RaybxBYSCWI
         rSJD+ixLPY9jrRowGv6Twe0NEhMITvxXI2Lb15VkBIqTyNX0HxJf3QJbSe0DRmXf3XXV
         ZMjKSBCL0dIBoAg7I38BBhL8mP/q/Om1gbYKnd/I7PXAhueKKCSqxJxUTknE+6VTgqZd
         iuE/1QsocAwRXVcDxh4XzlT8TzFWSkzXwcQFBhC1pa410dhclmrheGdWz0JPIRlMfKiw
         C2N4lfDQAeyFYpStalSPhPj9YDEZijgGyyBTrhf9ELe1U8iWpHOnUIPTeXpKuWZx4l08
         PHcA==
X-Gm-Message-State: APjAAAWyz9ulK4mYfO+aSBzeWT81zqJ9zRzazV7hgCtojE408wu9MWcl
        OYO0Z48GXmYSpdy2HMXoZnw=
X-Google-Smtp-Source: APXvYqwaPehZMyIH5t6ZebYqz3NoJag6KbO1p9M06WAAXQt/D3HQH/i6YOSj8Lp69Ypuo7y4c2NPvg==
X-Received: by 2002:a05:600c:2411:: with SMTP id 17mr25263307wmp.171.1566899050737;
        Tue, 27 Aug 2019 02:44:10 -0700 (PDT)
Received: from szeder.dev (x4db46f61.dyn.telefonica.de. [77.180.111.97])
        by smtp.gmail.com with ESMTPSA id u129sm2991951wmb.12.2019.08.27.02.44.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Aug 2019 02:44:09 -0700 (PDT)
Date:   Tue, 27 Aug 2019 11:44:07 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, git@vger.kernel.org,
        entwicklung@pengutronix.de
Subject: Re: git slow unless piped to cat
Message-ID: <20190827094407.GV20404@szeder.dev>
References: <20190827081559.mt5wjpdvqzn62dib@pengutronix.de>
 <20190827084111.GU20404@szeder.dev>
 <20190827085637.g6cpnuofpteyfqfz@pengutronix.de>
 <1566897126.4102.5.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1566897126.4102.5.camel@pengutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 27, 2019 at 11:12:06AM +0200, Philipp Zabel wrote:
> On Tue, 2019-08-27 at 10:56 +0200, Uwe Kleine-König wrote:
> > On Tue, Aug 27, 2019 at 10:41:11AM +0200, SZEDER Gábor wrote:
> > > On Tue, Aug 27, 2019 at 10:15:59AM +0200, Uwe Kleine-König wrote:
> > > > I have a problem here with git being slow in some situations.
> > > > Using git 2.23.0 (from Debian) the effect is:
> > > > 
> > > > ukl@dude.ptx:/ptx/src/git/linux.git$ sudo sh -c "echo 3 > /proc/sys/vm/drop_caches"; time git show v5.2
> > > > tag v5.2
> > > > ...
> > > > 
> > > > real	0m12.727s
> > > > user	0m0.300s
> > > > sys	0m0.371s
> > > > 
> > > > But to get the actual data isn't the problem:
> > > > 
> > > > ukl@dude.ptx:/ptx/src/git/linux.git$ sudo sh -c "echo 3 > /proc/sys/vm/drop_caches"; time git show v5.2 | cat
> > > > tag v5.2
> > > > ...
> > > > 
> > > > real	0m0.764s
> > > > user	0m0.014s
> > > > sys	0m0.020s
> > > > 
> > > 
> > > How does 'git --no-pager show v5.2' perform?  If it's as fast as the
> > > case piping the output to cat, then look into what pager and pager
> > > options you use.
> > 
> > 	ukl@dude.ptx:/ptx/src/git/linux.git$ sudo sh -c "echo 3 > /proc/sys/vm/drop_caches"; time git --no-pager show v5.2
> > 	tag v5.2
> > 	...
> > 
> > 	real	0m13.225s
> > 	user	0m0.355s
> > 	sys	0m0.336s
> > 
> > So this doesn't seem to be the problem. Also the local configuration
> > can be ruled out:
> > 
> > 	ukl@dude.ptx:/ptx/src/git/linux.git$ sudo sh -c "echo 3 > /proc/sys/vm/drop_caches"; time env GIT_CONFIG_NOSYSTEM=1 HOME=/nonexistant XDG_CONFIG_HOME=/nonexistant git --no-pager show --no-color v5.2
> > 	tag v5.2
> > 	...
> > 
> > 	real	0m13.587s
> > 	user	0m0.335s
> > 	sys	0m0.336s
> > 
> > Thanks
> > Uwe
> 
> Have you checked strace output? I see a directory walk through .git/refs
> and .git/packed-refs if the output is not redirected.

That's a good point, 'git show/log' show decorations (refs pointing to
any commits shown) when the output is a terminal:

  $ git show v5.2
  [...]
  commit 0ecfebd2b52404ae0c54a878c872bb93363ada36 (HEAD -> master, tag: v5.2)
  [...]
  $ git show v5.2 |cat
  [...]
  commit 0ecfebd2b52404ae0c54a878c872bb93363ada36
  [...]

And indeed, if you have a lot of refs and cold cache, then that might
account for a couple of seconds difference.  So, how does 'git show
--no-decorate v5.2' perform, and if it performs well, then how many
refs do you have ('git for-each-ref |wc -l')?

