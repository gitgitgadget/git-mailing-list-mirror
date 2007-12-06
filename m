From: David Brown <git@davidb.org>
Subject: Re: Git and GCC
Date: Thu, 6 Dec 2007 00:11:39 -0800
Message-ID: <20071206081139.GA14370@old.davidb.org>
References: <4aca3dc20712051947t5fbbb383ua1727c652eb25d7e@mail.gmail.com> <20071205.202047.58135920.davem@davemloft.net> <4aca3dc20712052032n521c344cla07a5df1f2c26cb8@mail.gmail.com> <20071205.204848.227521641.davem@davemloft.net> <4aca3dc20712052111o730f6fb6h7a329ee811a70f28@mail.gmail.com> <alpine.LFD.0.9999.0712052132450.13796@woody.linux-foundation.org> <1196927361.13109.1.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 	Daniel Berlin <dberlin@dberlin.org>, 	David Miller <davem@davemloft.net>, ismail@pardus.org.tr, 	gcc@gcc.gnu.org, git@vger.kernel.org
To: Harvey Harrison <harvey.harrison@gmail.com>
X-From: gcc-return-142729-gcc=m.gmane.org@gcc.gnu.org Thu Dec 06 09:12:28 2007
Return-path: <gcc-return-142729-gcc=m.gmane.org@gcc.gnu.org>
Envelope-to: gcc@gmane.org
Received: from sourceware.org ([209.132.176.174])
	by lo.gmane.org with smtp (Exim 4.50)
	id 1J0BqK-0008VQ-AD
	for gcc@gmane.org; Thu, 06 Dec 2007 09:12:24 +0100
Received: (qmail 2883 invoked by alias); 6 Dec 2007 08:12:04 -0000
Received: (qmail 2870 invoked by uid 22791); 6 Dec 2007 08:12:02 -0000
X-Spam-Check-By: sourceware.org
Received: from mail.davidb.org (HELO mail.davidb.org) (66.93.32.219)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 06 Dec 2007 08:11:57 +0000
Received: from davidb by mail.davidb.org with local (Exim 4.68 #1 (Debian)) 	id 1J0Bpb-0003nn-PI; Thu, 06 Dec 2007 00:11:39 -0800
Mail-Followup-To: Harvey Harrison <harvey.harrison@gmail.com>, 	Linus Torvalds <torvalds@linux-foundation.org>, 	Daniel Berlin <dberlin@dberlin.org>, 	David Miller <davem@davemloft.net>, ismail@pardus.org.tr, 	gcc@gcc.gnu.org, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1196927361.13109.1.camel@brick>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact gcc-help@gcc.gnu.org; run by ezmlm
Precedence: bulk
List-Id: <gcc.gcc.gnu.org>
List-Unsubscribe: <mailto:gcc-unsubscribe-gcc=m.gmane.org@gcc.gnu.org>
List-Archive: <http://gcc.gnu.org/ml/gcc/>
List-Post: <mailto:gcc@gcc.gnu.org>
List-Help: <http://gcc.gnu.org/ml/>
Sender: gcc-owner@gcc.gnu.org
Delivered-To: mailing list gcc@gcc.gnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67269>

On Wed, Dec 05, 2007 at 11:49:21PM -0800, Harvey Harrison wrote:
>
>> 	git repack -a -d --depth=250 --window=250
>> 
>
>Since I have the whole gcc repo locally I'll give this a shot overnight
>just to see what can be done at the extreme end or things.

When I tried this on a very large repo, at least one with some large files
in it, git quickly exceeded my physical memory and started thrashing the
machine.  I had good results with

  git config pack.deltaCacheSize 512m
  git config pack.windowMemory 512m

of course adjusting based on your physical memory.  I think changing the
windowMemory will affect the resulting compression, so changing these
ratios might get better compression out of the result.

If you're really patient, though, you could leave the unbounded window,
hope you have enough swap, and just let it run.

Dave
