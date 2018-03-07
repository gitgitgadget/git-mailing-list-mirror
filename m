Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CA841F404
	for <e@80x24.org>; Wed,  7 Mar 2018 21:41:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754877AbeCGVlH (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Mar 2018 16:41:07 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54942 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754745AbeCGVlG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Mar 2018 16:41:06 -0500
Received: by mail-wm0-f66.google.com with SMTP id z81so7526525wmb.4
        for <git@vger.kernel.org>; Wed, 07 Mar 2018 13:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ZUpvy6UXwGt2qQ3PcNYqsWR67owtLo4SsOhKPVBCjmg=;
        b=GxlOpFzPXLl3vPwhSLxIGkpoxN25Hqt60bqughRIw1o4qJeGY7qxQbx/S7A3InxRP1
         vZS6nVaw8pu2Afg9orZFDCBlINoSIp/RyAzgNKCasuCskQO9V/bnSM91BOnH3zp0HGjn
         79pYizkYngDywB7AVjuEMqkjJzuFzvsmiCN6aEQaMkRVwT+yjcDAO568lrdx4O+TNDw3
         auJGS87m4coim4X+xSv9EZ02Jj9+f8zOc+gYbPWPVPrZPsJ95IV03UZYT4Qt0Cs4IGBJ
         WEp8sbBHS1CRgKbOhk6Ig107jQDw80RNiL/6SGuNckXGgqQgWy97IuthsCtTjvFp1Owk
         G7+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ZUpvy6UXwGt2qQ3PcNYqsWR67owtLo4SsOhKPVBCjmg=;
        b=O7suEp+SCFTETVs/XloR6AN8KVCQUfwD2Yif337hWAMwjMIoO72KkHL2Q/rjQM9kd4
         VPVTF3LT3KO1gNJWyUCUAAAi8tBafTPPOSPrlqQmK7gsoZZSfoNF5OcM0vfR6YUh9jNG
         m5Piga8ufV5jG5PQrTNQ/XgUiyWxxZHjki4b4KSNMhfbcX1kc5HMIFXVKCxCn5O+JHQh
         KlmrGYcJCFwRsb27454AZLVQTnaBcxaG8g+gPgR0WJny+4gV6n+ofQD0iGEoirsaUw0r
         GXxyNf1fKWCm1FAEgPIzkPTbue6XU6qMtgngz4Pd8tFOupG31s6ut0GzCgf00wgco/bK
         kPFA==
X-Gm-Message-State: AElRT7FLOMwfKcPteHm96eFt6Gq6nrWgPwKZ/iCZ9JS7Oe3MKSej02Gd
        pP/PeZK3p1AkifZluzKpcXhEL89JUNc=
X-Google-Smtp-Source: AG47ELsX3HoZ2Hr+b+7ZMyvFGiDjkbyvtTzdLvgJB/E8XvMeocPldm+Dc+GKMD0FX9p46OidTYgF2g==
X-Received: by 10.28.160.26 with SMTP id j26mr14577675wme.76.1520458864894;
        Wed, 07 Mar 2018 13:41:04 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id p104sm25355436wrb.47.2018.03.07.13.41.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Mar 2018 13:41:02 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Robert Dailey <rcdailey.lists@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <stefanbeller@gmail.com>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH] Support long format for log-based submodule diff
References: <20180307211140.19272-1-rcdailey@gmail.com>
Date:   Wed, 07 Mar 2018 13:41:01 -0800
In-Reply-To: <20180307211140.19272-1-rcdailey@gmail.com> (Robert Dailey's
        message of "Wed, 7 Mar 2018 15:11:40 -0600")
Message-ID: <xmqqefkvzhqq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Robert Dailey <rcdailey.lists@gmail.com> writes:

> I could have gone through the effort to make this more configurable, but
> before doing that level of work I wanted to get some discussion going to
> understand first if this is a useful change and second how it should be
> configured. For example, we could allow:
>
> $ git diff --submodule=long-log
>
> Or a supplementary option such as:
>
> $ git diff --submodule=log --submodule-log-detail=(long|short)
>
> I'm not sure what makes sense here. I welcome thoughts/discussion and
> will provide follow-up patches.

My quick looking around reveals that prepare_submodule_summary() is
called only by show_submodule_summary(), which in turn is called
only from builtin_diff() in a codepath like this:

	if (o->submodule_format == DIFF_SUBMODULE_LOG &&
	    (!one->mode || S_ISGITLINK(one->mode)) &&
	    (!two->mode || S_ISGITLINK(two->mode))) {
		show_submodule_summary(o, one->path ? one->path : two->path,
				&one->oid, &two->oid,
				two->dirty_submodule);
		return;
	} else if (o->submodule_format == DIFF_SUBMODULE_INLINE_DIFF &&
		   (!one->mode || S_ISGITLINK(one->mode)) &&
		   (!two->mode || S_ISGITLINK(two->mode))) {
		show_submodule_inline_diff(o, one->path ? one->path : two->path,
				&one->oid, &two->oid,
				two->dirty_submodule);
		return;
	}

It looks like introducing a new value to o->submodule_format (enum
diff_submodule_format defined in diff.h) would be one natural way to
extend this codepath, at least to me from a quick glance.

It also looks to me that the above may become far easier to read if
the common "are we dealing with a filepair <one, two> that involves
submodules?" check in the above if/else if cascade is factored out,
perhaps like this as a preliminary clean-up step, before adding a
new value:

	if ((!one->mode || S_ISGITLINK(one->mode)) &&
	    (!two->mode || S_ISGITLINK(two->mode))) {
		switch (o->submodule_format) {
		case DIFF_SUBMODULE_LOG:
			... do the "log" thing ...
			return;
		case DIFF_SUBMODULE_INLINE_DIFF:
			... do the "inline" thing ...
			return;
		default:
			break;
		}
	}

Then the place to add a new format would be trivially obvious,
i.e. just add a new case arm to call a new function to give the
summary.
