From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/2] t/lib-http/apache.conf: load mod_unixd module in
 apache 2.4
Date: Thu, 25 Feb 2016 15:41:54 -0800
Message-ID: <CAPc5daUEqb2xuJFGj2xCPn-uqJ5XDcpP7VmiZr0VjZQ48m=ELw@mail.gmail.com>
References: <1456426632-23257-1-git-send-email-jacob.e.keller@intel.com>
 <20160225220045.GA10267@sigill.intra.peff.net> <xmqqbn74mlco.fsf@gitster.mtv.corp.google.com>
 <xmqq37sgml9f.fsf@gitster.mtv.corp.google.com> <CA+P7+xrtkgAv3oNwSvO1hfSAz_VDNGSa4GQWWSPDnZrZdsDokg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Jacob Keller <jacob.e.keller@intel.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Git mailing list <git@vger.kernel.org>,
	Mark Strapetz <marc.strapetz@syntevo.com>,
	Stefan Beller <sbeller@google.com>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 00:42:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ5Y3-0003tA-Am
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 00:42:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752116AbcBYXmP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 18:42:15 -0500
Received: from mail-yk0-f194.google.com ([209.85.160.194]:33582 "EHLO
	mail-yk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751959AbcBYXmP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 18:42:15 -0500
Received: by mail-yk0-f194.google.com with SMTP id r207so1714985ykd.0
        for <git@vger.kernel.org>; Thu, 25 Feb 2016 15:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=Lo983HaA9xj4TDC+M819lDqmV33/N0XCmYUAT1ge6KI=;
        b=JNDsKWU6PljAyG2VC5R08WLOj7UI17PSS1g68D7NPymI9iWPm3kUhpLZvY820+PS6s
         piDptmOm9iNmBkNjeq+fX7YJAT11+ME9SBc+CB2xx7+2yNLsu3IYkTImpJsVIka/k9m2
         ALDNfflqznUEWYSZi4k/4gy+xzBIvu6zv5fjDmFqgFPMNMsi6BFAY1OvOlpLciE+bOTG
         c3ogtzD1H6FMc27qMPaik2Bq6oYCs+1DMFXe62eZINVB2MdVZb/hBIljBvMCmHX8qtjF
         zWY2AHBpkIj/uUY4n7TAF7Cu05z5hXzww5v4CrrdMD8YAZyCCIJHYVgZlopsij/9boWf
         W/SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-type;
        bh=Lo983HaA9xj4TDC+M819lDqmV33/N0XCmYUAT1ge6KI=;
        b=mpCFqN097dQ8G8oPs5y4DneaSTtg2ip1f/ZZdmVPrRNHM0gBogZb3SloMdYe5H/9ih
         ofbfXr8s0IJe9XMPbAVRndfcDThggqmJFp7xzRzRSk+z8ZTt2VTwTCsnzZ70SLgJw5vF
         cFKkpZACxmICQPZ7/Zl/Uu/3EGXlG1aO9nb+C+Xx4xtm5QFb+fqC1HfXQE2RrPq8X45K
         FZ4RbmVM+V2D2yTBF612BlH+tLkESZDjNhSUYn5jRlf9DkkL4dPcs1P6SvTLTQvrf1bg
         LEvTJbcV0xbUPZqzfbP3y9FIQxYwV+xJrjBCrMc8vbjropPtCbDAmsBxrGELSrLHrOFJ
         +rcg==
X-Gm-Message-State: AG10YOSOx8SV64JXRG946vWWV7d5HjTPCXjEvCRag0MJv7UOQ2abKdhnPzgrAXg2bKR28SNNvtAuyoOV2McgdA==
X-Received: by 10.37.25.193 with SMTP id 184mr26158885ybz.47.1456443734339;
 Thu, 25 Feb 2016 15:42:14 -0800 (PST)
Received: by 10.129.116.131 with HTTP; Thu, 25 Feb 2016 15:41:54 -0800 (PST)
In-Reply-To: <CA+P7+xrtkgAv3oNwSvO1hfSAz_VDNGSa4GQWWSPDnZrZdsDokg@mail.gmail.com>
X-Google-Sender-Auth: HvG1onQ27roTBm2MNJE6bd-VXT8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287495>

On Thu, Feb 25, 2016 at 3:39 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
>>
>> Ahh, the one you quoted does have a better log message.  Let's
>> replace the ancieint one I have and use Jacob's 2/2 on top of it.
>>
>
> Agreed. I did not know the source of the issue, only what fixed it.

Actually, let's wait a bit to avoid unnecessary conflicts between topics.
sb/submodule-fetch-nontip changes the way how these calls to "clean env"
helper function are made.
