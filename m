From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: Re: [PATCH v5 2/4] Introduce "double conversion during merge" more gradually
Date: Thu, 1 Jul 2010 18:41:42 +0200
Message-ID: <D2F8C67C-F7AE-4523-870F-879B741C2591@gmail.com>
References: <cover.1277974452.git.eyvind.bernhardsen@gmail.com> <3ae294ef30c3539da47d101bc39638e63721eb0e.1277974452.git.eyvind.bernhardsen@gmail.com> <4C2C6BC5.1030905@viscovery.net> <7v630z41ao.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (iPhone Mail 8A293)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	"git@vger.kernel.orgList" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 01 18:41:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUMpT-0006AI-4a
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 18:41:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752979Ab0GAQla (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jul 2010 12:41:30 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:63644 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752785Ab0GAQl3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Jul 2010 12:41:29 -0400
Received: by wwb24 with SMTP id 24so99599wwb.1
        for <git@vger.kernel.org>; Thu, 01 Jul 2010 09:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:references:in-reply-to
         :mime-version:content-transfer-encoding:content-type:message-id:cc
         :x-mailer:from:subject:date:to;
        bh=ApfQRZoGcRxnpyld+HWZ15WQnXaWsQXDyRO5tu5VDII=;
        b=bUC706n4Jvjm+G7UdAXqIrAVoMR2odn+ePSkMnxOUecjffU2w6wvHo8lgtJrb8pPAv
         lbm+gIa7erDGG96+skONKep895y/Tv6tzjhzaFdU/PFQeNKxwaR5NTlqvFRZ/bPsYwix
         dib/UtLZ2Jp0r/qqMiAc1Ib0UZdiqCD8mDJOs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=references:in-reply-to:mime-version:content-transfer-encoding
         :content-type:message-id:cc:x-mailer:from:subject:date:to;
        b=uhDCuOXTp5Qx2i/B5aN65lzoLJ3yqLyB+mK63zSnkGN7nMDiVXP+2hPNtydxvzXnSl
         TiPqdHzG2R2YQoS5TOyEe0zJkKpE86XWl6vJjYz88ITycGtrFU59Tuy7VZy9AtiQLIkl
         OC/bYB9ejQ6j6911Bc9tyPTwaqWwhERrV60Ao=
Received: by 10.213.20.80 with SMTP id e16mr5733780ebb.13.1278002487858;
        Thu, 01 Jul 2010 09:41:27 -0700 (PDT)
Received: from [192.168.0.75] (38.183.251.212.customer.cdi.no [212.251.183.38])
        by mx.google.com with ESMTPS id b49sm11510964eei.5.2010.07.01.09.41.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 01 Jul 2010 09:41:26 -0700 (PDT)
In-Reply-To: <7v630z41ao.fsf@alter.siamese.dyndns.org>
X-Mailer: iPhone Mail (8A293)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150057>

On 1. juli 2010, at 18:25, Junio C Hamano <gitster@pobox.com> wrote:

> Johannes Sixt <j.sixt@viscovery.net> writes:
> 
>> Am 7/1/2010 11:09, schrieb Eyvind Bernhardsen:
>>> +core.mergePrefilter::
>> 
>> BTW, any particular reason that this is in the core namespace rather than
>> merge namespace? It could be merge.prefilter.
> 
> Good point.
> 
> Somehow to me "prefilter" does not sound to convey what really is going on
> here, though.

"Doubleconvert" doesn't really mean anything either though, and "convert" and "normalise" are too generic. I think the problem is that there's no existing name for what convert.c does.

I chose "filter" because of the filter property; the crlf and ident things can be regarded as built-in filters.
-- 
Eyvind
