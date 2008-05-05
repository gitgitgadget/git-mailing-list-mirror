From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 5/6] fn_out_diff_words_aux: Handle common diff line
 more carefully
Date: Mon, 5 May 2008 13:11:44 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805051310550.30431@racer>
References: <1209815828-6548-1-git-send-email-pkufranky@gmail.com>  <1209874815-14411-1-git-send-email-pkufranky@gmail.com>  <1209874815-14411-2-git-send-email-pkufranky@gmail.com>  <1209874815-14411-3-git-send-email-pkufranky@gmail.com> 
 <1209874815-14411-4-git-send-email-pkufranky@gmail.com>  <1209874815-14411-5-git-send-email-pkufranky@gmail.com>  <1209874815-14411-6-git-send-email-pkufranky@gmail.com>  <alpine.DEB.1.00.0805041053380.30431@racer>
 <46dff0320805040953i4230a686j8e8d63eaa6728c2f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 05 14:12:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JszYn-000329-Gz
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 14:12:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751709AbYEEMLu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 08:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbYEEMLu
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 08:11:50 -0400
Received: from mail.gmx.net ([213.165.64.20]:45135 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751133AbYEEMLt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 08:11:49 -0400
Received: (qmail invoked by alias); 05 May 2008 12:11:47 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO racer.local) [132.187.25.128]
  by mail.gmx.net (mp039) with SMTP; 05 May 2008 14:11:47 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18dPYY4fsUdub1t2z7xY/rNPAl2wSfkHHvlHbJMZ9
	fMpdb4PNi8bMXG
X-X-Sender: gene099@racer
In-Reply-To: <46dff0320805040953i4230a686j8e8d63eaa6728c2f@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81275>

Hi,

On Mon, 5 May 2008, Ping Yin wrote:

> On Sun, May 4, 2008 at 5:54 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >  On Sun, 4 May 2008, Ping Yin wrote:
> >
> >  > Before feeding minus and plus lines into xdi_diff, we replace non 
> >  > word characters with '\n'. So we need recover the replaced 
> >  > character (always the last character) in the callback 
> >  > fn_out_diff_words_aux.
> >  >
> >  > Therefore, a common diff line beginning with ' ' is not always a 
> >  > real common line.
> >
> >  Umm, why?
> 
> Because we need recover the replaced character.
> 
> Say, for a common diff line " foo", after restoring the replaced 
> character, the corresponding line in minus and plus may be different. 
> For example, "foo(" and "foo)".

Why do I have to spend time trying to figure out what you meant, write an 
email, and get the explanation only in a response (i.e. not the commit 
message, where it belongs)?

Ciao,
Dscho
