X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Erik Mouw <erik@harddisk-recovery.com>
Subject: Re: sizeof(struct ...)
Date: Thu, 23 Nov 2006 16:54:31 +0100
Organization: Harddisk-recovery.com
Message-ID: <20061123155431.GD6581@harddisk-recovery.com>
References: <20061123101609.1711.qmail@8b73034525b1a6.315fe32.mid.smarden.org> <45659781.5050005@lsrfire.ath.cx> <4565A46C.6090805@lsrfire.ath.cx> <4565A866.8020201@shadowen.org> <4565C205.8050300@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 23 Nov 2006 15:55:02 +0000 (UTC)
Cc: Andy Whitcroft <apw@shadowen.org>, Gerrit Pape <pape@smarden.org>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <4565C205.8050300@lsrfire.ath.cx>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32143>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnGuM-0004RP-DB for gcvg-git@gmane.org; Thu, 23 Nov
 2006 16:54:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755123AbWKWPyd (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 23 Nov 2006
 10:54:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756350AbWKWPyd
 (ORCPT <rfc822;git-outgoing>); Thu, 23 Nov 2006 10:54:33 -0500
Received: from dtp.xs4all.nl ([80.126.206.180]:23689 "HELO
 abra2.bitwizard.nl") by vger.kernel.org with SMTP id S1755123AbWKWPyc (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 23 Nov 2006 10:54:32 -0500
Received: (qmail 30562 invoked from network); 23 Nov 2006 16:54:31 +0100
Received: from unknown (HELO zurix.bitwizard.nl) (192.168.234.26) by
 abra2.bitwizard.nl with SMTP; 23 Nov 2006 16:54:31 +0100
Received: from erik by zurix.bitwizard.nl with local (Exim 3.36 #1 (Debian))
 id 1GnGuF-0002Cg-00; Thu, 23 Nov 2006 16:54:31 +0100
To: Ren? Scharfe <rene.scharfe@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org

On Thu, Nov 23, 2006 at 04:45:09PM +0100, Ren? Scharfe wrote:
> Andy Whitcroft schrieb:
> > You see packing attributes applied to similar things in the kernel.
> > Perhaps they are relevant here?
> > Is there not some kind of attribute thing we can apply to this structure
> > to prevent the padding?  You see that in the kernel from time to time.
> > 
> > struct foo {
> > } __attribute__((packed));
> 
> Yes, that would be nice, but unfortunately __attribute__ is no standard
> C.

There is no standard C way to pack structures. Some compilers use
#pragma's, gcc uses __attribute__((packed)).

>  Is there really a compiler that inserts padding between arrays of
> unsigned chars?

Yes, that compiler is called "gcc".

#include <stdio.h>

struct foo {
        unsigned char a[3];
        unsigned char b[3];
};

int main(void)
{
        printf("%d\n", sizeof(struct foo));
        return 0;
}

On i386 that prints 6, on ARM it prints 8.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
