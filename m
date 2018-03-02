Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98DD71F404
	for <e@80x24.org>; Fri,  2 Mar 2018 17:30:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1428112AbeCBRac (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Mar 2018 12:30:32 -0500
Received: from mail-pf0-f179.google.com ([209.85.192.179]:33878 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424482AbeCBRaa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Mar 2018 12:30:30 -0500
Received: by mail-pf0-f179.google.com with SMTP id j20so4280785pfi.1
        for <git@vger.kernel.org>; Fri, 02 Mar 2018 09:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=kg3zb8BO2QRjiuZYnN5zS/pX3pAOAi5oShlI4N1Uy90=;
        b=ks1GIiwSQFxkYqWvilnihhEvWD+glz3zxhb17lc5puEpBpzIU3XkrykA+5wdrKFxG0
         6c9yeJ3I7yvXptl3FPl082cpOTENVLNY9JOD/BDF/1xQJP03YFx18vNEd+R3aR47r/ZH
         ZFikhWSIj0r1Z1zmi2dXUJfTVJsqNwBLbi+WgldBlfTBAiE1JAcN5z4vmhKzc2BLSIwI
         CDCCwa2QHQlZwV/o+r/YgLLOs3ScYsqe/NP50RdqCejzTp4w1tFX2NxvOYM9ICUvGT20
         qrxrRp1Z8t9Z9Fn9kiXYDaGxapW9wFzNC7CzpmX75kYtfiwxXbxCzRjJbRsBbHs2nJ2F
         46bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=kg3zb8BO2QRjiuZYnN5zS/pX3pAOAi5oShlI4N1Uy90=;
        b=C4XH9MazrynLm9ZnS1lIGO5c3AXkfbeGC28D1+N4P6VLIuXQzCHrXdb+jB946e2rDH
         JArGDwIkHisw4tNtMFqv5D+nsSe5C2xgxsYysknWOu3MX0lDEGlhIgsAil8vWgSdK3ep
         hNBmSH7dCHt/lKDf7AtkGMpyXnsapDnj5cWPpuzn8tv/H29vXHV2QtlSmR85LS0Ug8oQ
         X2VbNqc8aPeoTzG7wW6cvjexQrLMA+9my/2bvXTplT8kbcDOYxPSO9+aq3KSmc1HnjEq
         2PAbR7SY3nb3fUh7M1JxC/pQdV9v8dP1/O4Qa4ZavqGR3WUU8yeeBnjaEL3/pYqMFR6H
         pKYg==
X-Gm-Message-State: APf1xPAur01mgd9NiIJnOmVbM3kw0rbwi8fhP8NaFaIQ9NLkz2q2QiOB
        EwWqVv4g3KO77HbNrZYEySLuNtfpJ4k3fskCafg=
X-Google-Smtp-Source: AG47ELvgpHm3N2o1oo2/2p7+owoEcSdBORA6dfavS33ioBbsxhGnzifYkPlrFeL+I7ithUmX+KXd2DHarC0SvAi1HEk=
X-Received: by 10.99.124.7 with SMTP id x7mr5078449pgc.356.1520011829442; Fri,
 02 Mar 2018 09:30:29 -0800 (PST)
MIME-Version: 1.0
Received: by 10.236.137.23 with HTTP; Fri, 2 Mar 2018 09:30:28 -0800 (PST)
In-Reply-To: <20180302104232.GA11074@sigill.intra.peff.net>
References: <CAD-Jur+6m1SjqHVWBxW5HnTjutSVrkP+dEXdYmFHzoUf0FGdNA@mail.gmail.com>
 <20180302104232.GA11074@sigill.intra.peff.net>
From:   Sam Kuper <sam.kuper@uclmail.net>
Date:   Fri, 2 Mar 2018 17:30:28 +0000
X-Google-Sender-Auth: NMc8Mgoz4q_FS2cfJTnURumibdA
Message-ID: <CAD-JurJLDSzf7_A0ZGWPYGyRiSnHWSpUrVEd9_+N1J7BamMM=Q@mail.gmail.com>
Subject: Re: Bug report: "Use of uninitialized value $_ in print"
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/03/2018, Jeff King <peff@peff.net> wrote:
> Unfortunately, I don't think there's an easy way to do what you want
> (show word-diffs but apply the full diff).

Oh :(

That would be a *very* useful feature to have, especially where
multiple small (e.g. single character or single word) changes are
sprinkled throughout a large file.

Should I start a separate thread for this as a feature request?
