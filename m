From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] diff: report bogus input to -C/-M/-B
Date: Thu, 21 Oct 2010 11:53:40 -0500
Message-ID: <20101021165340.GE3732@burratino>
References: <20101021144947.GA18210@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 21 18:57:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8ySJ-0004rH-OJ
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 18:57:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753305Ab0JUQ50 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 12:57:26 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:48272 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752617Ab0JUQ5Z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 12:57:25 -0400
Received: by vws2 with SMTP id 2so2832487vws.19
        for <git@vger.kernel.org>; Thu, 21 Oct 2010 09:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=FTkZdTW4+VffxusQz0P4ZjvzVWrtuihNlUdLt54C0EA=;
        b=gPgG0IEKOcB4vpdeBiphC7gbjDOQ7tsKpzF8hm7Mp3D4gKBi1zDap9O5jxWy6X7NB7
         rPwgFnv3qTFRcInoDagj7CwAJ8v5wZfKh0ruoc2Orz15LC3+FhbJOwdl6sA/rRR/+lHk
         R4GtE1uEGVFDrpmm60bVF9S7UA2+Hp8fBOsfc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=E0TlB5XruZzjARdH/kw/+IG1f6wJBpI/rTBK+/Uzj8K9tFVHeu4oILQLwCXkdY3/nG
         3aBCuq4kgxyvynlXltlT09N/38r4lUlOQX2SrwNqfKh88cDvHSnrIC/nAaaR8aoFD9EO
         drALSUuKpOpZUh2HrjXQE7Iwa+fW7/hJoUPQQ=
Received: by 10.220.187.11 with SMTP id cu11mr245762vcb.269.1287680244592;
        Thu, 21 Oct 2010 09:57:24 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id v20sm940591vbw.9.2010.10.21.09.57.22
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 21 Oct 2010 09:57:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101021144947.GA18210@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159524>

Jeff King wrote:

> Before:
> 
>   $ git diff -CM
>   $ echo $?
>   128
> 
> After:
> 
>   $ git diff -CM
>   error: invalid argument to -C: M
>   $ echo $?
>   128

Yes, please.

Who is it that exits(128) in this code path?  Are there other
functions it calls that might return an error without reporting it to
stderr?
