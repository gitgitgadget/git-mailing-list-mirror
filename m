From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Trying to get GIT running on SCO OpenServer
Date: Wed, 23 Jan 2008 19:19:40 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801231912230.2803@woody.linux-foundation.org>
References: <20080123212613.GN2230@yugib.highrise.ca> <alpine.LSU.1.00.0801232346010.5731@racer.site> <7vsl0oax42.fsf@gitster.siamese.dyndns.org> <4797F902.4000104@zytor.com> <alpine.LFD.1.00.0801231846540.2803@woody.linux-foundation.org>
 <3213B93E-42FF-4D63-A3A4-BD742630CEA1@vicaya.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Aidan Van Dyk <aidan@highrise.ca>, git@vger.kernel.org
To: Luke Lu <git@vicaya.com>
X-From: git-owner@vger.kernel.org Thu Jan 24 04:20:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHse6-0003uR-IG
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 04:20:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752524AbYAXDUY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2008 22:20:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752528AbYAXDUY
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jan 2008 22:20:24 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:58264 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752461AbYAXDUX (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Jan 2008 22:20:23 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0O3JfRe019098
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 23 Jan 2008 19:19:42 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0O3JeMG007436;
	Wed, 23 Jan 2008 19:19:40 -0800
In-Reply-To: <3213B93E-42FF-4D63-A3A4-BD742630CEA1@vicaya.com>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.724 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71586>



On Wed, 23 Jan 2008, Luke Lu wrote:
> 
> I wonder what's the downside of just using a native format implementation like
> the one in Vstr[1] or bstring[2]?

I'd suggest taking the kernel vsnprintf() instead. It has the standard 
interface (no support for FP, but we don't care) so it should be pretty 
easy to just plug in, and it doesn't reaquire much of the environment 
(just a 64-bit divide&modulus-by-100000).

			Linus
