Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4465920372
	for <e@80x24.org>; Fri,  6 Oct 2017 20:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752328AbdJFU17 (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 16:27:59 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:54334 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751484AbdJFU16 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 16:27:58 -0400
Received: by mail-qk0-f182.google.com with SMTP id n5so16808114qke.11
        for <git@vger.kernel.org>; Fri, 06 Oct 2017 13:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=E19Ivluig8tkFQoZc4iI2CbjKJoNSCcHM87tx0rFtms=;
        b=vEttAxDF0CMAu8FaI4Pju5iDWCIX5h3DI6W8d50wY2R59c6PumkgE5KAq8hepRQPAC
         eE2ZltTZFFX4BgouJM93u/PfUx9Usln1WzaBrF5dNYO1kKIR9hWcAN/UpP2Dgdu73WZF
         V6JPcBAepDOdh7xOXCKz4IceXh4meXifvUa81U2apeSLeaPckKdwiOuqqM/q8WHiFUpu
         neGsBZRAKPXwxyZnw7WbAPkRmflXU3sZVfqpRBI2LYsqM5ZewJPcoAd+W6VhHWC+NgAv
         mgAvc0jkN3guoYMAnpGJCZHWza2XHCrqs7J+FtXM9JBB92ScbnfnXZcGPtkiXpWgIy9w
         2TyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=E19Ivluig8tkFQoZc4iI2CbjKJoNSCcHM87tx0rFtms=;
        b=GxnqNP9suBQFlNOyynIjR7BcanZd9kNvEgDa0O55uErgLMAieTToJfZWtGLOg4IToO
         rokPMIK6fEcEJq/QFbn/4RodQGeam3qojiIjR+vL/WA4aFj7Ipt702Nvof3TYFp0Xsbh
         Ih48kXu6g18C26+ae91fcosMl4Tp+eoTqIM+UT8LzG2jqONYUok75pjIsir0y2BmUQDY
         KpqQczoMrAe5xfczopUdvDRdjImeTBdMs8Sa0q4s9BZuHikWoOSTm5h5GNi7WBO1k/Ox
         AIK0QQ1jAVlR2UvM6EZ2uUnf3wmdM3m4ts/Jqi4g8IBr1uDQvu/RdkKiXJtmjVkOH4y7
         wZNA==
X-Gm-Message-State: AMCzsaUQTwlLHDqqebRAXtZg/v0ubGoRjKl60s+NN/BEjiMYJwj9VChF
        q1BxPauJEfox0HFaod4S0Qcuupm3AltqtJEZDLbNiA==
X-Google-Smtp-Source: AOwi7QBD+6NspgadXFWULc8Am90GA1wTVdsDMWtbZYb/r06vl9bcpqz+zwr9eaAzWMlOLROdrtMbflQbXQip30fPgSE=
X-Received: by 10.55.33.203 with SMTP id f72mr108493qki.176.1507321677227;
 Fri, 06 Oct 2017 13:27:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.46 with HTTP; Fri, 6 Oct 2017 13:27:56 -0700 (PDT)
In-Reply-To: <CAN0heSo28RYmZKxY4UXq9ewVgYGJCXGf-6KSzkOB-enZppv5qg@mail.gmail.com>
References: <20170926235627.79606-1-bmwill@google.com> <20171003201507.3589-1-bmwill@google.com>
 <20171003201507.3589-4-bmwill@google.com> <20171006090907.gbsgygulzj3bgqrg@ruderich.org>
 <xmqq4lrcwr5c.fsf@gitster.mtv.corp.google.com> <CAN0heSrWekXdzqzhL3Lk37YOGPHUdKCDU85t3hJgqK7PSVBZ_g@mail.gmail.com>
 <xmqqr2ugv5om.fsf@gitster.mtv.corp.google.com> <CAN0heSo28RYmZKxY4UXq9ewVgYGJCXGf-6KSzkOB-enZppv5qg@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 6 Oct 2017 13:27:56 -0700
Message-ID: <CAGZ79kYnhxZs0ptpuiSuBhwYBfOm8NiK4a15Zwas6vbjWWZukA@mail.gmail.com>
Subject: Re: [PATCH v3 03/10] protocol: introduce protocol extention mechanisms
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Simon Ruderich <simon@ruderich.org>,
        Brandon Williams <bmwill@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Bryan Turner <bturner@atlassian.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I might be naive in thinking that protocol.version could be removed or
> redefined at our discretion just because it's marked as "experimental".

Well the redefinition might very well occur, when we now say "set to v1
to test v1 and fallback to v0 otherwise", but long term we want a white
or black list or some other protocol selection strategy encoded in this
configuration (we would not want to introduce yet another config to work
around the initial "failed experiment", would we?)

And hence I would be careful how we define the meaning of
protocol.version now.

For example we could instead now claim "protocol.version is a whitelist
of protocol versions, order is not specified. The only guarantee we're willing
to give is that no protocol is used that is not on the list".

Later we may want to either add another variable '.versionSelectionStrategy'
that helps out there or we'd just say protocol.version tries to select
the leftmost (first) protocol that both ends support.

All I was trying to say initially is that "we may try (one of) protocol.version,
but fall back to whatever (currently v0)" is too broad. We'd need to redefine
it shortly in the foreseeable future already.
