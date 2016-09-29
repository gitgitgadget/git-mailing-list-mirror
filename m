Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05A9820986
	for <e@80x24.org>; Thu, 29 Sep 2016 09:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932898AbcI2JiF (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 05:38:05 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33011 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932451AbcI2JiE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 05:38:04 -0400
Received: by mail-wm0-f66.google.com with SMTP id w84so9780413wmg.0
        for <git@vger.kernel.org>; Thu, 29 Sep 2016 02:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=IN3zU+pGzm3WreMzrxrcw0lf42VRuCe4Y/9sKilNqio=;
        b=Zz1prEcuUeQFECONRbsJDeaw093xxXAHxxvW2Cc6OeSWAeKcSYBzoQcsXQm56L2TS2
         5L0BGABw90VbFxlQAH62I9vdvJZ8CoQx41tw0FArDL94jV36bWXnDdf8Jm00xCyssqb4
         SUE3py1COUmjdavbCBB2KNzuMmS/Lx6FLg5CSijTDx+47T0z8rPfl7jYbBfiFAzTK1Je
         Kv0Qi+lwn3G14gQLhwoa895PDlOxaVSkCwiWu0WN8MMTiyBCnaX9UWJv3JEjcjODpq4p
         3ot9d7l7Ru98Co9taD3Dpo0fSZ/NNnZww0DVyO2tgZBCbkpcAg9kvgjiudA/kfgQdT5f
         h8jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=IN3zU+pGzm3WreMzrxrcw0lf42VRuCe4Y/9sKilNqio=;
        b=QUISRYRPSuMGvbNbUiOKZiIaxPeYExtNhV0Zy5aMOoyQxWHMiFB/pZnXkNH4jgDTlu
         gj7BhtO4ruQcUqH0QBQkcTMdg69QzB4DUoh2Mnsl1ZsYUtehq50s2ZIjC0+4PCfBkcS3
         rpunP3KdTkWOE3RCw6GAW4qEbYFxCy+6eEwuCh7Yjfsk5ezwDAlim7uRCo6KvDRTbmwL
         hV6WQZK9msTQa1gwplnu7jMuscsf7riLF2SClIMnwnR5qjF9XPoMJC73o+l060Wg7TN6
         md0he4/z+GP2EYqxNIPZhHUuge/3GWZQUIZ1U9CS62ELmh3LyNcb3KtHR5IkbgJW6N7O
         QItQ==
X-Gm-Message-State: AA6/9RkpOPkYNuihxtZX91C0t4BsMgloCfCC/8XOo1Oyev59w8d5UdkSR57DhXTLI4g+gw==
X-Received: by 10.194.176.69 with SMTP id cg5mr547572wjc.52.1475141882507;
        Thu, 29 Sep 2016 02:38:02 -0700 (PDT)
Received: from [192.168.1.26] (ddj41.neoplus.adsl.tpnet.pl. [83.23.87.41])
        by smtp.googlemail.com with ESMTPSA id l6sm13517582wmg.11.2016.09.29.02.38.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Sep 2016 02:38:01 -0700 (PDT)
Subject: Re: [PATCH v7 10/10] convert: add filter.<driver>.process option
To:     =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>
References: <20160908182132.50788-1-larsxschneider@gmail.com>
 <20160908182132.50788-11-larsxschneider@gmail.com>
 <20160910062919.GB11001@tb-raspi>
 <10020380-76ED-4371-A0BA-59D07AF33CE0@gmail.com>
 <96554f6d-988d-e0b8-7936-8d0f29a7564f@web.de>
 <xmqqvaxzvjj0.fsf@gitster.mtv.corp.google.com>
 <5E675A29-628F-4076-A5D9-E359CCF04295@gmail.com>
 <xmqq37l1nd42.fsf@gitster.mtv.corp.google.com>
 <30461d2d-5a9c-4b0c-25a0-aa3327622764@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Martin-Louis Bright <mlbright@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <1a5e30b0-ffa1-fbef-fda5-88e363d9a530@gmail.com>
Date:   Thu, 29 Sep 2016 11:37:54 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <30461d2d-5a9c-4b0c-25a0-aa3327622764@web.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 29.09.2016 o 08:33, Torsten Bögershausen pisze:
> On 15.09.16 22:04, Junio C Hamano wrote:
>> Lars Schneider <larsxschneider@gmail.com> writes:
>>
>>> Wouldn't that complicate the pathname parsing on the filter side?
>>> Can't we just define in our filter protocol documentation that our 
>>> "pathname" packet _always_ has a trailing "\n"? That would mean the 
>>> receiver would know a packet "pathname=ABC\n\n" encodes the path
>>> "ABC\n" [1].
>>
>> That's fine, too.  If you declare that pathname over the protocol is
>> a binary thing, you can also define that the packet does not have
>> the terminating \n, i.e. the example encodes the path "ABC\n\n",
>> which is also OK ;-)
>>
>> As long as the rule is clearly documented, easy for filter
>> implementors to follow it, and hard for them to get it wrong, I'd be
>> perfectly happy.
>>
> 
> (Sorry for the late reply)
> 
> In V8 the additional "\n" is clearly documented.
> 
> On the long run,
> I would suggest to be more clear what BINARY is:
> 
> --- a/Documentation/technical/protocol-common.txt
> +++ b/Documentation/technical/protocol-common.txt
> @@ -61,6 +61,9 @@ the length's hexadecimal representation.
>  A pkt-line MAY contain binary data, so implementors MUST ensure
>  pkt-line parsing/formatting routines are 8-bit clean.
>  
> +Each pkt-line that may contain ASCII control characters should
> +be treated as binary.
> +

Well, it is not as clear cut with pathnames.  Sane pathnames should
not contain control characters, even if they are outside US-ASCII,
assuming sane filesystem pathnames charset (like UTF-8).

One thing pathname cannot include is NUL ("\0") character.

So in most cases they are ASCII, but might not be.  Not that 
pkt-line text packets are binary-unsafe... I think the trailing
"\n" is here for easier debugging.

http://www.dwheeler.com/essays/filenames-in-shell.html
http://www.dwheeler.com/essays/fixing-unix-linux-filenames.html

-- 
Jakub Narębski
