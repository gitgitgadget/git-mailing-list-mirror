Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA5D620281
	for <e@80x24.org>; Sun,  5 Nov 2017 12:50:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752417AbdKEMul (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Nov 2017 07:50:41 -0500
Received: from mail-io0-f169.google.com ([209.85.223.169]:51921 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752402AbdKEMuk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Nov 2017 07:50:40 -0500
Received: by mail-io0-f169.google.com with SMTP id b186so12973861iof.8
        for <git@vger.kernel.org>; Sun, 05 Nov 2017 04:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XDzn6tHNQpViWoG3wfTVpDbpGlpIpoQY9t6fVS6lFrc=;
        b=l1GSwN8ZKy0fPKSw4SdsuxsctJerJJ8A9YAKF8KQiMHqy8Z3ONahR1v/BFfX+vyBz2
         EoSFGN3DNxMFBtH97IW9yBaFr9oSsqGsBQTu02EM5SKmbM65isAIK3nidUDo5Y5AYKLN
         UqDDs5lxT2LWohQHimbdkC2QIeC0uKHXpj6hxna+Q1cgqbwfv3aejwKM3b+Xj/Hdcafq
         mfCBPDR9kPK4yxERO1csMyIyPYKpBHFjYxsGzt1O8heatLEu2cj0iJfpJK8tS6VfDlch
         ftEOG0ke3MeSIFPL6O78r6ILo6LSDZkAvLDwZB9+ul5e4TVM28wL3XzZAKmLO4YKXkyg
         +r9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XDzn6tHNQpViWoG3wfTVpDbpGlpIpoQY9t6fVS6lFrc=;
        b=TC/qZSj5H/MTJIye5Lg5pueUUTFV3FXnG93tqDaZ/JnCfD0plcon9ndjNGjPO0pdy5
         IZyQDM88kf9otUHFzcS4xsojTWjpjDIU14PKp6+f6X3QaJlOhBbBiHparPyX40Ty8aF3
         Tipylr1EW5YNdXgX0C8rmDAxMlj8ynMsV/EJaVTXHdx96w4qz1z7dqKTAec4jhVWiMzK
         wJuwund1tNh+86vKqAyYcm1GjKYmoT+NES1DmMeOboyXhXhinSzc0KjXOmQAFOJFd9ex
         12mO77+55aQ1LiRTPhf/1HNn+b5kYWYxX447PZmc5wo+h41cGym/T9k4uJVreBdPlbbG
         xrvQ==
X-Gm-Message-State: AMCzsaVO+OrGCm3pWy7XcPdxrV4zzkChrrRWw9nfriLeJB2Unqke0Iet
        WAVvUBbn+UAJPS0SATHHcMl2Xk8Tt8l5AC6hPQ4=
X-Google-Smtp-Source: ABhQp+Rk8Y744ESCN5qtP0KAwdDXuw/BXbq7YrnKZwJF3dBymt1pXDPcmO5P+cArAuevsxQK+NvISmPTo7biiBUOvZQ=
X-Received: by 10.107.50.85 with SMTP id y82mr16464172ioy.67.1509886239447;
 Sun, 05 Nov 2017 04:50:39 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.7.10 with HTTP; Sun, 5 Nov 2017 04:50:38 -0800 (PST)
In-Reply-To: <xmqq4lqsf17n.fsf@gitster.mtv.corp.google.com>
References: <20171019123030.17338-1-chriscool@tuxfamily.org>
 <20171019123030.17338-2-chriscool@tuxfamily.org> <xmqq4lqsf17n.fsf@gitster.mtv.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 5 Nov 2017 13:50:38 +0100
Message-ID: <CAP8UFD2VxrhhJhiZLPFz6JDGVjuUdyAHTB8c++eNeoxVMAhhyw@mail.gmail.com>
Subject: Re: [PATCH 1/6] t0021/rot13-filter: refactor packet reading functions
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
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

On Sun, Oct 22, 2017 at 2:58 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> To make it possible in a following commit to move packet
>> reading and writing functions into a Packet.pm module,
>> let's refactor these functions, so they don't handle
>> printing debug output and exiting.
>>
>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>> ---
>>  t/t0021/rot13-filter.pl | 12 ++++++++----
>>  1 file changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/t/t0021/rot13-filter.pl b/t/t0021/rot13-filter.pl
>> index ad685d92f8..e4495a52f3 100644
>> --- a/t/t0021/rot13-filter.pl
>> +++ b/t/t0021/rot13-filter.pl
>> @@ -60,8 +60,7 @@ sub packet_bin_read {
>>       my $bytes_read = read STDIN, $buffer, 4;
>>       if ( $bytes_read == 0 ) {
>>               # EOF - Git stopped talking to us!
>> -             print $debug "STOP\n";
>> -             exit();
>> +             return ( -1, "" );
>>       }
>>       elsif ( $bytes_read != 4 ) {
>>               die "invalid packet: '$buffer'";
>> @@ -85,7 +84,7 @@ sub packet_bin_read {
>>
>>  sub packet_txt_read {
>>       my ( $res, $buf ) = packet_bin_read();
>> -     unless ( $buf eq '' or $buf =~ s/\n$// ) {
>> +     unless ( $res == -1 or $buf eq '' or $buf =~ s/\n$// ) {
>>               die "A non-binary line MUST be terminated by an LF.";
>>       }
>>       return ( $res, $buf );
>> @@ -131,7 +130,12 @@ print $debug "init handshake complete\n";
>>  $debug->flush();
>>
>>  while (1) {
>> -     my ( $command ) = packet_txt_read() =~ /^command=(.+)$/;
>> +     my ( $res, $command ) = packet_txt_read();
>> +     if ( $res == -1 ) {
>> +             print $debug "STOP\n";
>> +             exit();
>> +     }
>> +     $command =~ s/^command=//;
>>       print $debug "IN: $command";
>>       $debug->flush();
>
> This was not an issue in the old code which died upon unexpected EOF
> inside the lowest-level helper packet_bin_read(), but now you have
> one call to packet_bin_read() and many calls to packet_txt_read()
> whose return value is not checked for this new condition you are
> allowing packet_bin_read() to return.  This step taken alone is a
> regression---let's see how the remainder of the series updates the
> callers to compensate.

Yeah, in the new version I will send really soon now, I have made a
number of changes to check the return value for the EOF condition.

> I initially thought that it may be more Perl-ish to return undef or
> string instead of returning a 2-element list, but this code needs to
> distinguish three conditions (i.e. a normal string that is 0 or more
> bytes long, a flush, and an EOF), so that is not sufficient.  Perl
> experts on the list still may be able to suggest a better way than
> the current one to do so, but that is outside the scope of this
> refactoring.

Yeah I can't think of a better way either.

Thanks.
