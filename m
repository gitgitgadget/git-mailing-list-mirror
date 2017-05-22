Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85B7420281
	for <e@80x24.org>; Mon, 22 May 2017 09:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757985AbdEVJ1H (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 05:27:07 -0400
Received: from mail-it0-f46.google.com ([209.85.214.46]:35215 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757390AbdEVJ1D (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 05:27:03 -0400
Received: by mail-it0-f46.google.com with SMTP id c15so148273737ith.0
        for <git@vger.kernel.org>; Mon, 22 May 2017 02:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=IpG5Os+RM8Q/rQ6HY0NmqdoKiV2c9LZqOLm3XNABDEo=;
        b=sHfPrhwKWRwJbV7oFLkoP6qcfjpjKIYJCVU3AlZmwBemSxB7x/YAzSKPnwyNnKCoPT
         xPhZxuySVgseFMoTu/tFF6aRh8qKC4y7AmF3Y4WeIMFBeMrSpp5+uqYJeAi+ndvyU7jc
         zRe0hufVEi/AuBd5mli1RWzfgjsRzkTEy8kJABb+vutpHhKh6p0dFqRIzOMTt06ok2lM
         TBw0YGBS6qcEne+fNUoKTeclDsMDxRyFX91OlxeKn29RipGdiumf3bDXRQ7dHRqrsQLn
         EKeFf+jALADFlynva5K39T6BfLkHnXVaayxwbVRwutuJdKhTTfHV9u5JthocyunR+UEs
         WFMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=IpG5Os+RM8Q/rQ6HY0NmqdoKiV2c9LZqOLm3XNABDEo=;
        b=Hobo5nUkQjCnyaYLGqU/ugx1hJHF/x/dwuOND6G3nhbGrPHxVOeVShPSqhBiYDTgEQ
         DY25JDJogAe/dbH3DxkI0+64Vi3indVDI9SO0X32I6GVWkECFrDmwiwnU/DMJGRcNMb2
         uYy3XDyidYG1BJ1imszQwRVudN0L7Dezh8Z38UoLJ80bI/y1kdOlK8PB+xma5Sj2MtgC
         MZTcsJ0KQYDh+HoRLX1B/fuq8WiDaTy6GMAIAdItr5Hp3Nkl+GpRqA25rKh+dTQQv8Hj
         qlbGlEI8nLe+Cj1EerZYt/vz8WSQzRt/YkqwU37ZIhDr547DGrdbiatU3TsquxP5YYn7
         05Wg==
X-Gm-Message-State: AODbwcCr3w69SoNAexxNdC97G9/wnY/BAbXbXGRoPmzk9yR+aLlJ2huB
        Ky4bwW06BtTMzJpaMWplI4jSQ52rnw==
X-Received: by 10.36.37.78 with SMTP id g75mr20591661itg.94.1495445222370;
 Mon, 22 May 2017 02:27:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Mon, 22 May 2017 02:26:41 -0700 (PDT)
In-Reply-To: <20170521125950.5524-1-zxq_yx_007@163.com>
References: <20170521125950.5524-1-zxq_yx_007@163.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Mon, 22 May 2017 11:26:41 +0200
Message-ID: <CACBZZX5GYV50rjg9X602JHqFPaoofH9TwDf_-r_MDu8-rmNV6Q@mail.gmail.com>
Subject: Re: [PATCH v5] send-email: --batch-size to work around some SMTP
 server limit
To:     xiaoqiang zhao <zxq_yx_007@163.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jan Viktorin <viktorin@rehivetech.com>, mst@kernel.org,
        pbonzini@redhat.com, mina86@mina86.com,
        Ramkumar Ramachandra <artagnon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 21, 2017 at 2:59 PM, xiaoqiang zhao <zxq_yx_007@163.com> wrote:
> Some email servers (e.g. smtp.163.com) limit the number emails to be
> sent per session(connection) and this will lead to a faliure when
> sending many messages.

This OK to me, the nits I had are addressed by Junio's reply.

Looking at this the Nth time now though I wonder about this approach
in general. In all your E-Mails I don't think you ever said /what/
sort of error you had from the SMTP server, you just said you had a
failure or an error, I assume you hit one of the die's in the
send_message() function. Can you paste the actual error you get
without this patch?

I wonder if something like this would Just Work for this case without
any configuration or command-line options, with the added benefit of
just working for anyone with transitory SMTP issues as well (patch
posted with -w, full version at
https://github.com/avar/git/commit/acb60c4bde50bdcb62b71ed46f49617e2caef84e.patch):

diff --git a/git-send-email.perl b/git-send-email.perl
index 8a1ee0f0d4..c2d85236d1 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1363,6 +1363,10 @@ EOF
                        die __("The required SMTP server is not
properly defined.")
                }

+               my $num_tries = 0;
+               my $max_tries = 5;
+       smtp_again:
+               eval {
                        if ($smtp_encryption eq 'ssl') {
                                $smtp_server_port ||= 465; # ssmtp
                                require Net::SMTP::SSL;
@@ -1429,6 +1433,22 @@ EOF
                        }
                        $smtp->dataend() or die $smtp->message;
                        $smtp->code =~ /250|200/ or die
sprintf(__("Failed to send %s\n"), $subject).$smtp->message;
+                       1;
+               } or do {
+                       my $error = $@ || "Zombie Error";
+
+                       warn sprintf(__("Failed to send %s due to
error: %s"), $subject, $error);
+                       if ($num_tries++ < $max_tries) {
+                               $smtp->quit if defined $smtp;
+                               $smtp = undef;
+                               $auth = undef;
+                               my $sleep = $num_tries * 3; # 3, 6, 9, ...
+                               warn sprintf(__("This is retry %d/%d.
Sleeping %d before trying again"),
+                                            $num_tries, $max_tries, $sleep);
+                               sleep($sleep);
+                               goto smtp_again;
+                       }
+               };
        }
        if ($quiet) {
                printf($dry_run ? __("Dry-Sent %s\n") : __("Sent
%s\n"), $subject);

Now that's very much a WIP and I don't have a server like that to test against.

Having worked with SMTP a lot in a past life/job, I'd say it's *very*
likely that you're just getting a /^4/ error code from 163.com,
probably 421, which would make this logic even simpler. I.e. we could
just adjust this to back-off for /^4/ instead of trying to handle
arbitrary errors.

Anyway, I'm not interested in pursuing that WIP patch, and I don't
think perfect should be the enemy of the good here. Your patch works
for you, doesn't really damage anything else, so if you're not
interested in hacking up something like the above I think we should
just take it.

But I do think it would be very good to get a reply to you / details
in the commit message about what error you get exactly in this
scenario, see if you get better details with --smtp-debug, and if so
paste that (sans any secret info like user/password you don't want to
share).

Then if we're poking at this code in the future we can maybe just fix
this in some more general fashion while keeping this use-case in mind.
