From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Subject: [PATCH] git-merge-pack
Date: Fri, 7 Sep 2007 00:35:11 +0100 (BST)
Message-ID: <alpine.LFD.0.999.0709070027520.5626@evo.linux-foundation.org>
References: <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org>
 <20070905074206.GA31750@artemis.corp> <87odgh0zn6.fsf@hades.wkstn.nix>
 <46DEF1FA.4050500@midwinter.com> <877in50y7p.fsf@hades.wkstn.nix>
 <alpine.LFD.0.9999.0709051438460.21186@xanadu.home> <7vr6lcj2zi.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0709061651550.28586@racer.site> <7vk5r3adlx.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.0.999.0709061906010.5626@evo.linux-foundation.org>
 <7v1wdb9ymf.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nicolas Pitre <nico@cam.org>, Nix <nix@esperi.org.uk>,
	Steven Grimm <koreth@midwinter.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 01:36:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITQtn-00060W-LR
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 01:36:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932658AbXIFXga (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 19:36:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932657AbXIFXga
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 19:36:30 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:55549 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932649AbXIFXg3 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Sep 2007 19:36:29 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l86NZDKA023717
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 6 Sep 2007 16:35:14 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l86NZBjV013849;
	Thu, 6 Sep 2007 16:35:12 -0700
In-Reply-To: <7v1wdb9ymf.fsf_-_@gitster.siamese.dyndns.org>
X-Spam-Status: No, hits=-4.242 required=5 tests=AWL,BAYES_00,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.31__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57948>



On Thu, 6 Sep 2007, Junio C Hamano wrote:
>
> This is a beginning of "git-merge-pack" that combines smaller
> packs into one.  Currently it does not actually create a new
> pack, but pretends that it is a (dumb) "git-rev-list --objects"
> that lists the objects in the affected packs.  You have to pipe
> its output to "git-pack-objects".

Ok, so I had to double-check that builtin-pack-objects then deals properly 
with duplicate object names (which it does seem to do), so maybe it's 
worth adding a comment to that effect.

But ACK, this seems to be the right thing to do to generate a single 
bigger pack from many smaller ones.

		Linus
