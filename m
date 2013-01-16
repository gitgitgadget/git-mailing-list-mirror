From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH 1/2] fix clang -Wconstant-conversion with bit fields
Date: Thu, 17 Jan 2013 00:09:47 +0100
Message-ID: <CALWbr2ypYUvuE4pWfcVvVcnJkRvCNrM1gVHp_UXeke9gbgoE3A@mail.gmail.com>
References: <20130116182449.GA4881@sigill.intra.peff.net>
	<1358376443-7404-1-git-send-email-apelisse@gmail.com>
	<20130116230800.GB4574@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Max Horn <max@quendi.de>, Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Thu Jan 17 00:10:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tvc7U-0004Ze-VX
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jan 2013 00:10:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755127Ab3APXJt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 18:09:49 -0500
Received: from mail-ea0-f176.google.com ([209.85.215.176]:47519 "EHLO
	mail-ea0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754816Ab3APXJs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 18:09:48 -0500
Received: by mail-ea0-f176.google.com with SMTP id a13so460987eaa.21
        for <git@vger.kernel.org>; Wed, 16 Jan 2013 15:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=fIEjJkGVm5RANiNMhXc0s6ophxLTXz8ty33gFyylo+w=;
        b=EW3cEC6+/OzA2t76SZIqNgBozroV+ymtI82YFpgD3X/CqoURQr3SZgyMXzzmcco0Ij
         Y7RNtfScvJOKuE/AYM+5mH3ip0PfcMVODKCkHFLNYy3nQjscn0Kn94AqrQ2E4HX8dBF2
         PiRuQwjHPMno1MKAvPXI3SbnRO21cyUXTha59SqHpPODaicLN2GgsgGmGN/zmYrStxgq
         njy9Zcaj8+yWsT1ekfzQgMa/FDgW/ZPnr6DU+jVj+a82SBR/jzIVVMcDscvSVdMUkAiG
         ffl03Ddkx2+A4+O89YNqi7iHiuqOUShlGvFFqwtUNLf5SLHJxhdMhiNUHxCelemOiRoH
         Ko7Q==
X-Received: by 10.14.178.196 with SMTP id f44mr6768356eem.14.1358377787326;
 Wed, 16 Jan 2013 15:09:47 -0800 (PST)
Received: by 10.14.187.6 with HTTP; Wed, 16 Jan 2013 15:09:47 -0800 (PST)
In-Reply-To: <20130116230800.GB4574@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213822>

On Thu, Jan 17, 2013 at 12:08 AM, John Keeping <john@keeping.me.uk> wrote:
> On Wed, Jan 16, 2013 at 11:47:22PM +0100, Antoine Pelisse wrote:
>> clang incorrectly reports a constant conversion warning (implicit
>> truncation to bit field) when using the "flag &= ~FLAG" form, because
>> ~FLAG needs to be truncated.
> Which version of clang did you see this with?  I don't get these
> warnings with clang 3.2.

Ubuntu clang version 3.0-6ubuntu3 (tags/RELEASE_30/final) (based on LLVM 3.0)

It's good to know it's been fixed !
