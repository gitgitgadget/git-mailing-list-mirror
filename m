Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEFF820248
	for <e@80x24.org>; Tue, 26 Mar 2019 17:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732400AbfCZRu5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Mar 2019 13:50:57 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36669 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731571AbfCZRu4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Mar 2019 13:50:56 -0400
Received: by mail-pf1-f194.google.com with SMTP id p10so8422985pff.3
        for <git@vger.kernel.org>; Tue, 26 Mar 2019 10:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=vyuDMoJBVQh4ITINOQ5KfehhlvR1GFNl8FKe9AzEPac=;
        b=oJE6zxgAu2o+LvgRXlgj6FLEPCCggZxp1zrcO5LQdAPE5sqYuhPKFksT2t4YfdQaAo
         ZCykJyQvhT+DMcRH7W8J6+Sovvyq7AJmn5c2r6dQgST10GLwtSww6Li+4MSgSSPrI5uk
         /9hShQpKRGbRYBNUXLGfNaG1Ytho7J9TUhhsNOsJenFvXO76Wyolwet8TCLNvDJMcuiq
         mkO8JHnUMj7qrEYCk7sM0Atf71RlIwsSGZFzcZEuJ8q3rKMEDKmujE2Ns/87o7Iwp8Ym
         tMqpcOfZa8m5SSiropLMYn+bHWU6SG0gcu7EHP4I3ca+xtzQUbmOK+q3/cvzB+n/Ep/r
         Tq+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=vyuDMoJBVQh4ITINOQ5KfehhlvR1GFNl8FKe9AzEPac=;
        b=U7ccojVW7Q6wJQa0etrJpD86IoPzgMYYZ1EAjaOObBuG4n9QbN/i8prDwlbdjlk24r
         Gkx3CyPI/KhXa15/ia0XRvIsaDydbXqk8H20BJFvRGVvmXejvbfj1Stjogv/cirVJhyj
         9rmtnwSru2tp6h9Lbin3CWBj4Bb2eXwFLneWN54Trsj1lTCi+E/WEx0Mn4Y8Cr5LkzSU
         8oRx+Ie36eZPq/cxI8XHtLgp0lqYKnlV+bskw/dx9wkRjdZQmRXi0FTLal9y1c33A6tL
         MwjWVsO3S1cuQz9U8b9O+3pAK1bCbfpX7HbzcX0GttgARyOm6pS3StmA3jo+uKP5NLvH
         vBhw==
X-Gm-Message-State: APjAAAXWPGf5T7d997hvPl3PKeTAlTWcWAFU2cyvScQF/9s4mBQ2H+S4
        7gU+ewIwhhur2So+8VHPp07J1u5o
X-Google-Smtp-Source: APXvYqzkZlYwOd1J+4dTPUudgaKS3C2sfPSyMm8pgw+wXOpHKM6SCVQcvlsu413ZE3RDVzGZDGSHLw==
X-Received: by 2002:a65:6559:: with SMTP id a25mr27444024pgw.99.1553622655350;
        Tue, 26 Mar 2019 10:50:55 -0700 (PDT)
Received: from dev-l ([149.28.200.39])
        by smtp.gmail.com with ESMTPSA id f1sm30560869pgl.35.2019.03.26.10.50.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 10:50:54 -0700 (PDT)
Date:   Tue, 26 Mar 2019 10:50:52 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 0/3] rebase: learn --keep-base
Message-ID: <20190326175052.GA14922@dev-l>
References: <cover.1553354374.git.liu.denton@gmail.com>
 <87bm1xbt55.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87bm1xbt55.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar,

On Tue, Mar 26, 2019 at 03:35:34PM +0100, Ævar Arnfjörð Bjarmason wrote:
> 
> On Sat, Mar 23 2019, Denton Liu wrote:
> 
> > This series teaches rebase the --keep-base option.
> >
> > 'git rebase --keep-base <upstream>' is equivalent to
> > 'git rebase --onto <upstream>... <upstream>' or
> > 'git rebase --onto $(git merge-base <upstream> HEAD) <upstream>' .
> >
> > This seems to be a common case that people (including myself!) run into; I was
> > able to find these StackOverflow posts about this use case:
> >
> > * https://stackoverflow.com/questions/53234798/can-i-rebase-on-a-branchs-fork-point-without-explicitly-specifying-the-parent
> > * https://stackoverflow.com/questions/41529128/how-do-you-rebase-only-changes-between-two-branches-into-another-branch
> > * https://stackoverflow.com/a/4207357
> 
> Like with another series of yours I think this would be best squashed
> into one patch.

Will do.

> 
> Maybe I've misunderstood this but isn't this like --fork-point except
> with just plain "git merge-base" instead of "git merge-base
> --fork-point", but then again 2/3 shows multiple base aren't supported,
> but merge-base supports that.
> 

--fork-point gets used to determine the _set of_ commits which are to be
rebased, whereas --keep-base (and --onto) determine the base where that
set of commits will be spliced. As a result, these two options cover
orthogonal use-cases.

The reason why --keep-base doesn't support multiple bases for the same
reason that --onto already disallows multiple bases. If we have multiple
bases, how do we determine which one is the "true base" to use? It makes
more sense to error out and let the user manually specify it.

> I'd find something like the "DISCUSSION ON FORK-POINT MODE" in
> git-merge-base helpful with examples of what we'd pick in the various
> scenarios, and also if whatever commit this picks was something you
> could have "git merge-base" spew out, so you could get what rebase would
> do here from other tooling (which maybe is possible, but I'm confused by
> the "no multiple bases"...).

If I'm understanding you correctly then yes, this could be done with
other tooling. See the 0/3 for equivalent commands.

Perhaps I should update the rebase documentation to mention that
--fork-point and --keep-base are orthogonal because it's unclear for
you, it's probably unclear for other users as well.

Thanks,

Denton
