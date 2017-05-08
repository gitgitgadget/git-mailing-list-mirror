Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 871E21FC44
	for <e@80x24.org>; Mon,  8 May 2017 17:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754976AbdEHRIv (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 13:08:51 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:36027 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754948AbdEHRIt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 13:08:49 -0400
Received: by mail-pf0-f175.google.com with SMTP id m17so6847995pfg.3
        for <git@vger.kernel.org>; Mon, 08 May 2017 10:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=PFvJFwpZnjyTTHYW8Wl9Eif8e+wutc1GhNo8xHvglwA=;
        b=pr2ZNUouTM5l6QAZi9BPRiTU+GEZaEtPupOK8shholdRMFIxnR9zzageEMofrwDKVA
         B8g3ROHd5auM22VJTVZPmX93YTvMYJIsBq+ZfZTWU+DG1IdiDvfh0sbYDd4ifRmyENZw
         V4RVQDjfwQOG0HHAvA1UwQBtFhXnMkC4PQ+wp3TMRsZKhb9aexiapgoPQDis8QBJ6CNj
         mgvlTshqJyceXiRlCuLzR+SHAND8kyTqliqz2ZArtnwEBHhJ2uTDMK4zPWkkfsRxHq8o
         Ov77VdyYGgv53ZIFfpx/yVbQDg9aPn2pJgd5JcVRqouq570ccjK6vsPNxkZFLGMeT4FI
         iqWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=PFvJFwpZnjyTTHYW8Wl9Eif8e+wutc1GhNo8xHvglwA=;
        b=RTYYIjYqWxhd/Xh6SG7nHAxv1Rq3iXndm49flSMjjOm7/LmOXxI8qvN1WPBXARWqOH
         B5ag5UC4YlDH6shYxKjTRLeNU1u4CuPy/UA2o59X6rSlQyg9sXKs3H2qgB3XCzWfem3H
         I/bgdgkRKLFRTqXHeAq4naz1QU+nGtb+FqUniXuOVpg/SVbFWTBoSc3M+28J097nH7uu
         bruICT+f869YKshDq+6c6edNJu7CQNJTZBX5GB9/dO7yQMKiNDcsaZ1kqNuid/jbaSaX
         9p/z3irFslrxIIuag/SO1MR3wfrIx4fqImfoqhMJZX18xeEwbYfiO38b0IZoIuuunLcN
         awMg==
X-Gm-Message-State: AODbwcBJoBG1avMzLTrLvjzzMKgNf53KVOixpPvaLvtnrkA5N3Lxlfdy
        UhqulJOZT+8ni3k0BtL+3g==
X-Received: by 10.84.133.36 with SMTP id 33mr6321474plf.161.1494263328510;
        Mon, 08 May 2017 10:08:48 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:998e:2b7a:726f:b074])
        by smtp.gmail.com with ESMTPSA id i63sm18192014pgc.26.2017.05.08.10.08.47
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 08 May 2017 10:08:47 -0700 (PDT)
Date:   Mon, 8 May 2017 10:08:46 -0700
From:   Brandon Williams <bmwill@google.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     'Stefan Beller' <sbeller@google.com>,
        'Ciro Santilli' <ciro.santilli@gmail.com>, git@vger.kernel.org
Subject: Re: Add an option to automatically submodule update on checkout
Message-ID: <20170508170846.GD179149@google.com>
References: <CAFXrp_do8Jn-k18_FSRNeHQrWNydwdj2y3y5gw+XoZPGAzPL-w@mail.gmail.com>
 <001b01d2c809$62ac8520$28058f60$@nexbridge.com>
 <CAGZ79kaES-3ftadorYnx2wMDc-q7qsG376E1zy-C67Ldt2BO5g@mail.gmail.com>
 <002201d2c81a$9ff76060$dfe62120$@nexbridge.com>
 <CAGZ79kbxdXhhG3+4v9qH_oDi5o_zseGsQf8KCyTN3+axZB9sUA@mail.gmail.com>
 <002301d2c81d$4728aae0$d57a00a0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <002301d2c81d$4728aae0$d57a00a0$@nexbridge.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/08, Randall S. Becker wrote:
