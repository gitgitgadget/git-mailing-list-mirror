Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 367C51FAEB
	for <e@80x24.org>; Wed,  7 Jun 2017 20:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751499AbdFGUoB (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Jun 2017 16:44:01 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:37952 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751428AbdFGUoB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2017 16:44:01 -0400
Received: by mail-it0-f47.google.com with SMTP id r63so11905274itc.1
        for <git@vger.kernel.org>; Wed, 07 Jun 2017 13:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GY8VligfD+JWhch7zYJz12XS8BaZag0hjZ7t29zoZds=;
        b=sw8IL6rY7SZaKiGy+o/yiTrAYp6HKm/ZC9oZn8HtpJjb3dgooDSPZTyZDs8tBsrZ/a
         HH6B7jcBTL+tkJWD1NECx9dNLy0UYTKRb2EJwqTA2NTuubG++RDeKes8Nk4o3NYSocDQ
         F2aE0mf3ixXRSUBA61+ROp3MGkGbeHK7UEl7/HcA6Ue+vI5ySHzPsgjmxVhHgYIVc4h2
         +urJfaWcAwswUjahY2fR09NFjMBYubkaSlbJDC8u5XwGiYbhWbA/WaEbbr1QH2T6PxrR
         7pn5DEM4DEIE3rZhZKypsEJD+5mYH/2Vo/CuD4porjWwopEOPkzVuR891gyS9UnDWpFw
         tWCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GY8VligfD+JWhch7zYJz12XS8BaZag0hjZ7t29zoZds=;
        b=VJjbiTtOg5bilzc01AzGR85FCS2JsG9YYd79h0epLRcQlHQd4pIzu4ewxwHCJegkhh
         XwaT+Y5ug2kCPtxnjmf6c7Q1omhrXM2zfFk00TX+ac26epKTbC+Ewxl6/HPI8dD+VFGp
         NNQHalUMYhBJ2y7Es0d9zKEiSTb8kDpjCUOgteqP236fpaTpgwOo2z8GkuYBikpx7n3o
         fa7iYHG9Zx3CFq6nFIPuSjEM0kJPpQUG9rApeKdmkxFj4St7KqIJ7EfCF/GZ34newrp8
         Y1BXZIewddtgrnYIDzzriTsXY1XN7dTAl5F/hagCD6HPQf7bZFUeQdlo0A3myBThWSU5
         U9dg==
X-Gm-Message-State: AODbwcAwWysnDtCRhCqP61Y43iImglorqfA77dW1HJ8W5F+Pedu6oiVP
        Fa3V507qceP+35SWM9frL9a4VG3dZA==
X-Received: by 10.36.29.150 with SMTP id 144mr1936952itj.71.1496868239953;
 Wed, 07 Jun 2017 13:43:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.3.231 with HTTP; Wed, 7 Jun 2017 13:43:39 -0700 (PDT)
In-Reply-To: <CAKvHMgQB7fR+2O4AUYNn0JF13fxf3m-gJ70yPUEdqRkyfC-q+w@mail.gmail.com>
References: <CAKvHMgTBmdKrz-i9-uBFtx08pegjuY2=jKQE21pi=MabTuicrw@mail.gmail.com>
 <CAKvHMgSgOyDhffPm=-QEQNzoCoPtmWbV_R7JDtBFTHQ-sL3Wug@mail.gmail.com>
 <CACBZZX6AKYA5PmE6Le4cxCTCOOix1ErHyT21C=L83CQBYaN=RQ@mail.gmail.com>
 <CAKvHMgRpS3AgRAm1ukH18kX5jNF6PEU8YTsq7mQ36myQgRe=Pw@mail.gmail.com>
 <CACBZZX5dwUq58nghuMqnuGfe9sPm1VBxVwZGZcTCYgeO5OdyTg@mail.gmail.com> <CAKvHMgQB7fR+2O4AUYNn0JF13fxf3m-gJ70yPUEdqRkyfC-q+w@mail.gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Wed, 7 Jun 2017 22:43:39 +0200
Message-ID: <CACBZZX5Zdn5XpjsWchww+LxyqN+Y=BqrGJ6wrXUW3PnRcsw-fQ@mail.gmail.com>
Subject: Re: send-email: Net::SMTP::SSL failure
To:     Liam Breck <liam@networkimprov.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 7, 2017 at 9:39 PM, Liam Breck <liam@networkimprov.net> wrote:
> On Wed, Jun 7, 2017 at 12:30 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>> On Wed, Jun 7, 2017 at 8:04 PM, Liam Breck <liam@networkimprov.net> wrot=
e:
>>> Thanks for your help!
>>>
>>> On Wed, Jun 7, 2017 at 10:16 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
>>> <avarab@gmail.com> wrote:
>>>> On Wed, Jun 7, 2017 at 7:00 PM, Liam Breck <liam@networkimprov.net> wr=
ote:
>>>>> On Tue, Jun 6, 2017 at 10:47 PM, Liam Breck <liam@networkimprov.net> =
wrote:
>>>>>>
>>>>>> This is configured to send via a gmail account
>>>>>> git send-email --to-cover --cc-cover <patch-list>
>>>>>>
>>>>>> I See
>>>>>> Attempt to reload IO/Socket/SSL.pm aborted.
>>>>>> Compilation failed in require at
>>>>>> /usr/share/perl5/vendor_perl/Net/SMTP/SSL.pm line 6.
>>>>>> BEGIN failed--compilation aborted at
>>>>>> /usr/share/perl5/vendor_perl/Net/SMTP/SSL.pm line 6.
>>>>>> Compilation failed in require at /usr/lib/git-core/git-send-email li=
ne 1386.
>>>>>> fatal: 'send-email' appears to be a git command, but we were not
>>>>>> able to execute it. Maybe git-send-email is broken?
>>>>>>
>>>>>> Net/SMTP/SSL.pm v1.04
>>>>>>
>>>>>> perl v5.26.0
>>>>>>
>>>>>> Seen in git 2.11.1, 2.12.2, 2.13.0, 2.13.1 on Arch Linux
>>>>>
>>>>> Also fails with perl 5.24.1 & 5.24.0
>>>>>
>>>>> Last working config was git 2.9.3 on perl 5.24.1
>>>>>
>>>>> The relevant code from git-send-email is:
>>>>>
>>>>>             require Net::SMTP;
>>>>>             $smtp_domain ||=3D maildomain();
>>>>>             $smtp_server_port ||=3D 25;
>>>>>             $smtp ||=3D Net::SMTP->new($smtp_server,
>>>>>                          Hello =3D> $smtp_domain,
>>>>>                          Debug =3D> $debug_net_smtp,
>>>>>                          Port =3D> $smtp_server_port);
>>>>>             if ($smtp_encryption eq 'tls' && $smtp) {
>>>>>                 require Net::SMTP::SSL;
>>>>>                 $smtp->command('STARTTLS');
>>>>>
>>>>> I really wish git bundled its non-core perl libs...
>>>>
>>>> What's the output from just:
>>>>
>>>>     perl -MNet::SMTP -we1
>>>
>>> No output, exit code 0, however...
>>>
>>> $ perl -MIO::Socket::SSL -we1
>>> Can't load '/usr/lib/perl5/site_perl/auto/Net/SSLeay/SSLeay.so' for
>>> module Net::SSLeay: libssl.so.1.0.0: cannot open shared object file:
>>> No such file or directory at /usr/lib/perl5/core_perl/DynaLoader.pm
>>> line 193.
>>> at /usr/share/perl5/vendor_perl/IO/Socket/SSL.pm line 19.
>>> Compilation failed in require at
>>> /usr/share/perl5/vendor_perl/IO/Socket/SSL.pm line 19.
>>> BEGIN failed--compilation aborted at
>>> /usr/share/perl5/vendor_perl/IO/Socket/SSL.pm line 19.
>>> Compilation failed in require.
>>> BEGIN failed--compilation aborted.
>>>
>>> I don't have {vendor,site}_perl/auto/ tho I have the package for
>>> ssleay installed.
>>>
>>> Since which git release was that required?
>>
>> The actual issue here is that your Net::SSLeay package is broken
>> because it's linked to libssl.so.1.0.0 which has since gone away. You
>> should see that it's missing if you run whatever the Arch equivalent
>> is of these Debian commands:
>>
>>     $ dpkg -L libnet-ssleay-perl|grep \.so$
>>     /usr/lib/x86_64-linux-gnu/perl5/5.24/auto/Net/SSLeay/SSLeay.so
>>     $ /usr/bin/perldoc -l Net::SSLeay
>>     /usr/lib/x86_64-linux-gnu/perl5/5.24/Net/SSLeay.pod
>>     $ dpkg -S /usr/lib/x86_64-linux-gnu/perl5/5.24/Net/SSLeay.pod
>>     libnet-ssleay-perl: /usr/lib/x86_64-linux-gnu/perl5/5.24/Net/SSLeay.=
pod
>>     $ dpkg -L libnet-ssleay-perl|grep \.so$
>>     /usr/lib/x86_64-linux-gnu/perl5/5.24/auto/Net/SSLeay/SSLeay.so
>>     $ ldd -r /usr/lib/x86_64-linux-gnu/perl5/5.24/auto/Net/SSLeay/SSLeay=
.so
>> 2>&1|grep libssl
>>             libssl.so.1.1 =3D> /usr/lib/x86_64-linux-gnu/libssl.so.1.1
>> (0x00007f2523bb5000)
>>     $ dpkg -S /usr/lib/x86_64-linux-gnu/libssl.so.1.1
>>     libssl1.1:amd64: /usr/lib/x86_64-linux-gnu/libssl.so.1.1
>>
>> But that this isn't reported is a bug in git-send-email. This
>> (untested) patch is probably the least invasive and easiest way to
>> deal with this:
>>
>> diff --git a/git-send-email.perl b/git-send-email.perl
>> index 7fd5874436..3f0fcf9040 100755
>> --- a/git-send-email.perl
>> +++ b/git-send-email.perl
>> @@ -1354,6 +1354,8 @@ EOF
>>                         die __("The required SMTP server is not
>> properly defined.")
>>                 }
>>
>> +               delete $INC{"Net/SMTP.pm"} if exists $INC{"Net/SMTP.pm"}
>> +                                             and !defined $INC{"Net/SMT=
P.pm"};
>>                 require Net::SMTP;
>>                 my $use_net_smtp_ssl =3D
>> version->parse($Net::SMTP::VERSION) < version->parse("2.34");
>>                 $smtp_domain ||=3D maildomain();
>>
>> on closer inspection none of the other require() uses in that script
>> are run twice, so they don't have the same issue with hiding the
>> initial error.
>
> Arch didn't have packages for these perl modules until recently,
> forcing git users to install them with cpan. And then the new packages
> didn't emit a warning about checking for conflicts in the site_perl/
> directories. Grrr.
>
> Fixed this by uninstalling /usr/{lib,share}/perl5/site_perl/* I had
> only cleaned out share/ previously.

Ah, so you installed Net::SSLeay via CPAN, and then upgraded your Arch
openssl, breaking the CPAN-built *.so object?

> Agreed that send-email should be report errors properly. It's a rather
> essential tool.

Indeed, do you get a meaningful error if you apply my patch?

>>>> I have not looked deeply at this, but the error you're getting means
>>>> "we tried to load it before and failed, and here you are trying
>>>> again".
>>>>
>>>> This is almost definitely due to this line in git-send-email:
>>>>
>>>>         if (eval { require Net::SMTP; 1 }) {
>>>>
>>>> And more generally, this code is all buggy:
>>>>
>>>>     4 matches for "eval.*require" in buffer: git-send-email.perl
>>>>     153:my $have_email_valid =3D eval { require Email::Valid; 1 };
>>>>     154:my $have_mail_address =3D eval { require Mail::Address; 1 };
>>>>    1118:        if (eval { require Net::Domain; 1 }) {
>>>>    1129:        if (eval { require Net::SMTP; 1 }) {
>>>>
>>>> Well, "buggy" in the sense that we're just happy-go-lucky trying to
>>>> load these modules, and if they have an error we don't report it, then
>>>> when we try to load them again perl just emits a generic error saying
>>>> you're trying to require() something that already failed somewhere
>>>> before, a minimal test case for that is:
>>>>
>>>>     $ cat /tmp/Fails.pm
>>>>     package Fails;
>>>>     die "oh noes";
>>>>     $ perl -I/tmp -we 'eval { require Fails }; require Fails'
>>>>     Attempt to reload Fails.pm aborted.
>>>>     Compilation failed in require at -e line 1.
>>>>
>>>> Whereas what we really want to do is some variant of:
>>>>
>>>>     $ perl -MData::Dumper -I/tmp -we 'eval { require Fails } or warn
>>>> $@; require Fails'
>>>>     oh noes at /tmp/Fails.pm line 2.
>>>>     Compilation failed in require at -e line 1.
>>>>     Attempt to reload Fails.pm aborted.
>>>>     Compilation failed in require at -e line 1.
>>>>
>>>> Or even the more adventerous, this can have some bad side-effects with
>>>> some libraries (you lie to perl saying you haven't seen it before),
>>>> but I doubt Net::SMTP cares much, particularly when we're just about
>>>> to report an error:
>>>>
>>>>     $ perl -MData::Dumper -I/tmp -we 'eval { require Fails } or do {
>>>> delete $INC{"Fails.pm"} }; require Fails'
>>>>     oh noes at /tmp/Fails.pm line 2.
>>>>     Compilation failed in require at -e line 1.
