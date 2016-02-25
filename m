From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v3 1/2] t/lib-http/apache.conf: load mod_unixd module in
 apache 2.4
Date: Thu, 25 Feb 2016 15:39:37 -0800
Message-ID: <CA+P7+xrtkgAv3oNwSvO1hfSAz_VDNGSa4GQWWSPDnZrZdsDokg@mail.gmail.com>
References: <1456426632-23257-1-git-send-email-jacob.e.keller@intel.com>
 <20160225220045.GA10267@sigill.intra.peff.net> <xmqqbn74mlco.fsf@gitster.mtv.corp.google.com>
 <xmqq37sgml9f.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Jacob Keller <jacob.e.keller@intel.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Git mailing list <git@vger.kernel.org>,
	Mark Strapetz <marc.strapetz@syntevo.com>,
	Stefan Beller <sbeller@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 00:40:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ5Vq-0002PB-CU
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 00:40:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752238AbcBYXj6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 18:39:58 -0500
Received: from mail-io0-f176.google.com ([209.85.223.176]:36018 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752116AbcBYXj6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 18:39:58 -0500
Received: by mail-io0-f176.google.com with SMTP id l127so105442956iof.3
        for <git@vger.kernel.org>; Thu, 25 Feb 2016 15:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=L78p2hOc/c9Rebs/NZIDGaxMFCKvquYEfR4r6DQmtb8=;
        b=Ucd8SyHB5FhiUEVq9CjekUAbWvPke2ULKp9ePeX7ztJOTIG9D8JFKH2uEIks4235Za
         3sf1h2czYRv6IQj6ujqWxm1fhcD9SOYaartQTfGCZXIywtUg69xTU4o/4sHz3zawbiF9
         N02Kgf72zOlXhJBSIz/sSwyxvcJBgCESQB6Y9OvVaYkvGMoLq1O77tSZuX61jv4Tva1o
         4nMO9Jl5vSxmTV01PO04GFUlGIRNOIjHy6thGUtserc2nIhzh0CXRaZy8a5guh0Yjo8h
         FF/0boaLd3Gw4mkCm2lvTYatHgNZTyPEW8UbHZ2biSiaEzEY1Ooc87r1Sel8trxD8ayU
         zv8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=L78p2hOc/c9Rebs/NZIDGaxMFCKvquYEfR4r6DQmtb8=;
        b=Px1pqe4uNQ+GoCgCrTaS/XLydja8wXIDinIoUFgYh8DofnGD0bgz1kHN95Jezeuxmw
         f6qkmyLqKDX5Qi1NWTfMPTFZm9IL0mn9Ne0XF/LxK72sa3kig66LRdzamkDfxIkYvkCp
         mr8DfrxgqKFGGIFx+K1fNna+3uXYO0Wk8/lNML4oAA41pgO/nAK0p30hQF0EKTTFyfv0
         cbdR9HAAenDrlQRrV3ubNrbAxBd165vYaGKqaeoWNCGlNabUntN9u/Ulw0cNbSaLld/t
         Zd126QqWDxgknUcUQxE5d6JUSHucBTrd7QUCFkGTFIlWTHq39d3HhFibEZlGoW4svN3F
         Qpsg==
X-Gm-Message-State: AG10YORwK7pqMAZ+uVYlPCEUQbmqnYfY+AjhR61TIapBZ7ksabBdrzi+O3hKr1ztQBTm3Y3S9hWSJ2Zr9XjqMg==
X-Received: by 10.107.156.14 with SMTP id f14mr6580855ioe.0.1456443597148;
 Thu, 25 Feb 2016 15:39:57 -0800 (PST)
Received: by 10.107.20.76 with HTTP; Thu, 25 Feb 2016 15:39:37 -0800 (PST)
In-Reply-To: <xmqq37sgml9f.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287493>

On Thu, Feb 25, 2016 at 3:18 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>>> Michael (cc'd) posted an identical patch with some more discussion back
>>> in May:
>>>
>>>   http://article.gmane.org/gmane.comp.version-control.git/268770
>>>
>>> The series languished because none of the reviewers had systems that
>>> reproduced the problem, and I think there's some additional work needed
>>> to get all of the svn-over-http tests running[1].
>>>
>>> I think this bit should be OK to take without the rest (though I like
>>> the extra discussion in the original).
>>
>> I can resurrect 745a5487 (t/lib-httpd: load mod_unixd, 2015-04-08),
>> which is still on 'pu', and apply 2/2 from Jacov on top of it.
>
> Ahh, the one you quoted does have a better log message.  Let's
> replace the ancieint one I have and use Jacob's 2/2 on top of it.
>

Agreed. I did not know the source of the issue, only what fixed it.

Thanks,
Jake