> On May 8, 2017 12:55 PM, Stefan Beller wrote:
> >On Mon, May 8, 2017 at 9:46 AM, Randall S. Becker <rsbecker@nexbridge.com> wrote:
> >> On May 8, 2017 12:25 PM, Stefan Beller wrote:
> >>>On Mon, May 8, 2017 at 7:42 AM, Randall S. Becker <rsbecker@nexbridge.com> wrote:
> >>>> On May 6, 2017 4:38 AM Ciro Santilli wrote:
> >>>>> This is a must if you are working with submodules, otherwise every 
> >>>>> git checkout requires a git submodule update, and you forget it, 
> >>>>> and things break, and you understand, and you go to stack overflow 
> >>>>> questions 
> >>>>> http://stackoverflow.com/questions/22328053/why-doesnt-git-checkout
> >>>>> -a utomatically-do-git-submodule-update-recursive
> >>>>> http://stackoverflow.com/questions/4611512/is-there-a-way-to-make-g
> >>>>> it -pull-automatically-update-submodules
> >>>>> and you give up and create aliases :-)
> >>
> >>> The upcoming release (2.13) will have "git checkout 
> >>> --recurse-submodules", which will checkout the submodules at the commit as recorded in the superproject.
> >>> I plan to add an option "submodule.recurse" (name is subject to 
> >>> bikeshedding), which would make the --recurse-submodules flag given 
> >>> by default for all commands that support the flag. (Currently cooking we have reset --recurse-submodules, already existing there is push/pull).
> >>
> >> Brilliant! 😊
> >>
> >>>> I rather like the concept of supporting --recurse-submodules. The complexity is that the branches in all submodules all have to have compatible >>>semantics when doing the checkout, which is by no means guaranteed. In the scenario where you are including a submodule from a third-party (very >>>common - see gnulib), the branches likely won't be there, so you have a high probability of having the command fail or produce the same results as >>>currently exists if you allow the checkout even with problems (another option?). If you have control of everything, then this makes sense.
> >>
> >>>I am trying to give the use case of having control over everything (or rather mixed) more thought as well, e.g. "checkout --recurse-submodules -b >><name>" may want to create the branches in a subset of submodules as well.
> >>
> >> I have to admit that I just assumed it would have to work that way 
> >> this would not be particularly useful. However, in thinking about it, 
> >> we might want to limit the depth of how far -b <name> takes effect. If 
> >> the super module brings in submodules entirely within control of the 
> >> development group, having -b <name> apply down to leaf submodules 
> >> makes sense (in some policies). However, if some submodules span out 
> >> to, say, gnulib, that might not make particular sense. Some downward 
> >> limit might be appropriate. Perhaps, in the submodule ref, you might 
> >> want to qualify it as <commit>:<ref> (but the impact of that is 
> >> probably and admittedly pretty horrid). I hesitate to suggest a 
> >> numeric limit, as that assumes that submodules are organized in a 
> >> balanced tree - which is axiomatically unreasonable. Maybe something 
> >> in .git/config, like
> >>
> >> [branch "topic*"]
> >>         submodules=a,b,c
> >>
> >> But I suspect that would make things even more confusing.
> 
> >I thought about having yet-another-flag in the .gitmodules file, which states if the submodule is extern or internal.
> 
> >[submodule "gnulib"]
> >    path=./gnulib
> >    external = true # implies no branch for checkout -b --recurse-submodules
> 
> >I think there are a couple more situations where such "external" submodules are treated differently, so maybe we'd want to think carefully about the >actual name as different workflows would want to have different features for an internal/external submodule.
> 
> I didn't want to open up that one, but yes. That makes sense. However, I don't like overloading what "external" means or might mean in the future. Would you consider a distinct Boolean for that, like inherit-branch=true?

Something like that kind of already exists.  The 'branch' field.
Internal repos would most likely use the '.' value to indicate that the
submodules should track the superproject's branch.  While a value of say
'foo' would indicate that the submodule should always be on branch
'foo'; this could be used for external repositories.

> 
> Cheers,
> Randall
> 

-- 
Brandon Williams
