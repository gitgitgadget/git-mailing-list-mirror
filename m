Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B67D92101E
	for <e@80x24.org>; Mon,  4 Jul 2016 23:32:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932747AbcGDXcM (ORCPT <rfc822;e@80x24.org>);
	Mon, 4 Jul 2016 19:32:12 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35640 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932666AbcGDXcK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jul 2016 19:32:10 -0400
Received: by mail-pf0-f179.google.com with SMTP id c2so64556296pfa.2
        for <git@vger.kernel.org>; Mon, 04 Jul 2016 16:32:09 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kmbCJ2UU33MmOLEyKtcgouMz9CWTp5u/7gdxZYgd1yQ=;
        b=unsAg0T/NHj7q/j9BsUqv//8Yt3WGbJaAWrTgcIf8ElzcQtiGmSKPffm4vKr49CGf2
         +s6CAawAzuoofATd+NqbZnYQXBxku9ulExKX36dk+4+FFaQK5b7fTTppRh7Gs6m6civ9
         2HIgIUiOIzMVB0JAdd1pbS1QzBx9bViEqBp+emOPVoIm7g0iS5Mh50KWB4fjMx/kKyee
         N2JtcYtQoDbFAy2hhAiFJXARVw4b2BuUrVwB2klp+gcf5poaZ7uKcZmAWlRf/diuQ1qb
         EITOZD/UG3/1ofahdJroZU4FqVEE8FMVc5laGRoQn/CfVDa0kY6A/bUwwyJqLMgCaY0s
         rjlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kmbCJ2UU33MmOLEyKtcgouMz9CWTp5u/7gdxZYgd1yQ=;
        b=kWSoG5OIfqglumWQKzrK/O2eB/VDPIEQpURZB/qT2rkMM2qP5UQM7bI+Sk9rHdEL6O
         L/kT5HMGEaLY8TUoTcoJsfRU/m9dkqWEa84NoBjjH4uTjRbvzjH11tD2opBxFTkv//gF
         6WTQ02TQncEEZwfHvGyx8XrW01Gryf88abMSUUbENDlyQRcqGWloX/7AS9e0SOA8R2iJ
         cMhFU4Z6Jn8SruuQBp2cE6bBJO0RqfE8DYIq4xaJImXMk4qS9BzukBd1xA5GylBlK9T2
         CLnsXTgv7vxL2+oJ6HXhndwfbvmQWxDk9PXk/yRBMcWMUesyKLlypF5h2maIp0PKSxbu
         m7uA==
X-Gm-Message-State: ALyK8tIiLqKqR2RM4SQYxi1cdQS5L/ATztoEJo+6klXmC3IIUCMBrn8M6rmP2IL/3/hd830zVzFTwpcExokopw==
X-Received: by 10.98.10.25 with SMTP id s25mr26683444pfi.44.1467675129195;
 Mon, 04 Jul 2016 16:32:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.66.126.147 with HTTP; Mon, 4 Jul 2016 16:31:49 -0700 (PDT)
In-Reply-To: <CAH_OBieNO-fSW-ncsezZ5KG2c80fY-rUU6OPGgw0RJMGcpi+KQ@mail.gmail.com>
References: <CAH_OBieCcx0_=vuZgoJ8GrZhhReEAhnjrz2pQwbwGgPFww4JmQ@mail.gmail.com>
 <20160704203946.3ac8d3205c08bfaee9a93a46@domain007.com> <CAH_OBie4dUB8WXfmKhLaezVKi0=LhnFw=wKJO1c3oUMA7VkYdw@mail.gmail.com>
 <20160704212926.919a267706a6fa5791c47726@domain007.com> <CAH_OBieUYZTi+8W-m1TVVDstzF2vg1VuYQsd9Ka_uDoRYRY5rg@mail.gmail.com>
 <87eg79qcld.fsf@linux-m68k.org> <CAH_OBieNO-fSW-ncsezZ5KG2c80fY-rUU6OPGgw0RJMGcpi+KQ@mail.gmail.com>
From:	shawn wilson <ag4ve.us@gmail.com>
Date:	Mon, 4 Jul 2016 19:31:49 -0400
Message-ID: <CAH_OBidRkhGZ2yjAxGkvw=36PLtOACvHFuyKZxFZruTAtDwxiQ@mail.gmail.com>
Subject: Re: split directories into branches
To:	Andreas Schwab <schwab@linux-m68k.org>
Cc:	Konstantin Khomoutov <kostix+git@007spb.ru>,
	Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

correction

On Mon, Jul 4, 2016 at 7:30 PM, shawn wilson <ag4ve.us@gmail.com> wrote:

> shopt -s extglob; declare -a f=(!(cookbooks)); git filter-branch
> --tree-filter "mkdir -p cookbooks/base_sys && mv ${f[@]}
> cookbooks/base_sys"
>
