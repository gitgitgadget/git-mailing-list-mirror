From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [PATCH RFC 1/6] Re: send-email: Add --delay for separating emails
Date: Thu, 9 Apr 2009 12:38:15 -0500
Message-ID: <b4087cc50904091038v46f7f42bj844ba3a87ee28821@mail.gmail.com>
References: <49dcb464.06d7720a.66ca.ffffbd30@mx.google.com>
	 <20090409161756.GA12910@vidovic>
	 <b4087cc50904091027l4656a6adv6a72bad0a747cdc1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nicolas Sebrecht <nicolas.s-dev@laposte.net>
X-From: git-owner@vger.kernel.org Thu Apr 09 19:41:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LryFJ-0006Lh-4p
	for gcvg-git-2@gmane.org; Thu, 09 Apr 2009 19:41:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763516AbZDIRiV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Apr 2009 13:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933580AbZDIRiU
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Apr 2009 13:38:20 -0400
Received: from mail-qy0-f118.google.com ([209.85.221.118]:42619 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934072AbZDIRiR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Apr 2009 13:38:17 -0400
Received: by qyk16 with SMTP id 16so1532588qyk.33
        for <git@vger.kernel.org>; Thu, 09 Apr 2009 10:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=5Gjr1Dz6VusjxusHIrHi8a+0s7IH39mHIoSG03/3Kr8=;
        b=u/IVMcWf+XmWAjkN3+Q5kMEIbPi4xTEwQ3qdUft07koR5TOYn+yJchHWc6hY1J1aQd
         O0lBWqxK7U742xHRH1AJIGT9JcY3POcVJfMAM/qsT7az7z0fja048lpmJM2aTM354gdo
         vi1BOr/1gfag55ovvhw57Wp16GCy+U91WtZgg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=tz+SnbCNlpBmgSZeN6z+hIEDxcKBbtjS5H0cnWu2xZdACsjGf8ddd6sDcwToBEPmiq
         7U3bJKbc5TCkHpX3o8eT4sfxWQo7WidjOKgxeVV50qwLmd5sdUyZnFVfO6gajahZMgnl
         TwjDj2JGfl5K3X7ngom8/GQPT/sPTxZSRHMNA=
Received: by 10.224.11.77 with SMTP id s13mr3223616qas.4.1239298695993; Thu, 
	09 Apr 2009 10:38:15 -0700 (PDT)
In-Reply-To: <b4087cc50904091027l4656a6adv6a72bad0a747cdc1@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116187>

On Thu, Apr 9, 2009 at 12:27, Michael Witten <mfwitten@gmail.com> wrote:
> On Thu, Apr 9, 2009 at 11:17, Nicolas Sebrecht
> <nicolas.s-dev@laposte.net> wrote:
>>
>> The --delay option may have an undesirable side effect. In case of
>> non-chained emails, unrelated mails could be insterted between patches
>> where *all* MUA would be affected. It's not only true for very high
>> volume message mailing-lists (million monkeys receiving...). FMPOV, it's
>> worse than all display issues we already know or have with the current
>> behaviour.
>
> But it's already impossible to protect against this scenario. In that
> situation, the smallest delay possible is desired, so --delay wouldn't
> even be used (that is, its value would be zero). However, the transit
> delay could never be small enough to guarantee that no other emails
> are inserted into the patch series, so the only solution is to chain
> them. At this point, we're back to the problem of arrival time, and
> hence --delay becomes useful.

I do agree that --delay could exacerbate the spreading out of patches.
