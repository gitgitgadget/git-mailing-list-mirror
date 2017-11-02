Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1DFB20281
	for <e@80x24.org>; Thu,  2 Nov 2017 18:03:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933197AbdKBSDk (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 14:03:40 -0400
Received: from mail-qk0-f171.google.com ([209.85.220.171]:47859 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932196AbdKBSDj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 14:03:39 -0400
Received: by mail-qk0-f171.google.com with SMTP id m189so430414qke.4
        for <git@vger.kernel.org>; Thu, 02 Nov 2017 11:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=J/oB7Q4fm6Du/qVFbV8BArHDB19dK/QwUXLYam8yhDo=;
        b=XWcn3t0/xNoNFT9TSuo+F9vUDQL921eUTL7XDUQinCvQHo4j3RDJlb+T8P66KSzaDy
         HF9jn3CEKOfEseyxuj/4bKDeG18BcqCnJnuTkjtbWZ+JYDB0VhoKvWV1838tBOt5bpM6
         eQUw32OWjTvL99jx8fp013dBLBT+ZmWMPcCnnqWyJwkfA+w4NkmfdUzqqVWJqxRVL+lj
         Z9y1YizW47aKuHNs3sPpWbpyOqRUD/ovn+ZdGw/yvcz4KOmfQt+VmUDagtpcMCCOIv22
         Y06IgT55hSBJ7AhQbt616qM3LvZ4iXJiA5ETvuwFdY35bPMzFD/sly0IfMEnuLtwpQdg
         nohA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=J/oB7Q4fm6Du/qVFbV8BArHDB19dK/QwUXLYam8yhDo=;
        b=b6afcDwbth0lfAfQbzIs3wHxgnX7iOW27+h1Q19UlsxxnZDM11tOqfr4zYNfTK/Z+u
         x7MEglefVL/fpJZgE9ODzUOhXxpOyZZLQs4XEzd5y/OL6MTrIkBehQ63Q7bxYOUDB8cg
         uu4Qh6tsa1jYn2HDruIXnwi2NwKdTXu+fnm/VgZkvpHiVsT4+BW6cMMDkv34hJ44pWIa
         scmfpzrPr7aJadLqHRBJXiibRD7nZOIdh6RSEbuul/BtWTQc8W8nF4GkuEY2FGbLM1Pt
         QyHVY12Rs8QV0dEUrC0AJ9gy0xQkeYOI+WC+kPVDif1dPc/y2prLr3llcJLWm60p9p6b
         soDw==
X-Gm-Message-State: AMCzsaXtDD2zaNJ0TAzbBcwHRlirSH9AR5NWlk6x98oW+XaDtWLlNoSi
        SJCc3wtY0FhcSvDKKlHH6Bqjd3JXjxaG3Zq3pPNbXQ==
X-Google-Smtp-Source: ABhQp+Sm/hbn6gwUER9EKXgzFaFWgScK3UE9OhVuefg1lTjVLwgtud9NYTP19yOd9ByutAEdsNs5LJotR2wK3vpMXsk=
X-Received: by 10.55.33.203 with SMTP id f72mr6154434qki.176.1509645816814;
 Thu, 02 Nov 2017 11:03:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Thu, 2 Nov 2017 11:03:36 -0700 (PDT)
In-Reply-To: <20171102080111.edh5wqyklkoqkvlg@sigill.intra.peff.net>
References: <CAGZ79kbHwXpWXhUkokA9=XGN9D1YZevO_8MhbOztMXpkkHMFbg@mail.gmail.com>
 <20171101071422.c2k4plhntlgpdnbk@sigill.intra.peff.net> <CAGZ79kYKK69Xw0-2OxFpo9Q=Kv1hvw8D7YkfhMFFcgzTuevTCQ@mail.gmail.com>
 <CAGZ79kYghF6=AzL1N96fe2zixHCERXu=RpxHw2-kdUrU+j4CXw@mail.gmail.com>
 <20171102072237.wbmrzrgfyxdb3m3v@sigill.intra.peff.net> <xmqqh8udqfxe.fsf@gitster.mtv.corp.google.com>
 <20171102080111.edh5wqyklkoqkvlg@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 2 Nov 2017 11:03:36 -0700
Message-ID: <CAGZ79kZRymJxosAFOjGDzmzMk_ZxqDwdNv-V2510L2DwDdkr2Q@mail.gmail.com>
Subject: Re: On the nature of cover letters [WAS Re: [PATCH 0/6] Create Git/Packet.pm]
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>, Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 2, 2017 at 1:01 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Nov 02, 2017 at 04:48:45PM +0900, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>>
>> > If the clutter is too much, it could also go into a git-notes ref
>> > (that's not already implemented, but it seems like it would be pretty
>> > easy to teach "git am" to do that).
>>
>> FWIW, that is what I use a notes ref "amlog" for.
>
> Right, I completely forgot that you were already doing that. So jumping
> to the thread for a commit is basically:
>
>   $browser $(git notes --ref=amlog show $commit |
>              perl -pe 's{Message-Id: <(.*)>}{https://public-inbox.org/git/$1/t}')
>
> (Or whichever archive you prefer to use). Thanks for the reminder.
>

Thanks from my side as well. I did not pay attention when this was
introduced and see the notes ref for the first time today.

I'll incorporate that into my digging repertoire.

Thanks,
Stefan
