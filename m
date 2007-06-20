From: "Dongsheng Song" <dongsheng.song@gmail.com>
Subject: Re: Errors install git-1.5.2.2 on 64-bit AIX
Date: Wed, 20 Jun 2007 11:36:45 +0800
Message-ID: <4b3406f0706192036h32bf6081h9b1d6ef3981df585@mail.gmail.com>
References: <4b3406f0706191945j1a489743qfacdcafd7f7d73d4@mail.gmail.com>
	 <alpine.LFD.0.98.0706192007000.3593@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jun 20 05:37:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0r0H-0004sr-FI
	for gcvg-git@gmane.org; Wed, 20 Jun 2007 05:37:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759949AbXFTDgr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Jun 2007 23:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759962AbXFTDgr
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jun 2007 23:36:47 -0400
Received: from wx-out-0506.google.com ([66.249.82.230]:5251 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759949AbXFTDgq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2007 23:36:46 -0400
Received: by wx-out-0506.google.com with SMTP id t15so50714wxc
        for <git@vger.kernel.org>; Tue, 19 Jun 2007 20:36:45 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EIo5yepnqoM34eQPzhkkjWWiKUujvEnaiHzT03TpMb/9V3TsBLt/i01ztkOHohnvVWocvQIZoJfRTRABVErolSpuqG0jpbjTZoAEww6ZcK03pvzxPfqXCn1jelze5NUP1CFdVvO2d3gq7rw0J5YYRBZvEXwxzUUfKvRa22ecjo8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LYCyJp+SdklBW7PHaqgbyResVb2cv1mU10EgVeoYRKhX/HqZiSZm/AWtSwYFKfqgWcDHIa+Ir8INtEMiZh6YeHOejBC5fOeCRGlkyzanzdvSlVy1gH2tl2tZ8tSKp0bDMZ0X51akQed+/P/+x47YWMrUjAsXKagqcgA8RcQ9/fQ=
Received: by 10.70.129.4 with SMTP id b4mr369562wxd.1182310605527;
        Tue, 19 Jun 2007 20:36:45 -0700 (PDT)
Received: by 10.70.43.12 with HTTP; Tue, 19 Jun 2007 20:36:45 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.98.0706192007000.3593@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50527>

No "ginstall" or "gnuinstall". I will try compile coreutils-6.9 latter.

2007/6/20, Linus Torvalds <torvalds@linux-foundation.org>:
>
>
> On Wed, 20 Jun 2007, Dongsheng Song wrote:
> >
> > But install failed:
> > [ ... ]
> > Usage: install [-c dira] [-f dirb] [-i] [-m] [-M mode] [-O owner]
> >               [-G group] [-S] [-n dirc] [-o] [-s] file [dirx ...]
> > gnumake: *** [install] Error 2
>
> Do you possibly have a "ginstall" somewhere in addition to the GNU make?
>
> If so, just make the "INSTALL" macro in the Makefile point to that instead
> of the (apparently totally broken) regular "install" program on AIX.
>
> Maybe it's called "gnuinstall".
>
> That said, the installation is really just a matter of copying, so you
> *could* just replace the uses of "install" with either "-mkdir" or "cp"
> depending on whether it's used to make sure a directory exists, or to
> actually copy the programs.
>
>                 Linus
>
