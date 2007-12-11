From: Sean <seanlkml@sympatico.ca>
Subject: Re: Something is broken in repack
Date: Tue, 11 Dec 2007 01:01:30 -0500
Message-ID: <BAYC1-PASMTP08CFB6F824B1282649E5EAAE640@CEZ.ICE>
References: <9e4733910712071505y6834f040k37261d65a2d445c4@mail.gmail.com>
	<9e4733910712101825l33cdc2c0mca2ddbfd5afdb298@mail.gmail.com>
	<alpine.LFD.0.99999.0712102231570.555@xanadu.home>
	<9e4733910712102125w56c70c0cxb8b00a060b62077@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "Nicolas Pitre" <nico@cam.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Jon Smirl" <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 07:01:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1yBm-000461-Vu
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 07:01:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbXLKGBd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 01:01:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751266AbXLKGBd
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 01:01:33 -0500
Received: from bay0-omc2-s39.bay0.hotmail.com ([65.54.246.175]:31972 "EHLO
	bay0-omc2-s39.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751030AbXLKGBc (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Dec 2007 01:01:32 -0500
Received: from BAYC1-PASMTP08 ([65.54.191.168]) by bay0-omc2-s39.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 10 Dec 2007 22:01:32 -0800
X-Originating-IP: [74.15.76.104]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([74.15.76.104]) by bayc1-pasmtp08.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.2668);
	 Mon, 10 Dec 2007 22:01:32 -0800
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with smtp (Exim 4.43)
	id 1J1yBI-0004JW-Ts; Tue, 11 Dec 2007 01:01:24 -0500
In-Reply-To: <9e4733910712102125w56c70c0cxb8b00a060b62077@mail.gmail.com>
X-Mailer: Sylpheed 2.4.5 (GTK+ 2.12.1; i686-pc-linux-gnu)
X-OriginalArrivalTime: 11 Dec 2007 06:01:32.0417 (UTC) FILETIME=[477A2710:01C83BBB]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67795>

On Tue, 11 Dec 2007 00:25:55 -0500
"Jon Smirl" <jonsmirl@gmail.com> wrote:

> Something is hurting bad with threads. 170 CPU minutes with one
> thread, versus 195 CPU minutes with four threads.
> 
> Is there a different memory allocator that can be used when
> multithreaded on gcc? This whole problem may be coming from the memory
> allocation function. git is hardly interacting at all on the thread
> level so it's likely a problem in the C run-time.

You might want to try Google's malloc, it's basically a drop in replacement
with some optional built-in performance monitoring capabilities.  It is said
to be much faster and better at threading than glibc's:

  http://code.google.com/p/google-perftools/wiki/GooglePerformanceTools
  http://google-perftools.googlecode.com/svn/trunk/doc/tcmalloc.html


You can LD_PRELOAD it or link directly.

Cheers,
Sean
