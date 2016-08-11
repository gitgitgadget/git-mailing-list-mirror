Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E588E20193
	for <e@80x24.org>; Thu, 11 Aug 2016 18:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbcHKSb4 (ORCPT <rfc822;e@80x24.org>);
	Thu, 11 Aug 2016 14:31:56 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:33587 "EHLO
	mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750818AbcHKSbx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2016 14:31:53 -0400
Received: by mail-yw0-f195.google.com with SMTP id z8so166920ywa.0
        for <git@vger.kernel.org>; Thu, 11 Aug 2016 11:30:56 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Gwij6Co1sswwRlQx+n3Z4tYT9EBCnqtFKWy1inOVx/8=;
        b=C/5yzABFt+jJJd+Luk3NnsS59tUSn4wZPk+dccCTT60KiMjIMqxGmmIGKIF2MBRRPk
         YofgJcxQkWH51O5MyTKzmWlt0in0Y4BjhVqAFe7lxGHwx+kELqM94omI4zkxPX1w5WJI
         fKZtsBe5zVeBSN/K4dm2B29bB4F5TtXsubv8CpyRQSjLBW7uLcBw8VRwxtfP4isptVTz
         LmpukaJO/FlxEyPuR5BR/28btHbZbGf/kAjRZnisz8Op+glr6o9wx+yi5p/oxa5hbjfP
         kZfuxIh5qvcZ+hktJuAD72XqyTo10wPnSg9fTIfYkhddM+1LBFmUltmrFagTNoxFp5Xy
         40xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Gwij6Co1sswwRlQx+n3Z4tYT9EBCnqtFKWy1inOVx/8=;
        b=PMqiTANQS2EBgqZ4TevDgcxvN4NEedY2dpsIsfIBy5ptB4nlV2M/8t6pUkNpVC+UzT
         SEMt7oEzOUzp1Ogeg+U3nURPgIe0lqFrcY8HSzy8GuJn4bhwpWWZq+QuzveSShNyU0NO
         cCG33Nu0i6+X/rFuigfmiBxAfOVpLBP79DVCUGNEK9kjwGCAd4vgbUQp7iXyTE5zCrJ/
         nsqsaW510IprtpSrhgbDfRcjJIRTUoQ5fXHnLe3znkJa7wDt9lm1EUBTrYP7mQzgE0pb
         ZQTpoesqntwVu2k246acc3EXvtmD2/S2BTD2B5RL4mCEiNc8+8Szqno292hNlSn2EEHR
         lPMw==
X-Gm-Message-State: AEkoouuoRF+mO7SQyurJkhMVCOZnYjhGmcFAqCo9oa50OUxnfWs3zLBkQsZ4zFZli3CvuBJXpiTjZCMg4+4fTw==
X-Received: by 10.129.95.70 with SMTP id t67mr7650475ywb.284.1470940255527;
 Thu, 11 Aug 2016 11:30:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.50.196 with HTTP; Thu, 11 Aug 2016 11:30:33 -0700 (PDT)
In-Reply-To: <xmqqh9ar2pc7.fsf@gitster.mtv.corp.google.com>
References: <20160810231908.26330-1-jacob.e.keller@intel.com> <xmqqh9ar2pc7.fsf@gitster.mtv.corp.google.com>
From:	Jacob Keller <jacob.keller@gmail.com>
Date:	Thu, 11 Aug 2016 11:30:33 -0700
Message-ID: <CA+P7+xqodtUt9gPzZ5HxPurFy67niN5+-EDOTJpraNrvLJfZ=Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] diff: add --line-prefix option for passing in a prefix
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Jacob Keller <jacob.e.keller@intel.com>,
	Git mailing list <git@vger.kernel.org>,
	Lucian Poston <lucian.poston@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Aug 11, 2016 at 10:22 AM, Junio C Hamano <gitster@pobox.com> wrote:
> -- >8 --
> Subject: diff.c: remove output_prefix_length field
>
> "diff/log --stat" has a logic that determines the display columns
> available for the diffstat part of the output and apportions it for
> pathnames and diffstat graph automatically.
>
> 5e71a84a (Add output_prefix_length to diff_options, 2012-04-16)
> added the output_prefix_length field to diff_options structure to
> allow this logic subtract the display columns used for display the
> history graph part from the total "terminal width"; this matters
> when the "git log --graph -p" option is in use.
>
> The field be set to the number of display columns needed to show the
> output from the output_prefix() callback.  Any new output_prefix()
> callback must also update the field accordingly, which is error
> prone.  As there is only one user of the field, and the user has the
> actual value of the prefix string, let's get rid of the field and
> have the user count the display width itself.
>

Seems correct to me.

Thanks,
Jake
