From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Git help for kernel archeology, suppress diffs caused by CVS keyword expansion
Date: Mon, 23 Jul 2007 10:44:00 -0400
Message-ID: <9e4733910707230744u2d3a0a31t9f65d5c9e68c9805@mail.gmail.com>
References: <9e4733910707221148g69d7600bk632abb7452ce9c7c@mail.gmail.com>
	 <Pine.LNX.4.64.0707221959100.14781@racer.site>
	 <9e4733910707221210t2b2896b5ob4ce7bf95d4a707a@mail.gmail.com>
	 <Pine.LNX.4.64.0707222013200.14781@racer.site>
	 <9e4733910707221248q45fb3aaala9c79afd4b09830e@mail.gmail.com>
	 <Pine.LNX.4.64.0707222238180.14781@racer.site>
	 <9e4733910707221645x21d74e70y3c43bc8c02a9d4ca@mail.gmail.com>
	 <Pine.LNX.4.64.0707230048570.14781@racer.site>
	 <9e4733910707221711u6e965e6cr29e06fa8fb09165@mail.gmail.com>
	 <Pine.LNX.4.64.0707230136360.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 23 16:44:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICz8u-0007I3-S3
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 16:44:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753754AbXGWOoG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 10:44:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755024AbXGWOoE
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 10:44:04 -0400
Received: from wa-out-1112.google.com ([209.85.146.176]:11100 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750933AbXGWOoB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 10:44:01 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2020404wah
        for <git@vger.kernel.org>; Mon, 23 Jul 2007 07:44:01 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QUwruib0hdB9wPGPa9gQCyApLN9ZjLckv8WlgCrPeyD95RmY/Z7K3ZaH7sphImoBsFbSy+l22MdEPBsQTOOubB6i10AipdixaAc2jy/UFUPDhBKBW0Dm3sYJ19PB2jV4Nu+5aklOwrvUSBM8ACjZ4PfRXfA/BdmzwacsMLPMdJM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=U80NcS9BXiQprlTmL2iXJ/TvSfZ4gJvX8NCtNusG0LZt7+f55OL+a+yHcC9RM67hr7cssvNJi73+l1CiG1YvyTQCDG/nNajG0FKOcgrlLxPW6NQYMauwisPlvrpomdhAml4EMQ4jX2PXlZmwSkg1ADD6IWQqosYlAuKbcne93bs=
Received: by 10.114.151.13 with SMTP id y13mr3051881wad.1185201840564;
        Mon, 23 Jul 2007 07:44:00 -0700 (PDT)
Received: by 10.114.195.5 with HTTP; Mon, 23 Jul 2007 07:44:00 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0707230136360.14781@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53438>

On 7/22/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Okay, I did not really test thoroughly, it seems.  Sorry.  Next try.

It's working a lot better. People deal with $Id two different ways.
One way they delete all of the $Id lines, that is the case of the
Sonos patch. In the Phytec patch they left all of the $Id lines in
place which caused them to get modified. In both cases you just want
the lines with $Id to disappear in the patch.

It doesn't catch the $Id case from the Phytec patch.

diff -uarN linux-2.6.10/arch/cris/arch-v10/boot/rescue/head.S
linux-2.6.10-lpc3180/arch/cris/arch-v10/boot/rescue/head.S
--- linux-2.6.10/arch/cris/arch-v10/boot/rescue/head.S  2004-12-25
05:35:24.000000000 +0800
+++ linux-2.6.10-lpc3180/arch/cris/arch-v10/boot/rescue/head.S
2006-11-20 15:49:30.000000000 +0800
@@ -1,4 +1,5 @@
 /* $Id: head.S,v 1.6 2003/04/09 08:12:43 pkj Exp $
+/* $Id: head.S,v 1.2 2005/02/18 13:06:31 mike Exp $
  *
  * Rescue code, made to reside at the beginning of the
  * flash-memory. when it starts, it checks a partition

It's not catching all of the $Revision and $Date deltas.

The output diff shouldn't contain any CVS keywords. It is somewhat
tricky to catch all of the cases and fix up the diffs. This filter
should get written and debugged once and then made part of something
like git so that it doesn't get written over and over again. Perl is
way better for this I had 1000 lines of C in my program and it was
still missing 10% of the cases.

-- 
Jon Smirl
jonsmirl@gmail.com
