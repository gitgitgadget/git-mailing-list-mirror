From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: Something is broken in repack
Date: Wed, 12 Dec 2007 17:17:43 +0100
Message-ID: <fjp1iu$rv3$1@ger.gmane.org>
References: <9e4733910712071505y6834f040k37261d65a2d445c4@mail.gmail.com>  <9e4733910712101825l33cdc2c0mca2ddbfd5afdb298@mail.gmail.com>  <alpine.LFD.0.99999.0712102231570.555@xanadu.home>  <9e4733910712102125w56c70c0cxb8b00a060b62077@mail.gmail.com>  <9e4733910712102129v140c2affqf2e73e75855b61ea@mail.gmail.com>  <9e4733910712102301p5e6c4165v6afb32d157478828@mail.gmail.com>  <alpine.LFD.0.99999.0712110832251.555@xanadu.home>  <alpine.LFD.0.99999.0712110951070.555@xanadu.home>  <alpine.LFD.0.99999.0712111117440.555@xanadu.home>  <9e4733910712110821o7748802ag75d9df4be8b2c123@mail.gmail.com>  <alpine.LFD.0.99999.0712112057390.555@xanadu.home> <alpine.LFD.0.99999.0712120743040.555@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gcc@gcc.gnu.org
X-From: gcc-return-142936-gcc=m.gmane.org@gcc.gnu.org Wed Dec 12 17:19:38 2007
Return-path: <gcc-return-142936-gcc=m.gmane.org@gcc.gnu.org>
Envelope-to: gcc@gmane.org
Received: from sourceware.org ([209.132.176.174])
	by lo.gmane.org with smtp (Exim 4.50)
	id 1J2UJ3-0000V3-GT
	for gcc@gmane.org; Wed, 12 Dec 2007 17:19:33 +0100
Received: (qmail 30825 invoked by alias); 12 Dec 2007 16:19:14 -0000
Received: (qmail 30816 invoked by uid 22791); 12 Dec 2007 16:19:13 -0000
X-Spam-Check-By: sourceware.org
Received: from main.gmane.org (HELO ciao.gmane.org) (80.91.229.2)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Wed, 12 Dec 2007 16:19:00 +0000
Received: from list by ciao.gmane.org with local (Exim 4.43) 	id 1J2UHn-0005yj-Qy 	for gcc@gcc.gnu.org; Wed, 12 Dec 2007 16:18:15 +0000
Received: from usilu-ge.ti-edu.ch ([195.176.176.226])         by main.gmane.org with esmtp (Gmexim 0.1 (Debian))         id 1AlnuQ-0007hv-00         for <gcc@gcc.gnu.org>; Wed, 12 Dec 2007 16:18:15 +0000
Received: from bonzini by usilu-ge.ti-edu.ch with local (Gmexim 0.1 (Debian))         id 1AlnuQ-0007hv-00         for <gcc@gcc.gnu.org>; Wed, 12 Dec 2007 16:18:15 +0000
User-Agent: Thunderbird 2.0.0.9 (Macintosh/20071031)
In-Reply-To: <alpine.LFD.0.99999.0712120743040.555@xanadu.home>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68064>


> When I returned to the computer this morning, the repack was 
> completed... with a 1.3GB pack instead.
> 
> So... The gcc repo apparently really needs a large window to efficiently 
> compress those large objects.

So, am I right that if you have a very well-done pack (such as gcc's), 
you might want to repack in two phases:

- first discarding the old deltas and using a small window, thus 
producing a bad pack that can be repacked without humongous amounts of 
memory...

- ... then discarding the old deltas and producing another 
well-compressed pack?

Paolo
