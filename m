Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40E911FAEB
	for <e@80x24.org>; Wed,  7 Jun 2017 21:06:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751638AbdFGVGw (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Jun 2017 17:06:52 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:35412 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751603AbdFGVGu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2017 17:06:50 -0400
Received: by mail-io0-f172.google.com with SMTP id k93so12425295ioi.2
        for <git@vger.kernel.org>; Wed, 07 Jun 2017 14:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=Cr3fu8RF+c9KjteBLiGyoaTNsu4ctIrQ1qLPfAqalKI=;
        b=TIVMOeIhV1KCL0SL3iwo1EyX2SymoBiYqDT1txpXSgPDPZOv59lc6fhPqpGptm7FDR
         nsDYkpCiWTeVETreJbftsKmlICNn891tv9YBMVt63ZmfegvFGvt8POOsqqE04otg3O8c
         J9ZkA76qXyw2pjlnc24WVJsryiSdBV6ztTnnf2tUnGaaczwIEMLT3wVMMqNce71nnUUL
         yI7r6bQPXldJOzgNBnz6P092l4AS0pe5x8G+z80Y4NfKVeN32LU2KBuTB1t+6UzYdqSi
         AI5jvNuguHDazirs12JsPa7fHBEkpyh51z6CZPT5XOqL8EB2+wMLCkk1COBqqHlM4tm9
         VF9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=Cr3fu8RF+c9KjteBLiGyoaTNsu4ctIrQ1qLPfAqalKI=;
        b=R3rIhEkCZgq0A6E9VqipXL9i7dpOLER9yzwukUUBZ3tybyHvCBgLWvZ7pms5XItcPv
         D98lCG2uFKLTSpIK+sz4bL0nm1sswjfknFACOXJwAtC5TvEwhV6rgURNP0zqy5JWPlD+
         /EXtU9N3GFEPxxKc1bmeuuoNqtKCY6EtcsNEAjYjKb4Ikz5Gn8TgvFzWhGxeqPj5wh1L
         EE8uwfIaIeVIbbvQjVvuTfyUaH1rLLb4S5toXH33A+i/XOAknwbmGHZY+N6M+fhub2Wk
         Vg8gUiHddS6fW2mhSUD6nCaO2195NpMDBS+ak53wgS7HADc0TEq6NG1eLpyhrstLrb52
         B1WQ==
X-Gm-Message-State: AODbwcBosJs3gQxTBnpkvp7+ql47qrbFvEX4kvFRhkNouY2znxMJD+Lk
        tIATUEujVUlFN5VaIQDgb+kmA3BIJw==
X-Received: by 10.107.160.143 with SMTP id j137mr39103372ioe.20.1496869609821;
 Wed, 07 Jun 2017 14:06:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.135.7 with HTTP; Wed, 7 Jun 2017 14:06:49 -0700 (PDT)
In-Reply-To: <CACBZZX5Zdn5XpjsWchww+LxyqN+Y=BqrGJ6wrXUW3PnRcsw-fQ@mail.gmail.com>
References: <CAKvHMgTBmdKrz-i9-uBFtx08pegjuY2=jKQE21pi=MabTuicrw@mail.gmail.com>
 <CAKvHMgSgOyDhffPm=-QEQNzoCoPtmWbV_R7JDtBFTHQ-sL3Wug@mail.gmail.com>
 <CACBZZX6AKYA5PmE6Le4cxCTCOOix1ErHyT21C=L83CQBYaN=RQ@mail.gmail.com>
 <CAKvHMgRpS3AgRAm1ukH18kX5jNF6PEU8YTsq7mQ36myQgRe=Pw@mail.gmail.com>
 <CACBZZX5dwUq58nghuMqnuGfe9sPm1VBxVwZGZcTCYgeO5OdyTg@mail.gmail.com>
 <CAKvHMgQB7fR+2O4AUYNn0JF13fxf3m-gJ70yPUEdqRkyfC-q+w@mail.gmail.com> <CACBZZX5Zdn5XpjsWchww+LxyqN+Y=BqrGJ6wrXUW3PnRcsw-fQ@mail.gmail.com>
From:   Liam Breck <liam@networkimprov.net>
Date:   Wed, 7 Jun 2017 14:06:49 -0700
X-Google-Sender-Auth: Y4mWE6DWnK3x171iJ7PR9biAuLA
Message-ID: <CAKvHMgTS+JozeB6b+qvJGvjRv=5CZZhcVi3sGMww_gWpuWu9uA@mail.gmail.com>
Subject: Re: send-email: Net::SMTP::SSL failure
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 7, 2017 at 1:43 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> On Wed, Jun 7, 2017 at 9:39 PM, Liam Breck <liam@networkimprov.net> wrote=
:
>> On Wed, Jun 7, 2017 at 12:30 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
>> <avarab@gmail.com> wrote:
>>> On Wed, Jun 7, 2017 at 8:04 PM, Liam Breck <liam@networkimprov.net> wro=
te:
>>>> Thanks for your help!
>>>>
>>>> On Wed, Jun 7, 2017 at 10:16 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmaso=
n
>>>> <avarab@gmail.com> wrote:
>>>>> On Wed, Jun 7, 2017 at 7:00 PM, Liam Breck <liam@networkimprov.net> w=
rote:
>>>>>> On Tue, Jun 6, 2017 at 10:47 PM, Liam Breck <liam@networkimprov.net>=
 wrote:
>>>>>>>
>>>>>>> This is configured to send via a gmail account
>>>>>>> git send-email --to-cover --cc-cover <patch-list>
>>>>>>>
>>>>>>> I See
>>>>>>> Attempt to reload IO/Socket/SSL.pm aborted.
>>>>>>> Compilation failed in require at
>>>>>>> /usr/share/perl5/vendor_perl/Net/SMTP/SSL.pm line 6.
>>>>>>> BEGIN failed--compilation aborted at
>>>>>>> /usr/share/perl5/vendor_perl/Net/SMTP/SSL.pm line 6.
>>>>>>> Compilation failed in require at /usr/lib/git-core/git-send-email l=
ine 1386.
>>>>>>> fatal: 'send-email' appears to be a git command, but we were not
>>>>>>> able to execute it. Maybe git-send-email is broken?
>>>>>>>
>>>>>>> Net/SMTP/SSL.pm v1.04
>>>>>>>
>>>>>>> perl v5.26.0
>>>>>>>
>>>>>>> Seen in git 2.11.1, 2.12.2, 2.13.0, 2.13.1 on Arch Linux
>>>>>>
>>>>>> Also fails with perl 5.24.1 & 5.24.0
>>>>>>
>>>>>> Last working config was git 2.9.3 on perl 5.24.1
>>>>>>
>>>>>> The relevant code from git-send-email is:
>>>>>>
>>>>>>             require Net::SMTP;
>>>>>>             $smtp_domain ||=3D maildomain();
>>>>>>             $smtp_server_port ||=3D 25;
>>>>>>             $smtp ||=3D Net::SMTP->new($smtp_server,
>>>>>>                          Hello =3D> $smtp_domain,
>>>>>>                          Debug =3D> $debug_net_smtp,
>>>>>>                          Port =3D> $smtp_server_port);
>>>>>>             if ($smtp_encryption eq 'tls' && $smtp) {
>>>>>>                 require Net::SMTP::SSL;
>>>>>>                 $smtp->command('STARTTLS');
>>>>>>
>>>>>> I really wish git bundled its non-core perl libs...
>>>>>
>>>>> What's the output from just:
>>>>>
>>>>>     perl -MNet::SMTP -we1
>>>>
>>>> No output, exit code 0, however...
>>>>
>>>> $ perl -MIO::Socket::SSL -we1
>>>> Can't load '/usr/lib/perl5/site_perl/auto/Net/SSLeay/SSLeay.so' for
>>>> module Net::SSLeay: libssl.so.1.0.0: cannot open shared object file:
>>>> No such file or directory at /usr/lib/perl5/core_perl/DynaLoader.pm
>>>> line 193.
>>>> at /usr/share/perl5/vendor_perl/IO/Socket/SSL.pm line 19.
>>>> Compilation failed in require at
>>>> /usr/share/perl5/vendor_perl/IO/Socket/SSL.pm line 19.
>>>> BEGIN failed--compilation aborted at
>>>> /usr/share/perl5/vendor_perl/IO/Socket/SSL.pm line 19.
>>>> Compilation failed in require.
>>>> BEGIN failed--compilation aborted.
>>>>
>>>> I don't have {vendor,site}_perl/auto/ tho I have the package for
>>>> ssleay installed.
>>>>
>>>> Since which git release was that required?
>>>
>>> The actual issue here is that your Net::SSLeay package is broken
>>> because it's linked to libssl.so.1.0.0 which has since gone away. You
>>> should see that it's missing if you run whatever the Arch equivalent
>>> is of these Debian commands:
>>>
>>>     $ dpkg -L libnet-ssleay-perl|grep \.so$
>>>     /usr/lib/x86_64-linux-gnu/perl5/5.24/auto/Net/SSLeay/SSLeay.so
>>>     $ /usr/bin/perldoc -l Net::SSLeay
>>>     /usr/lib/x86_64-linux-gnu/perl5/5.24/Net/SSLeay.pod
>>>     $ dpkg -S /usr/lib/x86_64-linux-gnu/perl5/5.24/Net/SSLeay.pod
>>>     libnet-ssleay-perl: /usr/lib/x86_64-linux-gnu/perl5/5.24/Net/SSLeay=
.pod
>>>     $ dpkg -L libnet-ssleay-perl|grep \.so$
>>>     /usr/lib/x86_64-linux-gnu/perl5/5.24/auto/Net/SSLeay/SSLeay.so
>>>     $ ldd -r /usr/lib/x86_64-linux-gnu/perl5/5.24/auto/Net/SSLeay/SSLea=
y.so
>>> 2>&1|grep libssl
>>>             libssl.so.1.1 =3D> /usr/lib/x86_64-linux-gnu/libssl.so.1.1
>>> (0x00007f2523bb5000)
>>>     $ dpkg -S /usr/lib/x86_64-linux-gnu/libssl.so.1.1
>>>     libssl1.1:amd64: /usr/lib/x86_64-linux-gnu/libssl.so.1.1
>>>
>>> But that this isn't reported is a bug in git-send-email. This
>>> (untested) patch is probably the least invasive and easiest way to
>>> deal with this:
>>>
>>> diff --git a/git-send-email.perl b/git-send-email.perl
>>> index 7fd5874436..3f0fcf9040 100755
>>> --- a/git-send-email.perl
>>> +++ b/git-send-email.perl
>>> @@ -1354,6 +1354,8 @@ EOF
>>>                         die __("The required SMTP server is not
>>> properly defined.")
>>>                 }
>>>
>>> +               delete $INC{"Net/SMTP.pm"} if exists $INC{"Net/SMTP.pm"=
}
>>> +                                             and !defined $INC{"Net/SM=
TP.pm"};
>>>                 require Net::SMTP;
>>>                 my $use_net_smtp_ssl =3D
>>> version->parse($Net::SMTP::VERSION) < version->parse("2.34");
>>>                 $smtp_domain ||=3D maildomain();
>>>
>>> on closer inspection none of the other require() uses in that script
>>> are run twice, so they don't have the same issue with hiding the
>>> initial error.
>>
>> Arch didn't have packages for these perl modules until recently,
>> forcing git users to install them with cpan. And then the new packages
>> didn't emit a warning about checking for conflicts in the site_perl/
>> directories. Grrr.
>>
>> Fixed this by uninstalling /usr/{lib,share}/perl5/site_perl/* I had
>> only cleaned out share/ previously.
>
> Ah, so you installed Net::SSLeay via CPAN, and then upgraded your Arch
> openssl, breaking the CPAN-built *.so object?

Trouble started after an Arch system upgrade which didn't uninstall
site_perl/*, so yes probably. I actually fixed the problem first by
installing SSLeay via cpan, then noticed where it installed and
removed all the cpan stuff.

>> Agreed that send-email should be report errors properly. It's a rather
>> essential tool.
>
> Indeed, do you get a meaningful error if you apply my patch?

I'm not a git hacker, so I'm not set up to test this quickly, and I
lost a day's work trying to fix Arch :-(

>>>>> I have not looked deeply at this, but the error you're getting means
>>>>> "we tried to load it before and failed, and here you are trying
>>>>> again".
>>>>>
>>>>> This is almost definitely due to this line in git-send-email:
>>>>>
>>>>>         if (eval { require Net::SMTP; 1 }) {
>>>>>
>>>>> And more generally, this code is all buggy:
>>>>>
>>>>>     4 matches for "eval.*require" in buffer: git-send-email.perl
>>>>>     153:my $have_email_valid =3D eval { require Email::Valid; 1 };
>>>>>     154:my $have_mail_address =3D eval { require Mail::Address; 1 };
>>>>>    1118:        if (eval { require Net::Domain; 1 }) {
>>>>>    1129:        if (eval { require Net::SMTP; 1 }) {
>>>>>
>>>>> Well, "buggy" in the sense that we're just happy-go-lucky trying to
>>>>> load these modules, and if they have an error we don't report it, the=
n
>>>>> when we try to load them again perl just emits a generic error saying
>>>>> you're trying to require() something that already failed somewhere
>>>>> before, a minimal test case for that is:
>>>>>
>>>>>     $ cat /tmp/Fails.pm
>>>>>     package Fails;
>>>>>     die "oh noes";
>>>>>     $ perl -I/tmp -we 'eval { require Fails }; require Fails'
>>>>>     Attempt to reload Fails.pm aborted.
>>>>>     Compilation failed in require at -e line 1.
>>>>>
>>>>> Whereas what we really want to do is some variant of:
>>>>>
>>>>>     $ perl -MData::Dumper -I/tmp -we 'eval { require Fails } or warn
>>>>> $@; require Fails'
>>>>>     oh noes at /tmp/Fails.pm line 2.
>>>>>     Compilation failed in require at -e line 1.
>>>>>     Attempt to reload Fails.pm aborted.
>>>>>     Compilation failed in require at -e line 1.
>>>>>
>>>>> Or even the more adventerous, this can have some bad side-effects wit=
h
>>>>> some libraries (you lie to perl saying you haven't seen it before),
>>>>> but I doubt Net::SMTP cares much, particularly when we're just about
>>>>> to report an error:
>>>>>
>>>>>     $ perl -MData::Dumper -I/tmp -we 'eval { require Fails } or do {
>>>>> delete $INC{"Fails.pm"} }; require Fails'
>>>>>     oh noes at /tmp/Fails.pm line 2.
>>>>>     Compilation failed in require at -e line 1.
