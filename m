Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15300203E3
	for <e@80x24.org>; Tue, 26 Jul 2016 12:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755021AbcGZMYS (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 08:24:18 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34462 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752056AbcGZMYQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 08:24:16 -0400
Received: by mail-wm0-f66.google.com with SMTP id q128so1416155wma.1
        for <git@vger.kernel.org>; Tue, 26 Jul 2016 05:24:16 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=35E7Ud7vlTObXZDqfZxCTu8HQ7OxorBeKvqKI9HkMW0=;
        b=G82JwpMJz9nwI7WmEHjNAG5aIWFVmdh2MxMeoOW7hENQjd4QDiioJQwnSKU/eTtub6
         ooFrL7gMGRJVvN7i3ltOOI5KWnNPEMtbwPRpH0LM6HDT9BtnOGvEEePMIbugHk0zwZpE
         RyAFQXfeptXnlm/TON2GG1f+iOvUGY8H7sdbLXaz6elPjqKvA1Lc5Ay6hHMPCP1y6s8i
         L+MV4/esi+6Wkt3NuNwbW/J1FsFbedgijg8MAWeHQwyBPYgNowgexCRAROKzosvn4ILX
         Ji7PwsfnNooGYRySz40RdQ+wpbUcxwX/rJkSTCoqK0svg+V0/QqJ1I8WdMDZA9JO+QXJ
         eEsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=35E7Ud7vlTObXZDqfZxCTu8HQ7OxorBeKvqKI9HkMW0=;
        b=D6RqUje+n5C3qqgYvIimmsPVATLCeBdNJr6bYPfEUnWvxXZWi2scr+qCgfh/Y1ZXti
         7/yBQVekwz4vLWKFcmsdstsguqJPC+1F+w0P0rQJgyBjrWyUs7EnvDzjBDKh7uYkS6YX
         pe+enMQdGSZ9oy+YjV1ldMBKxfWqEn40TILzqVS6q/YXosyjHpiK7HAjLfcmzKAr9jpf
         fl3Lg3WWYcPvJw/p0Wuk+tLSNW6qY3tjkMAVUa39/RX/AeqIpHN2/2q6zb+kZz614ccM
         QfgrNequFCgAfTcTVFRediIQj7/cevUzM/eJIQGFzc6nUauSoUsLD5djTY3aQioUGtos
         rvHQ==
X-Gm-Message-State: AEkooutOjhPm79FtkQvHyco/rhUY/7+hS0lxz0VtKlIEKfIHkya8YYInymTevoijo4S9AQ==
X-Received: by 10.194.80.104 with SMTP id q8mr22088214wjx.151.1469535855214;
        Tue, 26 Jul 2016 05:24:15 -0700 (PDT)
Received: from [192.168.1.26] (afq129.neoplus.adsl.tpnet.pl. [83.25.146.129])
        by smtp.googlemail.com with ESMTPSA id q4sm710894wjk.24.2016.07.26.05.24.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jul 2016 05:24:14 -0700 (PDT)
Subject: Re: [PATCH v1 3/3] convert: add filter.<driver>.useProtocol option
To:	Lars Schneider <larsxschneider@gmail.com>
References: <20160722154900.19477-1-larsxschneider@gmail.com>
 <20160722154900.19477-4-larsxschneider@gmail.com>
 <5792B622.5040306@gmail.com> <0FB8A921-3465-4081-A36D-D2F19A8ED63D@gmail.com>
 <579521A1.4070501@gmail.com> <5795337A.1040701@gmail.com>
 <34F8B256-A129-4238-AE1A-CD8C1DE8C7DA@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
	mlbright@gmail.com, Junio C Hamano <gitster@pobox.com>,
	Eric Wong <e@80x24.org>
Newsgroups: gmane.comp.version-control.git
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <57975662.9050707@gmail.com>
Date:	Tue, 26 Jul 2016 14:24:02 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <34F8B256-A129-4238-AE1A-CD8C1DE8C7DA@gmail.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

W dniu 2016-07-25 o 22:16, Lars Schneider pisze:
> 
> On 24 Jul 2016, at 23:30, Jakub Narêbski <jnareb@gmail.com> wrote:
> 
>> W dniu 2016-07-24 o 22:14, Jakub Narêbski pisze:
>>> W dniu 2016-07-24 o 20:36, Lars Schneider pisze:
>>
>>>> I agree that the name is not ideal. "UseProtocol" as it is would be a boolean. 
>>>> I thought about "persistent" but this name wouldn't convey the scope of the 
>>>> persistency ("persistent for one Git operation" vs. "persistent for many Git 
>>>> operations"). What do you think about the protocol as int version idea
>>>> described in $gmane/300155 ?
>>>
>>> You mean the `protocol` as a config variable name (fully name being
>>> `filter.<driver>.protocol`), being integer-valued, isn't it? Wouldn't
>>> `protocolVersion` be a more explicit?
>>
>> Just throwing out further ideas:
>>
>> Perhaps make `persistent` string-valued variable, with the only value
>> supported for now, namely "per-process" / "operation"?
>>
>> Perhaps require for `pidfile` to be present for it to be daemon,
>> that is persist for possibly many Git operations. Or allow "daemon"
>> or "server" value for `persistent`, then?
> 
> I like the direction of this idea. What if we use a string-valued 
> "filter.<driver>.protocol" with the following options:
> 
> "simple" / "invocation-per-file" / << empty >> --> current clean/smudge behavior
> "invocation-per-process" --> new, proposed behavior
> 
> If necessary this could be enhanced in the future to support even a "daemon"
> mode (with a pidfile config).

Though, after thinking about it, this solution has the problem
that people might think that they can use their old per-file
filters, just flipping the `filter.<driver>.protocol`.

I dunno.
-- 
Jakub Narêbski

