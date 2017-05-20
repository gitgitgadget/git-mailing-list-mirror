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
	by dcvr.yhbt.net (Postfix) with ESMTP id C5C60201CF
	for <e@80x24.org>; Sat, 20 May 2017 07:56:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754107AbdETH4Y (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 May 2017 03:56:24 -0400
Received: from mail-it0-f52.google.com ([209.85.214.52]:35152 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751861AbdETH4X (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 May 2017 03:56:23 -0400
Received: by mail-it0-f52.google.com with SMTP id c15so129902567ith.0
        for <git@vger.kernel.org>; Sat, 20 May 2017 00:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qnx0KA3OJ/m9eZ6ov2u+gEKb+TaL+eUxISugF65jR+Q=;
        b=VuNuz2f4ota5opYvwncy+lmRP0JloXBe8uI+pfT+bHHXHRgxFO+nK9+7qvJK0HblWG
         p3C1/OPmmOEWkuR/lIXcwM89XgP/r0DIBOmIn1Ie49D7cvUFRE+wFKb/Ze4g7Old9pHM
         E78eWXTEZXDuuDja9M6QuEZojkZP/5XF/wTyNlEz8QyOOW75ojkqA1Nq9HtRqketv3CE
         J4vk1KUWtnfc7bDnImCz73XtIMKMucZDyBVMADRYMZnxOo3ECoqB6XBcJIUdAyWhi69M
         ulfyQaP9sIurq1eTZBrPGzFzHwxepIIyFDkvJQtw0anzYXDpJIS/XRRm3mbSo/LCDJqx
         mFuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qnx0KA3OJ/m9eZ6ov2u+gEKb+TaL+eUxISugF65jR+Q=;
        b=K1Hv394X5AfQM9Rf/mjKnkER7/R1IRFWKSiTdgBrIPVtqKvXMGQqWsS+4AG13c7evN
         HNAzVRebrcq14mdd40rdWZOEKBGlF7lRTUXiEUHN9sVpeTHg3Fj0qT7wWKOai4krLxWM
         gLPFh7ytx7HdOVGZG8SUXwhyTI1IGqgdHvZ9SEhR9b6fjvBpTyt8LQuOXbeyR7KgTqbb
         w09ikSkGjboUus7p9URa9Z4zjiY9JIorh7gX6l8hHEL0+gGF5+Lxazue/lkyQKblVcf3
         Gw8H3oRQOB+XDmhoc8J9ctd5DMj1xxhnh2jcm1ZMZO08IiTcb8GgcUQ82i8gxxV0Pxjn
         8PgQ==
X-Gm-Message-State: AODbwcCxJBE1aMcqv3Jr/OwluMpiQUVX0YqJKRsq1FdakO0grjam89jz
        1NzCyD8P2zz96knle3t6HHSx1oOOdA==
X-Received: by 10.36.166.4 with SMTP id q4mr13928869ite.66.1495266982248; Sat,
 20 May 2017 00:56:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Sat, 20 May 2017 00:56:01 -0700 (PDT)
In-Reply-To: <1495227246.19473.3.camel@kaarsemaker.net>
References: <CACBZZX5j1dYk8aeRED7T7iJ=b32aFUpfUWPpMpmtofBL3QnVXQ@mail.gmail.com>
 <20170324213732.29932-1-dennis@kaarsemaker.net> <1493881302.20467.3.camel@kaarsemaker.net>
 <1495227246.19473.3.camel@kaarsemaker.net>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sat, 20 May 2017 09:56:01 +0200
Message-ID: <CACBZZX7OE2rRD4W4weGhAoaurFRvA85Js0dN=80zcuxR0xM3SA@mail.gmail.com>
Subject: Re: [PATCH v2] send-email: Net::SMTP::SSL is obsolete, use only when necessary
To:     Dennis Kaarsemaker <dennis@kaarsemaker.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 19, 2017 at 10:54 PM, Dennis Kaarsemaker
<dennis@kaarsemaker.net> wrote:
> Second ping. This problem is not going away, so if this solution is not
> acceptable, I'd like to know what needs to be improved.

FWIW:

Reviewed-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>

> On Thu, 2017-05-04 at 09:01 +0200, Dennis Kaarsemaker wrote:
>> Ping. It's a little over a month since I sent this, but I haven't seen
>> any comments. Is this commit good to go?
>>
>> On Fri, 2017-03-24 at 22:37 +0100, Dennis Kaarsemaker wrote:
>> > Net::SMTP itself can do the necessary SSL and STARTTLS bits just fine
>> > since version 1.28, and Net::SMTP::SSL is now deprecated. Since 1.28
>> > isn't that old yet, keep the old code in place and use it when
>> > necessary.
>> >
>> > While we're in the area, mark some messages for translation that were
>> > not yet marked as such.
>> >
>> > Signed-off-by: Dennis Kaarsemaker <dennis@kaarsemaker.net>
>> > ---
>> >  git-send-email.perl | 54 ++++++++++++++++++++++++++++++++++----------=
---------
>> >  1 file changed, 35 insertions(+), 19 deletions(-)
>> >
>> > diff --git a/git-send-email.perl b/git-send-email.perl
>> > index eea0a517f7..0d90439d9a 100755
>> > --- a/git-send-email.perl
>> > +++ b/git-send-email.perl
>> > @@ -1353,10 +1353,12 @@ EOF
>> >                     die __("The required SMTP server is not properly d=
efined.")
>> >             }
>> >
>> > +           require Net::SMTP;
>> > +           my $use_net_smtp_ssl =3D version->parse($Net::SMTP::VERSIO=
N) < version->parse("1.28");
>> > +           $smtp_domain ||=3D maildomain();
>> > +
>> >             if ($smtp_encryption eq 'ssl') {
>> >                     $smtp_server_port ||=3D 465; # ssmtp
>> > -                   require Net::SMTP::SSL;
>> > -                   $smtp_domain ||=3D maildomain();
>> >                     require IO::Socket::SSL;
>> >
>> >                     # Suppress "variable accessed once" warning.
>> > @@ -1368,34 +1370,48 @@ EOF
>> >                     # Net::SMTP::SSL->new() does not forward any SSL o=
ptions
>> >                     IO::Socket::SSL::set_client_defaults(
>> >                             ssl_verify_params());
>> > -                   $smtp ||=3D Net::SMTP::SSL->new($smtp_server,
>> > -                                                 Hello =3D> $smtp_dom=
ain,
>> > -                                                 Port =3D> $smtp_serv=
er_port,
>> > -                                                 Debug =3D> $debug_ne=
t_smtp);
>> > +
>> > +                   if ($use_net_smtp_ssl) {
>> > +                           require Net::SMTP::SSL;
>> > +                           $smtp ||=3D Net::SMTP::SSL->new($smtp_serv=
er,
>> > +                                                         Hello =3D> $=
smtp_domain,
>> > +                                                         Port =3D> $s=
mtp_server_port,
>> > +                                                         Debug =3D> $=
debug_net_smtp);
>> > +                   }
>> > +                   else {
>> > +                           $smtp ||=3D Net::SMTP->new($smtp_server,
>> > +                                                    Hello =3D> $smtp_=
domain,
>> > +                                                    Port =3D> $smtp_s=
erver_port,
>> > +                                                    Debug =3D> $debug=
_net_smtp,
>> > +                                                    SSL =3D> 1);
>> > +                   }
>> >             }
>> >             else {
>> > -                   require Net::SMTP;
>> > -                   $smtp_domain ||=3D maildomain();
>> >                     $smtp_server_port ||=3D 25;
>> >                     $smtp ||=3D Net::SMTP->new($smtp_server,
>> >                                              Hello =3D> $smtp_domain,
>> >                                              Debug =3D> $debug_net_smt=
p,
>> >                                              Port =3D> $smtp_server_po=
rt);
>> >                     if ($smtp_encryption eq 'tls' && $smtp) {
>> > -                           require Net::SMTP::SSL;
>> > -                           $smtp->command('STARTTLS');
>> > -                           $smtp->response();
>> > -                           if ($smtp->code =3D=3D 220) {
>> > +                           if ($use_net_smtp_ssl) {
>> > +                                   $smtp->command('STARTTLS');
>> > +                                   $smtp->response();
>> > +                                   if ($smtp->code !=3D 220) {
>> > +                                           die sprintf(__("Server doe=
s not support STARTTLS! %s"), $smtp->message);
>> > +                                   }
>> > +                                   require Net::SMTP::SSL;
>> >                                     $smtp =3D Net::SMTP::SSL->start_SS=
L($smtp,
>> >                                                                       =
ssl_verify_params())
>> > -                                           or die "STARTTLS failed! "=
.IO::Socket::SSL::errstr();
>> > -                                   $smtp_encryption =3D '';
>> > -                                   # Send EHLO again to receive fresh
>> > -                                   # supported commands
>> > -                                   $smtp->hello($smtp_domain);
>> > -                           } else {
>> > -                                   die sprintf(__("Server does not su=
pport STARTTLS! %s"), $smtp->message);
>> > +                                           or die sprintf(__("STARTTL=
S failed! %s"), IO::Socket::SSL::errstr());
>> > +                           }
>> > +                           else {
>> > +                                   $smtp->starttls(ssl_verify_params(=
))
>> > +                                           or die sprintf(__("STARTTL=
S failed! %s"), IO::Socket::SSL::errstr());
>> >                             }
>> > +                           $smtp_encryption =3D '';
>> > +                           # Send EHLO again to receive fresh
>> > +                           # supported commands
>> > +                           $smtp->hello($smtp_domain);
>> >                     }
>> >             }
>> >
