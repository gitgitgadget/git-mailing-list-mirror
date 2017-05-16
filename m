Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B8CE1FAA8
	for <e@80x24.org>; Tue, 16 May 2017 17:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751221AbdEPRnZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 13:43:25 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:36309 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750795AbdEPRnY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 13:43:24 -0400
Received: by mail-it0-f68.google.com with SMTP id z15so14113822ite.3
        for <git@vger.kernel.org>; Tue, 16 May 2017 10:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2FW/IAcF1G8nvHvOszEAh3KuGeJ8xaN++FOoJhO4C0w=;
        b=SNNr9RPWW228B3DQyMZF7p2aoqP0d9Tke6cRN8L7xpWOOoICnOHwVHsW1NAQiRrr1x
         GWdEz2z9qdEsb5aUllGFlu3K6oYSadG1I0qxMYnQcywgDp697ntiDHhyPHKS6F5pQW0o
         du9fKST6pkoQ3mlu3RU+WzuHWOXa55xCBGLlTqYAn32Yr8LYkgTqyhGcmE5KIUuzdQse
         4LxeIf93L1roNtPf33h+yeuxMM68I2BToL+r53aLMLBsc/5nNU5PXWiyIiRskxHCposL
         gYuze3wzD0W5iIyoEB8aYmjvvTyWnhTVOWxfpSAbyaqE11hOTjBAfov6qbAWKhw/T1XD
         hCMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2FW/IAcF1G8nvHvOszEAh3KuGeJ8xaN++FOoJhO4C0w=;
        b=Qa6BkdtvsElamcP1Pt0AUKIM8GOWvkrPN+ZhfA1HH00Mkpp79/ce5tQXpRvJUllu7r
         ig1DMt6anLgo7lnKLDDyuuNK8nX50Jn9w1/S1a94zBCcmeuz+B9oa3YG97HT8mAuCNGU
         G6m6x6Ix77DSINugIocYgeRtW22L08koAL0x+RrUmQGtYnaf8wYRHg8EOO1LMvIOglau
         /Wf8Hf+jwGKKgh0JFEeASDW92Cz7SscEiqCjDrvIHR65ChtFuWaGoH5GC7bjK7hHkPAm
         r8X1MyttbDeeynUSbhIT7Rm8rwGNCqViEE8UbVwFj9DKFNVv9wK7bUE6RUAxSUU9Bbcq
         yZQA==
X-Gm-Message-State: AODbwcA8VeK2iKEJycJrHymbQnlXau2jDSv6PH37WBPiQgbDd68nSN2c
        QpRmc9tz92C5yP5ZpnvIJt85w4o4YQ==
X-Received: by 10.36.138.131 with SMTP id v125mr11920551itd.66.1494956603422;
 Tue, 16 May 2017 10:43:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Tue, 16 May 2017 10:43:02 -0700 (PDT)
In-Reply-To: <2BB8B551-01A6-4470-9370-5B1A03EB96D0@163.com>
References: <20170513015726.20281-1-zxq_yx_007@163.com> <20170516141014.6e8487df.viktorin@rehivetech.com>
 <2BB8B551-01A6-4470-9370-5B1A03EB96D0@163.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 16 May 2017 19:43:02 +0200
Message-ID: <CACBZZX76ZYc=BXoAc+stKu+6c7M8CY2V+z4Mg86Y9y9GqmC5dw@mail.gmail.com>
Subject: Re: [PATCH v4] send-email: --batch-size to work around some SMTP
 server limit
To:     =?UTF-8?B?6LW15bCP5by6?= <zxq_yx_007@163.com>
Cc:     Jan Viktorin <viktorin@rehivetech.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, mst@kernel.org,
        pbonzini@redhat.com, mina86@mina86.com,
        Ramkumar Ramachandra <artagnon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 16, 2017 at 3:55 PM, =E8=B5=B5=E5=B0=8F=E5=BC=BA <zxq_yx_007@16=
