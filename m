Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B4701F4BD
	for <e@80x24.org>; Wed,  2 Oct 2019 20:08:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbfJBUIm (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Oct 2019 16:08:42 -0400
Received: from mail-pl1-f182.google.com ([209.85.214.182]:39477 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbfJBUIm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Oct 2019 16:08:42 -0400
Received: by mail-pl1-f182.google.com with SMTP id s17so303150plp.6
        for <git@vger.kernel.org>; Wed, 02 Oct 2019 13:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kI5nCnlmdrUCaJazQCFQRDa43xnAvs2qvWcqR8myWWM=;
        b=YBTnEmbBzK/JItbggSZFV9Yv+FR1JccodSa+VUvyp/bRk1bcIOgtbXWIR+IztOZ2PH
         nPRlNPTMW3bvsEKcDGMDNmFvNd6ArdZBBLn6ZMixE9elTlzmptMWawdoVuqjzsVE4eRX
         Tzzb2AUF+ryizAHe+QGquxfeqxrugw6fU3x1HxLJawaldfodfbiq0YiLKnYa5Q3AHYv8
         s2O/5I4iSJeIuNJgLf40Uzce1IiMEhDlaHQLXm36+6s8O74urvcPkurb/Fpjo4xvVab0
         w3ud3Y+Aebx8aRA32jf/2HB27wBkddqHOOb+DyX/oRlGmNp4+zrWHhUxaAPClzSzi/KG
         oHhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kI5nCnlmdrUCaJazQCFQRDa43xnAvs2qvWcqR8myWWM=;
        b=ERLfN7cuucQUtxBns8nMvyOTt47dssEgc+dWOJ+FggfSvS3eJoNJK212vz9cdp1Xjm
         MSPDuTW92ReqMd5790JGWEsLfaEQyXhZ8gG/h900P1oqoGQ06iL6HBLOIa4o+OBYUyDp
         qWkQMIUXwEZVWf7MdFKGi6ZXQOKtR6Er8i2LqEWqmXK9Us+TnOpyn6+ZN1mqgIBSvVR6
         +Fr9cSDqhUrQ3x2/7S4l19XpE08/PYyaYBJRkynROoRo2xN5gCfiNpEDTGC7kxA8brPS
         ohWInYeQyb9Ocs4zoNAX/fLWg5H1veNz3pznNUBUp100bSqeaSTl8+2mP8fy8fIDhKov
         sOog==
X-Gm-Message-State: APjAAAWoYRHmuA3WqJrc4oveRY/+22EWBVVGM1C+V+IJrX4A0F6I88Yb
        JtHTq4vOmovyDc0M6RQisT0=
X-Google-Smtp-Source: APXvYqz7IirTYQ8QMnpWjva0p2Ihf6V7X/fOWjWRXxmKy0IvJxu5sbk/kXDg7MLtJiIy4JbBuHmkCg==
X-Received: by 2002:a17:902:868a:: with SMTP id g10mr5704158plo.235.1570046919600;
        Wed, 02 Oct 2019 13:08:39 -0700 (PDT)
Received: from generichostname ([204.14.239.137])
        by smtp.gmail.com with ESMTPSA id a8sm288775pfa.182.2019.10.02.13.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 13:08:38 -0700 (PDT)
Date:   Wed, 2 Oct 2019 13:08:36 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Paul Tan <pyokagan@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [BUG] incorrect line numbers reported in git am
Message-ID: <20191002200836.GA24697@generichostname>
References: <20191002184546.GA22174@generichostname>
 <xmqqd0ffdj9k.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqd0ffdj9k.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 03, 2019 at 04:44:55AM +0900, Junio C Hamano wrote:
> Denton Liu <liu.denton@gmail.com> writes:
> 
> > 	Applying: dir: special case check for the possibility that pathspec is NULL
> > 	error: corrupt patch at line 87
> 
> This refers to line 87 of the input file, not a line that begins
> with "@@ -87,count...", doesn't it?

Correct, it refers to line 87 of the input file. Since the whole mail is
202 lines long and the faulty hunk comes at the end of the whole mail,
I'd expect the faulty line number to say something like line 198 or
something that's near the end of the mail. Line 87 is somewhere in the
middle of the log message in the mail.

I think the problem comes from line number being expressed as an offset
from the "---" (begin diff) line as opposed to an offset from the actual
beginning of the mail.

>  If the sender hand edits a
> patch without correcting the number of lines recorded in the hunk
> header, the parser may not see the next hunk that begins with "@@"
> or run out of the input before it reads the required number of lines
> given the last hunk header.

Correct, but I think that's orthogonal to the main issue. It makes sense
why the error is being reported but what doesn't make sense is the fact
that the line numbers reported are so far off from what a user would
expect.

> 
> We might be able to notice when the input file is shorter than the
> last hunk wants it to be, in which case we should be able to say
> 'premature end of input at line 87' or something like that.

Yep, I noticed this bug while I was writing a patch to do exactly that.

> 
> 
