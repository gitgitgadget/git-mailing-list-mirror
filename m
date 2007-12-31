From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH WIP] sha1-lookup: make selection of 'middle' less aggressive
Date: Tue, 1 Jan 2008 00:47:47 +0100
Message-ID: <e5bfff550712311547x484757f8lc3c8456a2719e827@mail.gmail.com>
References: <7vd4soa3cw.fsf@gitster.siamese.dyndns.org>
	 <7vtzm08l9w.fsf@gitster.siamese.dyndns.org>
	 <alpine.LFD.1.00.0712301150120.32517@woody.linux-foundation.org>
	 <7vodc77t0o.fsf@gitster.siamese.dyndns.org>
	 <e5bfff550712301404g273dd092w9b36b48d94ed1e70@mail.gmail.com>
	 <alpine.LFD.1.00.0712311232520.32517@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jan 01 00:48:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J9UMj-0007kR-2l
	for gcvg-git-2@gmane.org; Tue, 01 Jan 2008 00:48:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751776AbXLaXru (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Dec 2007 18:47:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751590AbXLaXru
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Dec 2007 18:47:50 -0500
Received: from rv-out-0910.google.com ([209.85.198.186]:63929 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751406AbXLaXrt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Dec 2007 18:47:49 -0500
Received: by rv-out-0910.google.com with SMTP id k20so4733525rvb.1
        for <git@vger.kernel.org>; Mon, 31 Dec 2007 15:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=0A2qs9w4X6wKw03n6hL/I7TwbtaREjF0glhKcT1XRMA=;
        b=wqhigpOsC3XUwV3zs9Gzzeg+2sfTcx98hi3KJPyXeRVKr8BU5nVVm7R0pRWHqpwNY/Si8LK06yWSFHqEF04abUFDPQMovcK3PjjwRtegkwfBFTY4rv2hMx3L352c0wmjjqiwRJMOi/UThoGWj6fihTx5/apkVLe9tbsF8TancT8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Vv8d9gihSZ+IPFrTR6Xarx+9cv5JpQg8Qk/L2mF2qeLk6AWP9pxs0QGEAvhZx0lTx5qWgV8biKKkQSDpSz0PYDzW7VtPYlf6OdPhlzp7jOsxWVbJZENKGjY0s49PwZpxo4/m6bjuBjRPkkXDX+a8DDlJYeHPR0rmquV/q4p6xXk=
Received: by 10.141.129.14 with SMTP id g14mr6176916rvn.209.1199144867911;
        Mon, 31 Dec 2007 15:47:47 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Mon, 31 Dec 2007 15:47:47 -0800 (PST)
In-Reply-To: <alpine.LFD.1.00.0712311232520.32517@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69426>

On Dec 31, 2007 9:37 PM, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
>
> Even today, I don't really know of a better compression choice, despite
> now being more aware of how critical uncompression performance is.
>

In the kernel, from not long ago, is used also LZO compression that
_seems_ much faster to decompress then zlib

http://lkml.org/lkml/2007/5/1/297

The developer, Richard Purdie, says it's also 40% faster to read for jffs2.

>
> Quite possibly, the cache miss costs dominate over any algorithmic costs.
>

What way could be used to build up a test to check this?


Thanks
Marco