3.com> wrote:
>
>
>> =E5=9C=A8 2017=E5=B9=B45=E6=9C=8816=E6=97=A5=EF=BC=8C20:10=EF=BC=8CJan V=
iktorin <viktorin@rehivetech.com> =E5=86=99=E9=81=93=EF=BC=9A
>>
>> Hello,
>>
>> with this patch applied to git 2.12, I could see:
>>
>> Use of uninitialized value $batch_size in numeric eq (=3D=3D) at /usr/li=
b/git-core/git-send-email line 1679
>>
>> when --batch-size is NOT used. See below...
>>
>> On Sat, 13 May 2017 09:57:26 +0800
>> xiaoqiang zhao <zxq_yx_007@163.com> wrote:
>>
>>> Some email servers (e.g. smtp.163.com) limit the number emails to be
>>> sent per session(connection) and this will lead to a faliure when
>>> sending many messages.
>>>
>>> Teach send-email to disconnect after sending a number of messages
>>> (configurable via the --batch-size=3D<num> option), wait for a few
>>> seconds (configurable via the --relogin-delay=3D<seconds> option) and
>>> reconnect, to work around such a limit.
>>>
>>> Also add this two configure option for git config command.
>>>
>>> Note:
>>>   Re-authentication will happen every $<batch-size> messages, so it
>>> will be much more acceptable if you use some form of credential helper
>>> (e.g. the 'sendemail.smtppass' config option), otherwise you will have
>>> to retype password every time when asked.
>>>
>>> Signed-off-by: xiaoqiang zhao <zxq_yx_007@163.com>
>>> ---
>>> contrib/completion/git-completion.bash |  2 ++
>>> git-send-email.perl                    | 18 ++++++++++++++++++
>>> 2 files changed, 20 insertions(+)
>>>
>>> diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
>>> index af658995d..29496353a 100644
>>> --- a/contrib/completion/git-completion.bash
>>> +++ b/contrib/completion/git-completion.bash
>>> @@ -2608,6 +2608,8 @@ _git_config ()
>>>        sendemail.thread
>>>        sendemail.to
>>>        sendemail.validate
>>> +        sendemail.smtpbatchsize
>>> +        sendemail.smtprelogindelay
>>>        showbranch.default
>>>        status.relativePaths
>>>        status.showUntrackedFiles
>>> diff --git a/git-send-email.perl b/git-send-email.perl
>>> index eea0a517f..071d1ab9d 100755
>>> --- a/git-send-email.perl
>>> +++ b/git-send-email.perl
>>> @@ -81,6 +81,10 @@ git send-email --dump-aliases
>>>                                      This setting forces to use one of =
the listed mechanisms.
>>>     --smtp-debug            <0|1>  * Disable, enable Net::SMTP debug.
>>>
>>> +    --batch-size            <int>  * send max <int> message per connec=
tion.
>>> +    --relogin-delay         <int>  * delay <int> seconds between two s=
uccessive login, default to 1,
>>> +                                     This option can only be used with=
 --batch-size
>>> +
>>>   Automating:
>>>     --identity              <str>  * Use the sendemail.<id> options.
>>>     --to-cmd                <str>  * Email To: via `<str> \$patch_path`
>>> @@ -153,6 +157,7 @@ my $have_email_valid =3D eval { require Email::Vali=
d; 1 };
>>> my $have_mail_address =3D eval { require Mail::Address; 1 };
>>> my $smtp;
>>> my $auth;
>>> +my $num_sent =3D 0;
>>>
>>> # Regexes for RFC 2047 productions.
>>> my $re_token =3D qr/[^][()<>@,;:\\"\/?.=3D \000-\037\177-\377]+/;
>>> @@ -216,6 +221,7 @@ my ($cover_cc, $cover_to);
>>> my ($to_cmd, $cc_cmd);
>>> my ($smtp_server, $smtp_server_port, @smtp_server_options);
>>> my ($smtp_authuser, $smtp_encryption, $smtp_ssl_cert_path);
>>> +my ($batch_size, $relogin_delay);
>>> my ($identity, $aliasfiletype, @alias_files, $smtp_domain, $smtp_auth);
>>> my ($validate, $confirm);
>>> my (@suppress_cc);
>>> @@ -247,6 +253,8 @@ my %config_settings =3D (
>>>     "smtppass" =3D> \$smtp_authpass,
>>>     "smtpdomain" =3D> \$smtp_domain,
>>>     "smtpauth" =3D> \$smtp_auth,
>>> +    "smtpbatchsize" =3D> \$batch_size,
>>> +    "smtprelogindelay" =3D> \$relogin_delay,
>>>     "to" =3D> \@initial_to,
>>>     "tocmd" =3D> \$to_cmd,
>>>     "cc" =3D> \@initial_cc,
>>> @@ -358,6 +366,8 @@ $rc =3D GetOptions(
>>>            "force" =3D> \$force,
>>>            "xmailer!" =3D> \$use_xmailer,
>>>            "no-xmailer" =3D> sub {$use_xmailer =3D 0},
>>> +            "batch-size=3Di" =3D> \$batch_size,
>>> +            "relogin-delay=3Di" =3D> \$relogin_delay,
>>>     );
>>>
>>> usage() if $help;
>>> @@ -1664,6 +1674,14 @@ foreach my $t (@files) {
>>>        }
>>>    }
>>>    $message_id =3D undef;
>>> +    $num_sent++;
>>> +    if ($num_sent =3D=3D $batch_size) {
>>
>> This is the line. I think, batch_size can be sometimes uninitialized
>> while this statement is executed.
>>
>> Regards
>> Jan
>
> Thank you for reporting this=EF=BC=8CI will take a look .

You just need to initialize the variables you're using, see e.g. these
existing ones:

    my ($quiet, $dry_run) =3D (0, 0);

Just do the same for the ones you're adding.

>>> +        $num_sent =3D 0;
>>> +        $smtp->quit if defined $smtp;
>>> +        undef $smtp;
>>> +        undef $auth;
>>> +        sleep($relogin_delay);
>>> +    }
>>> }
>>>
>>> # Execute a command (e.g. $to_cmd) to get a list of email addresses
>
>
