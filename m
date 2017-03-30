Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF98A20966
	for <e@80x24.org>; Thu, 30 Mar 2017 23:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754898AbdC3XAn (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 19:00:43 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:35179 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754333AbdC3XAn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 19:00:43 -0400
Received: by mail-io0-f175.google.com with SMTP id z13so29598191iof.2
        for <git@vger.kernel.org>; Thu, 30 Mar 2017 16:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=retailnext.net; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nQCF4zlLHBeg+KIrHPA2zmSWqfYBN2qSa9MPHULQ+ZE=;
        b=dZ2NSU0OddTJaLXRF+l0luC2fN5nO4EwzBkmxm4cKqtPXwvJ+BDLCBc0KXaBGaFKuC
         KI6jdD7Rm2xALmJ9Rsla6DsHiTGuFnfCAIXkZFR2lRH37zlRKSlDW25EMjticEsRK/fh
         qZkEyupBRQjfiNILKVomHJQwxl11uCHU0BAoI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nQCF4zlLHBeg+KIrHPA2zmSWqfYBN2qSa9MPHULQ+ZE=;
        b=PDSt/uaZozgrdd/e8Ue4zKBAQBqjsZykxnXkCMSNb4lE1WMEZMXeTi58en3Hqfr3vO
         foFgkQViF0V+iUUkclV2xA775Vbdk3OQZIFnOjID1WIPgmD1g8pkKfEBevCjFhVZudA2
         rBrY5uwnFLq6+edicuEtaTV5vQb1/uqPLtRqYryYKRGbS+3f8nTTltJxd8KGvte48vyL
         hAbcUnhf6YqLHPu/MBA9TZC1vGiWr4w5JeranGbVjk/XbjybD760ZtZ0asrHqlpvSSwL
         IBYJT/zvsV2Au2MXRuMR8JHYkgsv59fJ8ZRQYnMrTphx7Vp43GWrvvfAYv0v0GKMTqSz
         7fmA==
X-Gm-Message-State: AFeK/H1ErQQ11Z+9b2aKhI6h/y/uc2SOTHL+AGqTBrie8LkVtcvqg7uQqWvK//Ve4zU837cUbQXLOMvC4Q4TxjsH
X-Received: by 10.107.6.66 with SMTP id 63mr3581617iog.6.1490914841659; Thu,
 30 Mar 2017 16:00:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.164.230 with HTTP; Thu, 30 Mar 2017 16:00:41 -0700 (PDT)
In-Reply-To: <xmqqo9wi1ifw.fsf@gitster.mtv.corp.google.com>
References: <CAJF7t-dqSa7tmQqNEWmg_VZ=+832nsZ-3JmSGA03qK6aY5eNTQ@mail.gmail.com>
 <xmqqo9wi1ifw.fsf@gitster.mtv.corp.google.com>
From:   Nate Mueller <nate@retailnext.net>
Date:   Thu, 30 Mar 2017 16:00:41 -0700
Message-ID: <CAJF7t-cAtR9yp2184pUsw+w3mf-SSMW4FUY27N8+f=6u7qjx3g@mail.gmail.com>
Subject: Re: Issue with 2.11.0 and GIT_EXEC_PATH with multiple entries
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Really?  My config has been set this way for years and it's never
caused problems before.  I have subcommands in both of those
directories and all work.

On Thu, Mar 30, 2017 at 3:57 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Nate Mueller <nate@retailnext.net> writes:
>
>> This fails for me because my GIT_EXEC_PATH is set to
>> "/Library/Developer/CommandLineTools/usr/libexec/git-core:/Users/nate/.git-exec".
>
> That environment variable is designed to hold a single path, not
> like $PATH that lists multiple places in a colon separated list.



-- 
Nate Mueller - Head of Engineering - RetailNext - 406-356-6283
