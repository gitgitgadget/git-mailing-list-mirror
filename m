From: Nicolas Pitre <nico@cam.org>
Subject: Re: git-index-pack really does suck..
Date: Tue, 03 Apr 2007 17:28:26 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704031722590.28181@xanadu.home>
References: <Pine.LNX.4.64.0704030754020.6730@woody.linux-foundation.org>
 <db69205d0704031227q1009eabfhdd82aa3636f25bb6@mail.gmail.com>
 <Pine.LNX.4.64.0704031304420.6730@woody.linux-foundation.org>
 <alpine.LFD.0.98.0704031625050.28181@xanadu.home>
 <7vzm5pur7g.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0704031357470.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, Chris Lee <clee@kde.org>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Apr 03 23:28:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYqYK-0008PP-4y
	for gcvg-git@gmane.org; Tue, 03 Apr 2007 23:28:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945973AbXDCV22 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 17:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945966AbXDCV21
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 17:28:27 -0400
Received: from relais.videotron.ca ([24.201.245.36]:31896 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945973AbXDCV21 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 17:28:27 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JFX00HFOYBEM7B0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 03 Apr 2007 17:28:26 -0400 (EDT)
In-reply-to: <Pine.LNX.4.64.0704031357470.6730@woody.linux-foundation.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43671>

On Tue, 3 Apr 2007, Linus Torvalds wrote:

> See my separate timing numbers, although I bet that Chris can give even 
> better ones..
> 
> Chris, try applying my patch, and then inside the KDE repo you have, do
> 
> 	git index-pack --paranoid --stdin --fix-thin new.pack < ~/git/.git/objects/pack/pack-*.pack
> 
> (ie index the objects of the *git* repository, not the KDE one). That 
> should approximate doing a fair-sized "git pull" - getting new objects. Do 
> it with and without --paranoid, and time it.

Like I said this is bogus since the index-pack is throttled by the 
network making this overhead a non issue in real life.

And like I said there should _not_ be such a memory usage difference 
which is probably showing potential problems *elsewhere*.

> I bet that what I see as a 7% slowdown will be much bigger for you, just 
> because the negative lookups will be all that much more expensive when you 
> have tons of objects.

And I bet your newton-raphson lookup idea would shine and bring that 
overhead down considerably in that case.


Nicolas
