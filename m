Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A042A203C1
	for <e@80x24.org>; Wed, 20 Jul 2016 23:31:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751035AbcGTXb0 (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 19:31:26 -0400
Received: from mail-yw0-f173.google.com ([209.85.161.173]:34420 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750827AbcGTXbZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jul 2016 19:31:25 -0400
Received: by mail-yw0-f173.google.com with SMTP id z8so37868349ywa.1
        for <git@vger.kernel.org>; Wed, 20 Jul 2016 16:31:24 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=sn24cRfF4dshiDdKqjooCdB8Bq7hGsLQXccIsm3Vl1I=;
        b=q5Tf+MPCtlQGlICj3YNd/W4I3E+N264cA9f4d6ZlcuMgyd2WDbXNDc0I0eK0fSgkmR
         c2XafEIQaX6crwEBlEeGTSoIHb5gicoZK2a0olTURaJ9JI9xuZXrWptlPJH4Fjh5i9TN
         tXE21Ou2Q2x9IVUOsjEPU5ybXkKdvS9a5jmPHjyL+9wUTKfH4bfnBbQ3j8TkT7Nw/l1R
         mMkgML9j08aEi8dl+Bu3NCuG1wiOUVf3r+JySZtWCHn6Da0oNdOxFMryAkEyG9D4HsN8
         uXKEcqrRNQm1b9lBOzx+W7JTLLQqsUmL3fLDRvlQWV0c07NQu6EXEOPm576DW4gTGsbV
         Zysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=sn24cRfF4dshiDdKqjooCdB8Bq7hGsLQXccIsm3Vl1I=;
        b=IwYmRwAFs/kiXK3Jf3xuGW7RNgg55Pe0AwggSy1WvT1exHChPOykPLXdg4clZD8MHH
         oSOFxFJWjw9ez5j3Un/l12pQqz0cELa+cAr/Hrkq2VGiO1q65FmQ6MsQVjf4UOOZYPAS
         eEZgQIh2DU0PSuNJhuplFawqQJeGLNdu8i5B1WJ5AwxLwfXebgYVy5KZQy1FGBjW5wum
         AomXG4g5t55YWQzYFDBX4m/eQ+VY8GizQQMbdVojdm0kSIyf+Rth/5qwvhoRAYOt6EQU
         LRGdt3J62bVbRBXAPUMriMJNnuG2Rb4UQ30t1T01JO+8UCmmuupUaVzHp5PYb94/jqFe
         dP3w==
X-Gm-Message-State: ALyK8tL17Mn4Lgifm3kNUjBeoYy8Bwv00AbcX7aHc6EY9r7dTvFcPD8Nre/rQSkW5IY3HIH6EQgKmG3MAOHoPw==
X-Received: by 10.13.206.65 with SMTP id q62mr7844521ywd.317.1469057484114;
 Wed, 20 Jul 2016 16:31:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.13.250.4 with HTTP; Wed, 20 Jul 2016 16:31:04 -0700 (PDT)
In-Reply-To: <579004CC.8090503@gmail.com>
References: <CAOHAwykGkfY7M30jT8t0k6Gsdy5QSBHmAPiWYoKibjUgS-G6hg@mail.gmail.com>
 <20160720131424.GC17469@sigill.intra.peff.net> <xmqqd1m8du1b.fsf@gitster.mtv.corp.google.com>
 <579004CC.8090503@gmail.com>
From:	Junio C Hamano <gitster@pobox.com>
Date:	Wed, 20 Jul 2016 16:31:04 -0700
X-Google-Sender-Auth: HKdeacnq3YVafSxFXxC2AiA0Cjs
Message-ID: <CAPc5daUjK1k8teTw8enb3yNwo+WesJY3BVHM34Wdqu31czUB4Q@mail.gmail.com>
Subject: Re: How to generate feature branch statistics?
To:	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Cc:	Jeff King <peff@peff.net>,
	Ernesto Maserati <ernesto.2.maserati@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jul 20, 2016 at 4:10 PM, Jakub Narębski <jnareb@gmail.com> wrote:
> W dniu 2016-07-20 o 20:49, Junio C Hamano pisze:
>
>> For our own history and workflow, the duration between the inception
>> of a topic branch and the time it gets merged to 'master' is not all
>> that interesting.
>
> Nb. if I haven't messed something up (the git history is not simple
> merging of topic branches into mainline), the shortest time from
> creating a branch to merging it in git.git is 7 seconds (probably
> it was a bugfix-type of a topic branch), the longest if I did it
> correctly is slightly less than 4 years (???): 641830c.

The former is quite understandable. The point of having such a topic
is so that it can be merged down to older maintenance releases.
