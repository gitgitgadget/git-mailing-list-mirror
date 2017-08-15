Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 578B4208B8
	for <e@80x24.org>; Tue, 15 Aug 2017 18:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753423AbdHOSSK (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 14:18:10 -0400
Received: from mail-yw0-f171.google.com ([209.85.161.171]:35142 "EHLO
        mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753117AbdHOSSJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 14:18:09 -0400
Received: by mail-yw0-f171.google.com with SMTP id l82so9430265ywc.2
        for <git@vger.kernel.org>; Tue, 15 Aug 2017 11:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hcmhzsDgqUeymgu4/o/c6iNsPG/PVbfCz+ioeJR/sXQ=;
        b=aH9KIqNFfQAAPJqqaLTQQHWH8heqm8sXa8ZsQFQDuq1bU8Ztw8kn/igj1zlZ6nGJYV
         NDwWc6A5+y44FHICYm09yAUHtyP3c6mhF6F/IyKGkqVG+E8YViqLzGgeKvuwiZOcn6tc
         6+mrkDbKg9HPQdMsQqG4BXCK38RRS9DGS9TKQjnRA7KTDRoWT0vetP4x5C/pujfMxjbw
         3fVEyD7P7jSyF7MlNaWb4EvQb1/+Dgqj6MjJCa0+CWvzqn3zXZBnymnoOX7dJrFqmW5D
         KiIjluuP4LFqByv/jZ/0ncUbid+R9/73jdmdZSnA3xirMma3NzI4Ub+SOce1ORvutfvG
         wm+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hcmhzsDgqUeymgu4/o/c6iNsPG/PVbfCz+ioeJR/sXQ=;
        b=ubFekOPWDWSfS2z9bQlza11fZe7nYtK1j4aP8OSNAD/psrmhFe0LuxCzyjo45jnL5C
         ECAtcDWw2xFPj13mZCt+Hmob3atm4xKqhfK9rAkrGJiqniJsAi8Cx5HI2Ne9K4IsXCb2
         +HkpZNosiK+KB+hQnbhpaIRCDs/rIRHbtlmWb6X0tRT1nLp5qPif71sRHx4g8LqS+x/V
         RSWiLHvGJP8lLeybhfYYD7YhCvKjfM6LhBxWtcJbbaVjDNExKT9/PVD1UtABL0jtQWWq
         DOvA1ngy9JRz/2ia5cbbE/blBIHkJ3NxR9cCakJaz829j6HuO2MKyhLhzdQ8m1QMJp43
         JDIw==
X-Gm-Message-State: AHYfb5gzX6ewW6zOp9ni0luZJ8ZizzObhbx8lRxVW+g58zAZtEReXtoU
        flNA+iy9YMP+gtpXaeA2kRgaubJIbDKK3so=
X-Received: by 10.13.206.132 with SMTP id q126mr23511971ywd.337.1502821088854;
 Tue, 15 Aug 2017 11:18:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.56.142 with HTTP; Tue, 15 Aug 2017 11:18:08 -0700 (PDT)
In-Reply-To: <5c46f1e4-825e-8e10-e323-e637e170f315@morey-chaisemartin.com>
References: <ab866314-608b-eaca-b335-12cffe165526@morey-chaisemartin.com> <5c46f1e4-825e-8e10-e323-e637e170f315@morey-chaisemartin.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 15 Aug 2017 11:18:08 -0700
Message-ID: <CAGZ79kbgYqo=6FvRNwB0AOKT8mioPTu2CearVttA30nZ8wBMHQ@mail.gmail.com>
Subject: Re: [RFC 0/3] imap-send curl tunnelling support
To:     Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 15, 2017 at 10:49 AM, Nicolas Morey-Chaisemartin
<nicolas@morey-chaisemartin.com> wrote:
> Ping.
>
> I'd like to get feedback from Windows developer on patch #2
> Patch#3 will probably need some updates as I expected Jeff old curl drop =
patches to make it in.
> As it seems to be going another way a few more ifdefs will be required

+cc Windows devs

>
> Nicolas
>
> Le 09/08/2017 =C3=A0 16:43, Nicolas Morey-Chaisemartin a =C3=A9crit :
>> From 7.21.5, curl can be tricked into using an open fd.
>> This series uses this to allow using curl over a tunnel.
>>
>> I have a few doubt on patch #2:
>> - is socketpair working on all git supported system (windows ?)
>> - should socketpair always be used or limited to the curl over tunnel ca=
se ?
>>   I don't think there is too much different between an unname pipe and a=
 socketpair but I'm not sure either :)
>>
>> This series also shows a "bug" in curl.
>> When trying out the tunnel example fro imap-send documentation, this hap=
pends:
>> Starting tunnel 'ssh -q -C localhost /usr/sbin/imapd ./Maildir'... ok
>> sending 3 messages
>> 16:38:54.055221 http.c:639              =3D=3D Info: Hostname was NOT fo=
und in DNS cache
>> 16:38:54.059505 http.c:639              =3D=3D Info:   Trying ::1...
>> 16:38:54.059545 http.c:639              =3D=3D Info: Connected to localh=
ost () port 143 (#0)
>> 16:38:54.354379 http.c:586              <=3D Recv header, 0000000332 byt=
es (0x0000014c)
>> 16:38:54.354405 http.c:598              <=3D Recv header: * PREAUTH [CAP=
ABILITY IMAP4REV1 I18NLEVEL=3D1 LITERAL+ IDLE UIDPLUS NAMESPACE CHILDREN MA=
ILBOX-REFERRALS BINARY UNSELECT ESEARCH WITHIN SCAN SORT THREAD=3DREFERENCE=
S THREAD=3DORDEREDSUBJECT MULTIAPPEND] Pre-authenticated user nmorey portia=
.home.nicolas.morey-chaisemartin.com IMAP4rev1 2007e.404 at Wed, 9 Aug 2017=
 16:38:54 +0200 (CEST)
>> 16:38:54.354425 http.c:639              =3D=3D Info: Bad tagged response
>> 16:38:54.354448 http.c:639              =3D=3D Info: Closing connection =
0
>> curl_easy_perform() failed: FTP: weird server reply
>>
>> It appears curl do not support the PREAUTH tag.
>>
>> However a test with "nc imap.server.ext 143" is working fine.
>>
>> Nicolas Morey-Chaisemartin (3):
>>   imap-send: move tunnel setup to its own function
>>   imap-send: use a socketpair instead of pipe to communicate with the
>>     tunnel
>>   imap_send: add support for curl over tunnel
>>
>>  Documentation/git-imap-send.txt |  4 +-
>>  imap-send.c                     | 91 +++++++++++++++++++++++++++++++---=
-------
>>  2 files changed, 72 insertions(+), 23 deletions(-)
>>
>
