Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B2B12018E
	for <e@80x24.org>; Fri,  5 Aug 2016 21:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1950440AbcHEVeE (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 17:34:04 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:38387 "EHLO
	mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1950415AbcHEVd7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 17:33:59 -0400
Received: by mail-it0-f49.google.com with SMTP id j124so35960853ith.1
        for <git@vger.kernel.org>; Fri, 05 Aug 2016 14:33:58 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vu4YVPWXoxlnKRCny/trar69wmFYtbgumGZ1sCfqXS4=;
        b=QTtF8Vg07x7k4Hi7W/HHjKgO90i/Tz9FgY01MTbVtnuFZ/VwiirEj/4jhtddOu8kqs
         FZumSFJ/f7mlVJGlMRLogsyFegH753fMlwZZCV925ia0rFtezqxI7naow427kqCaJdYB
         HK5sHCG0OJ5ACKeAnUcppvw6bc/VE6NTKssP/1YruV+l7Y32tG/Tan3EV2zKF1XwaxtP
         F75p9FbKx45HfTwYJBY5qiLbD1tbOzajycxHU2YD2AdD/5siMxnSaVfngkVg3JWo+hGy
         nbWWEKrRvzvz622z3SR9fYJcJIhdtN5VQj/QRcAmW5oaa94JYZQsHkdCmHeEiyd5JrIF
         dj0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vu4YVPWXoxlnKRCny/trar69wmFYtbgumGZ1sCfqXS4=;
        b=YibGNiOBXUBgBLcgTBP4CCIK1RXH8Xwtyvm/1A+Jf5W2AlVhCOG+EyT4zbkdkql/wH
         yEYwHAzaH+z9eyPP1I39GQd+weZ3qrUwiHRgA8yHKiYj4oETxeC5pz5mWzdat1yAaZJh
         9QtuGoM6e7QSyw+RB0VlSwRRL0ImXUVxXHXayBZ7gImbTgCCTSoTBWySBCmJEJ6pdx9k
         rQJTsQJoJOVPVtOP+BY9NQ4+2Bz6caa1v7mI4NZj3tvohmcajWG2yitg+ost9DPAEVF9
         pyyuaBRM97W+sUI0BB7y7JAPsk2wEk37bagD+frHQgWIaCMgbpx841pkcKcuB3iapUqs
         lnXA==
X-Gm-Message-State: AEkoouvdiTwIZEaBhEFtIAkzB7f0eyoHFbjNFQKbf69ixjUh9hqgnFOcdOoDZ4O7fNvvTZK39ouUu6gX+I6yLhB6
X-Received: by 10.36.29.15 with SMTP id 15mr6538560itj.97.1470432838300; Fri,
 05 Aug 2016 14:33:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Fri, 5 Aug 2016 14:33:57 -0700 (PDT)
In-Reply-To: <xmqqwpjuvr6i.fsf@gitster.mtv.corp.google.com>
References: <20160804195159.7788-1-sbeller@google.com> <20160804195159.7788-5-sbeller@google.com>
 <CAGZ79kY4YxftihTP_cNqLrVTn0wrfNd5_mb40AB-t2beyzvdLA@mail.gmail.com>
 <xmqq60rfvsbq.fsf@gitster.mtv.corp.google.com> <CAGZ79kbTcHN+18z+eXx+QDOCXL9vKeGYKukQJJ+ZnxT55_8htg@mail.gmail.com>
 <xmqqwpjuvr6i.fsf@gitster.mtv.corp.google.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Fri, 5 Aug 2016 14:33:57 -0700
Message-ID: <CAGZ79kYpvzXOA_X9yYO+rBV3q5WwRnSmExU7JdwotC6cuZ_YKA@mail.gmail.com>
Subject: Re: [PATCH 4/6] submodule--helper update-clone: allow multiple references
To:	Junio C Hamano <gitster@pobox.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>, mst@redhat.com,
	Jens Lehmann <Jens.Lehmann@web.de>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Aug 5, 2016 at 2:31 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> I thought about rolling it as a strict bugfix; but the bug is shaded by the
>> inverse bug in the helper, so the user would never see an issue.
>
> Ahh, OK, because the helper accepts "--reference" "--reference=foo"
> as a OPT_STRING whose value happens to be "--reference=foo", and
> then uses
>
>         if (suc->reference)
>                 argv_array_push(&child->args, suc->reference)
>
> where suc->reference _is_ "--reference=foo" when invoking the
> underlying "git clone", it cancels out.
>
> Then it is OK.
>
> In fact there is NO bug.  It just is that update_clone subcommand
> used a convention different from others that took the whole
> --option=arg as a parameter to --reference option.  It could be
> argued that it is an API bug between git-submodule.sh and
> git-submodule--helper, but nobody else goes through this "weird"
> interface, so it is not worth splitting the patch.


I'll mention the fix of the API bug in the reroll then.
