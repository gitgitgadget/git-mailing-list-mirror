Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B73091FC43
	for <e@80x24.org>; Mon, 13 Mar 2017 18:34:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752226AbdCMSeu (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 14:34:50 -0400
Received: from mail-yw0-f182.google.com ([209.85.161.182]:33877 "EHLO
        mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751777AbdCMSes (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 14:34:48 -0400
Received: by mail-yw0-f182.google.com with SMTP id p77so64799567ywg.1
        for <git@vger.kernel.org>; Mon, 13 Mar 2017 11:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=R+y1ebDqljIFxu/AKcX7DHSYebIYUY9zmpTCzKyWaL8=;
        b=dZWR8ppiVUTDTNW4gwsoyNV4MtFxkHHcjLhhVOy8YwZlYBNzq/B2FrKcSb92C0Vgka
         Y3qvXUlKbnTEiqN/n9Nx/qM+s56twmOf3fNRu/u86W/hyL9JbkmDP3ZTqMW3O91SPlN+
         A1DnTRV57i0VnzP2mzy1oEA3hwoYdBKrndeN+kOpZc0AVRIgujV1f8BmwIlx4lLfyTJN
         xCd1Ax6ILxo+hsxabbr5FdGOeu8JPRcPnv7zZkLnViqpzuGpoLlTT+1cROfOhNU0pZ2C
         7aFtwE6N1ASn0XwMTYHp8YSSy8st3oFi6qcW0FrTQX7Iz1k+1tcarOwC4c7dRYgvJIqe
         6WSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=R+y1ebDqljIFxu/AKcX7DHSYebIYUY9zmpTCzKyWaL8=;
        b=AxnxrYNl/5TcD97SBmrqypZ41LHzuTnozVG8tCVZjbTBcu2PcOGstGH9LHA+IpLXel
         ri8v3fDWeZATgoP0vTacUl8fS46sJ4UQiV9h2Uvr/ldFzh7kKVmuN2w0qaW7gsV/ZZbi
         GicaQ4OpN+hQxW4N0KHXLdUWulJ0ALczguujK1J5tuahC0/4eeDkpi5yP6xsbe41c50I
         3rgXvgMT+mAhh8DB6k8hUIKMWMN+p3j8cE+qSU/pv15BlGKrqaGd1I5ubuMSqmf6IIxv
         8ux3Fp7misAW+ebu1DCmZsPQETL5Oq6adSXocGaQlZ0dXMMIA2h1Z+h+Aq5Es1vWM6ts
         uQBg==
X-Gm-Message-State: AFeK/H0zx3oNJAVeVICJ4HWlQqQXYrSL92xXx0dJioqvc6BJQAEqTB1wBlPL0cmA1o4eMolRwnyhmho9JhAf2w==
X-Received: by 10.37.26.7 with SMTP id a7mr1778622yba.18.1489430087329; Mon,
 13 Mar 2017 11:34:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.174.26 with HTTP; Mon, 13 Mar 2017 11:34:16 -0700 (PDT)
In-Reply-To: <20170313174804.GH26789@aiede.mtv.corp.google.com>
References: <20170304011251.GA26789@aiede.mtv.corp.google.com>
 <91a34c5b-7844-3db2-cf29-411df5bcf886@noekeon.org> <20170313174804.GH26789@aiede.mtv.corp.google.com>
From:   ankostis <ankostis@gmail.com>
Date:   Mon, 13 Mar 2017 19:34:16 +0100
Message-ID: <CA+dhYEViN4-boZLN+5QJyE7RtX+q6a92p0C2O6TA53==BZfTrQ@mail.gmail.com>
Subject: Re: RFC: Another proposed hash function transition plan
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     The Keccak Team <keccak@noekeon.org>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>, bmwill@google.com,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13 March 2017 at 18:48, Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> Hi,
>
> The Keccak Team wrote:
>
> > We have read your transition plan to move away from SHA-1 and noticed
> > your intent to use SHA3-256 as the new hash function in the new Git
> > repository format and protocol. Although this is a valid choice, we
> > think that the new SHA-3 standard proposes alternatives that may also be
> > interesting for your use cases.  As designers of the Keccak function
> > family, we thought we could jump in the mail thread and present these
> > alternatives.
>
> I indeed had some reservations about SHA3-256's performance.  The main
> hash function we had in mind to compare against is blake2bp-256.  This
> overview of other functions to compare against should end up being
> very helpful.

What if some of us need this extra difficulty, and don't mind about
the performance tax,
because we need to refer to hashes 10 or 30 years from now,
or even in the Post Quantum era?

Thanks,
  Kostis
