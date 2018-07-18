Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 201F91F597
	for <e@80x24.org>; Wed, 18 Jul 2018 17:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731525AbeGRRu6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 13:50:58 -0400
Received: from mail-yb0-f174.google.com ([209.85.213.174]:41102 "EHLO
        mail-yb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727635AbeGRRu5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 13:50:57 -0400
Received: by mail-yb0-f174.google.com with SMTP id s8-v6so2125695ybe.8
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 10:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9rEi3L+n6jLqzfXnKiQbMlLXIAWDxUtiCgkeNmhyrS0=;
        b=CqUgt0KnDAFbQxUxlICFg6KaalccBjPK1eUsciKQX9IPLJBrQdpnO3Y0u5j/srndrf
         3quod5G+Us8HgIe2jU/SB1lfTqSQu1uoByVsB5U1EAIGR8EQSvx0cSYrmjroG5+wQyHO
         s0WB+qvWDOVfSxfwSXNCHwCkE2KYm5pHELwr87Vjgv+T0cu1Dzgb35d1+7CdFbVxaIat
         EMMqMPpZjOnEDoOc1CM9aMLealufl76SSNIWX3DgLCEuLvQl6q//8kOFHh13MOlY/A+Z
         OL0KPMOvsm5abVUiutYuJVie9L94q0zIFbnz9y4UvUHEZ/nLGhkVEuQOPE2NOnF9JS8f
         ghAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9rEi3L+n6jLqzfXnKiQbMlLXIAWDxUtiCgkeNmhyrS0=;
        b=FVjfuzD5KjBSAt5jRW/hK3anlHWL9QtOxay/ErYE9WY4cidVblo9Gwc8EPy94RldVW
         kcpX/fhZpYJviGYQwIjSlQDgxOQasEW9FK39PMnm0UU3uONB1Tixu19YePD3t6C7F5cD
         +A9ck1Qk6rTxvoRgZeb3K0yIPqoMc/RmuhsD6LQ4k20IAJoluUpfHN+OEzlDzXE0kcSm
         Y6YTpw8F37hFzvYHoAPDr4HFnxPbxonLEZxQ+7YI+aTuInKuInfhJbOmA2fyby4ZgmyA
         0ErF8kCqkwhO/il85zfZl6D5xRbApMOkaivrRDRfRA3rlNhv89Gc6yWgN9yXtkuHt8f4
         D5Dw==
X-Gm-Message-State: AOUpUlHufmisVomnESCSRvK5dmUorsu6iqs+pc/uV+HFDWs/zwG+rRpu
        LL9hU2LMVmJ6xD63o2xJqD3QlHbLQSq7phHE/yVTJschx1M=
X-Google-Smtp-Source: AAOMgpcCoZfJC/d1SJYidwpHsxbkR89H06iz8TpyjPS2u4MVcmA/LBVCqlpnxsEpAiDm0/cLzdSCddWa1+ejpfqF01E=
X-Received: by 2002:a25:a263:: with SMTP id b90-v6mr3741102ybi.247.1531933926015;
 Wed, 18 Jul 2018 10:12:06 -0700 (PDT)
MIME-Version: 1.0
References: <1536686621.139255.1531895907281@ox.hosteurope.de>
In-Reply-To: <1536686621.139255.1531895907281@ox.hosteurope.de>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 18 Jul 2018 10:11:54 -0700
Message-ID: <CAGZ79kYZB5=_UL9g+Y4Xty8Z7Gohvvk7wdAw5P5iKzNUhR3_nw@mail.gmail.com>
Subject: Re: Receiving console output from GIT 10mins after abort/termination?
To:     webmaster@frank-wolf.org
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 17, 2018 at 11:38 PM Frank Wolf <webmaster@frank-wolf.org> wrote:
>
> Hi @ll,
>
> I hope I'm posting to the right group (not sure if it's Windows related) but I've got
> a weird problem using GIT:
>
> By accident I've tried to push a repository (containing an already
> commited but not yet pushed submodule reference).
> This fails immediately with an error of course BUT
>
> after 10 mins I get an output on the console though the command exited!?
> (... $Received disconnect from <GIT serverIP>: User session has timed out idling after 6000000 ms....)

This sounds like it is better suited for
https://github.com/git-for-windows/git/issues/new
as the error message suggests it comes from some software
bundled with GfW to make Git work on Windows.

(Gits source code doesn't contain such an error message)
