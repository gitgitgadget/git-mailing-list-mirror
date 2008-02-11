From: Nicolas Pitre <nico@cam.org>
Subject: Re: [RFC] repack vs re-clone
Date: Mon, 11 Feb 2008 14:40:00 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0802111436100.2732@xanadu.home>
References: <e5bfff550802100025k616ccff5ib2917d283eeb0ff0@mail.gmail.com>
 <m3myq7e3ie.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Marco Costalba <mcostalba@gmail.com>,
	git mailing list <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 20:40:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOeWD-0005sR-0Y
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 20:40:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757435AbYBKTkH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 14:40:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757162AbYBKTkH
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 14:40:07 -0500
Received: from relais.videotron.ca ([24.201.245.36]:32916 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756922AbYBKTkF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 14:40:05 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JW3004QYAMHLU30@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 11 Feb 2008 14:39:53 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <m3myq7e3ie.fsf@localhost.localdomain>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73570>

On Mon, 11 Feb 2008, Jakub Narebski wrote:

> [*1*] I hope that '--no-reuse-delta' means _try_ to find better delta,
> but use current one as possible delta, not stupid forget about current
> deltaification at all...

It is really "forget about everything".  And by the time you look for 
the best delta from scratch, remembering what was the best delta before 
won't give you much performance gain, plus it has nasty issues like 
making sure no delta cycles are created if you reuse an old delta, etc.


Nicolas
