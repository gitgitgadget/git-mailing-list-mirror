Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39CDF207B3
	for <e@80x24.org>; Thu,  4 May 2017 06:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751370AbdEDG54 (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 02:57:56 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34128 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751303AbdEDG5y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 02:57:54 -0400
Received: by mail-wm0-f67.google.com with SMTP id z129so1231761wmb.1
        for <git@vger.kernel.org>; Wed, 03 May 2017 23:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:newsgroups:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=C03LvqkK57t89FJTi/m3ziApdA4moG9F9KXZcQDDwfk=;
        b=l76ZomoUvDiXoT2BM/9RI/lUwEv8H0n0jVxFHpgosgHzvbJl7YhsJ1KEuE68YM0NGz
         sMwWI/c919ngxZiVnR0nkfucLQaSeP/ALXSiVKbIcPnuCp6uxGQpGuwqLtVZAlTL5mG6
         mzZpi3kqOIGT0k+TVnsyXuYKS/41Sx9CRBhOqNHmI6Pvj6CpVBFHrTNGSBHWNgrEYH1X
         /Ymi/FLF8Wz04xBnUHcBzBnwLXa6+3aFPgUIfY+LVLoeM8rcy0NN2rKgP1NCMrHlREHU
         7vY0WTaMN7b++9uh6iqwziYQeUSEfMJvzPPBqpfKOMTDo9zyofSuUG025ZWh3lnlW2nG
         bgHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:newsgroups:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=C03LvqkK57t89FJTi/m3ziApdA4moG9F9KXZcQDDwfk=;
        b=jxW19QEn522gfQeo11Bn69ON9W52j5tKH3mNJ9AenBakWp8uUfVxQIBFu7l/NoRa5y
         bPumCKg0n85VBGUksKswvnWw9PGJ+NkAbJqunk/pF5G7r6zetTFBTmeCvbZKyM/Y5qGK
         jIyRs1xQh6/b9X7UZ5Stee8s4jvkv0Owi3wkfYPkT+Gg+reZp9TA9qOBmhDg6l3lPnTH
         WLjrnTin/xEVxMp9s2JdXChi5O1HT19678C/qPucqQYFLuDHM4c2nWzCia2fYMaR4FM0
         glNs9jPS756sICMjcUcxD1JA9r2i3SkVKBVV5JxhHIfkzMSBfbBfOoE3bPO1OJ0suf3T
         H5YA==
X-Gm-Message-State: AN3rC/71qjwn7RFiqKEJJAKc5qB78vgAq6uggMXk4Sc8u5i2tTy5G5/I
        6Qcc0z+/cQW7KQ==
X-Received: by 10.80.212.211 with SMTP id e19mr4125339edj.164.1493881073246;
        Wed, 03 May 2017 23:57:53 -0700 (PDT)
Received: from [10.176.41.238] ([131.228.216.134])
        by smtp.googlemail.com with ESMTPSA id m9sm430159edm.62.2017.05.03.23.57.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 May 2017 23:57:52 -0700 (PDT)
Subject: Re: git-clone --config order & fetching extra refs during initial
 clone
To:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Robin H. Johnson" <robbat2@gentoo.org>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Newsgroups: gmane.comp.version-control.git
References: <robbat2-20170225T185056-448272755Z@orbis-terrarum.net>
 <20170225205052.j3p7obbf4onf6cbf@sigill.intra.peff.net>
 <xmqqd1e3xx4c.fsf@gitster.mtv.corp.google.com>
 <20170227211217.73gydlxb2qu2sp3m@sigill.intra.peff.net>
 <CAM0VKj=rsAfKvVccOMOoo5==Q1yW1U0zJBbUV=faKppWFm-u+g@mail.gmail.com>
 <20170315170829.7gp44typsyrlw6kg@sigill.intra.peff.net>
 <CAM0VKjnjMEThuMvLEQByxWvxVvdzMSVsFKKstKLMweEx5UwTcg@mail.gmail.com>
 <20170503202224.arjszzbruxjgpkt5@sigill.intra.peff.net>
From:   Sebastian Schuberth <sschuberth@gmail.com>
Message-ID: <9a4e4354-d94e-c914-3ac2-309dd5e7896b@gmail.com>
Date:   Thu, 4 May 2017 08:57:51 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <20170503202224.arjszzbruxjgpkt5@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/3/2017 22:22, Jeff King wrote:

>> My patch deals with 'remote.<name>.refspec', i.e. 'remote->fetch'.
>> Apparently some extra care is necessary for 'remote.<name>.tagOpt' and
>> 'remote->fetch_tags', too.  Perhaps there are more, I haven't checked
>> again, and maybe we'll add similar config variables in the future.  So
>> I don't think that dealing with such config variables one by one in
>> 'git clone', too, is the right long-term solution...  but perhaps it's
>> sufficient for the time being?
> 
> I think your patch is a strict improvement and we don't need to hold up
> waiting for a perfect fix (and because of the --single-branch thing you
> mentioned, this may be the best we can do anyway).

I agree. Let's fix one thing at a time, and not make this a overarching "account for all previously ignored config variables during clone" fix. Esp. as specifying the refspec is explicitly documented to work durig clone [1] I think we should get this in ASAP.

Thanks for your work so far!

[1] https://git-scm.com/docs/git-clone#git-clone---configltkeygtltvaluegt

Regards,
Sebastian
