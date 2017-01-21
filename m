Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06AFD1F89C
	for <e@80x24.org>; Sat, 21 Jan 2017 15:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750917AbdAUPrM (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jan 2017 10:47:12 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:35265 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750836AbdAUPrK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jan 2017 10:47:10 -0500
Received: by mail-it0-f67.google.com with SMTP id 203so5872791ith.2
        for <git@vger.kernel.org>; Sat, 21 Jan 2017 07:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=rKfInG2NkLERlg5AHzsvfvo6icmxKN/HmoOVX/9v4zA=;
        b=RweJQoRnu+GaG5HthiHwHMouw7cKHsdl79lYgpIcCoWrm6ax8S7eNjSB9IABfmMGic
         YmdCcJ1UHPxUkwlRjnZZ2qCSNn+OtNFWDCunDA0P523UVNm2Gq+NaBc2Sv+BSE+5/by5
         C1aT8aqH0Xc66SGt3kX8C2hk/9VElKnd4JZbNdiN9HG9I0jyIEkT8Up2wCDV9ZVpTgW1
         N9q+NrRVvjN7p+iMq/domPTtBJuNERFUh2XLoA06UpryyvJ9Sa88PB8lR+7qis1rjl1N
         vExUKJWg9u4Wik/9dNZXxWBrSW1teY8QaOCyGnm+E7qx4BW1nRu/idhljh/wOOQUopee
         B3Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=rKfInG2NkLERlg5AHzsvfvo6icmxKN/HmoOVX/9v4zA=;
        b=NqE8zwVrGCVma1zgX9I4yxI+J0eMrLnJyac1eL5vXBII/U8hpXKw/qRbPRkKEdbcPJ
         KEvjDBHPz5GGy1NWPQIjltcte2RDPEy/EIjOWSxm7ijWPrQPS5RmI6F0krkMMX/eI0aU
         iBaAaMZMUli1mgZY6L8njmICDG3OCGjHRThtRMvghu94jEkpTVrxGtMNmOiT35+Q/mw1
         Q23RkroC88cLtmnKas8VTrtPxI1tQ5QPUX7yMSrinPzqc71gtDcZB9fQ5PqO/xtx6B/2
         ++JZ/vfF2Ul9LUn7UYX0kpSGgMmzzgq0bgOZMB3EVSQMs6lvfeVWvzopBSD0mAxb+nPs
         jOoA==
X-Gm-Message-State: AIkVDXJhvh+ooXSEicHRJ7XEkZzHDK2UMKiRvane3ItkUkpqz9N2OSTxNQVYY5kcJ4G8Rw==
X-Received: by 10.36.217.150 with SMTP id p144mr8565801itg.90.1485013629730;
        Sat, 21 Jan 2017 07:47:09 -0800 (PST)
Received: from [192.168.1.190] (h69-129-206-25.mdsnwi.broadband.dynamic.tds.net. [69.129.206.25])
        by smtp.gmail.com with ESMTPSA id 35sm6418731iot.6.2017.01.21.07.47.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jan 2017 07:47:09 -0800 (PST)
Subject: Re: submodule network operations [WAS: Re: [RFC/PATCH 0/4] working
 tree operations: support superprefix]
To:     Stefan Beller <sbeller@google.com>
References: <CAGZ79kZRV7x9B6SHRcHjJweHrjURxWKmN-=Wz_aNw2TPwYh_xw@mail.gmail.com>
 <ebf6c90e-044f-5538-2325-601d002a81fe@gmail.com>
 <CAGZ79kaf0BhbnJGhkjT_Ys44y4c4AaxV8U_ydWp4bbFMkGRcsQ@mail.gmail.com>
 <e6c5567a-2032-c598-97c8-08518f86b611@gmail.com>
 <CAGZ79kaS7zt3DKrRuqzzODc1HHEP-xd-8HBC0JA-HvmqAJOZfw@mail.gmail.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        David Turner <novalis@novalis.org>
From:   "Brian J. Davis" <bitminer@gmail.com>
Message-ID: <04fe8035-dbf0-83d2-c465-f746b99ce609@gmail.com>
Date:   Sat, 21 Jan 2017 09:53:59 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kaS7zt3DKrRuqzzODc1HHEP-xd-8HBC0JA-HvmqAJOZfw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 1/19/2017 7:22 PM, Stefan Beller wrote:
>>> Between the init and the update step you can modify the URLs.
>>> These commands are just a repetition from the first email, but the
>>> git commands can be viewed as moving from one state to another
>>> for submodules; submodules itself can be seen as a state machine
>>> according to that proposed documentation. Maybe such a state machine
>>> makes it easier to understand for some people.
>>
>> "Between the init and the update step you can modify the URLs."  Yes I can
>> and have to... wish it was not this way.
> So how would yo u rather want to do it?
> look at the .gitmodules file beforehand and then run a "submodule update" ?
> Or a thing like
>
>      git -c url.https://internal.insteadOf git://github.com/ \
>          -c submodule.record-rewritten-urls submodule update
>
> (no need for init there as theoretically there is not
> need for such an intermediate step)
>
"Yes please and thank you" ... both.

My thought was to simply allow addition to .gitmodules.  If I understand 
correctly you are proposing, to override these at the command line and 
possibly rewrite them on submodule update, but maybe not save or add to 
.gitmodules. I would then propose both.
1) allow user to add to .gitmodules for those who do not care that 
"outsiders" know the internal dev server
and
2) allow to rewrite while not saving to .gitmodules on fresh clone and 
submodule update for thoes that do not want ousiders to known internal 
dev server.
and possibly:
3) allow at command line to add remote to .gitmodules on submodule 
commands (note add optoin in -c <name> = <value> pair)

.gitmodules before:

[submodule "subprojects/wrangler"]
         path = subprojects/wrangler
         url = git://github.com/

Then your adapted command:

git -c url.https://internal.insteadOf git://github.com/ \
         -c submodule.record-rewritten-urls=add,internal --add submodule update

would produce

[submodule "subprojects/projname"]
         path = subprojects/projname
         remote.origin.url = git://github.com/
         remote.internal.url =https://internal.insteadOf

Or similar support.

>>> [remote "origin"]
>>>     url = https://github.com/..
>>> [remote "inhouse"]
>>>     url = https://inhouse.corp/..
>>>
>>> But where do we clone it from?
>>> (Or do we just do a "git init" on that submodule and fetch
>>> from both remotes? in which order?)
>> origin by default and inhouse if specified. There is already a implied
>> default (origin). The idea was not to do both but rather what is specified.
>> Origin and inhouse are just names for remotes. If one wanted a
>> "--all-remotes" could pull from everywhere in the Ether if feature was to be
>> implemented.
> How is origin implied to be the default?
> Should there be an order (e.g. if you cannot find it at inhouse get it
> from github,
> if they are down, get it from kernel.org)
As it is in the Highlander series... "there can be only one" (remote).   
So that is what I mean by origin.  The only remote allowed is the 
"origin" unless changed by the user... but there can still only be one 
*currently*. Though I see your point as it is not labeled "origin".  It 
is not labeled at all.  Apologies for confusion there.




