Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 963341FBB0
	for <e@80x24.org>; Thu,  1 Dec 2016 21:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757785AbcLAV4e (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 16:56:34 -0500
Received: from mail-qt0-f174.google.com ([209.85.216.174]:33317 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751676AbcLAV4d (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 16:56:33 -0500
Received: by mail-qt0-f174.google.com with SMTP id p16so234159477qta.0
        for <git@vger.kernel.org>; Thu, 01 Dec 2016 13:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=F1NCX5k9gRRw9xq4IbgDfNAqTvzaISrJstnE3Mta7Wo=;
        b=F1y4jHaQLT+V9I06vwv89bKdmBf+e3OBYojHsFOfv3jo7x6jPBpcpsYZ+Ne6ravdOc
         EyGyenqT5ObwXPjQCsXxy25+K+a3RElWko/dAuXdmalQm4aMBglAoaUjk4gQivr+9OxN
         e4vRLCcnLBEzJja33qqNDuLCYN2dVwcAxMSkRk3YtdoYV5Ue8pNmESEHpFLceduelsL7
         6fDbHC9A0lSmmFAMg1rzOo/BfwDC980PAM8up7AheTOih2+kBqG45AFiOCz6BSDtcV3+
         EgSPG5HrIY/7vZ+SJ6qYhfcOEvMyiWz/RYqaFQKShq2mtZ9UVXLpvUwbAnIPIlHsoXWb
         gpYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=F1NCX5k9gRRw9xq4IbgDfNAqTvzaISrJstnE3Mta7Wo=;
        b=HRnevhdOSIH2TzRF9o5L6hSGucpbI1AL8ng7h4etZi1EuBo4rVUH1SOH2fCYMJQGzg
         5MjDmxQoybfNDnfr/fYb2KQPc3dIq28McpbqAgE774MtugWZcH7qQkP6rvPVpXTLemEI
         VpyFiDrDb1pxwGUmMNTJg0MF4RSqu2HRHc5I8MCzyxVksZncZ0HGkDbpKuR+3Tk21i5g
         /nZk99xBpZjptcvl/ymw338PS8aZiss1BZ6z1KiUqcWfgP6CCzWRUIhEIvXe8YAo3ca6
         wtMRO+DmLZTYW873k1kmLPZadZYtyTMG19iyKwql27rG31ifK6Y9k7qDXwsJIesZN/qE
         NB/w==
X-Gm-Message-State: AKaTC015/kXUk3JxDrnAEyeBxwiH4KYdQNpJ1tCuwh7KjYFvK5Lzf1/Lxw6N95jrak9fveHI2ocPzsFDs8MDRjWV
X-Received: by 10.200.49.235 with SMTP id i40mr39738617qte.170.1480629392566;
 Thu, 01 Dec 2016 13:56:32 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.147.188 with HTTP; Thu, 1 Dec 2016 13:56:32 -0800 (PST)
In-Reply-To: <20161201205944.2py2ijranq4g2wap@sigill.intra.peff.net>
References: <1479840397-68264-1-git-send-email-bmwill@google.com>
 <1480555714-186183-1-git-send-email-bmwill@google.com> <1480555714-186183-2-git-send-email-bmwill@google.com>
 <20161201042926.mr2qdta7hviizcya@sigill.intra.peff.net> <xmqqwpfja3nk.fsf@gitster.mtv.corp.google.com>
 <20161201190925.xi2z7vauxyf3yxyc@sigill.intra.peff.net> <20161201191603.GB54082@google.com>
 <20161201205444.GG54082@google.com> <20161201205944.2py2ijranq4g2wap@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 1 Dec 2016 13:56:32 -0800
Message-ID: <CAGZ79kaqzssfN_bRQYpqC9HsKmyQZNCQcs+T5ke95Sf-C5PaRQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/6] submodules: add helper functions to determine
 presence of submodules
To:     Jeff King <peff@peff.net>
Cc:     Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 1, 2016 at 12:59 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Dec 01, 2016 at 12:54:44PM -0800, Brandon Williams wrote:
>
>> > I think this more robust check is probably a good idea, that way we
>> > don't step into a submodule with a .git directory that isn't really a
>> > .git dir.
>>
>> Looks like this is a no-go as well...the call to is_git_directory() ends
>> up calling real_path...which ends up performing the chdir call, which
>> puts us right back to where we started!  (as a side note I was using
>> is_git_directory else where...which I now know I can't use)
>
> Bleh. Looks like it happens as part of the recently-added
> get_common_dir(). I'm not sure if that is ever relevant for submodules,
> but I guess in theory you could have a submodule clone that is part of a
> worktree?

Sure we can, for a test that we don't have that, see the embedgitdirs series. ;)

For now each submodule has its own complete git dir, but the vision
would be to have a common git dir for submodules in the common
superprojects git dir as well, such that objects are shared actually. :)

>
> -Peff
