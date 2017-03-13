Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FFB220373
	for <e@80x24.org>; Mon, 13 Mar 2017 20:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752661AbdCMUUH (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 16:20:07 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:34873 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750812AbdCMUUE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 16:20:04 -0400
Received: by mail-it0-f65.google.com with SMTP id f203so7174171itf.2
        for <git@vger.kernel.org>; Mon, 13 Mar 2017 13:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Rflvg8yeT2gl4braUFNMSk89L4aXQquv/ftYbVcgJYw=;
        b=XzJ8oEbhrb1xzzDIWfT5Lh+Jzjmxdx7F/KD7yqbOI4o0CYbYhNm5VCjTs7tokV+YHe
         LjyPfPVskrAL8KSi83PrVIZ9ynWRuYAIn5fU46FZr1dWmdi+it26RiNTIcsXZ9yO8JOG
         PltOxTJqCPDTwi5fM9tgjlwry8StNeJSWDi5AxabKUdBU6Eghk6FX6S4tMui62+dP2dR
         RcJ6DX5LSWL081B6IIL4WSsY4gigxIxiTqaawJ8Cq5ABcs5qlQenxxmFi1BcqO2YTCQ5
         6btAWHGkuenza5kOSQs7zMBPNyXUd7BsztAQgX6Bh2MGOFO3KqwTAjf/7Vlr1nz8M5zN
         LxwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Rflvg8yeT2gl4braUFNMSk89L4aXQquv/ftYbVcgJYw=;
        b=C/MB7s9HlNR5yYgJ64LvOy6Jnt2sdIwpO+yZ2/mRQlEfdWoLHQPdHMlTeRlb88bfoA
         V2WXK/Nm7hsEi6ii/IYaZKbk4FjX8GaBBdW3R/BNEgWKqDL8DO+8fdBy54ih1eXvNJwU
         R2mb9ROS9fVZ6SIHRTEQuQJdxIHiJrEHMsZRKIq5QQhEKEXUn6oUQrVVtbvQ6e8v/02P
         iapHq4ZMjQ1YEwSr1A6zrugsdXqsxW86KKhP4GP0pwfHAdjm/jG94ky1q+7VHwabLNok
         iHKjAhuRj0h5kVH+tH+swO5XrJwqTKXSk3CMynguf7DjOdDO2mVwguQu6/P5Cs9h/geC
         ONhg==
X-Gm-Message-State: AFeK/H0dmIfiCfPTwIxfX51fFg1A9m82io6LIvozpim8GAboXqLjeY6rZSv51PswioHH9494Wwc1EbCwF7KEsQ==
X-Received: by 10.36.204.137 with SMTP id x131mr12009640itf.35.1489436403574;
 Mon, 13 Mar 2017 13:20:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.136.102 with HTTP; Mon, 13 Mar 2017 13:20:02 -0700 (PDT)
In-Reply-To: <1e6a592f-7da1-8043-0b29-0bb7c8cda3f3@cwi.nl>
References: <20170301195302.3pybakmjqztosohj@sigill.intra.peff.net>
 <CA+55aFwf3sxKW+dGTMjNAeHMOf=rvctEQohm+rbhEb=e3KLpHw@mail.gmail.com>
 <20170301203427.e5xa5ej3czli7c3o@sigill.intra.peff.net> <CA+55aFz4ixVKVURki8FeXjL5H51A_cQXsZpzKJ-N9n574Yy1rg@mail.gmail.com>
 <CY1PR0301MB21073D82F4A6AB0DAD8BF1FCC4280@CY1PR0301MB2107.namprd03.prod.outlook.com>
 <xmqq1suge1jn.fsf@gitster.mtv.corp.google.com> <CY1PR0301MB2107112BCC2DECD215E70549C42A0@CY1PR0301MB2107.namprd03.prod.outlook.com>
 <20170313151322.ouryghyb5orkpk5g@sigill.intra.peff.net> <CY1PR0301MB2107B3C5131D5DC7F91A0147C4250@CY1PR0301MB2107.namprd03.prod.outlook.com>
 <CY1PR0301MB2107876B6E47FBCF03AB1EA1C4250@CY1PR0301MB2107.namprd03.prod.outlook.com>
 <20170313194848.2z2dlgpomu6e3dkh@sigill.intra.peff.net> <1e6a592f-7da1-8043-0b29-0bb7c8cda3f3@cwi.nl>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 13 Mar 2017 13:20:02 -0700
X-Google-Sender-Auth: 8m-OdCxrllx6OvCKqCqKRwDmBug
Message-ID: <CA+55aFyNi2uHwd9nzjy3dOu2L1A0jPN6AD43WKj-05km1GNtRQ@mail.gmail.com>
Subject: Re: [PATCH] Put sha1dc on a diet
To:     Marc Stevens <marc.stevens@cwi.nl>
Cc:     Jeff King <peff@peff.net>, Dan Shumow <danshu@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 13, 2017 at 1:12 PM, Marc Stevens <marc.stevens@cwi.nl> wrote:
> Indeed, I've committed a fix, and a small bug fix for the new code just now.

Unrelated side note: there may be some missing dependencies in the
build infrastructure or something, because when I tried Jeff's script
that did that "test the merge and the two parents", and used the
pack-file of the kernel for testing, I got:

  5611971c610143e6d38bbdca463f4c9f79a056a0
/home/torvalds/v2.6/linux/.git/objects/pack/pack-153bb8cd11846cf9a27ef7b1069aa9cb9f5b724f.pack

  real 0m2.432s
  user 0m2.348s
  sys 0m0.084s

  5611971c610143e6d38bbdca463f4c9f79a056a0
/home/torvalds/v2.6/linux/.git/objects/pack/pack-153bb8cd11846cf9a27ef7b1069aa9cb9f5b724f.pack

  real 0m3.747s
  user 0m3.672s
  sys 0m0.076s

  5611971c610143e6d38bbdca463f4c9f79a056a0 *coll*
/home/torvalds/v2.6/linux/.git/objects/pack/pack-153bb8cd11846cf9a27ef7b1069aa9cb9f5b724f.pack

  real 0m5.061s
  user 0m4.984s
  sys 0m0.077s

never mind the performace, notice the *coll* in that last case.

But doing a "git clean -dqfx; make -j8" and re-testing the same tree,
the issue is gone.

I suspect some dependency on a header file is broken, causing some
object file to not be properly re-built, which in turn then
incorrectly causes the 'ctx2.found_collision' test to test the wrong
bit or something.

                 Linus
