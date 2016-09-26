Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04F96207EC
	for <e@80x24.org>; Mon, 26 Sep 2016 21:14:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941582AbcIZVO1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 17:14:27 -0400
Received: from mail-it0-f43.google.com ([209.85.214.43]:35039 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753027AbcIZVO0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 17:14:26 -0400
Received: by mail-it0-f43.google.com with SMTP id r192so86937465ita.0
        for <git@vger.kernel.org>; Mon, 26 Sep 2016 14:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=31UIbhyIDiNrCP20WmBGwQ3bioESjyRqab619NeVqhA=;
        b=Ghjey4CTq8DJSVxxHgB2vDt7AoQcPbU5k3IasteCm7AMGmBuJgiFW9PkFBAdSKq2O4
         WppTQxMgKKDq2ZBL4WmL8u71kUlp0UatzWra6nMMLxkoBw+TGWxv8WymbCpfUPE4eXNI
         ubAFnR4kjj0fuoXtILWkpocxEF1MqtT4Cn47DWOSAbhcbvA+eBBVusoSQ9KuDWfQTE0P
         y9YeX2gMUVKGpkV67rXy0vUH1V1nifW814duF4KUJu9W7cit8BHl92BK5XzwzbUddCaZ
         4f7IOigYanT+Ngqf+jvQ49CooxsOaVVd5Tu/zuRnCcap6HWgMzzOM2S8sUmp3bReKRzE
         ySQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=31UIbhyIDiNrCP20WmBGwQ3bioESjyRqab619NeVqhA=;
        b=lOsSOO2zMbdAQFIjcZAfOuG2qxIS1L12M6S8puNb7feFlTBctCFbLh8t4eipZudoez
         vFDS+SgHYkT6L928fl8yu6fVYkXCvpib2fahDVj2yhNcQ2b75B+1inAdTGb/7pK5k/GA
         a31XNjJ3BIuVcCLdmjfM2/fB7BmXhfmEv6v9aWeUQ6VqeuYVaujjIFmzQypbfmGCmpoX
         NIZ57reNHDJT0JZsngTGVyAfYXte5osJdgKt7m72ldUztGrWntrDVbph87t4YTRHKuSa
         VbXGF10x1v42acE4KNK6QfBazKqxubuk1vmRsAvexZo7K1XgfbSTEISvAbsbLdHBT3Zh
         sYTQ==
X-Gm-Message-State: AA6/9RnHZagt5aoVZ/qM2NEbKfu1gd4oK+zgVmsqCK+Njv98FE7lZ9bQoyxMd1j5/ts93fJ82OiuAE9fNI6vrgqf
X-Received: by 10.36.92.196 with SMTP id q187mr60483itb.33.1474924465895; Mon,
 26 Sep 2016 14:14:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.173.98 with HTTP; Mon, 26 Sep 2016 14:14:25 -0700 (PDT)
In-Reply-To: <xmqq37kmqt4a.fsf@gitster.mtv.corp.google.com>
References: <20160926193553.32631-1-sbeller@google.com> <xmqq7f9yqu9w.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kbeq+Wznm=ChWO0tU5A_haPQ6DvKNHbK+8Y3es5OVcRag@mail.gmail.com> <xmqq37kmqt4a.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 26 Sep 2016 14:14:25 -0700
Message-ID: <CAGZ79kZmy=sx5Awh4W5gq=sW6E7HTRVOiZak834brftENZSyJw@mail.gmail.com>
Subject: Re: [PATCH] Documentation/fetch-options: emit recurse-submodules,
 jobs unconditionally
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jens Lehmann <Jens.Lehmann@web.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 26, 2016 at 1:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> After a bit more research, I think 8f0700dd33f (fetch/pull: Add the
>> 'on-demand' value to the --recurse-submodules option) is the culprit,
>> where this patch should have been squashed into, as that made the
>> both locations word for word equal.
>
> Hmph, my digging points to elsewhere.  7811d960 ("pull: Document the
> "--[no-]recurse-submodules" options", 2011-02-07)

That commit seems like it want to intentionally keep it different for
fetch and pull
(otherwise the fetch-options.txt would have been reworded there).

Rereading the actual option descriptions, I realize they are different.
(Initially I used a diff tool to see if there is aminor difference, and I was
surprised they were word for word identical; It must have been a mistake
on copying one of the option texts)

The git-pull part actually conveys pull specific information, so let's drop
this patch entirely.

> which is older
> than 8f0700dd ("fetch/pull: Add the 'on-demand' value to the
> --recurse-submodules option", 2011-03-06) seems to be the real
> change that pulled the description of recurse-submodules made in
> fetch-options into "show this only when we are not describing pull".
>
> Unfortunately it is not clear why we actively wanted to be sketchier
> when showing "git help fetch"; otherwise the change would have been
> made to the existing description there without adding a new entry to
> "git-pull.txt".
>
