Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE969207EC
	for <e@80x24.org>; Fri, 23 Sep 2016 20:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761682AbcIWUtt (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Sep 2016 16:49:49 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:36196 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759174AbcIWUts (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2016 16:49:48 -0400
Received: by mail-wm0-f41.google.com with SMTP id w84so53058216wmg.1
        for <git@vger.kernel.org>; Fri, 23 Sep 2016 13:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mKltPSXbc3G9V6hBgSOdU1T1SlosuLhIGPC7LvGmHZ0=;
        b=mvJgOFklkwyDaBYKTsY8XNDp/Th4K0qM7ZFi1lgjnHXLlSHGB1/y5z1uXy5NPEiYvf
         fI5NncOw0jH3hc+J6gpy3SMD+VHQHcuWIeCylS7O6pCep8WgeAcqdDYI1VMKYLKIYLWx
         wKeboQfCrh4R7VeL0YEik+QgPIM1SdGEa9vXPwU2x/Aa7JwfbfQg+pPOqB9YjTS6wk35
         uDo+P1wXk5mIUWlT4CiQR8CMEe+Pdh2XzAG0OFVNBTpj5i5n2lluhyN/WWavKL6Gg5O4
         68EYw2fH2eKzko9VXzG9jBHx/QsKgBfdj34xAD/Zktop9uywoUPGUcFJNKkiE3NA9An/
         Iy4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mKltPSXbc3G9V6hBgSOdU1T1SlosuLhIGPC7LvGmHZ0=;
        b=QkVebMKIyMYlLhvh+qjNE5xopjwB5VBspTEbMPOjpOIm0i9q3kS9+p2LEmpgVuQ6ww
         Omc7/nB4Tylpz2skzBVa1UgxtrPeaDekybgo/DF0yv+5L3LCecdej/Deq563uJH3SrqZ
         m0lje6E0wvsvViHZ4ezZ1QmYo4wM48KW49YMiTClvuwOjpRnz60Cer3OvSXXfngZBtwQ
         OtDbSwl40sTChsSHVB6g7QtWWHvn/WRlsPUfoquCvVSRdaJ0ipf+ja0xT3rutn99XnS9
         NhfsAhvtIqEX74wSY4zhEZiCA6/PWne9vGLCCIOei1JaZUFMTKEqT3BsJneSog6jL4k3
         wtAQ==
X-Gm-Message-State: AA6/9Rl/uDOBcr/jsBmCTrUXZPvjwmBvTVenyklcTMGQmaKH6buQhyp6BQ8Jl7VHLZmnqoFXlrOVzknJTZuieMuP
X-Received: by 10.28.128.88 with SMTP id b85mr4280013wmd.2.1474663787352; Fri,
 23 Sep 2016 13:49:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.69.25 with HTTP; Fri, 23 Sep 2016 13:49:46 -0700 (PDT)
In-Reply-To: <xmqqbmze1kzt.fsf@gitster.mtv.corp.google.com>
References: <CAKoko1oacXxrSMZBvfM9X6iGDq+KcUUZnUrD2qD3X8+ze8vUXg@mail.gmail.com>
 <1474500486-101640-1-git-send-email-bmwill@google.com> <xmqqbmze1kzt.fsf@gitster.mtv.corp.google.com>
From:   Brandon Williams <bmwill@google.com>
Date:   Fri, 23 Sep 2016 13:49:46 -0700
Message-ID: <CAKoko1qZCBPx9T4WoYZc0LdDhU5bpUaGa+emFL-1RvVU4MX8Ow@mail.gmail.com>
Subject: Re: [PATCH 2/2 v2] ls-files: add pathspec matching for submodules
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 23, 2016 at 12:20 PM, Junio C Hamano <gitster@pobox.com> wrote:
> There is an interesting observation around this code.  Note that it
> is just something to keep in mind, even though I think we are in no
> position to solve this within the scope of this series, or in fact I
> am not sure if there is anything to "fix".
>
> The expectation here is that the leading part of pathspec elements
> contain path components above and outside the current working tree,
> e.g. in a superproject with a submodule at "sub/", the end-user may
> have said from the top of the superproject
>
> A saving grace is that "s*b/file" in this case is what the end-user
> is giving us, not something we internally generated.  So we can
> simply blame the end user, saying "what --recurse-submodules does is
> to (conceptually) flatten the indices of submodules into the index
> of the superproject and show the entries that match your pathspec.
> Because you gave us 's*b/file', which does match 's*b/oob/file',
> that is what you get."
>
> ;-)

Yeah I've been thinking a bit about that as well.  To me, it is
incredibly silly to
have a wildcard character in a filename (its unfortunate that its
allowed).  We can
easily do as you suggest and simply blame the user and if they do have wildcard
characters in their filenames they would just need to force the
pathspec code to
do checks literally (using the appropriate pathspec magic).  This
would just limit their
ability to use actual wildcards in their pathspecs, ie they have to
pick wildcards in their
filenames or the ability to do wildmatching.

-Brandon
