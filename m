From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: Problems with git 1.8.5.3 on HP-UX 11.11
Date: Fri, 28 Mar 2014 15:43:29 -0400
Message-ID: <CAPig+cQKZ-oKTQ4Y2=qDaeQRXVZYOKRcSadOx2RwfjCziuu6fw@mail.gmail.com>
References: <9D24AD27564FAE4CB8D0C15D080DEFCB0106A89226@m4ukex08.intranet.macro4.com>
	<8FDD21D28EC16844948E2A773083574A03363EBC@m4ukex08.intranet.macro4.com>
	<20140328190156.GA30739@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Gerhard Grimm <gerhard.grimm@detec.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 28 20:43:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTcgx-0004hF-Nq
	for gcvg-git-2@plane.gmane.org; Fri, 28 Mar 2014 20:43:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751902AbaC1Tnb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2014 15:43:31 -0400
Received: from mail-yk0-f173.google.com ([209.85.160.173]:53597 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750925AbaC1Tna (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2014 15:43:30 -0400
Received: by mail-yk0-f173.google.com with SMTP id 10so4099428ykt.32
        for <git@vger.kernel.org>; Fri, 28 Mar 2014 12:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=V3E3mRS1Gh0hsUzltKzX53ghjF/ic7cRgHB5/JGjtPA=;
        b=c/pYKz90pJx8kG3jt48YAfZgkzIzxt572jEosDz4eINjN6shyCpLccpM3FZq9gOW/Y
         N/eVPqairwEnAzmNy/cFZpvrYfcpl40Cqs9hdNSSunyLDNHs7mTx00lXlWKn646NlXuw
         +mjnX5hBGmdbie7Po0+Ow0DN6YKFCQeHXDxCIHGGkpWv7/oID/nq7Zq8ETbr4e2l6aoS
         V+qVBrw5BM7JxxoheZF9Jd3GF4BGEmTZpQ83lfEt0UwdPxOHfPYFPVjH0Hz0nD7K8MIj
         tP39+IGHEXI3mm1TZIIJshIw8o71VkM7AhISlfLftnHlxOvF2mwfXQSLdBPvuBFhLEBi
         Dn2w==
X-Received: by 10.236.31.40 with SMTP id l28mr14356012yha.17.1396035809768;
 Fri, 28 Mar 2014 12:43:29 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Fri, 28 Mar 2014 12:43:29 -0700 (PDT)
In-Reply-To: <20140328190156.GA30739@sigill.intra.peff.net>
X-Google-Sender-Auth: M3oHK9fUXwXBPAnVbVLvnYy1Zg8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245423>

On Fri, Mar 28, 2014 at 3:01 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Mar 28, 2014 at 11:09:14AM -0000, Gerhard Grimm wrote:
>> git submodule init
>>
>> fails with the output
>>
>>     Assertion failed: err == REG_ESPACE, file compat/regex/regexec.c, line 1096
>>     No submodule mapping found in .gitmodules for path 'module'
>
> The regexes we use here are not particularly complicated. So either
> there is a bug (but nobody else has reported anything on any other
> platform) or your system regex library has some problem with what we are
> feeding it. The simplest solution may be to compile with:
>
>   NO_REGEX=YesPlease
>
> which will build and use the glibc implementation in compat/regex
> instead.

Based upon the assertion-failure message, it looks like he's already
using compat/regex.
