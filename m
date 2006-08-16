From: Nicolas Pitre <nico@cam.org>
Subject: Re: Git files data formats documentation
Date: Wed, 16 Aug 2006 12:55:23 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0608161243080.3494@localhost.localdomain>
References: <44D42F0D.3040707@gmail.com> <44D51D47.9090700@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 16 18:55:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDOfv-00076O-To
	for gcvg-git@gmane.org; Wed, 16 Aug 2006 18:55:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbWHPQzY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Aug 2006 12:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbWHPQzY
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Aug 2006 12:55:24 -0400
Received: from relais.videotron.ca ([24.201.245.36]:29364 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751149AbWHPQzY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Aug 2006 12:55:24 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J4300IAJOCBGKH0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 16 Aug 2006 12:55:23 -0400 (EDT)
In-reply-to: <44D51D47.9090700@gmail.com>
X-X-Sender: nico@localhost.localdomain
To: A Large Angry SCM <gitzilla@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25517>

A Large Angry SCM wrote:
> This information may be useful for reading and writing the various Git
> files.

[...]

        # For version 2 pack files, the size of a copy is limited to
        # 64K bytes or less and bit 6 of the opcode byte is set if the
        # source of the copy is from the buffer of the result object
        # instead of the the base object.
        #
        # It's unknown if any version 2 pack files were created with
        # bit 6 set in the opcode byte; however, the change that added
        # support for version 3 pack files removed the code that would
        # change the copy source to the result buffer.

There were no version 2 pack files with bit 6 set in the opcode byte 
ever produced (except on my own hard disk when I was experimenting with 
that feature).  The (negative) compression gain turned up to be not 
worth the needed computational cost to make use of it, hence that bit is 
now dedicated to specifying an extra size byte.

See commit d60fc1c8649f80c006b9f493c542461e81608d4b log message for 
more.


Nicolas
