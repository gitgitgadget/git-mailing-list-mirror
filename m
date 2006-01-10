From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: git pull on Linux/ACPI release tree
Date: Tue, 10 Jan 2006 13:05:56 -0500
Message-ID: <252A408D-0B42-49F3-92BC-B80F94F19F40@mac.com>
References: <20060109225143.60520.qmail@web31807.mail.mud.yahoo.com> <Pine.LNX.4.64.0601091845160.5588@g5.osdl.org> <99D82C29-4F19-4DD3-A961-698C3FC0631D@mac.com> <46a038f90601092238r3476556apf948bfe5247da484@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Luben Tuikov <ltuikov@yahoo.com>,
	"Brown, Len" <len.brown@intel.com>,
	"Luck, Tony" <tony.luck@intel.com>,
	Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@osdl.org>,
	"David S. Miller" <davem@davemloft.net>,
	linux-acpi@vger.kernel.org,
	LKML Kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 10 19:07:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwNta-0007O9-KX
	for gcvg-git@gmane.org; Tue, 10 Jan 2006 19:06:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932303AbWAJSGz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jan 2006 13:06:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932308AbWAJSGz
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jan 2006 13:06:55 -0500
Received: from smtpout.mac.com ([17.250.248.83]:12782 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932299AbWAJSGx (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jan 2006 13:06:53 -0500
Received: from mac.com (smtpin07-en2 [10.13.10.152])
	by smtpout.mac.com (Xserve/8.12.11/smtpout07/MantshX 4.0) with ESMTP id k0AI63Ke023671;
	Tue, 10 Jan 2006 10:06:03 -0800 (PST)
Received: from [10.0.0.2] (ip70-187-212-71.dc.dc.cox.net [70.187.212.71])
	(authenticated bits=0)
	by mac.com (Xserve/smtpin07/MantshX 4.0) with ESMTP id k0AI5x6V010254
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NO);
	Tue, 10 Jan 2006 10:06:01 -0800 (PST)
In-Reply-To: <46a038f90601092238r3476556apf948bfe5247da484@mail.gmail.com>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-Mailer: Apple Mail (2.746.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14431>

On Jan 10, 2006, at 01:38, Martin Langhoff wrote:
> On 1/10/06, Kyle Moffett <mrmacman_g4@mac.com> wrote:
>> If they all work, then we know precisely that it's the  
>> interactions between them, which also makes debugging a lot easier.
>
> The more complex your tree structure is, the more the interactions  
> are likely to be part of the problem. Is git-bisect not useful in  
> this scenario?

IIRC git-bisect just does an outright linearization of the whole tree  
anyways, which makes git-bisect work everywhere, even in the presence  
of difficult cross-merges.  On the other hand, if you are git- 
bisecting ACPI changes (perhaps due to some ACPI breakage), and ACPI  
has 10 pulls from mainline, you _also_ have to wade through the  
bisection of any other changes that occurred in mainline, even if  
they're totally irrelevant.  This is why it's useful to only pull  
mainline into your tree (EX: ACPI) when you functionally depend on  
changes there (as Linus so eloquently expounded upon).

Cheers,
Kyle Moffett

--
Q: Why do programmers confuse Halloween and Christmas?
A: Because OCT 31 == DEC 25.
