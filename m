Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF29F2018E
	for <e@80x24.org>; Fri,  5 Aug 2016 21:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S939547AbcHEVTq (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 17:19:46 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:33959 "EHLO
	mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1948619AbcHEVTm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 17:19:42 -0400
Received: by mail-io0-f172.google.com with SMTP id q83so311754586iod.1
        for <git@vger.kernel.org>; Fri, 05 Aug 2016 14:19:41 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Rdtabpw2p/8EMCu7DkT/h26xzrVNJ01w7jhub1gs8V4=;
        b=RCYlRR1EOOeExUkGeTsyiYn17baUwfLoY+gVzJxgt8trc3ygMrSONejA5fNGMeKocF
         T3t2lsVEQF4EEgDC/Q/SJYS5gt9zOLci3RPC6cohMUsbwwHHUWKdFogiqqIowuNbYiZO
         OoYY7EvtHezK3xqQyltQigKvFUesPXsjRO6XSdwsLt9mU/enwmyTSDKnF/v8CnHPQHxp
         k0Vo61cLBN/NZMMhb3EG4BDkgjO/HHrnSc3FUj78oSV2G0dnBfMA8tVgZiy5Y/JJh1oI
         Wy+z38xSyiC4bG9Mzk0v+Y0sOs4wDJ/9cq6q+9SbmucAoWg/JZoEx5DYCmX7UFTA/YiY
         CXMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Rdtabpw2p/8EMCu7DkT/h26xzrVNJ01w7jhub1gs8V4=;
        b=FzZhXhSDVSyP9Rawkia6uSA+eOvJoTyv+IjQEFqYAqErqpNA78M+/MkwiXKW5lrRdT
         VHJm9M0AjGNmWM09TkQ0dq/RNk+I74d3zHsIqxHr06ZdzJsWxbfS1UPCHnwhWw5zvz6x
         rKsTpTDuKhk6CgxZqkruxXJWSqiHjlfK0aJPX3SFS4ynFiWCiW41P0ep3+tKFYdJZgK8
         R2EngiFBbs+otUROF8TEvY7YxbnzTM+aG/62CEjEDC0FguWAnGPVLx1sm4cTyDTbHEoD
         iO/sNWvzSm09xVMG2+4pntK0Rp6U274jZFhZ7h627J09e9SVLSG+NZR+pUkDWqP6KVPs
         sbzg==
X-Gm-Message-State: AEkoouvLb1yM1W0RPo7MvStbOSNFTjcnkyeePqNQnzNddPqTwjp0up3oidY8XWlex7+2HVQRBD+NMbpH9nb9doTa
X-Received: by 10.107.178.129 with SMTP id b123mr82521578iof.83.1470431981184;
 Fri, 05 Aug 2016 14:19:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Fri, 5 Aug 2016 14:19:40 -0700 (PDT)
In-Reply-To: <xmqq60rfvsbq.fsf@gitster.mtv.corp.google.com>
References: <20160804195159.7788-1-sbeller@google.com> <20160804195159.7788-5-sbeller@google.com>
 <CAGZ79kY4YxftihTP_cNqLrVTn0wrfNd5_mb40AB-t2beyzvdLA@mail.gmail.com> <xmqq60rfvsbq.fsf@gitster.mtv.corp.google.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Fri, 5 Aug 2016 14:19:40 -0700
Message-ID: <CAGZ79kbTcHN+18z+eXx+QDOCXL9vKeGYKukQJJ+ZnxT55_8htg@mail.gmail.com>
Subject: Re: [PATCH 4/6] submodule--helper update-clone: allow multiple references
To:	Junio C Hamano <gitster@pobox.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>, mst@redhat.com,
	Jens Lehmann <Jens.Lehmann@web.de>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Aug 5, 2016 at 2:06 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>>> -               ${reference:+--reference "$reference"} \
>>> +               ${reference:+"$reference"} \
>>
>> Note how this changed the API of the submodule--helper.
>> Currently we pass in --reference $reference
>> and $reference consists of the string "--reference" and the actual
>> reference. So it looked like '--reference' '--reference=foo'
>
> So this change is a strict bugfix.  The code without this patch
> had cmd_update that places "--reference=foo" in $reference, but
> the call to "git submodule--helper" it makes added an unnecessary
> "--reference" in front of it.

I thought about rolling it as a strict bugfix; but the bug is shaded by the
inverse bug in the helper, so the user would never see an issue.

It is more a cleanup of the internal communication between the shell
script and the helper written in C. (And that communication is
supposed to not be user visible or relevant)

>
> I was wondering why there is no corresponding change to add
> "--reference" on the code that calls cmd_update().  Thanks for
> saving my time ;-)

When I wrote the patch I cared more about the while-at-it part than
the bug fix as I do not consider the bug worth to merge down to maint
or even fast tracking it as a bug fix. It's just changing the internal
communication to be clearer.

>
> Perhaps that needs to go into the log message, though.  Allowing
> multiple references is not that interesting from the POV of the
> codebase immediately after this step and only deserves a "by the
> way" mention.
>
>     Subject: submodule--helper: fix cmd_update()
>
>     cmd_update places "--reference=foo" in $reference, but the call to
>     "git submodule--helper" it makes adds an unnecessary "--reference"
>     in front of it.  The underlying "git clone" was called with two
>     command options "--reference" and "--reference=foo" because of
>     this.
>
>     While at it, prepare the code to accept multiple references, as
>     the underlying "git clone" can happily take more than one.
>
> or something like that.
>
> Needless to say, "While at it" could become a separate step, and a
> pure bugfix part may even want to become a separate and more urgent
> topic that can go to 'maint', with a test to prevent regression.

Sure. I'll do so in a reroll.
