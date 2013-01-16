From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH 1/2] fix clang -Wconstant-conversion with bit fields
Date: Thu, 17 Jan 2013 00:15:43 +0100
Message-ID: <CALWbr2zLZpCtcszihHcbiu5vwP6ezUd3ZLLGw2ck2aykPQpg8w@mail.gmail.com>
References: <20130116182449.GA4881@sigill.intra.peff.net>
	<1358376443-7404-1-git-send-email-apelisse@gmail.com>
	<20130116230800.GB4574@serenity.lan>
	<CALWbr2ypYUvuE4pWfcVvVcnJkRvCNrM1gVHp_UXeke9gbgoE3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Max Horn <max@quendi.de>, Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Thu Jan 17 00:16:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvcDE-0004m0-Vj
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jan 2013 00:16:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756926Ab3APXPp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 18:15:45 -0500
Received: from mail-ea0-f180.google.com ([209.85.215.180]:48941 "EHLO
	mail-ea0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755806Ab3APXPo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 18:15:44 -0500
Received: by mail-ea0-f180.google.com with SMTP id c1so743672eaa.39
        for <git@vger.kernel.org>; Wed, 16 Jan 2013 15:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=kenSQXSE1itDI9CEneaBTqeTHoNOMU7epPsZ0nW57I0=;
        b=wmiz3l21VillCDHXdiUEDNtNzFdI3Y0AtTw8hJgLR7yp/5rkyrVakc6SCym2o+IKMJ
         2kjIsyTxumOwHS8UZ8+vw6Gg9VkgAshFnmWkIoeWY0ZWUCpSDclQlY5eKQRGzk97XJ5Y
         4oDAUS23lLF0UH+Kav7aVcwsP+FDu8hIVcOpeGZ1aTW1XosrJJuk5RD8OM9+ve+l32Jz
         4rtXVpz/ZnkCAfvln8g7Imx8FmMBQ8IGea7Xk67x/SKmKAkbHyxjPxbRSuHehfZxWrgB
         qjdYzkf/WTfcRCGZqf8x7mlhDFQrsjs34lyAlfzyFVpPOAQJmzVC3EC7TMVupJkiGfGg
         fXYA==
X-Received: by 10.14.1.195 with SMTP id 43mr6718680eed.31.1358378143430; Wed,
 16 Jan 2013 15:15:43 -0800 (PST)
Received: by 10.14.187.6 with HTTP; Wed, 16 Jan 2013 15:15:43 -0800 (PST)
In-Reply-To: <CALWbr2ypYUvuE4pWfcVvVcnJkRvCNrM1gVHp_UXeke9gbgoE3A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213824>

So I guess we should drop this patch, it's probably not worth it,
especially if it's been fixed already by clang.

On Thu, Jan 17, 2013 at 12:09 AM, Antoine Pelisse <apelisse@gmail.com> wrote:
> On Thu, Jan 17, 2013 at 12:08 AM, John Keeping <john@keeping.me.uk> wrote:
>> On Wed, Jan 16, 2013 at 11:47:22PM +0100, Antoine Pelisse wrote:
>>> clang incorrectly reports a constant conversion warning (implicit
>>> truncation to bit field) when using the "flag &= ~FLAG" form, because
>>> ~FLAG needs to be truncated.
>> Which version of clang did you see this with?  I don't get these
>> warnings with clang 3.2.
>
> Ubuntu clang version 3.0-6ubuntu3 (tags/RELEASE_30/final) (based on LLVM 3.0)
>
> It's good to know it's been fixed !
