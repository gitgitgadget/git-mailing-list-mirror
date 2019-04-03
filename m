Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92CDF20248
	for <e@80x24.org>; Wed,  3 Apr 2019 21:33:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbfDCVdY (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Apr 2019 17:33:24 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40433 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbfDCVdX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Apr 2019 17:33:23 -0400
Received: by mail-pf1-f196.google.com with SMTP id c207so219574pfc.7
        for <git@vger.kernel.org>; Wed, 03 Apr 2019 14:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=p/BXNIIepoJz4SHe1CZcmu4LIdcIpZW9fqnh8AAmb8g=;
        b=IcB0ForOrJHZbpYqMJwt2nd6xXspXXoefPjngyyDB3FVZB57XCVtKRC45FO/CYPvCk
         7psx7ZKqmPp+nyCRGCRDt81gZat5q6Y9iazzXKPps95VNrO0nIbmvcC8PUvwX9CN5Kv5
         C/lUlkWsND7+k1i9lCStQCAMeYbHuC5QLln0RP+M3r0GLl1K54a2QmqQluOvzGgWxJJE
         aAVEIrr7nhvmmDLVVQCiYeJxntXYPP4IKZpyHUuLyd4cbwuoq4Jk3E61xeietrU0i4XF
         lYh1wBq7x9aF1RYpkBmao7Ty1ru2EVZv+qMBKo5EJtluvC4/+hQVqc2OomBrMnDOujHT
         30pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=p/BXNIIepoJz4SHe1CZcmu4LIdcIpZW9fqnh8AAmb8g=;
        b=TW+b5m69vzumer+jcLrHyTgrDECamMH3Mk1GybhSzsZTFiggtEd1Iu/KJUQOvgcc1V
         3i56WOuVx26Z5+zmm/rnATP8UYaghcOmE6lzIYW6aVJNZLgVITfOBpxPqMVnQ1FCX0LR
         +mlXMcqfAF7ukMAZzYJmTb3o1JO2K8GMYa2BVrIiHhNIY9RZPqrvnfb23SB/vaYfil5k
         cgPBI2FqfoWcMeuVoR9MIZ9HZ755bArMb0gMgzu9go/0paV3dabWMpGtxwufLF+oJhP8
         085uFjUJWI9qBv5J6JoJpIEJfp4ar32M5AmcKGiSN8BB3VeFUnG2tLZetgU9XNvFwrMO
         CJfA==
X-Gm-Message-State: APjAAAW65jASS6xQtKP6urNT4Lo73G1ktWDaQuzCHAQTeaGFjsN3T3LW
        8oQi/6waGHUmPxYK3rbg730=
X-Google-Smtp-Source: APXvYqyOCmhXkfKkoNHqijU0baxA+WLY5xOd88IRJFYrz/VntwZuXf6XkU8bqvtKP2AYiIK+P+s92A==
X-Received: by 2002:a62:e315:: with SMTP id g21mr1857565pfh.2.1554327201795;
        Wed, 03 Apr 2019 14:33:21 -0700 (PDT)
Received: from dev-l ([149.28.200.39])
        by smtp.gmail.com with ESMTPSA id h1sm4360045pgs.67.2019.04.03.14.33.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 14:33:20 -0700 (PDT)
Date:   Wed, 3 Apr 2019 14:33:18 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Robert Dailey <rcdailey.lists@gmail.com>,
        Jeff King <peff@peff.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2.5 2/2] tag: prevent nested tags
Message-ID: <20190403213318.GA14137@dev-l>
References: <1bd9ee28bc8726490ec0a93286056beeb147fc49.1554183429.git.liu.denton@gmail.com>
 <20190402230345.GA5004@dev-l>
 <xmqqzhp7sfw4.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqzhp7sfw4.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 03, 2019 at 04:32:27PM +0900, Junio C Hamano wrote:
> Denton Liu <liu.denton@gmail.com> writes:
> 
> > This is the first use of the '%n$<fmt>' style of printf format in the
> > *.[ch] files in our codebase, but it's supported by POSIX[1] and there
> > are existing uses for it in po/*.po files, so hopefully it won't cause
> 
> The latter is a stronger indication that this should be OK than the
> former ;-)  Thanks for digging and noting.

Thank Ævar, I shamelessly stole this message from one of his patches
that didn't get included in[1].

> 
> > diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
> > index 88620429ea..ec4f6ae658 100644
> > --- a/Documentation/config/advice.txt
> > +++ b/Documentation/config/advice.txt
> > @@ -90,4 +90,6 @@ advice.*::
> >  	waitingForEditor::
> >  		Print a message to the terminal whenever Git is waiting for
> >  		editor input from the user.
> > +	nestedTag::
> > +		Advice shown if a user attempts to recursively tag a tag object.
> >  --
> 
> In addition to 'advice', we may have to add a configuration to help
> projects that wants to tag tag objects regularly so that they do not
> have to keep typing "--allow-nested-tag".  But that can wait until a
> participant of such a project comes forward and makes a case for
> their workflow.
> 
> > +chain of custody by signing someone else's signed tag. However, in
> > +practice, this is typically a mistake so we prevent it from happening by
> > +default unless specifically requested.
> 
> I am not sure if this is so bad, actually.  Why do we need to treat
> it as a mistake?  When a command that wants a commit is fed a tag
> (either a tag that directly refers to a commit, or a tag that tags
> another tag that refers to a commit), the command knows how to peel
> so it's not like the user is forced to say "git log T^{commit}".

This patch came about because Robert Dailey expressed confusion after
accidentally creating a tag-to-a-tag a while back by mistake when he
actually meant to amend a tag.

In the discussion upthread, Peff noted that he has never seen a
tag-to-a-tag in the wild before. I think the conclusion was that for
the majority of users, doing this is an error. That is what this patch
is guarding against.

> 
> And if something that *MUST* take a commit refuses to (or more
> likely, forges to) peel a tag down to a commit and yields an error,
> I think that is what needs fixing, not the command that creates a
> tag.
> 
> So, I am fairly negative on this change---unless it is made much
> more clear in the doc and/or in the proposed log message what
> practical downside there are to the end users if we do not stop this
> "mistake", that is.

I can update the log message to include more detail.

> 
> > +Automatically erroring on nested tags was introduced in Git version
> > +2.22.0.
> 
> And please do not write something like this.  A feature gets in a
> release when it is ready, and we may not ship this in 2.22.

Ævar suggested that we include this because git tag gets used by a lot
of scripts so in case one ever starts failing, a maintainer can more
easily track down the reason why.

> 
> "git tag --help" the user is running may or may not have the
> paragraph about "nested tag", depending on the existence of the
> feature in the version of Git the user is running, so there is no
> need to say something like that.
> 
> And no, I do not buy arguments like "random web servers serve
> different versions of documentation without identifying which
> version of Git they describe".
> 

Thanks for the comments,

Denton

[1]: https://public-inbox.org/git/20181026192734.9609-8-avarab@gmail.com/
