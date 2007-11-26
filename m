From: Nicolas Pitre <nico@cam.org>
Subject: Re: If you would write git from scratch now, what would you change?
Date: Mon, 26 Nov 2007 14:30:19 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0711261417580.9605@xanadu.home>
References: <200711252248.27904.jnareb@gmail.com>
 <858x4l2apc.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Nov 26 20:30:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwjfD-0003cP-JA
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 20:30:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753778AbXKZTaV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 14:30:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753812AbXKZTaV
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 14:30:21 -0500
Received: from relais.videotron.ca ([24.201.245.36]:51927 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753720AbXKZTaU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2007 14:30:20 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JS400DREOUJ41R0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 26 Nov 2007 14:30:19 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <858x4l2apc.fsf@lola.goethe.zz>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66098>

On Mon, 26 Nov 2007, David Kastrup wrote:

> Get rid of plumbing at the command line level.

We can't get rid of plumbing.  It is part of Git probably forever and is 
really really convenient for scripting in any language you want.  

The only valid argument IMHO is the way too large number of Git commands 
directly available from the cmdline.

The solution: make purely plumbing commands _not_ directly available 
from the command line. Instead, they can be available through 'git 
lowlevel <blah>' instead of 'git <blah>' and only 'git lowlevel' would 
stand in your shell default path.

Such a scheme can be implemented in parallel with the current one for a 
release while the direct plumbing commands are deprecated in order to 
give script authors a transition period to fix their code.


Nicolas
