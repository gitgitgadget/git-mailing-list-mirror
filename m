From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 2/3] rev-list: Introduce --no-output to avoid /dev/null
	redirects
Date: Fri, 9 Nov 2007 00:44:18 +0100
Message-ID: <20071108234418.GE4899@steel.home>
References: <20071108080052.GB16690@spearce.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Nov 09 04:44:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqKnV-0004r6-JX
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 04:44:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753347AbXKIDob (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 22:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753289AbXKIDob
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 22:44:31 -0500
Received: from cg-p07-fb.rzone.de ([81.169.146.215]:39438 "EHLO
	cg-p07-fb.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753243AbXKIDoa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 22:44:30 -0500
Received: from mo-p07-ob.rzone.de (fruni-mo-p07-ob.mail [192.168.63.183])
	by gibbsson-fb-07.store (RZmta 14.0) with ESMTP id G0287ajA8GMKnc
	for <git@vger.kernel.org>; Fri, 9 Nov 2007 00:45:20 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from tigra.home (Fc819.f.strato-dslnet.de [195.4.200.25])
	by post.webmailer.de (fruni mo60) (RZmta 14.0)
	with ESMTP id x02254jA8KJxM5 ; Fri, 9 Nov 2007 00:44:18 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 3522C277AE;
	Fri,  9 Nov 2007 00:44:18 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 1E60E56D22; Fri,  9 Nov 2007 00:44:18 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20071108080052.GB16690@spearce.org>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWowxOg==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64126>

Shawn O. Pearce, Thu, Nov 08, 2007 09:00:52 +0100:
> Some uses of git-rev-list are to run it with --objects to see if
> a range of objects between two or more commits is fully connected
> or not.  In such a case the caller doesn't care about the actual
> object names or hash hints so formatting this data only for it to
> be dumped to /dev/null by a redirect is a waste of CPU time.  If
> all the caller needs is the exit status then --no-output can be
> used to bypass the commit and object formatting.

We already have --quiet and even --exit-code.
