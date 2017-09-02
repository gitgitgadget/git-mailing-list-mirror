Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C2BC1F4DD
	for <e@80x24.org>; Sat,  2 Sep 2017 00:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752206AbdIBAEW (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Sep 2017 20:04:22 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:34507 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750955AbdIBAEV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Sep 2017 20:04:21 -0400
Received: by mail-pg0-f54.google.com with SMTP id t193so4526445pgc.1
        for <git@vger.kernel.org>; Fri, 01 Sep 2017 17:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=9i50Y+l2yvFq5vz/zwcl3ybYK5IGOW/bXh6rFVbXaPU=;
        b=Qfw13Ve7W2dovb4iBTaNoymzF7EGi6cyRWggYIQQucUnrf6Tmytvs1heTRSmMfzvKR
         X3r1Ce795DuJG8rPwvZ3TDrhPe2CNEavf0TAApuZOIfve/R4RMc7NeNkBOL5M7VtFios
         QuL5gFVaFzr+vYYNr3McBCruEB1iS0sa+pWhcO2+7afVzdd/Te6TcV02VjCUsopsZ5ZA
         HbQX4igBpUsSi5Y0yevxXfG15qFWPnEhqDXlYGkXn3DW/nWWzGhRmuw1gxg/StmjkvD2
         IxAO7ItJYFfjuqcz3aJToPs4q+dKbjuEsdoUnMNIVJEIH50ws3rAA+MP+u5LvMjQT2Aq
         uEaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=9i50Y+l2yvFq5vz/zwcl3ybYK5IGOW/bXh6rFVbXaPU=;
        b=lMXIJcUkDkpAHzlfXe1XrYsEx+i88FfVepp+iZyVgTARrfq/Cx3TVov4aScvoI8+RN
         aKMxUW3Z46V0z0jXSIdrSYH127NoLTapnN/A06mA6kBkZe0IPd89BNyVmqwDZPZHrl44
         9II0av6uQfv3MJmVpfJ3MGsF0PLDh783fwN3J3KrbCVuzXdL7H7OLCh1spsyhrQGwXB7
         lomBTF8VGkINbwjAUoKwnJ74OibnLnfQo5Jrpc36tcsObhoGkhI6Bkvl2LTcr1TQUU07
         75SlRsLF0vNjOWL0Z41UrWxAHz7IqGtlHGY9jZPWQcQut/USaXn7UMMwyRMG540qY+tc
         qEag==
X-Gm-Message-State: AHPjjUgcOO7QvhrwDpYn31AsZPJuLGaArVBVXjkE97kRx7Q6AgL2NE4n
        9SP3n/ApYVYHaA==
X-Google-Smtp-Source: ADKCNb5Sn1CLeSlyUJu20D9cZc+CxO/cnLnSRnPUp3R14E6/W1IPsPvwIIT3RBQ3T0vWn+JDkzHKaw==
X-Received: by 10.99.108.66 with SMTP id h63mr3865980pgc.336.1504310660307;
        Fri, 01 Sep 2017 17:04:20 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:c8a:d1f4:a5bc:2c5f])
        by smtp.gmail.com with ESMTPSA id 21sm1499622pfb.146.2017.09.01.17.04.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 01 Sep 2017 17:04:19 -0700 (PDT)
Date:   Fri, 1 Sep 2017 17:04:17 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Sebastian Schuberth <sschuberth@gmail.com>
Cc:     Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Commit dropped when swapping commits with rebase -i -p
Message-ID: <20170902000417.GE143138@aiede.mtv.corp.google.com>
References: <oo62vr$pvq$1@blaine.gmane.org>
 <CAN0heSqGfxrFTwuaxgppZTx+3U=g_Qs4PyaCBF6ddV_PbvdpTQ@mail.gmail.com>
 <CAHGBnuMC_10krsdZe2KiQ4jjiL43kogn--dWjPgca_p2xgmQMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHGBnuMC_10krsdZe2KiQ4jjiL43kogn--dWjPgca_p2xgmQMA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Sebastian Schuberth wrote:
> On Wed, Aug 30, 2017 at 8:07 PM, Martin Ågren <martin.agren@gmail.com> wrote:

>> The man-page for git rebase says that combining -p with -i is "generally
>> not a good idea unless you know what you are doing (see BUGS below)".
>
> Thanks for pointing this out again. I remember to have read this some
> time ago, but as I general consider myself to know what I'm doing, I
> forgot about it :-)

Heh.

> Anyway, this should really more explicitly say *what* you need to know
> about, that is, reordering commits does not work.

It tries to explain that, even with an example.  If you have ideas for
improving the wording, that would be welcome.

That said, ...

>> So if you agree that a "dropped commit" is a "counterintuitive result",
>> this is known and documented. Maybe the warning could be harsher, but it
>> does say "unless you know what you are doing".
>
> I'd say it's worse than counterintuitive, as counterintuitive might
> still be correct, while in my case it clearly is not. So yes, the
> warning must be harsher in my opinion. Maybe we should even abort
> rebase -i-p if reordering of commits is detected.

This sounds like a more promising approach.  If you can detect when
the rebase -i -p is going to cause trouble, then I would be all for
aborting.  If you want to be extra nice to people, you can provide a
--force escape valve to let them experience the broken behavior, but I
don't think that is necessary.

I also think a loud warning when -i -p is used even when it is not
going to cause trouble would be a valuable change.  E.g. maybe the
template that opens in the editor could say something about reordering
commits not being advisable?

E.g. I could imagine the todo list including some instructions in the
spirit of

	# git rebase --preserve-merges does not support reordering commits.
	# To attempt reordering anyway, add a line with the text "reorder".
	# It is not likely to behave as you expect.  You have been
	# warned.

Thanks,
Jonathan
