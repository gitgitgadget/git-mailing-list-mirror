From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] index: be careful when handling long names
Date: Sun, 13 Jan 2008 23:53:21 +0100
Message-ID: <20080113225321.GA19970@steel.home>
References: <alpine.LFD.1.00.0801121426510.2806@woody.linux-foundation.org> <alpine.LFD.1.00.0801121735020.2806@woody.linux-foundation.org> <alpine.LFD.1.00.0801121949180.2806@woody.linux-foundation.org> <7vtzliqh3u.fsf@gitster.siamese.dyndns.org> <7vd4s6qal0.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0801130922030.2806@woody.linux-foundation.org> <7vsl11plbe.fsf@gitster.siamese.dyndns.org> <7vhchhpd3h.fsf_-_@gitster.siamese.dyndns.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 13 23:54:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEBiK-0006eb-Jq
	for gcvg-git-2@gmane.org; Sun, 13 Jan 2008 23:54:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753964AbYAMWx2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2008 17:53:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753572AbYAMWx2
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jan 2008 17:53:28 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:15199 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753904AbYAMWx1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2008 17:53:27 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3CculzwpJqjpg==
Received: from tigra.home (Fab5c.f.strato-dslnet.de [195.4.171.92])
	by post.webmailer.de (mrclete mo59) (RZmta 15.4)
	with ESMTP id g01d35k0DIL2KY ; Sun, 13 Jan 2008 23:53:22 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 064BC277AE;
	Sun, 13 Jan 2008 23:53:21 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 5F50656D22; Sun, 13 Jan 2008 23:53:21 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vhchhpd3h.fsf_-_@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70419>

Junio C Hamano, Sun, Jan 13, 2008 23:36:34 +0100:
> +test_expect_success 'very long name in the index handled sanely' '
> +
> +	a=a && # 1
> +	a=$a$a$a$a$a$a$a$a$a$a$a$a$a$a$a$a && # 16
> +	a=$a$a$a$a$a$a$a$a$a$a$a$a$a$a$a$a && # 256
> +	a=$a$a$a$a$a$a$a$a$a$a$a$a$a$a$a$a && # 4096

I'd expect it to fail on some systems (everywindowsthing up to w2k,
maybe some commercial unices).
