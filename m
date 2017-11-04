Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDA7020281
	for <e@80x24.org>; Sat,  4 Nov 2017 08:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752314AbdKDIjD (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Nov 2017 04:39:03 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:54040 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751532AbdKDIjA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Nov 2017 04:39:00 -0400
Received: by mail-io0-f177.google.com with SMTP id 189so10912625iow.10
        for <git@vger.kernel.org>; Sat, 04 Nov 2017 01:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8rSsaIT3QIURlZHiGya6xQjyDN9jcIrsmZ8r/J0D+RE=;
        b=POSvihx6n0fezIzPfm0s7bZILFCgVGzHFtiqHYsI09gnUHuz8/Dx+9T2CHJg7YhKAd
         BduSsOOpTI59njXXgRnjQIq+VRGCO9UY0JsILVzluR/Xte3Zu4n7Azb/jbOUAAR89Gpl
         z6bUEbWP9VFQdrErBrPaqjuXbuMXH4YwCiY7EllaTYSdci08s0b7F0MmfD9+3IYeR4AN
         2YBXIRSxsxwpVk0c7pHDYpBW3bgEvCsfYNd/vjb+fdyXqH4NiH+IHtbctwjv/kaJKWJu
         C/3AjuV8ORHtdQABD3gIavbTUT4YZSozwQP/lyE+gTVJiY9WhJKRtQKQLxFh0tF7POEV
         jqhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8rSsaIT3QIURlZHiGya6xQjyDN9jcIrsmZ8r/J0D+RE=;
        b=uIFA+YHA3VN4HJg2cOqh/ywLkXrH9rJWpHA/WiZBlLaywZiuKDjDS/FeawCr+dwTyz
         1LVZRAGWawgI81+lXG0Sjy3T/NhyhIgqNv6GhkZK/Os2CQSCeTN0JxTY2T4inDMIA6hp
         ef7RV7qQ/seH2D4BqyXAWKH5xiE+YZXAxZubuoyQU9aKgWHRBszxUWGIfYARIA0fc752
         xB+YISiymwM5H9rj85+gVF8rYLq2ovLV3ul/bcyNW6XE25+YtpUwub2Xtfowmw67ndub
         sV/rgiZGAq9kDR3LsQeMOzeIjZO/WF3zAR/YIXWySj7HwIXi14gsS2zcMsSA9rLg+Aw8
         lwhg==
X-Gm-Message-State: AMCzsaXlFC28QmuUM0i0ah1wHV6XKfUDd2KAGQmKv9HA4avO+Av5FVVP
        wU0CCqXt43u8mnwVx6IsABMRw19sunfpzNuliPs=
X-Google-Smtp-Source: ABhQp+SxMwbsftFDVfyGnGDDptg5rFz2R7DOhrkOM0e2G1o8/mXLcvPxAOEzQzRXKZaNgD6bI+pEpVbeQ4kCgORZiXU=
X-Received: by 10.107.180.20 with SMTP id d20mr12666139iof.116.1509784739165;
 Sat, 04 Nov 2017 01:38:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.7.10 with HTTP; Sat, 4 Nov 2017 01:38:58 -0700 (PDT)
In-Reply-To: <xmqqefpwdkf9.fsf@gitster.mtv.corp.google.com>
References: <20171019123030.17338-1-chriscool@tuxfamily.org>
 <20171019123030.17338-6-chriscool@tuxfamily.org> <xmqqefpwdkf9.fsf@gitster.mtv.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 4 Nov 2017 09:38:58 +0100
Message-ID: <CAP8UFD0MppGwD5iXNjs8y+qxpFGc2NbYE9gcqe2pmJWAt6CZfg@mail.gmail.com>
Subject: Re: [PATCH 5/6] t0021/rot13-filter: add capability functions
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

On Sun, Oct 22, 2017 at 3:46 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> Add functions to help read and write capabilities.
>> These functions will be reused in following patches.
>
> One more thing that is more noteworthy (read: do not forget to
> describe it in the proposed log message) is that the original used
> to require capabilities to come in a fixed order.
>
> The new code allows these capabilities to be declared in any order,

Yeah and I think it is good.

> it even allows duplicates (intended? shouldn't we be flagging it as
> an error?),

I think allowing duplicates is ok, as we allow duplicates in many
cases already, like duplicate command line options.
Or perhaps we should just warn?

> the helper can require a set of capabilities we do want
> to see and fail if the remote doesn't declare any one of them
> (good).

Yeah.

> It does not check if the remote declares any capability we do not
> know about (intended? the original noticed this situation and error
> out---shouldn't the more generalized helper that is meant to be
> reusable allow us to do so, too?).

I think that it is ok in general to just ignore capabilities we don't
know (as long as we don't advertise them). The protocol should work
using only the capabilities that both ends support.

Now if we just talk about testing, we might sometimes want to check
that one end sends only some specific capabilities. So in this case it
could be good if we could error out. On the other hand, if we test how
Git behaves when we advertise some specific capabilities, it might not
be a good idea to error out as it would break tests when Git learns a
new capability and advertise it.

In the specific case of rot13-filter.pl I think we are more in the
later case than in the former.

So I think it is ok to wait until we would really want to check that
one end sends only some specific capabilities, before we improve the
Packet.pm module to make it support that.

>         Side note: my answer to the last question is "it is OK and
>         even desirable to ignore the fact that they claim to support
>         a capability we do not know about", but I may be mistaken.

Yeah I agree.

>         The reasoning and the conclusion that is consistent with
>         what the code does should be described in any case.

Ok I will document all the above in the commit message.

>> +sub packet_read_capabilities {
>> +     my @cap;
>> +     while (1) {
>> +             my ( $res, $buf ) = packet_bin_read();
>> +             return ( $res, @cap ) if ( $res != 0 );
>
> The original had the same "'list eq list' does not do what you may
> think it does" issue.  This one corrects it, which is good.
>
> I am not sure if ($res != 0) is correct though.  What should happen
> when you get an unexpected EOF at this point?  The original would
> have died; this ignores and continues.

Well if there is an unexpected EOF, then packet_bin_read() returns
(-1, ""), so packet_read_capabilities() returns (-1, @cap) where @cap
contains the capabilities already received. Then
packet_read_and_check_capabilities() checks that we received all the
capabilities we expect and dies if that is not the case. If we did
receive all the capabilities, then
packet_read_and_check_capabilities() still returns -1, so the caller
may check that and die.

But yeah we could also just die in packet_read_capabilities() if $res
is -1. I will make this change.

>> +             unless ( $buf =~ s/\n$// ) {
>> +                     die "A non-binary line MUST be terminated by an LF.\n"
>> +                         . "Received: '$buf'";
>> +             }
>
> It may make sense to extract this in a small helper and call it from
> here and from packet_txt_read().

Ok, I have done this in my current version, that I plan to send soon.

>> +             die "bad capability buf: '$buf'" unless ( $buf =~ s/capability=// );
>
> This may merely be a style thing, but I somehow find statement
> modifiers hard to follow, unless its condition is almost always
> true.  If you follow the logic in a loop and see "die" at the
> beginning, a normal thing to expect is that there were conditionals
> that said "continue" (eh, 'next' or 'redo') to catch the normal case
> and the control would reach "die" only under exceptional error
> cases, but hiding a rare error condition after 'unless' statement
> modifier breaks that expectation.

Ok, I will use:

unless ( $buf =~ s/capability=// ) {
        die "bad capability buf: '$buf'" ;
}

>> +             push @cap, $buf;
>> +     }
>> +}
>> +
>> +sub packet_read_and_check_capabilities {
>> +     my @local_caps = @_;
>> +     my @remote_res_caps = packet_read_capabilities();
>> +     my $res = shift @remote_res_caps;
>> +     my %remote_caps = map { $_ => 1 } @remote_res_caps;
>
> FYI:
>
>         my ($res, @remote_caps) = packet_read_capabilities();
>         my %remote_caps = map { $_ => 1 } @remote_caps;
>
> may be more conventional way.

Yeah I will use what you suggest.

>> +     foreach (@local_caps) {
>> +             die "'$_' capability not available" unless (exists($remote_caps{$_}));
>> +     }
>
> It is good that we can now accept capabilities in any order and
> still enforce all the required capabilities are supported by the
> other side.  It deserves a mention in the proposed log message.

Ok, will add one.

>> +     return $res;
>> +}
>> +
>> +sub packet_write_capabilities {
>> +     packet_txt_write( "capability=" . $_ ) foreach (@_);
>> +     packet_flush();
>> +}
>> +
>>  print $debug "START\n";
>>  $debug->flush();
>>
>>  packet_initialize("git-filter", 2);
>>
>> -( packet_txt_read() eq ( 0, "capability=clean" ) )  || die "bad capability";
>> -( packet_txt_read() eq ( 0, "capability=smudge" ) ) || die "bad capability";
>> -( packet_txt_read() eq ( 0, "capability=delay" ) )  || die "bad capability";
>> -( packet_bin_read() eq ( 1, "" ) )                  || die "bad capability end";
>> +packet_read_and_check_capabilities("clean", "smudge", "delay");
>> +packet_write_capabilities(@capabilities);
>
> Neither the original nor the rewrite ensures that @capabilities we
> ask to the other side to activate is a subset of what the other side
> actually declared.
>
> Fixing this is a bit more involved than "refactor what we have", but
> probably is part of "refactor so that we can reuse in other
> situations".  You'd want to return the list of caps received from
> packet_read_and_check_capabilities() and make sure @capabilities is
> a subset of that before writing them out to the other side to
> request.

Ok, I will add that too.

Thanks.
