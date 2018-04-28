Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 441311F428
	for <e@80x24.org>; Sat, 28 Apr 2018 21:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752047AbeD1V1u (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Apr 2018 17:27:50 -0400
Received: from mail-lf0-f45.google.com ([209.85.215.45]:36653 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752014AbeD1V1t (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Apr 2018 17:27:49 -0400
Received: by mail-lf0-f45.google.com with SMTP id w8-v6so7439108lfe.3
        for <git@vger.kernel.org>; Sat, 28 Apr 2018 14:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=saville-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nsXwhSKsLBa2x38peNpCkAyy2DwxIeedD4mAqqs4Gt0=;
        b=Z+4QO9dUNQeEYdh+qYXQIFX2cenIltttXYsSLrTYhRFxv7irCxIPJzRgONEk9Lt6qJ
         zfgb2x2oKrgvGcDcLetC76PPWzuoJ2utYx6qHvV8IfbIRDRrfTDZYwEEuiO9lOrALoSb
         3iVMDZ6NzZiRsCIVzOGvPPAyrS2CmCGnWU/sR/+voCKOQ3PBL4yJ4lv0bvdmivs86O0N
         nVROSI506hrNLE6EKVcoUiy/Wc0PWf1Eu8vUpDcXBMZ6y96tELC8hVmogAasB7RnTekC
         B75ATQMosD6+zvsjI9WDbQ+O2TRcNiCf9IbxCdpgrJPy2kn97BQy1zPopauY6LXBJGcE
         sXIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nsXwhSKsLBa2x38peNpCkAyy2DwxIeedD4mAqqs4Gt0=;
        b=IdfoY29764gJdzCsrCivHm71aJjZBVojcYRvMKPGuSXi17H19iLDSevPe0eEAGZjRd
         ze5PnHPhhXMudafX5Q0FCwjAU0MBwhqSsaGtnys0PlIl69t9B/JkhUChT8RZTDnS80Es
         0apeUwJ903x+yGz9IVMHgUukU6zICDcvS1MYCZWmFHQOL4T99cEobK0OjixsGgtf+naH
         BeaZT3mBQ3BIjA0ZnvPkzOW32ZgYqbWSFfg3CBdF0rdWZ3BqI5IiOIFoxp15HoHLX8Y6
         nSjAsHjw8t1PvOs8nc20NjUnVOg+MR24AyEmbml2NpUUfQ5hHcdVL3PdL3JlJ3h5PnmS
         7RYw==
X-Gm-Message-State: ALQs6tDtTaG4EOcL2+KdMz+yY1yrJVWNJOWoSxTIZs8c7MDitLCzNu2t
        +zsKoXLhvigI11tEXrPZPWvooJonOuC7t0McKIUgFqD5
X-Google-Smtp-Source: AB8JxZpT2SSoPGx8JwpvRpUrgw1NRZHJDwH8MvoJ0HcR4h8LIbg/f+Q1s6T6NMtU44Un8a0ZS1D6ZzV5ZU+UaRbTItY=
X-Received: by 2002:a2e:1288:: with SMTP id 8-v6mr4589594ljs.137.1524950867622;
 Sat, 28 Apr 2018 14:27:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:9ecc:0:0:0:0:0 with HTTP; Sat, 28 Apr 2018 14:27:26
 -0700 (PDT)
In-Reply-To: <CAKk8isq9wXLpMJxT4SHzAtj6abm6phH4G-XjfUY4=0V6g3XxdQ@mail.gmail.com>
References: <xmqqbme51rgn.fsf@gitster-ct.c.googlers.com> <20180428182728.21696-1-wink@saville.com>
 <CAKk8isq9wXLpMJxT4SHzAtj6abm6phH4G-XjfUY4=0V6g3XxdQ@mail.gmail.com>
From:   Wink Saville <wink@saville.com>
Date:   Sat, 28 Apr 2018 14:27:26 -0700
Message-ID: <CAKk8ispsPehLkVwWqtUq7rhxeBvn0+Xhn9VWhbYJjjZgy8WLPw@mail.gmail.com>
Subject: Re: [RFC PATCH v3] Teach remote add the --remote-tags option
To:     Git List <git@vger.kernel.org>
Cc:     Wink Saville <wink@saville.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I forgot to mention that I added the code to error out
if --remote-tags is used with "tracking" (-t | --track) or
mirror:
  +       if ((fetch_tags == TAGS_SET_REMOTE) && mirror)
  +               die(_("specifying --remote-tags makes no sense with
--mirror"));
  +       if ((fetch_tags == TAGS_SET_REMOTE) && track.nr)
  +               die(_("specifying --remote-tags makes no sense with
-t or --track"));
