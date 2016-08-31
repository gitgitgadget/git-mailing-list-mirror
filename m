Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 814631FBB0
	for <e@80x24.org>; Wed, 31 Aug 2016 05:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752234AbcHaFEJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 01:04:09 -0400
Received: from mail-it0-f52.google.com ([209.85.214.52]:38887 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751136AbcHaFEI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 01:04:08 -0400
Received: by mail-it0-f52.google.com with SMTP id g62so76586336ith.1
        for <git@vger.kernel.org>; Tue, 30 Aug 2016 22:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Os1eRGqJGWs593ceobEroChZM1F+8lTDRacbTVCDhAk=;
        b=Thlp0tnaN2+9m4h7MueulLPxXiibHz0FN+mnDWCRO94xTLLQVaqjc9TwRQxniE3/8W
         U0tUQNc6mS+kqw5TA8/7Jk4PMRHY1y+/qXo6axsbEQ2NRbbeOEZDqEWysp1fCtj61ncw
         eID+dFc/x7KqVE9aPKSaknJH6N80QtGHg/2nPEVguQceMX8auxuO2r3OlRMKNPuy9QIb
         ZVQ7gFtf5wctPibp6CQwyWYlCgPOG6WnCG887n6/M14N9ArSab39KmPc2NtIT97aoqZU
         wj+VLIJcyXZodxo3yxEnK4B7pO5o/uFO6Uq+owkrNvzDg1P41aQgp33IURXZ6tvM1W0e
         rEbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Os1eRGqJGWs593ceobEroChZM1F+8lTDRacbTVCDhAk=;
        b=Q9m7lqHYb+UQaUrfrardagMLL0vVQBKsjasgR3LhclOha4Bm3QimSleJBzFZxJavOS
         l2rWBqP+5Tv/Dfw+DXuu1Ziz+HsQlPlqhn6dDk7gGHfMfv2XbQ6w2z87UH0kRtbcejMW
         8ArnCzfWeLYqmsnS93id7zI/x9Uu5p1eVEs+YwaxgmrSXP8JUXFMDjPqor7g+Hq5g1mB
         3jCTSVyx0MBtaMfP7lzwMCad3hHXmTRri8RzLZOJY8KFElHIK4TiRpgqJfXBOdbt6FGp
         J+IAwt3Sp69/bEvx1Hls80NgGDfZFbGTUlFuPdcC7wkmQfyfngBpYDan1G2XjPVF+TEf
         IW3Q==
X-Gm-Message-State: AE9vXwOkazeBIYoSVQH/KFAy2gYNEGDYmS5h62Dlb5vjTeO9c+5JTk968qQzjDPXwhRrEFiHNgQn72EDM1/Q/vIr
X-Received: by 10.36.88.131 with SMTP id f125mr9724973itb.46.1472619847900;
 Tue, 30 Aug 2016 22:04:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Tue, 30 Aug 2016 22:04:07 -0700 (PDT)
In-Reply-To: <CA+P7+xrokr0ZGidQFuvpN+-J_WDjkaUropcnPGVjZHafc12AnQ@mail.gmail.com>
References: <20160815215327.15682-1-sbeller@google.com> <20160815215327.15682-9-sbeller@google.com>
 <CA+P7+xpDqkTFLUJBhSwWiVnXw-iy1fmGBWzVBLmybOcPOmevBw@mail.gmail.com>
 <CAGZ79ka6nwYjBRcUKAxCqAodq=Hw6f86J0Mq6GWyKgMO_PNi4A@mail.gmail.com>
 <CA+P7+xpmyx+QsdOpS7JC1i9Z6cdsy_=MK7J_rGYiukPsqAJBVQ@mail.gmail.com>
 <CAGZ79kah4sY0NJkaqDiUqcwsCHn0SECkMjN8SoXQ8vGi6zRkuw@mail.gmail.com> <CA+P7+xrokr0ZGidQFuvpN+-J_WDjkaUropcnPGVjZHafc12AnQ@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 30 Aug 2016 22:04:07 -0700
Message-ID: <CAGZ79kYAHXct0Fz-sw0-FbN5-Mij-C4Qwak_S0mxKHyW=U5jWQ@mail.gmail.com>
Subject: Re: [PATCHv5 8/8] clone: recursive and reference option triggers
 submodule alternates
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jens Lehmann <Jens.Lehmann@web.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 24, 2016 at 4:37 PM, Jacob Keller <jacob.keller@gmail.com> wrote:

> Yes that seems reasonable.
>
> Thanks,
> Jake

I reviewed all your comments and you seem to be ok with including this
series as it is queued currently?

Thanks,
Stefan
