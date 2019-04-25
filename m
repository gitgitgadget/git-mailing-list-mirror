Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD29F1F453
	for <e@80x24.org>; Thu, 25 Apr 2019 16:28:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfDYQ2F (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Apr 2019 12:28:05 -0400
Received: from mx.kolabnow.com ([95.128.36.42]:57876 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726435AbfDYQ2F (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Apr 2019 12:28:05 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTP id 51FEC403F7;
        Thu, 25 Apr 2019 18:28:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:mime-version:content-type:content-type
        :references:in-reply-to:date:date:from:from:subject:subject
        :message-id:received:received:received; s=dkim20160331; t=
        1556209682; x=1558024083; bh=lVFYw0J23BKf8p4ACZtpUf6OLM9hfHIOo6O
        l1Y8XOC0=; b=Lz3EQnlXEMLyV4VaJpqBq7tOBxnA171pHvTwnCAOWyuVd/c+lsF
        vwgjK6vuA9zbytyABjWMFj+gMvhloIAS89E16HNFEPwAR0nDuvX9LuBWX8q66/yh
        x2OSFFgqINyHWrBeaAetwxftUnIhOhicq9rmeDhF2uOVOhcr3AwiTT8vDstzattO
        iAbZ9ETK43p5yHMERtrHikcNCgCBsnOdZl+qlRJU/QSKR43IED6sUr1VnwLUvBUD
        2iCCjks7yXu8jFuakrHMk59up1poqaYbI6r4bTgU3yQm/N6E4zIXItpYK44dikxl
        Q5q/nkm9VCffh1ehX84tBcIKkR4aOpPo3ijR31pCe1mC08flrwV/zdxAlw/Oaz9p
        YTAYhht3DvN5Ow2SuowhaqQD7T/lqeVcueQ615s6BPfSgidLAQIwpAlGAXauev1y
        i1oLFuSW5gcXsiuldEv4vF9BxOX5oe8V0Bo107RGB5G7ABkI0s7gy+WflELY4Voc
        Yfq/ks8rbYtxlrX/YjVgEPb3vxJ6yJO9S+jsFVN4St+4jCYyBWWIwPQWA8CPJGRZ
        yIopgOuupPfnud83sKSANUlxIOb5ClyLkb95aTBQOdPwr9V5NUlAgNIRiGXdL/in
        sauReEN+W9XmLvhaCwhZsUPzyEmCjNvaqBASxFphMJB7uoJ/Z0UqlZ64=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id g8ySPl4uKuYU; Thu, 25 Apr 2019 18:28:02 +0200 (CEST)
Received: from int-mx002.mykolab.com (unknown [10.9.13.2])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTPS id 3526F402AA;
        Thu, 25 Apr 2019 18:28:01 +0200 (CEST)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx002.mykolab.com (Postfix) with ESMTPS id D4B694F85;
        Thu, 25 Apr 2019 18:28:01 +0200 (CEST)
Message-ID: <dfc0a40233677ce0e1d9d073c41b6f0fea3bf746.camel@stellar.sh>
Subject: Re: [PATCH] Documentation/merge-options: clarify --squash behavior
From:   Vishal Verma <vishal@stellar.sh>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Rafael =?ISO-8859-1?Q?Ascens=E3o?= <rafa.almas@gmail.com>
Date:   Thu, 25 Apr 2019 10:26:26 -0600
In-Reply-To: <xmqqr29qyb1i.fsf@gitster-ct.c.googlers.com>
References: <20190424212212.10039-1-vishal.l.verma@intel.com>
         <xmqqr29qyb1i.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, 2019-04-25 at 13:16 +0900, Junio C Hamano wrote:
> 
> I think it is bad to silently ignore the option.  With or without
> this documentation update, I think it is sensible to update the code
> so that it errors out when "--squash --commit" are both given at the
> same time, just like when "--squash --no-ff" is given.

Yes that makes sense.

> Or make it "just work" as you said.  Using a boolean variable as
> tristate is something we do in many places and it by itself is not a
> rocket science.  You initialize the variable to -1 (unset), let
> parse_options() to set it to 0/1 when "--[no-]commit" is seen, and
> inspect after parse_options() finishes.  If the variable is still
> -1, you know the user wants "the default" behaviour.

Ah I see - I was conflating OPT_BOOL with the parameter being a boolean
as well without checking, but I see now that isn't the case.

> 
> The "default" behaviour you are proposing would probably be
> something like
> 
>         if (option_commit < 0) {
>                 /* 
>                  * default to record the result in a commit.
>                  * but --squash traditionally does not.
>                  */
>                 if (!squash)
>                         option_commit = 1;
>                 else
>                         option_commit = 0;
>         }
> 
> But I suspect that the option parsing part is the least difficult in
> the "make it just work" change.  That is because I think that the
> machinery to record the result in a commit is not expecting to be
> asked to create a single-parent commit to record the result of the
> squashing, so there may be need for adjusting to how the result
> wants to be recorded before the code makes a commit.

Yes I was going to try to allow the commit option as an experiment, and
just see what happens. For now I'll send a v2 that has a doc update as
well as prints a warning using the above technique.

I'll dig more into what allowing --commit actually means (as time
allows) - I'm definitely a newbie with git internals, and indeed this is
my first posting here.

Thanks for the feedback!

	-Vishal

