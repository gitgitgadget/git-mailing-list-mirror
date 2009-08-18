From: Frank Li <lznuaa@gmail.com>
Subject: Re: [PATCH 03/11] Define SNPRINTF_SIZE_CORR 1 when use MSVC build git
Date: Tue, 18 Aug 2009 09:19:26 +0800
Message-ID: <1976ea660908171819m38d3524ud174a7e76a171e75@mail.gmail.com>
References: <1250524872-5148-1-git-send-email-lznuaa@gmail.com>
	 <1250524872-5148-2-git-send-email-lznuaa@gmail.com>
	 <1250524872-5148-3-git-send-email-lznuaa@gmail.com>
	 <alpine.DEB.1.00.0908171829510.4991@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Aug 18 03:19:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdDMN-0007gU-Uy
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 03:19:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758528AbZHRBT0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 21:19:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758533AbZHRBT0
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 21:19:26 -0400
Received: from qw-out-2122.google.com ([74.125.92.27]:11776 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752223AbZHRBT0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 21:19:26 -0400
Received: by qw-out-2122.google.com with SMTP id 8so1128348qwh.37
        for <git@vger.kernel.org>; Mon, 17 Aug 2009 18:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=UsNYAfN0qM0zPvFrNc5FhY85gj7iZCi2xnImDCEeqQw=;
        b=JFjgZjNrvwOeY4blZhjK89pr+4l+x34ja/FBONmMKdJYgZ+Su+G7RXh/OlbApszv19
         JhZIsbVDSgals4XLj5CCbpGPBNDu7F7yHobW1PRqRMerWC2HMmJY0sXBR1xSbJVW84xh
         KIVxFAtPgIsMTkdRfo1XkW+xDVS/OlaDtz+xM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=KokjaxMj2LFsgHXsxdqtcXoXelriJjEJRUmodD4kkcu1DazOmR4Qr1RbuLqLVZHC0c
         h7bxhOxFIOtXzqxGV8MzmiG4R1QWiLb/DgERBGfaBzmuU9oDx1pxTBCaHHdHAkPEltEY
         XlK4cvIYqwhhFdgsNieHdZq2DP3QEgjy4EAxQ=
Received: by 10.224.103.70 with SMTP id j6mr4904322qao.208.1250558367023; Mon, 
	17 Aug 2009 18:19:27 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0908171829510.4991@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126335>

> How about this instead?
>
> 	Define SNPRINTF_SIZE_CORR=1 for Microsoft Visual C++
>
> 	The Microsoft C runtime's vsnprintf function does not add NUL at
> 	the end of the buffer.
>
> 	Further, Microsoft deprecated vsnprintf in favor of _vsnprintf, so
> 	add a #define to that end.

Of course,  do you need me change commit comment and resend patch?

>
> The patch is good, although I suspect that the definition of vsnprintf is
> better handled in the precompiler options in .vcproj.
>

If define in .vcproj, it needs copy that to DEBUG\RELEASE and 32bit\64bit (2x2)
4 places. It is easy to miss one.

> Ciao,
> Dscho
>
