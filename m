From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [PATCH] Make git-mv work in subdirectories, too
Date: Wed, 30 Nov 2005 15:50:10 +0100
Message-ID: <200511301550.10644.Josef.Weidendorfer@gmx.de>
References: <Pine.LNX.4.63.0511251236060.30796@wbgn013.biozentrum.uni-wuerzburg.de> <7vmzjsdt3z.fsf@assigned-by-dhcp.cox.net> <20051129221024.GB3033@steel.home>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 30 16:50:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhTHq-00071B-6A
	for gcvg-git@gmane.org; Wed, 30 Nov 2005 15:50:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbVK3OuT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 Nov 2005 09:50:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbVK3OuT
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Nov 2005 09:50:19 -0500
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:20383 "EHLO
	mailout1.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S1751252AbVK3OuR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2005 09:50:17 -0500
Received: from dhcp-3s-61.lrr.in.tum.de (dhcp-3s-61.lrr.in.tum.de [131.159.35.61])
	by mail.in.tum.de (Postfix) with ESMTP id 879422612;
	Wed, 30 Nov 2005 15:50:14 +0100 (MET)
To: git@vger.kernel.org, Alex Riesen <raa.lkml@gmail.com>
User-Agent: KMail/1.9
In-Reply-To: <20051129221024.GB3033@steel.home>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay2.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13002>

On Tuesday 29 November 2005 23:10, Alex Riesen wrote:

> It actually works in subdirs.
> 
> --- t/t4007-mv.sh

> test_expect_success \
>     'moving the file' \
>     'cd path0 && git-mv COPYING ../path1/COPYING'

Thanks for the test.
After moving to path1, you should check the other way, too:

  cd path0 && git-mv ../path1/COPYING COPYING

And this currenly does *not* work because git-mv is only aware
of the git-controlled files in the subdirectory.

We probably also should check that source and target are in the
same git repo.

Josef
