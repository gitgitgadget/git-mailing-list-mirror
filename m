From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH] t3032 - make compatible with systems using \r\n as a
 line ending
Date: Tue, 16 Jul 2013 15:44:07 -0400
Message-ID: <51E5A287.40708@gmail.com>
References: <51E591FF.7030600@gmail.com> <1374000592-31845-1-git-send-email-mlevedahl@gmail.com> <20130716185933.GO14690@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 16 21:44:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzBAV-0006Gq-VO
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jul 2013 21:44:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933785Ab3GPToM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jul 2013 15:44:12 -0400
Received: from mail-qc0-f176.google.com ([209.85.216.176]:35873 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933352Ab3GPToL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jul 2013 15:44:11 -0400
Received: by mail-qc0-f176.google.com with SMTP id z10so624748qcx.35
        for <git@vger.kernel.org>; Tue, 16 Jul 2013 12:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=9Eycs8NslrUbXePGrlMKI0YmdLm/nE5Uq7/33lC7PGg=;
        b=yCzUQ1d95aUm6JthhycckfaIySuaIazOb1YbmbceWfOy8biRgxpGCIza6JeJoUZ09n
         ZNTvnY5fPRpgOgVZ7/xn1s7gsqnWNCZGN4SsWkfSMOHT9470HRq71fyqqNAo/Zh5PM43
         XslDuOQT4NsbjPVEgM7uifDjGAi/ALI5GLoc3wLRzczW+w7C9hv5wg/hBsjvjHzEV6rJ
         CCJ85A8aJ476W21/l1BTI1cw2yrPRwVpaB8/x3IdJAcKU31ZM3lqdKiJUCSkS09IYlxa
         9BHzn5IFYNret9+5yN9gKQFJX5HOYG4n7weEAvgt2+w23FKG5MaMtis5Z5BM+5S5BciO
         AsdQ==
X-Received: by 10.49.95.97 with SMTP id dj1mr4248941qeb.46.1374003850023;
        Tue, 16 Jul 2013 12:44:10 -0700 (PDT)
Received: from mark-laptop.lan (pool-72-66-83-222.washdc.fios.verizon.net. [72.66.83.222])
        by mx.google.com with ESMTPSA id t18sm6826741qam.12.2013.07.16.12.44.08
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 16 Jul 2013 12:44:09 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
In-Reply-To: <20130716185933.GO14690@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230579>

On 07/16/2013 02:59 PM, Jonathan Nieder wrote:
> Mark Levedahl wrote:
>
>> Subtests 6, 7, and 9 rely test that merge-recursive correctly
>> ignores whitespace when so directed. Change the particular whitespace
>> sequences to be ones that are not known line endings so the whitespace
>> is not changed when being extracted by line oriented grep.
> merge-recursive needs to be able to deal with \r at EOL, too, so if at
> all possible I would prefer to see the test fixed to pass on Cygwin
> some other way.
>
> Thanks.
>
No line oriented tool is going to avoid this problem. I suppose someone 
with much more perl skill I possess could write a grep replacement 
explicitly using binary file modes to fix this. Or, the test could just 
check the sha1sum of text.txt against a prestored value, Or the test 
could use \r\n ONLY on systems that do not use that as a line ending 
mode. Or ...

Mark
