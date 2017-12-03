Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35EFD20C11
	for <e@80x24.org>; Sun,  3 Dec 2017 23:41:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752488AbdLCXlG (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Dec 2017 18:41:06 -0500
Received: from mail-yb0-f172.google.com ([209.85.213.172]:39734 "EHLO
        mail-yb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752369AbdLCXlF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Dec 2017 18:41:05 -0500
Received: by mail-yb0-f172.google.com with SMTP id b73so2495423yba.6
        for <git@vger.kernel.org>; Sun, 03 Dec 2017 15:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wqhb5AvE2ntdaZE4QCbd127948fyk/l7Yc8lgGbPjN4=;
        b=h/rTlVlpTNEi27OPGMfgazD4AefQtGTcfBzlKMUKAgNMO68AazEccfpyCLwWgzNABm
         40bMVZtdO0zpzvkRweNMdr8VHTSDem8Y5MnaSLq/cgMBIayBlkloLtln9L+GCUKaps/s
         gQUf29dl1k4PKqk6MI3TkkYwGetqIPZ8XszQ9XrAqpZnKajiP4uYrmEWKZ9Ffym3MIlL
         Z/zS79OLsnZJrf/rtgGT1Vxg8wmJpYVSK/tHDXAGLrIJYl5cNKqc1wGl4lSqjh1BpDCx
         3qB20ui+L+PxpMXJ61yjlUpfRdRMmwj7kX26e+z0MP4uu0Vj+1xgsCVeHC2KyVYumt4r
         SEwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wqhb5AvE2ntdaZE4QCbd127948fyk/l7Yc8lgGbPjN4=;
        b=FLseTmrZ4iYVs9GE7G19vNjGm/oJWC+u7KG9IQKpOpLQsMU2dcnXTXa4ERwF7i9ivW
         ++O9wCVJ7Nbi0GO/v+1gJ06NvWSHJB/7m0TKgubT8c8XoDhVDj40bwGx+Xuu6+7SeqI+
         dCr6zu/irjM6v3OixRlbknKaUpdxeJK1cO0Knq/7b0260ws1P2cyOJLo8Q/vv7J+suzK
         Egrc6R5ksGaejnWQHs3hGbQILKxPrCTftqQ1vXlpEVa9Xwn9wAmo9YEPYrd320A4CwcL
         9/isXhKojYo38//tqauTP6cQbVEo9lvifL80YLkvjfaKW/ZvT2kkAjZ2uXRpqOE+eiKt
         K/FA==
X-Gm-Message-State: AKGB3mJ7eRwPzEckRocQAY+QCJHAFwB8Hzt6lPbCFAnbjeMpFdW/BVYi
        HkUKFk5KSif56EFrzlYLlN9HpqLF8t6v5kqO4Fc=
X-Google-Smtp-Source: AGs4zMaveR0bFHhtSG3pRVdKovXYMG69hxdu8YIYnxUW86EZxB95zE331hDhFUhWxO+RyGsc5ENqOui3NY3sOgL0KyI=
X-Received: by 10.37.55.75 with SMTP id e72mr3225083yba.8.1512344464940; Sun,
 03 Dec 2017 15:41:04 -0800 (PST)
MIME-Version: 1.0
Received: by 10.129.135.70 with HTTP; Sun, 3 Dec 2017 15:41:04 -0800 (PST)
In-Reply-To: <874lp7v5du.fsf@evledraar.booking.com>
References: <20171202170220.10073-1-second.payre@gmail.com> <874lp7v5du.fsf@evledraar.booking.com>
From:   Nathan PAYRE <second.payre@gmail.com>
Date:   Mon, 4 Dec 2017 00:41:04 +0100
Message-ID: <CAGb4CBUY0QVOHqAFDi6kSVmK48PzKKTuXR2F_Nr+6cHHUhxBzQ@mail.gmail.com>
Subject: Re: [PATCH] send-email: extract email-parsing code into a subroutine
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Ryan Anderson <ryan@michonline.com>, e@80x24.org,
        Junio C Hamano <gitster@pobox.com>,
        Nathan Payre <nathan.payre@etu.univ-lyon1.fr>,
        Matthieu Moy <matthieu.moy@univ-lyon1.fr>,
        Timothee Albertin <timothee.albertin@etu.univ-lyon1.fr>,
        Daniel Bensoussan <daniel.bensoussan--bohm@etu.univ-lyon1.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've tested your code, and after few changes it's works perfectly!
The code looks better now.
Thanks a lot for your review.

2017-12-03 23:00 GMT+01:00 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@g=
mail.com>:
>
> On Sat, Dec 02 2017, Payre Nathan jotted:
>
>> From: Nathan Payre <second.payre@gmail.com>
>>
>> The existing code mixes parsing of email header with regular
>> expression and actual code. Extract the parsing code into a new
>> subroutine 'parse_header_line()'. This improves the code readability
>> and make parse_header_line reusable in other place.
>>
>> Signed-off-by: Nathan Payre <nathan.payre@etu.univ-lyon1.fr>
>> Signed-off-by: Matthieu Moy <matthieu.moy@univ-lyon1.fr>
>> Signed-off-by: Timothee Albertin <timothee.albertin@etu.univ-lyon1.fr>
>> Signed-off-by: Daniel Bensoussan <daniel.bensoussan--bohm@etu.univ-lyon1=
.fr>
>> ---
>>
>> This patch is a first step to implement a new feature.
>> See new feature discussion here: https://public-inbox.org/git/2017103022=
3444.5052-1-nathan.payre@etu.univ-lyon1.fr/
>>
>>  git-send-email.perl | 106 +++++++++++++++++++++++++++++++++++++++------=
-------
>>  1 file changed, 80 insertions(+), 26 deletions(-)
>>
>> diff --git a/git-send-email.perl b/git-send-email.perl
>> index 2208dcc21..98c2e461c 100755
>> --- a/git-send-email.perl
>> +++ b/git-send-email.perl
>> @@ -715,41 +715,64 @@ EOT3
>>       if (!defined $compose_encoding) {
>>               $compose_encoding =3D "UTF-8";
>>       }
>> -     while(<$c>) {
>> +
>> +     my %parsed_email;
>> +     while (<$c>) {
>>               next if m/^GIT:/;
>> -             if ($in_body) {
>> -                     $summary_empty =3D 0 unless (/^\n$/);
>> -             } elsif (/^\n$/) {
>> -                     $in_body =3D 1;
>> -                     if ($need_8bit_cte) {
>> +             parse_header_line($_, \%parsed_email);
>> +             if (/^\n$/i) {
>> +                     while (my $row =3D <$c>) {
>> +                             if (!($row =3D~ m/^GIT:/)) {
>> +                                     $parsed_email{'body'} =3D $parsed_=
email{'body'} . $row;
>> +                             }
>> +                     }
>> +             }
>> +     }
>> +     if ($parsed_email{'from'}) {
>> +             $sender =3D $parsed_email{'from'};
>> +     }
>> +     if ($parsed_email{'in_reply_to'}) {
>> +             $initial_reply_to =3D $parsed_email{'in_reply_to'};
>> +     }
>> +     if ($parsed_email{'subject'}) {
>> +             $initial_subject =3D $parsed_email{'subject'};
>> +             print $c2 "Subject: " .
>> +                     quote_subject($parsed_email{'subject'}, $compose_e=
ncoding) .
>> +                     "\n";
>> +     }
>> +     if ($parsed_email{'mime-version'}) {
>> +             $need_8bit_cte =3D 0;
>> +     }
>> +     if ($need_8bit_cte) {
>> +             if ($parsed_email{'content-type'}) {
>> +                             print $c2 "MIME-Version: 1.0\n",
>> +                                      "Content-Type: $parsed_email{'con=
tent-type'};",
>> +                                      "Content-Transfer-Encoding: 8bit\=
n";
>> +                     } else {
>>                               print $c2 "MIME-Version: 1.0\n",
>>                                        "Content-Type: text/plain; ",
>> -                                        "charset=3D$compose_encoding\n"=
,
>> +                                      "charset=3D$compose_encoding\n",
>>                                        "Content-Transfer-Encoding: 8bit\=
n";
>>                       }
>> -             } elsif (/^MIME-Version:/i) {
>> -                     $need_8bit_cte =3D 0;
>> -             } elsif (/^Subject:\s*(.+)\s*$/i) {
>> -                     $initial_subject =3D $1;
>> -                     my $subject =3D $initial_subject;
>> -                     $_ =3D "Subject: " .
>> -                             quote_subject($subject, $compose_encoding)=
 .
>> -                             "\n";
>> -             } elsif (/^In-Reply-To:\s*(.+)\s*$/i) {
>> -                     $initial_reply_to =3D $1;
>> -                     next;
>> -             } elsif (/^From:\s*(.+)\s*$/i) {
>> -                     $sender =3D $1;
>> -                     next;
>> -             } elsif (/^(?:To|Cc|Bcc):/i) {
>> -                     print __("To/Cc/Bcc fields are not interpreted yet=
, they have been ignored\n");
>> -                     next;
>> -             }
>> -             print $c2 $_;
>>       }
>> +     if ($parsed_email{'body'}) {
>> +             $summary_empty =3D 0;
>> +             print $c2 "\n$parsed_email{'body'}\n";
>> +     }
>> +
>>       close $c;
>>       close $c2;
>>
>> +     open $c2, "<", $compose_filename . ".final"
>> +             or die sprintf(__("Failed to open %s.final: %s"), $compose=
_filename, $!);
>> +
>> +     print "affichage : \n";
>> +     while (<$c2>) {
>> +             print $_;
>> +     }
>> +
>> +     close $c2;
>> +
>>       if ($summary_empty) {
>>               print __("Summary email is empty, skipping it\n");
>>               $compose =3D -1;
>> @@ -792,6 +815,37 @@ sub ask {
>>       return;
>>  }
>>
>> +sub parse_header_line {
>> +     my $lines =3D shift;
>> +     my $parsed_line =3D shift;
>> +
>> +     foreach (split(/\n/, $lines)) {
>> +             if (/^From:\s*(.+)$/i) {
>> +                     $parsed_line->{'from'} =3D $1;
>> +             } elsif (/^To:\s*(.+)$/i) {
>> +                     $parsed_line->{'to'} =3D [ parse_address_line($1) =
];
>> +             } elsif (/^Cc:\s*(.+)$/i) {
>> +                     $parsed_line->{'cc'} =3D [ parse_address_line($1) =
];
>> +             } elsif (/^Bcc:\s*(.+)$/i) {
>> +                     $parsed_line->{'bcc'} =3D [ parse_address_line($1)=
 ];
>> +             } elsif (/^Subject:\s*(.+)\s*$/i) {
>> +                     $parsed_line->{'subject'} =3D $1;
>> +             } elsif (/^Date: (.*)/i) {
>> +                     $parsed_line->{'date'} =3D $1;
>> +             } elsif (/^In-Reply-To:\s*(.+)\s*$/i) {
>> +                     $parsed_line->{'in_reply_to'} =3D $1;
>> +             } elsif (/^Message-ID: (.*)$/i) {
>> +                     $parsed_line->{'message_id'} =3D $1;
>> +             } elsif (/^MIME-Version:$/i) {
>> +                     $parsed_line->{'mime-version'} =3D $1;
>> +             } elsif (/^Content-Type:\s+(.*)\s*$/i) {
>> +                     $parsed_line->{'content-type'} =3D $1;
>> +             } elsif (/^References:\s+(.*)/i) {
>> +                     $parsed_line->{'references'} =3D $1;
>> +             }
>> +     }
>> +}
>> +
>>  my %broken_encoding;
>>
>>  sub file_declares_8bit_cte {
>
> I haven't read the patches that follow. Completely untested, But just a
> diff on top I came up with while reading this:
>
> Rationale:
>
>  * Once you start passing $_ to functions you should probably just give
>    it a name.
>
>  * !($x =3D~ m//) you can just write as $x !~ m//
>
>  * There's a lot of copy/paste programming in parse_header_line() and an
>    inconsistency between you seeing A-Header and turning it into either
>    a_header or a-header. If you just stick with a-header and use dash
>    you end up with just two cases.
>
>    The resulting line is quite long, so it's worth doing:
>
>    my $header_parsed   =3D join "|", qw(To CC ...);
>    my $header_unparsed =3D join "|", qw(From Subject Message-ID ...);
>    [...]
>    if ($str =3D~ /^($header_unparsed)
>
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 98c2e461cf..3696cad456 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -717,12 +717,12 @@ EOT3
>         }
>
>         my %parsed_email;
> -       while (<$c>) {
> -               next if m/^GIT:/;
> -               parse_header_line($_, \%parsed_email);
> -               if (/^\n$/i) {
> +       while (my $line =3D <$c>) {
> +               next if $line =3D~ m/^GIT:/;
> +               parse_header_line($line, \%parsed_email);
> +               if ($line =3D~ /^\n$/i) {
>                         while (my $row =3D <$c>) {
> -                               if (!($row =3D~ m/^GIT:/)) {
> +                               if ($row !~ m/^GIT:/) {
>                                         $parsed_email{'body'} =3D $parsed=
_email{'body'} . $row;
>                                 }
>                         }
> @@ -731,7 +731,7 @@ EOT3
>         if ($parsed_email{'from'}) {
>                 $sender =3D $parsed_email{'from'};
>         }
> -       if ($parsed_email{'in_reply_to'}) {
> +       if ($parsed_email{'in-reply-to'}) {
>                 $initial_reply_to =3D $parsed_email{'in_reply_to'};
>         }
>         if ($parsed_email{'subject'}) {
> @@ -820,28 +820,10 @@ sub parse_header_line {
>         my $parsed_line =3D shift;
>
>         foreach (split(/\n/, $lines)) {
> -               if (/^From:\s*(.+)$/i) {
> -                       $parsed_line->{'from'} =3D $1;
> -               } elsif (/^To:\s*(.+)$/i) {
> -                       $parsed_line->{'to'} =3D [ parse_address_line($1)=
 ];
> -               } elsif (/^Cc:\s*(.+)$/i) {
> -                       $parsed_line->{'cc'} =3D [ parse_address_line($1)=
 ];
> -               } elsif (/^Bcc:\s*(.+)$/i) {
> -                       $parsed_line->{'bcc'} =3D [ parse_address_line($1=
) ];
> -               } elsif (/^Subject:\s*(.+)\s*$/i) {
> -                       $parsed_line->{'subject'} =3D $1;
> -               } elsif (/^Date: (.*)/i) {
> -                       $parsed_line->{'date'} =3D $1;
> -               } elsif (/^In-Reply-To:\s*(.+)\s*$/i) {
> -                       $parsed_line->{'in_reply_to'} =3D $1;
> -               } elsif (/^Message-ID: (.*)$/i) {
> -                       $parsed_line->{'message_id'} =3D $1;
> -               } elsif (/^MIME-Version:$/i) {
> -                       $parsed_line->{'mime-version'} =3D $1;
> -               } elsif (/^Content-Type:\s+(.*)\s*$/i) {
> -                       $parsed_line->{'content-type'} =3D $1;
> -               } elsif (/^References:\s+(.*)/i) {
> -                       $parsed_line->{'references'} =3D $1;
> +               if (/^(To|Cc|Bcc):\s*(.+)$/i) {
> +                       $parsed_line->{lc $1} =3D [ parse_address_line($2=
) ];
> +               } elsif (/^(From|Subject|Date|In-Reply-To|Message-ID|MIME=
-Version|Content-Type|References):\s*(.+)\s*$/i) {
> +                       $parsed_line->{lc $1} =3D $2;
>                 }
>         }
>  }
