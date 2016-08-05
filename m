Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14D3020489
	for <e@80x24.org>; Fri,  5 Aug 2016 09:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934722AbcHEJ7k (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 05:59:40 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34182 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753503AbcHEJ7j convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Aug 2016 05:59:39 -0400
Received: by mail-wm0-f65.google.com with SMTP id q128so3065218wma.1
        for <git@vger.kernel.org>; Fri, 05 Aug 2016 02:59:38 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=nOaa9CmmlaCpB5vV6QFSPus55YhlT5Kc65GyBf9ocu0=;
        b=pNQvuZ5chdyQjVwglknRkmQI5fzh/5tMdj8BU/0+fef17X5xkUy8HtBtjVl0uff5ek
         yYg1fLMrpiv7FIVtCO+6VvDXixL4yxU4HBhoUpSyqPyZa2p+Zrj01nUcI+ugZC2OK/vi
         EBN61dHBwdyFIS6scuO73DOtzT3GOQuFhjCSnVSKMU3osUa2UBaIkXoxYr2sfnwUaFbH
         DWskob7dtEqk8TdTj+AhzW2GyD+WYmEQ18NDvET9Z27MV6+SBrQr8yNsGBYw5XiwdC4O
         PWx1Ehun3+KYAnTqywqGuBhzXvVf5oq23GUH4zXPtqV9zkcOGx+he/70e4lnq8FvSR+j
         yKqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=nOaa9CmmlaCpB5vV6QFSPus55YhlT5Kc65GyBf9ocu0=;
        b=jf81wZLziZ9HRgbAbzE7RsEhPW5xmtvYbialZRCyKYYT3p24lKS/byKk62T1qyN3xk
         yaBZ3Gbe0nlMUFo6LeHfdk2doJXkBYYkxsx4q2AUrcAt82ZD1k6tcWGHTuNQIk3iLrnj
         ZmQ3vuDOxv6rRDGdS1sq4LAfRazOYAcOtG2BdEUa0roAFxvlTamsr17Vgw2VPWI4Hs72
         xAVz2XtszYsDdcYIkx594Jjy2erjNIxQmGXqo7UgMnVcmFp5B5WpJgDfOtR2phYdFP1t
         jV4leHxEyiI1dEQ4VncvkCUu9JR3I3MyOxZqYwjmOALXUOvqmQmQpimE/Pedr7XiwTJq
         5Llw==
X-Gm-Message-State: AEkoouuBUf6LbQVvrUCcTCsON03qpZakyJizddporpEuFMUA4yObEnsNtbfmeZcKwzGV2w==
X-Received: by 10.194.57.244 with SMTP id l20mr70365598wjq.1.1470391177691;
        Fri, 05 Aug 2016 02:59:37 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id o142sm7819280wme.20.2016.08.05.02.59.35
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 Aug 2016 02:59:37 -0700 (PDT)
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v3 03/10] pkt-line: add packet_flush_gentle()
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20160802195546.GA2660@atze2.lan>
Date:	Fri, 5 Aug 2016 11:59:36 +0200
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>,
	"gitster@pobox.com" <gitster@pobox.com>,
	"jnareb@gmail.com" <jnareb@gmail.com>,
	"mlbright@gmail.com" <mlbright@gmail.com>,
	"e@80x24.org" <e@80x24.org>, "peff@peff.net" <peff@peff.net>
Content-Transfer-Encoding: 8BIT
Message-Id: <3BA617E0-4DE6-46F6-B148-67265CABE707@gmail.com>
References: <20160727000605.49982-1-larsxschneider%40gmail.com/> <20160729233801.82844-1-larsxschneider@gmail.com> <20160729233801.82844-4-larsxschneider@gmail.com> <63231F5B-959F-4A9D-89B9-E4A42AF34AB1@web.de> <8FC2D283-AF8D-4643-834E-3D1927C558C0@gmail.com> <20160802195546.GA2660@atze2.lan>
To:	=?iso-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 02 Aug 2016, at 21:56, Torsten Bögershausen <tboegi@web.de> wrote:
> 
> On Sun, Jul 31, 2016 at 11:45:08PM +0200, Lars Schneider wrote:
>> 
>>> On 31 Jul 2016, at 22:36, Torstem Bögershausen <tboegi@web.de> wrote:
>>> 
>>> 
>>> 
>>>> Am 29.07.2016 um 20:37 schrieb larsxschneider@gmail.com:
>>>> 
>>>> From: Lars Schneider <larsxschneider@gmail.com>
>>>> 
>>>> packet_flush() would die in case of a write error even though for some callers
>>>> an error would be acceptable.
>>> What happens if there is a write error ?
>>> Basically the protocol is out of synch.
>>> Lenght information is mixed up with payload, or the other way
>>> around.
>>> It may be, that the consequences of a write error are acceptable,
>>> because a filter is allowed to fail.
>>> What is not acceptable is a "broken" protocol.
>>> The consequence schould be to close the fd and tear down all
>>> resources. connected to it.
>>> In our case to terminate the external filter daemon in some way,
>>> and to never use this instance again.
>> 
>> Correct! That is exactly what is happening in kill_protocol2_filter()
>> here:
> 
> Wait a second.
> Is kill the same as shutdown ?
> I would expect that

No, kill is used if the filter behaved strangely or signaled an error.
"Shutdown" is a graceful shutdown. However, that might not be an ideal
name. See the bottom of my discussion with Peff here:
http://public-inbox.org/git/74C2CEA6-EAAB-406F-8B37-969654955413%40gmail.com/


> The process terminates itself as soon as it detects EOF.
> As there is nothing more read.
> 
> Then the next question: The combination of kill & protocol in kill_protocol(),
> what does it mean ?

I renamed that function to "kill_multi_file_filter". Initially I called
the multi file filter "protocol" (bad decision I know) and named the
functions accordingly.


> Is it more like a graceful shutdown_protocol() ?

Yes.

Thanks,
Lars