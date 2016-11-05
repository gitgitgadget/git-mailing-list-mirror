Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD2C12022D
	for <e@80x24.org>; Sat,  5 Nov 2016 00:27:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751601AbcKEA1S (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Nov 2016 20:27:18 -0400
Received: from mail-lf0-f43.google.com ([209.85.215.43]:33017 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751676AbcKEA1R (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2016 20:27:17 -0400
Received: by mail-lf0-f43.google.com with SMTP id c13so75831915lfg.0
        for <git@vger.kernel.org>; Fri, 04 Nov 2016 17:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ILg1A9gtO4Sq/kOjHsHUHrNljPxwPAdvAVaaWq8ttlc=;
        b=aQj9UUR6P5K4FWMUBYvPnE001ZzALurQfD1mwxXyDKMypewxXaznJdzBvIja9oBTZz
         3pT+8TqSIrzULvWu/dl8bzcoSxdAz4yBl+D+E1H0qosz6w8Bq2M0PqXswXo0VHjOn0jL
         LK8CfH0ZjLS1zkPDm9zd5xriWy3grUnyZFFrighkM0dLcRBJLn7J1UHq7K4wnVjwzPjc
         3Lv08vTsYr5bryACQV7BBq9Vobb2vhsWBBP0XOvqWvAPiJnUK7O/1BM1AzLGfTBt1+1h
         1IgH0SJJWiAAPqnmbWf4UHvmd+D+gpV58+RqYNu5zNJJ5p5YUrr87/IYDTqqcNUD5Jix
         cyAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ILg1A9gtO4Sq/kOjHsHUHrNljPxwPAdvAVaaWq8ttlc=;
        b=YNQKXd3HCP3nJkBQcML22fZSepCBS+gpOqbFNoVwalPyNxlwi0UahSgQGcJLkd4IA/
         nRBunmuuWWXcz1lNKll0jAXa+LGhl6qhBxhv3q09IDtSacCCk/+JXiBnROppMpeSBAEy
         +/NC74wsIOL4/M2UgFtudA/ycan2IReeu+Jbr93qxNxNP2j+SCCVxsPR7HNVxOyOrRij
         kO/5b18OhPz7YQ2SsfsgUMkRTWOaN9f6vmWqwky0Wp/yzWkDqhYVtGNTQJfN5G7Y/DB0
         xwSYzhv/RYxNwJdfkMSPH3KpLAlaGXRFGGt8rn5Szf+lRNMGlj17UZSTs36rt3EtIBzJ
         d1Aw==
X-Gm-Message-State: ABUngve34XaGjCRKu6yKz5JB0vcMDxccUiwX36m+wktLhkQUF5VNw4HKoOgDliq0POJrDYOAGzBNc1VZZ3dgdA==
X-Received: by 10.25.72.74 with SMTP id v71mr11140597lfa.130.1478305635262;
 Fri, 04 Nov 2016 17:27:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.163.84 with HTTP; Fri, 4 Nov 2016 17:27:14 -0700 (PDT)
In-Reply-To: <xmqqh97rovx9.fsf@gitster.mtv.corp.google.com>
References: <20161023092648.12086-1-chriscool@tuxfamily.org>
 <20161023092648.12086-10-chriscool@tuxfamily.org> <CACsJy8A0djR6=s0AY0tzVehYY5b1-o11uRsFdGtOUCeu4Z6Xjw@mail.gmail.com>
 <xmqqh97rovx9.fsf@gitster.mtv.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 5 Nov 2016 01:27:14 +0100
Message-ID: <CAP8UFD1q0vpXNLG-WS_9E0qNjPzqf7iGkH0k4qH10HMfnanwag@mail.gmail.com>
Subject: Re: [PATCH v1 09/19] config: add git_config_get_max_percent_split_change()
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 1, 2016 at 8:13 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>>> +               return -1;
>
> Perhaps do the usual
>
>         return error(_("..."));
>
> here?

Ok, it will be in the next version.
