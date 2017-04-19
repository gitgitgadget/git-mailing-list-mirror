Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF3581FE90
	for <e@80x24.org>; Wed, 19 Apr 2017 19:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969179AbdDSTI2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 15:08:28 -0400
Received: from mail-yb0-f174.google.com ([209.85.213.174]:33071 "EHLO
        mail-yb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965850AbdDSTI0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 15:08:26 -0400
Received: by mail-yb0-f174.google.com with SMTP id 81so13295252ybp.0
        for <git@vger.kernel.org>; Wed, 19 Apr 2017 12:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wD0RUMAZX08OQLK3HzbJh04v7Gp4EnzB+c6vv1gCsg8=;
        b=YBuSymenVG5hltlJz1ShSgQPDhdi4KbLyXDJp3gBQQX+opAnr4vhp8iz4/LAWLarvJ
         cYdaFCj8preEMDAixHbpNQvQ8S6IMV6EmUO9OO4y4+HGM9+ReAsSuzBfrP/mzWcFBZsu
         a63Xo2P3u2ab814Y2EYaTj+SRscbhDYOAF7JkjTKKq6tTRNJABgYVsPbfZKjkY8XngGX
         gRV3sgZG188q5H96vbFsu5MOl9TQAtS4tSiIWBpx5uI5vo1LntIXUZ/gZuHBysxoH5PV
         /GCPKPLM3kwan56Qx79ehQ2kKq4jWV6MOyJDYXqVdlL9gbcdkQj6S4WDG8LjiH3R9Ugw
         GNKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wD0RUMAZX08OQLK3HzbJh04v7Gp4EnzB+c6vv1gCsg8=;
        b=tak/aqa6ThKpHUg6CR6SBr7Ozvmt7wLWKvGwaTzvYHaSN0VpLt/aEtQh8dbFdGsFqA
         8SZ6BVd6C6bqqTwKHf5a+60yHXun/EeGSBd8cl3M4DzTD2jvpIvwt2tiM3zgzKtDvKpv
         7GH1Zipne7Nb0FgW+xjB/YuB68VPmkCmOkNx2P2v86PFgkOMiaMdKt1tg7E4ihaOibna
         5pUck7NJ5tWRlSWptwq3Ehkzvy21KBiUL9LhWXZ1/0OGN4L0AbOuTm00TT/ek1kgDYhY
         zRjLUl2m1bDi2xAN0DUOD6rdyX1GXtJlFE18a80cibq8hVmCntP9kXHYzvm2Dt2rMmNW
         NImQ==
X-Gm-Message-State: AN3rC/6Ph854FNlDyiu6aGGQbVIv7iMvbjqlqTGOc9Xf/flKwvsk+dFe
        ZfNM7Qpbj890vysK92tolSQD6Kk0XYkREL8=
X-Received: by 10.84.222.134 with SMTP id x6mr5681735pls.52.1492628905371;
 Wed, 19 Apr 2017 12:08:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.153.156 with HTTP; Wed, 19 Apr 2017 12:08:24 -0700 (PDT)
In-Reply-To: <xmqqfuh5av47.fsf@gitster.mtv.corp.google.com>
References: <20170418213725.7901-1-sbeller@google.com> <20170418213725.7901-5-sbeller@google.com>
 <xmqqfuh5av47.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 19 Apr 2017 12:08:24 -0700
Message-ID: <CAGZ79kZ4oJcCD5QttcSzkfTVotust8vnBmSbp0sh5PrpqMQgJw@mail.gmail.com>
Subject: Re: [PATCHv2 4/4] builtin/reset: add --recurse-submodules switch
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Philip Oakley <philipoakley@iee.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 18, 2017 at 9:18 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> git-reset is yet another working tree manipulator, which should
>> be taught about submodules.
>>
>> One use case of "git-reset" is to reset to a known good state,
>> and dropping commits that did not work as expected.
>>
>> In that case one of the expected outcomes from a hard reset
>> would be to have broken submodules reset to a known good
>> state as well.  A test for this was added in a prior patch.
>
> When "git reset --hard" at the top-level superproject updates a
> gitlink in the index to a commit that was different from what was
> checked out in the working tree of the submodule, what should
> happen?

We reset the submodule to the commit as recorded in the superproject,
detaching its HEAD.


>  Do we reset the tip of the current branch in the submodule
> to point at the commit the index of the top-level records?  Do we
> detach the HEAD in the submodule to point at the commit?  Something
> else that is configurable?  Or do we just run "git reset --hard"
> in each submodule (which may leave submodule's HEAD different from
> what is recorded in the index of the superproject)?
>
> "... to a known good state as well" does not help answering the above.

I agree.

>
