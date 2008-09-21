From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH 01/14] Extend index to save more flags
Date: Sun, 21 Sep 2008 11:34:51 +0700
Message-ID: <fcaeb9bf0809202134p2457e0cdn50ae8183ba07bcde@mail.gmail.com>
References: <1221904913-25887-1-git-send-email-pclouds@gmail.com>
	 <1221904913-25887-2-git-send-email-pclouds@gmail.com>
	 <m3skrulbrd.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 21 06:40:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhGjn-0004b6-Fr
	for gcvg-git-2@gmane.org; Sun, 21 Sep 2008 06:39:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750877AbYIUEex (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Sep 2008 00:34:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750852AbYIUEex
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Sep 2008 00:34:53 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:8848 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750838AbYIUEex (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Sep 2008 00:34:53 -0400
Received: by fg-out-1718.google.com with SMTP id 19so995498fgg.17
        for <git@vger.kernel.org>; Sat, 20 Sep 2008 21:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=9A09IsXq8tEunyyD37vcWw+UzRZZ5enOVIQFCsEFkl0=;
        b=Y3hNono7KxZ1rMkb7/4qtehVbMRlpKQxf3S4+EwiFObc1arFSpf8dcTXQNiCYkD0Yj
         s065hN6ABLfceFU3CvENzyjWyzUXXI1DEDehuRO1d/b5JmB97d7FK1zHmV/7gWoKQmag
         Sgb4Jr5toTasGv3Zx2wBNf/20qSsGa0M8WksQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=bIjT4F2CVUn6a86EDaycltwt4Ze+kNppfm9vXWVFrVMlfcmOHdElLxOsfNKjYYMhao
         Krs2cWQcGRko/qrsNg3piOUJv7PeILYFZ/AgEChShzj75NL8QKlue6ugdU48p5V2fa2E
         9rYnt0qQ6bFK/wG/dZ5cIVpJNZmMMXZn5WO+0=
Received: by 10.86.72.15 with SMTP id u15mr3602351fga.22.1221971691330;
        Sat, 20 Sep 2008 21:34:51 -0700 (PDT)
Received: by 10.86.59.5 with HTTP; Sat, 20 Sep 2008 21:34:51 -0700 (PDT)
In-Reply-To: <m3skrulbrd.fsf@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96382>

On 9/21/08, Jakub Narebski <jnareb@gmail.com> wrote:
>  > +
>  > +#define CE_EXTENDED_FLAGS (0)
>  > +
>  > +/*
>  > + * Safeguard to avoid saving wrong flags:
>  > + *  - CE_EXTENDED2 won't get saved until its semantic is known
>  > + *  - Bits in 0x0000FFFF have been saved in ce_flags already
>  > + *  - Bits in 0x003F0000 are currently in-memory flags
>  > + */
>  > +#if CE_EXTENDED_FLAGS & 0x80CFFFFF
>  > +#error "CE_EXTENDED_FLAGS out of range"
>  > +#endif
>
>
> I don't quite understand the above fragment (especially with the fact
>  that CE_EXTENDED_FLAGS is defined as (0))...

Because this patch does not introduce any new on-disk flag yet so
CE_EXTENDED_FLAGS remains 0. In the next patch, CE_EXTENDED_FLAGS will
be updated to have CE_NO_CHECKOUT.
-- 
Duy
