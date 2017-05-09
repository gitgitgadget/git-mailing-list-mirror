Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C3362018D
	for <e@80x24.org>; Tue,  9 May 2017 02:06:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753191AbdEICGx (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 22:06:53 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34928 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752608AbdEICGv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 22:06:51 -0400
Received: by mail-pg0-f66.google.com with SMTP id i63so12982866pgd.2
        for <git@vger.kernel.org>; Mon, 08 May 2017 19:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=aebDxccQpcP9pdC0TnE8XXaNcc/6TjWn5oldu7T7rFM=;
        b=Cg2fvWZyJERJaeE+o/aTCpFpZer4fJCDV3F01MfTi8V8TPZv3EVb9kCFZwkHp0xBUN
         pbOqsykiPzTUQTMOfdqjNLVC940CayMgBykqMXAxjft92eYPmzHkiLJg1NltlfW8WnOz
         +PnBopo8xkTxmOIwc+0jmDFFNBvTSwEflysV0vh5NbmqyXp7mHxa5KjsYkNDl+zpdStN
         IJkewKp1/zkOmnVlxh4WTWCne1f6GKelYar+tIotm0W33sA41bXlO3kAzkfsP/qGYh2C
         HYK7dlaKNOLVpiLUUSGJkh0vDRMDU2VTkDYl1MoWjDcldDH+okwS+mNhIB0zF8wcfnKh
         zQmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=aebDxccQpcP9pdC0TnE8XXaNcc/6TjWn5oldu7T7rFM=;
        b=doF+Z8BAKXxC1r3sT4yB8HwEpt8JeHk/ebIOjUMm6UFm5mcdmj+j/lqgDkvzHmuHge
         Q5uLzc/xiauvOgPll60rO1M5l0dakELHsk4ozHS5SfPgvqNgkW3KdlaX5Gzs/IQ3fF66
         b3thccg+jFGUBRP11o5xMThkRPWlqs1UddeCDIEZRp365TjQuvlmkfo5SxS/sEs814cd
         hsuZdCyZqL9/3Y2mxzRyN2guOIIIzxRm0qjpvGf8dQKe1K1a4G/Ehaai8r320l9r3F8Q
         uMTlsId5NiqsQwXqp0J4kWOlYTcm06oGQVjAmtQRYbc5aRDbCPNUqQ05PPetDLuZ6sYt
         Vc3w==
X-Gm-Message-State: AN3rC/4jrDBrfsCAwk7EvWorw0LSZEzIpEnIwgBGEHReB79pY3L0ljzv
        IgfS0Ctp/uTXaK58jiFdAg==
X-Received: by 10.98.74.135 with SMTP id c7mr34188463pfj.140.1494295611215;
        Mon, 08 May 2017 19:06:51 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:2823:d4da:fd9a:464a])
        by smtp.gmail.com with ESMTPSA id a24sm24447783pfl.70.2017.05.08.19.06.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 08 May 2017 19:06:50 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] diff.c: Fix whitespace issues due to a mismerge(?)
References: <20170508184354.31671-1-sbeller@google.com>
Date:   Tue, 09 May 2017 11:06:50 +0900
In-Reply-To: <20170508184354.31671-1-sbeller@google.com> (Stefan Beller's
        message of "Mon, 8 May 2017 11:43:54 -0700")
Message-ID: <xmqqo9v26ax1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> It looks like all these lines were introduced by one of the conflict chunks
> in 4af9a7d344 (Merge branch 'bc/object-id', 2016-09-19). Viewing that
> commit in gitk, the indentation seems fine, i.e. there is just one
> whitespace in front of the lines, as you would expect from a formatted
> patch.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
>  Junio, 
>  I do not think it is worth to apply this patch on its own,
>  but maybe it is worth to investigate your setup? (Assuming it is
>  git that did the merge, we may have a bug in whitespacing and
>  merge conflicts.)

Thanks for spotting.  

I do not think you have to worry about any bug in Git-the-program
with this merge.  If you try to reproduce the merge yourself (which
by the way is easy to do, with "M=4af9a7d344 && git checkout $M^ &&
git merge $M^2"), you'll see that quite a lot of changes made to
"builtin/apply.c" had to be hand-ported to the corresponding lines
that are now in "apply.c" at the top-level, because in the meantime
13b5af22 ("apply: move libified code from builtin/apply.c to
apply.{c,h}", 2016-04-22) moved things around while the merged side
branch has been cooking.  

It is very likely that manual killing and yanking in Emacs
introduced the screw-up.
