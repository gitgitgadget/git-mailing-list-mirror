Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4AAE2095B
	for <e@80x24.org>; Mon, 20 Mar 2017 12:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754141AbdCTKns (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 06:43:48 -0400
Received: from mail-oi0-f48.google.com ([209.85.218.48]:34574 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754142AbdCTKnn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 06:43:43 -0400
Received: by mail-oi0-f48.google.com with SMTP id w81so19943121oig.1
        for <git@vger.kernel.org>; Mon, 20 Mar 2017 03:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=i+xglBgS60edD+fQkjRkyYga3KLtsUqjvSfKNmX7cSI=;
        b=NAEW5uSipMYBUgx1O7RQPGRk42K9Dz/WOG2s5D0VG7BpjYPet04zFFwVLnkqsrWl7H
         babmgDlZv2D1XbuOb9eMl40VkI5nLfNedDYrEa+NxPn8dQGQnMET60IHl8dF+koOcSxb
         PhtytpY08IzX8gaNw8xR5T88TS6q0TPVcBZDg8pEhd6hy4NVll/rVFvWXsM56mQgy+vY
         7N+OtbPcaq9IpndtkmQK5KjlnPLGZywg0eKK105dn3o3ElLHnfwdn3Gt0VY3JoueNV63
         Kj9s/KoRBnvIPuKNlB9PIlrEav0JGzj1FKUZT+0a+sM2UgQDmERIV/5560uJJC0DrKxa
         HJLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=i+xglBgS60edD+fQkjRkyYga3KLtsUqjvSfKNmX7cSI=;
        b=JMeUOp+Re1dtTTyCtRDXTTc+hcat1awsLJybwvddUuWi4dmt9DAE7mNsStcL++R/7I
         OlkKi+1EI7BeyrNTAHettDAO3HVp6Uf7lZvDoOICHeO1HCtuti98tgIzpoQGiZBHS2ho
         UIG9o/tOy0wpba0xpzQNOXKc8H79eA7CS3/0/y/6ZUgXr+B78KIGGskbs8BBelVtENxw
         fqwkRtE+WXtf9uDbcF3qjrZ5FUGp1P3Al/tEhTciwPBFIh3tb62i4M4QqStYBNMCTgOs
         0f1/5rv7NBAjqJPbYUREOE/k799/DGCyPiBMK16bAPatYuAdkKS1cyv9NFvYXtSi0ssX
         rbdw==
X-Gm-Message-State: AFeK/H3rffOwRDVDuXYIbXFz3wWGu/EgCtXUkvCr/0Uoe3am3veqgsM6JJBQBuJxDY2AQZ+kJfZL970yXn351A==
X-Received: by 10.202.182.7 with SMTP id g7mr14491657oif.175.1490006568966;
 Mon, 20 Mar 2017 03:42:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.158.84 with HTTP; Mon, 20 Mar 2017 03:42:18 -0700 (PDT)
In-Reply-To: <20170319131845.tl6o3t2nwicj2rug@genre.crustytoothpaste.net>
References: <CACsJy8Du+WWWkx3wqRJYA=cyTdro=OOD7GWaFi29=h1_9yC+LQ@mail.gmail.com>
 <vpqa88hlghm.fsf@anie.imag.fr> <20170319131845.tl6o3t2nwicj2rug@genre.crustytoothpaste.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 20 Mar 2017 17:42:18 +0700
Message-ID: <CACsJy8CxX_C8rOb3mZXHum-5w+aev=QR-r3DZ5Ad=zg8j2XxnQ@mail.gmail.com>
Subject: Re: Add configuration options for some commonly used command-line options
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 19, 2017 at 8:18 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>> OTOH, we already have almost "enable such or such option by default"
>> with aliases. People who always run "git am" with "-3" can write
>>
>> [alias]
>>         a3 = am -3
>>
>> and just run "git a3".
>
> I tend to agree here.

That's exactly what I'm doing too. But I have an impression that the
stream of new configuration for default cmdline options keeps coming
in. And this, as a gsoc microproject, encourages more to come :-/

There's also another reason I suggested this but I don't know if it
will work out yet. If we start to make parse_options() or similar to
handle some configurations, we probably can gradually move away from
the procedural callback-based config parsing to a more declarative
style like 'struct option'. That opens up new opportunities: spotting
config name typos, listing applicable variables of a command ....
-- 
Duy
