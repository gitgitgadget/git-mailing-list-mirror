From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: email address handling
Date: Sat, 2 Aug 2008 09:20:17 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0808020916370.3318@nehalem.linux-foundation.org>
References: <alpine.LFD.1.10.0808011229400.3277@nehalem.linux-foundation.org> <alpine.LFD.1.10.0808011253580.3277@nehalem.linux-foundation.org> <20080801131127.20b3acfd.akpm@linux-foundation.org> <alpine.LFD.1.10.0808011316050.3277@nehalem.linux-foundation.org>
 <20080801132415.0b0314e4.akpm@linux-foundation.org> <alpine.LFD.1.10.0808011335230.3277@nehalem.linux-foundation.org> <20080801135421.5ca0f6af.akpm@linux-foundation.org> <7vvdykqub6.fsf@gitster.siamese.dyndns.org> <20080801145804.85041bbd.akpm@linux-foundation.org>
 <20080801221539.GA8617@mit.edu> <20080801152720.56dbff09.akpm@linux-foundation.org> <alpine.LFD.1.10.0808011534260.6819@nehalem.linux-foundation.org> <20080801154902.c60717e5.akpm@linux-foundation.org> <alpine.LFD.1.10.0808011554350.6819@nehalem.linux-foundation.org>
 <alpine.LFD.1.10.0808011608150.6819@nehalem.linux-foundation.org> <alpine.DEB.1.00.0808021321500.9611@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Theodore Tso <tytso@mit.edu>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Aug 02 18:23:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPJtG-0007V1-KG
	for gcvg-git-2@gmane.org; Sat, 02 Aug 2008 18:23:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753540AbYHBQUq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Aug 2008 12:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752927AbYHBQUp
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Aug 2008 12:20:45 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:35540 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752783AbYHBQUp (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 Aug 2008 12:20:45 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m72GKINM009608
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 2 Aug 2008 09:20:19 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m72GKHGp012020;
	Sat, 2 Aug 2008 09:20:17 -0700
In-Reply-To: <alpine.DEB.1.00.0808021321500.9611@pacific.mpi-cbg.de.mpi-cbg.de>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.413 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91151>



On Sat, 2 Aug 2008, Johannes Schindelin wrote:
> 
> Ah, there lies the rub (you forgot that the original complaint was about 
> a comma, and pretty=email does not handle those):

Indeed.

I wonder where that is_rfc2047_special() function came from.  The list of 
"special" characters is totally bogus.

The real RFC has comma, but it has a lot of other characters too:

  especials = "(" / ")" / "<" / ">" / "@" / "," / ";" / ":" /
              "<" / "> / "/" / "[" / "]" / "?" / "." / "="

because basically the rfc2047 encoding has to be a superset of the 822 
(and later 2822) encodings.

		Linus
