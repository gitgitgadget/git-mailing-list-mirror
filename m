From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v4 3/3] config: add '--show-origin' option to print the origin of a config value
Date: Tue, 16 Feb 2016 10:52:57 +0100
Message-ID: <AC15F01E-4B2C-4E38-98D7-F2D5B139B488@gmail.com>
References: <1455531466-16617-1-git-send-email-larsxschneider@gmail.com> <1455531466-16617-4-git-send-email-larsxschneider@gmail.com> <xmqqegcdpqhh.fsf@gitster.mtv.corp.google.com> <20160215225938.GA30631@sigill.intra.peff.net> <xmqq4md9o7da.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	sschuberth@gmail.com, ramsay@ramsayjones.plus.com,
	sunshine@sunshineco.com, hvoigt@hvoigt.net, sbeller@google.com,
	Johannes.Schindelin@gmx.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 10:53:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVcJk-0001XF-1V
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 10:53:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754530AbcBPJxG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 04:53:06 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:37246 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754341AbcBPJxC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 04:53:02 -0500
Received: by mail-wm0-f45.google.com with SMTP id g62so144071267wme.0
        for <git@vger.kernel.org>; Tue, 16 Feb 2016 01:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=nQC7i9aOZf2vNll0DrPTNXXqDV9Ku1aEr82/OIiNXhM=;
        b=AVZuYyoV9JXczE89V2hKcMiGvmTn115pwvrV7H5S06MnmAwwGcSOyhvWfKZQF6tD6V
         ycPGBW1jVWlIp3Bomzfpk+ARv9OQBaCFk3vJ19V5BhRzGQRS4k9XkHIx6Er5EHT6j9yX
         Xsh+2EK9GNgR6sRzqzOIVmEJbB+UFSIgsQspD0A+WNr0TvhoeZiNmruoYoUdzY+JQROA
         bP6fdktGQXfoO3sXjhnct0ULfipdtTI72FDlLNQWVAQ6HSAxdvKxJls4IGfLbv3/jwFx
         hvvT5h0UQxo5gXt3DgmXmQzpDO3vtOcMrV2Ei1ctlmGaztEznaM4J/wITen3YbZcoAvx
         wGMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:content-type:mime-version:subject:from
         :in-reply-to:date:cc:content-transfer-encoding:message-id:references
         :to;
        bh=nQC7i9aOZf2vNll0DrPTNXXqDV9Ku1aEr82/OIiNXhM=;
        b=DNVdmq6zEKYfioQLuCvQJt3nGbquysmzirDiDZvXZwLS2nueWRtJLnlIiw30Tm9K0v
         vJa8kIurSnuEAyj9rKgQCvnAQqp8A3/HmBk8j86nSb00dkch6HXYXft/8gIpFkm06Ibt
         JAhG3biTQzuLDLgLzJds4pqcVQaWnhg18ZaF653MVlz/CkyLQWosCt5gQLNXHPS8eW8f
         vjs8nK+Hfy77YAwEdZV0lCVt51wNGV1ckhEpwlvBjMx+SAc6HNJJTC5TXYJjCLiUaUn+
         t9/eOv1Gh0UwMNsNlsJGiq7m/ldeIfT2R6tEdeSUmH1hiOTY67WbxAp7NZxorOYBiqTf
         pmOw==
X-Gm-Message-State: AG10YOQUds1A7pH01aoUdyP9TQONcEAcMaCxXQKFpAAi3goMUp7fcU3OA8U4Q1iBoDi0vQ==
X-Received: by 10.194.236.233 with SMTP id ux9mr3952621wjc.161.1455616380768;
        Tue, 16 Feb 2016 01:53:00 -0800 (PST)
Received: from slxbook3.fritz.box (p5DDB43DD.dip0.t-ipconnect.de. [93.219.67.221])
        by smtp.gmail.com with ESMTPSA id hh8sm10645831wjc.42.2016.02.16.01.52.58
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Feb 2016 01:53:00 -0800 (PST)
In-Reply-To: <xmqq4md9o7da.fsf@gitster.mtv.corp.google.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286338>


On 16 Feb 2016, at 00:56, Junio C Hamano <gitster@pobox.com> wrote:

> Jeff King <peff@peff.net> writes:
> 
>>> An existing test t3300 tells me that a test that uses a path with a
>>> tab needs to be skipped on FAT/NTFS.  If your goal is to make sure
>>> dquote is exercised, can't we just do with a path with a SP in it or
>>> something?
>> 
>> It has to trigger quote_c_style(). You can see the complete set of
>> quoted characters in quote.c:sq_lookup, but space is not one of them.
>> Probably double-quote or backslash is the best bet, as the rest are all
>> control characters.
> 
> Yeah, 3300 seems to use dq for that.
> 
> Thanks for checking.

Thanks for the pointer Junio. I didn't think of FAT/NTFS. I will mimic
3300 and use double quotes.

Thanks,
Lars
