From: Steven Grimm <koreth@midwinter.com>
Subject: Re: Making submodules easier to work with
Date: Thu, 1 May 2008 16:29:17 -0700
Message-ID: <3B9C16C0-0D0C-42D3-8315-72C8D8C88452@midwinter.com>
References: <8B885217-8C18-417E-8F11-BB6661792CD3@gmail.com> <alpine.DEB.1.00.0804301121240.17469@eeepc-johanness> <BC221793-3FB5-4249-8E8D-819C1B413592@gmail.com> <32541b130804301331o70310831raf71db7cbb51d507@mail.gmail.com> <EFEF26F9-D5D6-4BAC-9A8F-6D96E45AFAF7@gmail.com> <32541b130804301448i537a0b98ta01cecc472e20aec@mail.gmail.com> <1209594215.25663.864.camel@work.sfbay.sun.com> <32541b130804301528k70ae2f7eq5229c0b4bb1d3788@mail.gmail.com> <20080501183837.GA4772@pvv.org>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Roman Shaposhnik <rvs@sun.com>,
	Tim Harper <timcharper@gmail.com>, git@vger.kernel.org
To: Finn Arne Gangstad <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Fri May 02 01:30:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JriE2-0008Rk-E8
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 01:30:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753319AbYEAX3T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2008 19:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752780AbYEAX3T
	(ORCPT <rfc822;git-outgoing>); Thu, 1 May 2008 19:29:19 -0400
Received: from tater.midwinter.com ([216.32.86.90]:44028 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752551AbYEAX3S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2008 19:29:18 -0400
Received: (qmail 15136 invoked from network); 1 May 2008 23:29:18 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=JAkmmsEOqQhv8zuabXS6tHR0DfwE290hOdzpvfuRoXbqAaGmeTMW/q+JtQwwrEVa  ;
Received: from localhost (HELO ?IPv6:::1?) (127.0.0.1)
  by localhost with SMTP; 1 May 2008 23:29:18 -0000
In-Reply-To: <20080501183837.GA4772@pvv.org>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80947>

On May 1, 2008, at 11:38 AM, Finn Arne Gangstad wrote:
> Where do we want to go with submodules?

I have two uses for submodules.

The first one is... well, not really submodules at all. I really want  
sparse checkout so I can avoid bothering with parts of the larger  
project tree I don't care about or need. But right now submodules are  
the only way to approximate sparse checkout, so until we have true  
sparse checkout support, I want to be able to get semantics that act  
like the submodules are just subdirectories in the supermodule with no  
special care required. For this use case, the "automatically update  
all my submodules and push all of them when I push the supermodule"  
behavior being discussed here, along with synchronizing local branches  
between the super and submodules, would be a huge usability improvement.

The second is closer to the current design's intended use case: a sort  
of version-controlled symbolic link. This is for libraries and other  
external dependencies. The current model is not too bad for this use  
case, though ideally I'd like to see it get as low-touch as, say, svn  
externals, where only one person on a development team needs to worry  
about setting up and updating submodules and they cause the right  
files to show up automatically for everyone else.

-Steve
