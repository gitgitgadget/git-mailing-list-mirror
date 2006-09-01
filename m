From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: Mozilla .git tree
Date: Fri, 01 Sep 2006 10:45:30 -0700
Message-ID: <44F871BA.3070303@gmail.com>
References: <20060829165811.GB21729@spearce.org>	<9e4733910608291037k2d9fb791v18abc19bdddf5e89@mail.gmail.com>	<20060829175819.GE21729@spearce.org>	<9e4733910608291155g782953bbv5df1b74878f4fcf1@mail.gmail.com>	<20060829190548.GK21729@spearce.org>	<9e4733910608291252q130fc723r945e6ab906ca6969@mail.gmail.com>	<20060829232007.GC22935@spearce.org>	<9e4733910608291807q9b896e4sdbfaa9e49de58c2b@mail.gmail.com>	<20060830015122.GE22935@spearce.org>	<9e4733910608291958l45c0257dla6e5ebd4176f7164@mail.gmail.com>	<20060830031029.GA23967@spearce.org>	<Pine.LNX.4.64.0608300124550.9796@xanadu.home> <7vzmdmh2lu.fsf@assigned-by-dhcp.cox.net>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Fri Sep 01 19:45:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GJD5F-0004Ap-Dw
	for gcvg-git@gmane.org; Fri, 01 Sep 2006 19:45:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbWIARpe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Sep 2006 13:45:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbWIARpe
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Sep 2006 13:45:34 -0400
Received: from wx-out-0506.google.com ([66.249.82.237]:33577 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751289AbWIARpe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Sep 2006 13:45:34 -0400
Received: by wx-out-0506.google.com with SMTP id s14so1071360wxc
        for <git@vger.kernel.org>; Fri, 01 Sep 2006 10:45:33 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=eO4oUpYsgGcaFiQBQpuFdsn/FuibSQZ/V6eXRZtfP0wJTZNvEIf+c+VvaWGLLzX4fMxk/94dKkWHHMDT+5TWv7mS/ZGQKQPbd2RFAwwqOHyXPMoP6Qp2pZY6VzNYMWyBouPHtMWI6EWa9W1tXa7iFoTh+pdn92bRCXpeKiXlqro=
Received: by 10.70.129.5 with SMTP id b5mr2873160wxd;
        Fri, 01 Sep 2006 10:45:33 -0700 (PDT)
Received: from ?10.0.0.6? ( [67.20.67.8])
        by mx.gmail.com with ESMTP id g2sm2125241wra.2006.09.01.10.45.32;
        Fri, 01 Sep 2006 10:45:32 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.5 (X11/20060725)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmdmh2lu.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26303>

Junio C Hamano wrote:
> Nicolas Pitre <nico@cam.org> writes:
> 
>> And the zlib header contains a CRC which we're about to use for 
>> validating the data when doing delta data reuse in order to prevent pack 
>> corruption propagation like the one recently posted on the list.  
> 
> Ah, never thought of using the CRC directly.  I was thinking
> about inflating into void and see if it succeeds, which as you
> say is perhaps quite expensive.

Unfortunately, the zlib CRC is of the _uncompressed_ data [1], so
inflating the stream is still necessary to check for corruption.

[1] RFC 1950, "ZLIB Compressed Data Format Specification", May 1996.
Pages 4-6.
