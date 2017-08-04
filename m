Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D769208B4
	for <e@80x24.org>; Fri,  4 Aug 2017 06:32:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751318AbdHDGcE (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Aug 2017 02:32:04 -0400
Received: from mail-qt0-f181.google.com ([209.85.216.181]:35496 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751259AbdHDGcD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Aug 2017 02:32:03 -0400
Received: by mail-qt0-f181.google.com with SMTP id p3so4282506qtg.2
        for <git@vger.kernel.org>; Thu, 03 Aug 2017 23:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=IH1WRB6e3tWE6ia4hSWQy0uMFXhLpsN4flusUolEw6U=;
        b=oKPevPADuLBFrFDSOmZNmzisqoLFF/WWMJVJ2gaNZTfZUxn4m2bvWjUVqrvb0TPm0c
         +OLy56GE2DAZa8ZCLmfWeK89YtFqoMVQEtlPSHQcwVH51MrTiptNB3uStYhl5MnG2yZl
         snRk5YjBDWGT6lo3BwWMeOfVL2vNij/79+aE9Tmi3WfrNMyYRayRTlqjAfhUtYpbjESZ
         T3eLKT/X32ZATVFbx+NnoQMNyasoJqS212IyhtBYtFKQXJUbkvqDyk0sQY5jGSal91kh
         dTZs1HgNrk2yP5gJxgb71jfxF5Hx3/XHjlOxBK4y5bwKIUc/VfwmIBTyzi2zJ29eFiv6
         hDGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=IH1WRB6e3tWE6ia4hSWQy0uMFXhLpsN4flusUolEw6U=;
        b=ZG+RPKcfLEwFVWxYcceLyqe9JN1Z1ylZFrjDOl0y9GilC4TBaTanufMViL5O2DPF35
         J18Mi3IzKn04WLZS1/C0JUPex3axl/Mft+O1XyodjxWKmLb4bGjQfI7l81MmuRWQfCli
         jPtekS+XH3QAZGKzV3vFHVTHJrpTt2QsSFQC1zxkn5c7TG1rT1m3pir9Sj2/dNxe6+Ie
         UFHlhaiz4qocqVilZGhAnsld1Kmq488OpHIAFaoFSqDYJZE8eFRnkc8tH9y+TxfyAlmL
         9HXi0vSI2g4jinIYJUH2Atr/MAXiy7oip4Rrj1tSlFYkgG4VeOjB7F4uyytI3/7AAB0j
         Lfqg==
X-Gm-Message-State: AHYfb5iGXhTVl05h0nYw/cAerrvVLflmXTD0wpQFg8ENnoM4Sz8WDJqo
        oTz1Dy+SRZx/FPEKyVaAbuogTmWUtw==
X-Received: by 10.237.34.75 with SMTP id o11mr1606131qtc.299.1501828322258;
 Thu, 03 Aug 2017 23:32:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.31.13 with HTTP; Thu, 3 Aug 2017 23:32:01 -0700 (PDT)
In-Reply-To: <xmqqo9rwxy8k.fsf@gitster.mtv.corp.google.com>
References: <20170803091926.1755-1-chriscool@tuxfamily.org>
 <20170803091926.1755-5-chriscool@tuxfamily.org> <xmqqo9rwxy8k.fsf@gitster.mtv.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 4 Aug 2017 08:32:01 +0200
Message-ID: <CAP8UFD3KaTEWiPmdNGmMx_5Dc+UDTWbPgeV8-=7y26-26q0Mxw@mail.gmail.com>
Subject: Re: [PATCH v5 04/40] Add Git/Packet.pm from parts of t0021/rot13-filter.pl
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 3, 2017 at 9:11 PM, Junio C Hamano <gitster@pobox.com> wrote:

>> diff --git a/perl/Git/Packet.pm b/perl/Git/Packet.pm
>> new file mode 100644
>> index 0000000000..aaffecbe2a
>> --- /dev/null
>> +++ b/perl/Git/Packet.pm
>> @@ -0,0 +1,71 @@
>> +package Git::Packet;
>> +use 5.008;
>> +use strict;
>> +use warnings;
>> +BEGIN {
>> +     require Exporter;
>> +     if ($] < 5.008003) {
>> +             *import = \&Exporter::import;
>> +     } else {
>> +             # Exporter 5.57 which supports this invocation was
>> +             # released with perl 5.8.3
>> +             Exporter->import('import');
>> +     }
>> +}
>
> This is merely me being curious, but do we want this boilerplate,
> which we do not use in perl/Git.pm but we do in perl/Git/I18N.pm?

I don't know. I copied it as I thought that we wanted to support Perl
versions starting from 5.8.0, but I am ok to remove it or to leave it
depending on what the Perl experts think (CCing AEvar) and what we
decide.

>> +our @EXPORT = qw(
>> +                     packet_bin_read
>> +                     packet_txt_read
>> +                     packet_bin_write
>> +                     packet_txt_write
>> +                     packet_flush
>> +             );
>> +our @EXPORT_OK = @EXPORT;
>
> We can see that you made sure that the only thing 05/40 needs to do
> is to use this package and remove the definition of these subs,
> without having to touch any caller by first updating the original
> implementation in 03/40 and then exporting these names in 04/40.
> Knowing that the preparation is nicely done already, it is a bit
> irritating to see that 05/40 is a separate patch, as we need to
> switch between the patches to see if there is any difference between
> the original implementation of the subs, and the replacement
> implemented in here.  It would have been nicer to have changes in
> 04/40 and 05/40 in a single patch.

Ok, I have squashed 04/40 and 05/40 together in my current version of
this series.
