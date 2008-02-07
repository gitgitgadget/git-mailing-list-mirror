From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: git-fetch in 1.5.4 fails versus 1.5.3.8
Date: Fri, 8 Feb 2008 00:53:09 +0300
Message-ID: <20080207215309.GP30368@dpotapov.dyndns.org>
References: <pan.2008.02.04.18.25.26@progsoc.org> <20080205050741.GA4624@coredump.intra.peff.net> <pan.2008.02.06.21.56.35@progsoc.org> <20080207042332.GA7632@sigill.intra.peff.net> <pan.2008.02.07.10.15.05@progsoc.org> <20080207142322.GC18497@mail-vs.djpig.de> <alpine.LFD.1.00.0802071039010.2883@woody.linux-foundation.org> <20080207204026.GA2550@sigill.intra.peff.net> <alpine.LFD.1.00.0802071256570.2896@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Frank Lichtenheld <frank@lichtenheld.de>,
	Anand Kumria <wildfire@progsoc.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Feb 07 22:53:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNEgn-000848-PG
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 22:53:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754381AbYBGVxQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 16:53:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754362AbYBGVxQ
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 16:53:16 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:13553 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753033AbYBGVxP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 16:53:15 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1013170nfb.21
        for <git@vger.kernel.org>; Thu, 07 Feb 2008 13:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=lnKrni48HJDQXTYZ+9ZgILI6IlndmXHs7g6Zal4sgIs=;
        b=FBQTGBeMRrFfmm83TnmjtfaKybj7Vv4bx3w/OgvXiTQsKGACIus4mK9uyzT/gI+Vn/TBJz7P4PfPgnTkle7f81Hn43phEFEDyUQ8JYjexWM5Tfyf+D3/umDqhrAETLv3OLKbKTOKaTrtyOwRpHORBrzHB27UvSDWFcx6l3dmLF0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=W3sS9a0ost4R70DV2BeZKHq+tVyMN2jkyscYFcx26NWBT4UVsFd4psOYKcrNPD/ZgFINYplu4boPuxZEjDmpJsdRfhScgzWEbFhDZLUToXqYPt1HucsnH02y+oaabQQkr8En+AK++A8BKMEytxLGksa+PkASCei6irSyP6ONNS0=
Received: by 10.78.168.1 with SMTP id q1mr21232391hue.76.1202421193228;
        Thu, 07 Feb 2008 13:53:13 -0800 (PST)
Received: from localhost ( [85.141.191.183])
        by mx.google.com with ESMTPS id j10sm12711110muh.16.2008.02.07.13.53.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 07 Feb 2008 13:53:12 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0802071256570.2896@woody.linux-foundation.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73008>

On Thu, Feb 07, 2008 at 01:01:09PM -0800, Linus Torvalds wrote:
> 
> On Thu, 7 Feb 2008, Jeff King wrote:
> > 
> > FWIW, this is not about OpenSSL for SHA1; it is about the underlying
> > library used by curl to do SSL (gnutls vs openssl).
> 
> My comment was about claiming "not distributable". That was simply not 
> true. It's perfectly distributable, it's just Debian that has issues with 
> OpenSSL (but then they shouldn't link it against curl either, so there 
> seems to be some _other_ problem there too).

The curl license is very permissive, so there is no problem to link it
against any GPL program. OTOH, the OpenSSL is more restrictive than GPL,
and because GPL is copyleft (i.e. it prevents adding any restriction on
any derived work) to distribute Git linked against OpenSSL is technically
illegal unless OpenSSL is the part of the standard OS libraries or Git
developers provide a special exemption that allows to link Git against
OpenSSL and to redistribute the result. For more details, see
http://www.gnome.org/~markmc/openssl-and-the-gpl.html

Dmitry
