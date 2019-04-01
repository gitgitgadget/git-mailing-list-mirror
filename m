Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3A6820248
	for <e@80x24.org>; Mon,  1 Apr 2019 03:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731655AbfDAD5F (ORCPT <rfc822;e@80x24.org>);
        Sun, 31 Mar 2019 23:57:05 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:40649 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731476AbfDAD5F (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Mar 2019 23:57:05 -0400
Received: by mail-io1-f66.google.com with SMTP id d201so6558357iof.7
        for <git@vger.kernel.org>; Sun, 31 Mar 2019 20:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xIDxEGnD09pISsCfRIJLh5drhyRMbl/mGn94qn+DrDY=;
        b=jMg944qTwcqYT+N4bjnE2iSCkvu8EeFXwx82ZdX4NnxONkBtbcyi/NLi3pL1WFvSia
         ofLws8sKX7VYxdgQTFpcgLu5Yr+T4SZ1VAH6tuX8ZKtHH/n/OvEptVvOYgbC3VaYIwMU
         tcyEwi6smfv7b5P8Pju9ASmyOVSobot4qra2q6MVZSdbrU8gGkR2gbC1wGbIPuMnsKKP
         YuY6LTancVUExwtSOwPgOvh9d26gXhoC10lz5RseX3NonrI9flEKGXSeUxR2rNoTIJTE
         ArtRardUY6Hv2Txngncz2wtwc2JdlpJQNQQpejCpesbTYNABtW0a4hLpk/1WTR4iYyJf
         UWrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xIDxEGnD09pISsCfRIJLh5drhyRMbl/mGn94qn+DrDY=;
        b=bVQ88aMn+1lqNd2PSuojVU9Ppr3cEkfGzjzW6bnwsi/FtpDsLte7uXTEVrUxXRbp07
         aWnNgJjdEU7dYv5yOoVB5eHT8dtew6qdSJZ3/ffhte1fC1GAgmQV295BChgsnh+dit/j
         rJBgFrRmZUghWj9+3PclGvn6oppsKf7HJ/vWqOhOMNvvbLqnEP0hDBi8eG85JuiCJ7A9
         HBTRET6KQM+bLhUM+EumK5DSvNcwK4r8UHFFafedD65u0JUBjmsgHoMslnrThA26/0Ce
         oH7JlrWaZ/N05y977zP6Wvx+BHFsHKwb/XaZQE9PFr0ONW5MhDkGK0p7XBPA8xz34edC
         M/Vg==
X-Gm-Message-State: APjAAAWKyj5X2YsNFiavd/n44c2SAvg+WFfcrHfG+NA+nqa2oc+cxQdK
        BvFNNM4r0iNSQMlKPd2j4CrwAUaiJ0eJfGSCSQa2IQ==
X-Google-Smtp-Source: APXvYqyAZ3kBtgNmvde8hDKnXb7cjCQ2uZtan21aOGhGA0s/enHcGqezlf3TDU2i5V1mwN/6OOoM0PH6Ijnk6HVYagA=
X-Received: by 2002:a5e:d608:: with SMTP id w8mr41916810iom.293.1554091023798;
 Sun, 31 Mar 2019 20:57:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190226122829.19178-1-avarab@gmail.com> <20190322232237.13293-1-matheus.bernardino@usp.br>
 <20190322232237.13293-3-matheus.bernardino@usp.br> <20190328221049.GK32487@hank.intra.tgummerer.com>
 <CAHd-oW78Cwhq8sFFjOX4c6kS8JsEUUd_RGgheJhdN6MLAr+G2Q@mail.gmail.com>
 <20190329200517.GO32487@hank.intra.tgummerer.com> <CAHd-oW5aTyr7OmYwETLHYbHbRYgcUPuHpt2eN=Z2FWrqUQTzJQ@mail.gmail.com>
 <20190330192738.GQ32487@hank.intra.tgummerer.com>
In-Reply-To: <20190330192738.GQ32487@hank.intra.tgummerer.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Mon, 1 Apr 2019 00:56:52 -0300
Message-ID: <CAHd-oW7jJWyww1i6rLG60M91NJa4AV2nbyOaXA6KE=StmmN6_A@mail.gmail.com>
Subject: Re: [GSoC][PATCH v4 2/7] clone: better handle symlinked files at .git/objects/
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Kernel USP <kernel-usp@googlegroups.com>,
        Benoit Pierre <benoit.pierre@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 30, 2019 at 4:27 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:
>
> On 03/30, Matheus Tavares Bernardino wrote:
> > On Fri, Mar 29, 2019 at 5:05 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:
> > >
> > > On 03/29, Matheus Tavares Bernardino wrote:
> > > > Ok, what if instead of using linkat() we use 'realpath(const char
> > > > *path, char *resolved_path)', which will resolve any symlinks at
> > > > 'path' and store the canonical path at 'resolved_path'? Then, we can
> > > > still keep using link() but now, with the certainty that all platforms
> > > > will have a consistent behaviour? (also, realpath() is POSIX.1-2001)
> > > > Would that be a better idea?
> > >
> > > Yeah, I think that is a good idea.  Note that 'realpath()' itself is
> > > not used anywhere in our codebase either, but there is
> > > 'strbuf_realpath()', that from reading the function documentation does
> > > exactly what 'realpath()' would do.  So using 'strbuf_realpath()'
> > > would probably be the right thing to do here.
> >
> > Thanks. While I was looking for realpath() at git codebase (before I
> > saw your email), I got a little confused: Besides strbuf_realpath() I
> > also found real_path(), real_path_if_valid() and real_pathdup(). All
> > these last three use strbuf_realpath() but they also initialize the
> > struct strbuf internally and just return a 'char *', which is much
> > convenient in some cases.
>
> Right, feel free to use whichever is most convenient for you, and
> whichever works in the context.
>
> >                            What seems weird to me is that, whilst
> > real_pathdup() releases the internally initialized struct strubuf
> > (leaving just the returned string to be free'd by the user), the other
> > two don't. So, if struct strbuf change in the future to have more
> > dynamic allocated resources, these functions will also have to be
> > modified. Also, since real_pathdup() can already do what the other two
> > do, do you know if there is a reason to keep all of them?
>
> Right, '*dup()' functions usually leave the return value to be free'd
> by the caller.  And while 'real_pathdup()' could do what the others do
> already it also takes more effort to use it.  Users don't need to free
> the return value from 'real_path()' to avoid a memory leak.  This
> alone justifies its existence I think.
>
> > One last question: I found some places which don't free the string
> > returned by, for example, real_path() (e.g., find_worktree() at
> > worktree.c). Would it be a valid/good patch (or patches) to add free()
> > calls in this places? (I'm currently trying to get more people here at
> > USP to contribute to git, and maybe this could be a nice first
> > contribution for them...)
>
> Trying to plug memory leaks in the codebase is definitely something
> that I think is worthy of doing.  Sometimes it's not worth actually
> free'ing the memory, for example just before the program exits, in
> which case we can use the UNLEAK annotation.  It was introduced in
> 0e5bba53af ("add UNLEAK annotation for reducing leak false positives",
> 2017-09-08) if you want more background.
>
> That said, the memory from 'real_path()' should actually not be
> free'd.  The strbuf there has a static lifetime, so it is valid until
> git exits.  If we were to free the return value of the function we'd
> actually free an internal buffer of the strbuf, that is still valid.
> So if someone were to use 'real_path()' after that, the memory that
> strbuf still thinks it owns would actually have been free'd, which
> would result in undefined behaviour, and probably would make git
> segfault.
>

Thanks for the great explanation, Thomas. I hadn't noticed that the
strbuf variable inside real_path() is declared as static. I also took
some time, now, to better understand how strbuf functions deal with
the buf attribute (especially how it's realloc'ed) and now I think I
understand it better. Thanks again for the help!

> --
> You received this message because you are subscribed to the Google Groups "Kernel USP" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-usp+unsubscribe@googlegroups.com.
> To post to this group, send email to kernel-usp@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kernel-usp/20190330192738.GQ32487%40hank.intra.tgummerer.com.
> For more options, visit https://groups.google.com/d/optout.
