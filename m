Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EAE4200B9
	for <e@80x24.org>; Fri,  4 May 2018 03:07:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751271AbeEDDHr (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 23:07:47 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:32862 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751236AbeEDDHq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 23:07:46 -0400
Received: by mail-wr0-f193.google.com with SMTP id o4-v6so19508816wrm.0
        for <git@vger.kernel.org>; Thu, 03 May 2018 20:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=9GavA0QzaqbQWyqRf+1UPV67HPHWzj6xE6t02BW8ozU=;
        b=A9uQ5Inm9brW2wLSqSGyuwqHlSlBWCD4qMxuIwccYdpBL9SpEUpmFhMcDm0KiAUyth
         8fUzJWhY+AUTqwkBV09N6mhqoayFqua/vEgFDGKKPLCUDJcMJ5S0opdu4g+GS0qLPkSR
         PARAkidXrAp3wZtvisXLlI1EQ6Vu1V5L6QxOakZGm5pmzkZbIbhhTIU67giLFgaxFLp9
         NTTLYuTDN+sDjO3DsmTIMSnaDwlNxIpziPBNQxCVyOG4ybJzjilyt0Is/9euAbytsNOB
         VqdCLQY00zM2M76gqIQcgsYPCeR2DqfY7CKta/LU7SXhDpa2wBQ9BOFLQaPDGZiC0c+C
         3fwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=9GavA0QzaqbQWyqRf+1UPV67HPHWzj6xE6t02BW8ozU=;
        b=SDz8m2WIeP2wDcHyXKFx1OLjKQ2XsxwvCp1KSfpDoBE320VoNrEHd5+3lFFkQG/7sc
         qPE1FblIKHSlnOetnNYuz7ZIwdyv3AFlhkZN5AtTMfpMCkJ3tH+CVkjwa7M1V5prUd/Z
         nGQh8xh2GRIvH0nBp92+L2Y3x7G4G00VncPoH99jVpiGouECFJnt5qwbaWNfn4t0rqg3
         digKnrYZdrMynFA0fbHuV/rUOTHIYAkgrxciKT1C+NB5H/n3DIFqFYJDEjMO13HnOcg4
         KuOfrfqm194M5Qq77mBIfXh0KCFBy/5dX11vKgBMKqPwmpODtJ2ZcrZfQn3rj24nqZyL
         AzTA==
X-Gm-Message-State: ALQs6tCQwjbyZxTql4YcwO+VPKbzRHOGQN0D5CX2Dh+tWgh4XZShX34C
        2Gx1oM1WPdATsumD6SbOVTs=
X-Google-Smtp-Source: AB8JxZodK4Tkv852fmlQ/w0hm5yoB0dYrcR6QvePQWhjQoCNltt3jEHj1Haun45TVXFL/GWXKz07yA==
X-Received: by 2002:adf:aac5:: with SMTP id i5-v6mr18249587wrc.16.1525403265501;
        Thu, 03 May 2018 20:07:45 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id c21-v6sm14828642wre.43.2018.05.03.20.07.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 May 2018 20:07:44 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <Ben.Peart@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "newren\@gmail.com" <newren@gmail.com>,
        "peff\@peff.net" <peff@peff.net>,
        "pclouds\@gmail.com" <pclouds@gmail.com>,
        "vmiklos\@frugalware.org" <vmiklos@frugalware.org>,
        Kevin Willford <kewillf@microsoft.com>,
        "Johannes.Schindelin\@gmx.de" <Johannes.Schindelin@gmx.de>,
        "eckhard.s.maass\@googlemail.com" <eckhard.s.maass@googlemail.com>
Subject: Re: [PATCH v4 2/3] merge: Add merge.renames config setting
References: <20180420133632.17580-1-benpeart@microsoft.com>
        <20180502160056.5836-1-benpeart@microsoft.com>
        <20180502160056.5836-3-benpeart@microsoft.com>
Date:   Fri, 04 May 2018 12:07:44 +0900
In-Reply-To: <20180502160056.5836-3-benpeart@microsoft.com> (Ben Peart's
        message of "Wed, 2 May 2018 16:01:14 +0000")
Message-ID: <xmqqefist8xr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <Ben.Peart@microsoft.com> writes:

I'd downcase the verb on the subject.

> Add the ability to control rename detection for merge via a config setting.
> This setting behaves the same and defaults to the value of diff.renames but only
> applies to merge.
>
> Reviewed-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Helped-by: Elijah Newren <newren@gmail.com>
> Signed-off-by: Ben Peart <benpeart@microsoft.com>
> ...
> diff --git a/merge-recursive.h b/merge-recursive.h
> index d863cf8867..c1d9b5b3d9 100644
> --- a/merge-recursive.h
> +++ b/merge-recursive.h
> @@ -55,6 +56,11 @@ struct collision_entry {
>  	struct string_list source_files;
>  	unsigned reported_already:1;
>  };
> +inline int merge_detect_rename(struct merge_options *o)
> +{
> +	return o->merge_detect_rename >= 0 ? o->merge_detect_rename :
> +		o->diff_detect_rename >= 0 ? o->diff_detect_rename : 1;
> +}

I'll tweak the above to leave a blank before the function, and make
it "static inline", to ensure that the output from

    $ git grep -e '\<inline\>' --and --not -e 'static inline' -- \*.h

is empty.
