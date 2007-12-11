From: David Miller <davem@davemloft.net>
Subject: Re: Something is broken in repack
Date: Tue, 11 Dec 2007 09:24:02 -0800 (PST)
Message-ID: <20071211.092402.266823343.davem@davemloft.net>
References: <9e4733910712102301p5e6c4165v6afb32d157478828@mail.gmail.com> 	<alpine.LFD.0.9999.0712110806540.25032@woody.linux-foundation.org> 	<alpine.LFD.0.99999.0712111202470.555@xanadu.home>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: torvalds@linux-foundation.org, jonsmirl@gmail.com, gitster@pobox.com,  gcc@gcc.gnu.org, git@vger.kernel.org
To: nico@cam.org
X-From: gcc-return-142914-gcc=m.gmane.org@gcc.gnu.org Tue Dec 11 18:24:41 2007
Return-path: <gcc-return-142914-gcc=m.gmane.org@gcc.gnu.org>
Envelope-to: gcc@gmane.org
Received: from sourceware.org ([209.132.176.174])
	by lo.gmane.org with smtp (Exim 4.50)
	id 1J28qL-0005XB-Tr
	for gcc@gmane.org; Tue, 11 Dec 2007 18:24:30 +0100
Received: (qmail 1739 invoked by alias); 11 Dec 2007 17:24:10 -0000
Received: (qmail 1730 invoked by uid 22791); 11 Dec 2007 17:24:09 -0000
X-Spam-Check-By: sourceware.org
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net (HELO sunset.davemloft.net) (74.93.104.97)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Tue, 11 Dec 2007 17:24:04 +0000
Received: from localhost (localhost [127.0.0.1]) 	by sunset.davemloft.net (Postfix) with ESMTP id 9DCA735C001; 	Tue, 11 Dec 2007 09:24:02 -0800 (PST)
In-Reply-To: <alpine.LFD.0.99999.0712111202470.555@xanadu.home>
X-Mailer: Mew version 5.2 on Emacs 22.1 / Mule 5.0 (SAKAKI)
X-IsSubscribed: yes
Mailing-List: contact gcc-help@gcc.gnu.org; run by ezmlm
Precedence: bulk
List-Id: <gcc.gcc.gnu.org>
List-Unsubscribe: <mailto:gcc-unsubscribe-gcc=m.gmane.org@gcc.gnu.org>
List-Archive: <http://gcc.gnu.org/ml/gcc/>
List-Post: <mailto:gcc@gcc.gnu.org>
List-Help: <http://gcc.gnu.org/ml/>
Sender: gcc-owner@gcc.gnu.org
Delivered-To: mailing list gcc@gcc.gnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67887>

From: Nicolas Pitre <nico@cam.org>
Date: Tue, 11 Dec 2007 12:21:11 -0500 (EST)

> BUT.  The point is that repacking the gcc repo using "git repack -a -f 
> --window=250" has a radically different memory usage profile whether you 
> do the repack on the earlier 2.1GB pack or the later 300MB pack.  

If you repack on the smaller pack file, git has to expand more stuff
internally in order to search the deltas, whereas with the larger pack
file I bet git has to less often undelta'ify to get base objects blobs
for delta search.

In fact that behavior makes perfect sense to me and I don't understand
GIT internals very well :-)
