From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 14/21] Convert ce_path_match() to use struct pathspec
Date: Fri, 17 Dec 2010 22:11:30 +0700
Message-ID: <AANLkTinfzd8wOFTymVGeKH6cBg-6Ua6U+4N8x1TrQcHZ@mail.gmail.com>
References: <1292425376-14550-1-git-send-email-pclouds@gmail.com>
 <1292425376-14550-15-git-send-email-pclouds@gmail.com> <7v39pxl10y.fsf@alter.siamese.dyndns.org>
 <AANLkTikKCU==mS5_TdqHstETj=CQ_deHMCJ4xW0r+Sck@mail.gmail.com> <7vfwtwjv0f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 17 16:12:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTbyc-0002ti-4V
	for gcvg-git-2@lo.gmane.org; Fri, 17 Dec 2010 16:12:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755156Ab0LQPME (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Dec 2010 10:12:04 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:48531 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754861Ab0LQPMD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Dec 2010 10:12:03 -0500
Received: by wwa36 with SMTP id 36so753363wwa.1
        for <git@vger.kernel.org>; Fri, 17 Dec 2010 07:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=8jtWB2GXWvHRVfdbkPHJXsy4eRvVX4FG6va7LuhsXxw=;
        b=UJsSnMf9zWz7kQ2EtaA+PlONN94NOmAb7KWPmPw8stOa96kKIIj/p3JfzoA34A7Egw
         tnQ6qYHbuAUxLceGJbHGcW/7FQrlFrac//lijzcAU/FLBr7nNMJYWqUjcCVHj0dnuMpJ
         uLYJGoRZZzcsXe/Cwhf+4Okk3n0s0kla0k940=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=oEYKGPq45GRPysQvJOuhAkHPCBYvJZUgbiW3/y6gAbCYZbQAHvL8mWl1boEJCHdgvd
         it9n1MHs7WTgi2jLMwqe26vhIJUMZYkAdgJyLMl0QRV0TFzaKCwdOkMf3XXOP6MfTaKW
         9uBIm7PrV7Q8CN9uEYYhEvwBcWLQ5nhFF6LQ4=
Received: by 10.216.177.9 with SMTP id c9mr1257535wem.34.1292598721065; Fri,
 17 Dec 2010 07:12:01 -0800 (PST)
Received: by 10.216.158.83 with HTTP; Fri, 17 Dec 2010 07:11:30 -0800 (PST)
In-Reply-To: <7vfwtwjv0f.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163883>

On Fri, Dec 17, 2010 at 10:09 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>>> I wonder if it makes more sense to change the type of revs->prune_data
>>> from an array of pointers to strings to a pointer to struct pathspec.
>>> Is there a downside?
>>
>> Converting a pointer to another pointer means mis typecasting can
>> happen and the compiler won't help catching them.
>
> You can rename the field at the same time, and the compiler will catch
> anything you forgot to touch, no?
>

Yes. I didn't think of that :(
-- 
Duy
