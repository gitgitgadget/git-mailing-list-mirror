Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 326C0202A0
	for <e@80x24.org>; Sun, 19 Nov 2017 17:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751109AbdKSRuH (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Nov 2017 12:50:07 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:41477 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750952AbdKSRuG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Nov 2017 12:50:06 -0500
Received: by mail-pf0-f194.google.com with SMTP id j28so5560215pfk.8
        for <git@vger.kernel.org>; Sun, 19 Nov 2017 09:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ziqz8xg3LvjeueQ/DwIPjDqQoXlSozqavJ7ZrQ0zMMc=;
        b=NHoUKS1f9d6uJilu8ZwTn0u1f/PSXxSZJfp2KiSxFbaM3yG9r5vLCf3KALRRRksSli
         v48mbr9MVsuAqQheCS9wn1UXrskUm48XV9p6+TWQhqN925KyPJpAz0Qiu0/AGv/52Mm7
         yHw8K6ZTUvzHFQ8kxLxEXvK132Q0/+BnmhXCEoz9U79obUovpkU+/GSZx7VG1mM6V2td
         A68IEMs5sxiz5ptvprNtZZXbxZrVxbF60btuUefrmGWmlIKJoFPFKWVykq5IAIvsEHTl
         etrFAdke5X01Pk2B8T+PMYhwFBpAqqIJMrZyw/5wsDyd6j8HrNUWgyFtdrTLkOq6I7Ur
         BT8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ziqz8xg3LvjeueQ/DwIPjDqQoXlSozqavJ7ZrQ0zMMc=;
        b=A5mGgXqhOHCz6sD/hwB7Rl5eHU0rnrFEzyatevCIUWwFixA2mmRtcINNufzajjDNRx
         +LZxmZlcCpHCC72gtM51ieVYHaHZkYdZeYIHPBXjGqKG+8c91Vq8S72kxcc0eKmzidaV
         nKvOgx4b/5gUgCPJl6khFnFe+qWcwyEvm2hcV5Z5D7NaUtEJ7/jfnnP2xDBdb2r2A/47
         9I5DT93QXhV3xKnhx+tWg3ny2Yw1SrWVvw1+WIo5fnSJTm3WhzJRIjk9ubvAlHWu7R8i
         OqXSS+AJQyfq/e5iwj1ph30LRv6sf1dTnNEplAh9Y2xbdLmLx9PsMKtjU9NpkQlMRPbJ
         d2eQ==
X-Gm-Message-State: AJaThX6urPaoC8fAIDA1X3A8a+IBchZbQz14RX8htsnnJ4XrUrfSK5JD
        CBNdvK+Ae3rsIRFyTCkYgwk=
X-Google-Smtp-Source: AGs4zMbVJHwEn1thHGmk60SVTwhqvNFi+tbvgV0XFVG0gr54rbORDlc0QeFD6d5EfBYuKxnrGCC4/Q==
X-Received: by 10.84.213.144 with SMTP id g16mr11468145pli.339.1511113805848;
        Sun, 19 Nov 2017 09:50:05 -0800 (PST)
Received: from ?IPv6:2405:204:72c8:8b21:b8b1:7c41:1a33:6334? ([2405:204:72c8:8b21:b8b1:7c41:1a33:6334])
        by smtp.gmail.com with ESMTPSA id q9sm17426239pfl.116.2017.11.19.09.49.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Nov 2017 09:50:04 -0800 (PST)
Subject: Re: [PATCH v2] launch_editor(): indicate that Git waits for user
 input
To:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Lars Schneider <lars.schneider@autodesk.com>,
        Git List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Lars Schneider <larsxschneider@gmail.com>
References: <20171117135109.18071-1-lars.schneider@autodesk.com>
 <CAPig+cQ3a0guJUhnbktrjs6fL6mSrUXmPqR0BafEAOhVr7Sy-w@mail.gmail.com>
 <xmqqh8tsqs83.fsf@gitster.mtv.corp.google.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <d53a655b-f51e-3f44-23db-581071010fd2@gmail.com>
Date:   Sun, 19 Nov 2017 23:19:51 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqh8tsqs83.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Saturday 18 November 2017 07:10 AM, Junio C Hamano wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> 
>>> @@ -40,6 +40,32 @@ int launch_editor(const char *path, struct strbuf *buffer, const char *const *en
>>> +               static const char *close_notice = NULL;
>>> +
>>> +               if (isatty(2) && !close_notice) {
>>
>> If you reverse this condition to say (!close_notice && isatty(2)),
>> then you save an isatty() invocation each time if close_notice is
>> already assigned.
>>
>> However, it's not clear how much benefit you gain from stashing this
>> away in a static variable. Premature optimization?
> 
> The variable being "static" could be (but it was done primarily
> because it allowed me not to worry about freeing),

AFAIK, observing the way the variable 'close_notice' is used, I guess 
you don't need to worry about freeing it up even if it wasn't "static".
That's my interpretation of the following section of the C standard,

========================
6.5.2.5 Compound literals

...

9 EXAMPLE 2
In contrast, in
void f(void)
{
int *p;
/*...*/
p = (int [2]){*p};
/*...*/
}
p is assigned the address of the first element of an array of two ints, 
the first having the value previously pointed to by p and the second, 
zero. The expressions in this compound literal need not be constant. The
unnamed object has automatic storage duration.
=========================

So the unnamed objects created as a consequence of the string literals 
assigned to 'close_notice' should have "automatic" storage duration 
which means you don't have to worry about allocating memory for them 
which would make you worry about freeing it up. If I'm stating something 
wrong, let me know.

BTW, I find making the variable 'close_notice' to be 'static' unwanted 
as I couldn't find any piece of code that invokes 'launch_editor' more 
than once within a single run. What could be the possible cases in which 
'launch_editor' could be called twice ?


>> Should printing of close_notice be done before the error()? Otherwise,
>> you get this:
>>
>> --- 8< ---
>> Launched your editor (...) ...There was a problem...
>> --- 8< ---
> 
> In my version with a far shorter message, I deliberately chose not
> to clear the notice.  We ran the editor, and we saw a problem.  That
> is what happened and that is what will be left on the terminal.
> 

It might be a good thing to keep the notice but I think it would be 
better to have that error message in a "new line". I'm not sure if it's 
possible or not.


---
Kaartic
