From: Tor Myklebust <tmyklebu@csclub.uwaterloo.ca>
Subject: Re: memmem.c improvement
Date: Fri, 30 Nov 2007 22:07:01 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0711302151340.9426@caffeine.csclub.uwaterloo.ca>
References: <4750AF4F.6090207@pipapo.org> <Pine.LNX.4.64.0711301954370.9426@caffeine.csclub.uwaterloo.ca>  <4750C74B.8060308@pipapo.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: libc-alpha@sourceware.org, git@vger.kernel.org
To: Christian Thaeter <ct@pipapo.org>
X-From: libc-alpha-return-20629-glibc-alpha=m.gmane.org@sourceware.org Sat Dec 01 04:07:31 2007
Return-path: <libc-alpha-return-20629-glibc-alpha=m.gmane.org@sourceware.org>
Envelope-to: glibc-alpha@gmane.org
Received: from sourceware.org ([209.132.176.174])
	by lo.gmane.org with smtp (Exim 4.50)
	id 1IyIhV-0001YH-NU
	for glibc-alpha@gmane.org; Sat, 01 Dec 2007 04:07:30 +0100
Received: (qmail 2468 invoked by alias); 1 Dec 2007 03:07:11 -0000
Received: (qmail 1910 invoked by uid 22791); 1 Dec 2007 03:07:10 -0000
X-Spam-Check-By: sourceware.org
Received: from caffeine.csclub.uwaterloo.ca (HELO caffeine.csclub.uwaterloo.ca) (129.97.134.17)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sat, 01 Dec 2007 03:07:03 +0000
Received: from caffeine.csclub.uwaterloo.ca (localhost [127.0.0.1]) 	by caffeine.csclub.uwaterloo.ca (Postfix) with ESMTP id D4E9C73DC2; 	Fri, 30 Nov 2007 22:07:01 -0500 (EST)
Received: from caffeine.csclub.uwaterloo.ca (caffeine.csclub.uwaterloo.ca [129.97.134.17]) 	by caffeine.csclub.uwaterloo.ca (Postfix) with ESMTP id B1CA373DC0; 	Fri, 30 Nov 2007 22:07:01 -0500 (EST)
In-Reply-To: <4750C74B.8060308@pipapo.org>
X-IsSubscribed: yes
Mailing-List: contact libc-alpha-help@sourceware.org; run by ezmlm
Precedence: bulk
List-Id: <libc-alpha.sourceware.org>
List-Unsubscribe: <mailto:libc-alpha-unsubscribe-glibc-alpha=m.gmane.org@sourceware.org>
List-Subscribe: <mailto:libc-alpha-subscribe@sourceware.org>
List-Archive: <http://sourceware.org/ml/libc-alpha/>
List-Post: <mailto:libc-alpha@sourceware.org>
List-Help: <mailto:libc-alpha-help@sourceware.org>, <http://sourceware.org/ml/#faqs>
Sender: libc-alpha-owner@sourceware.org
Delivered-To: mailing list libc-alpha@sourceware.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66694>

On Sat, 1 Dec 2007, Christian Thaeter wrote:

> I am fully aware that this is not the best possible search algorithm.
> It is considerably better than the actual one for 'common' data.

And not considerably worse in the worst case I could think of.  (Which was 
my point, not that it was slow or sucked in some other way.)

> Having a string with few symbols or other corner cases needs an 
> algorithm better suited for that task.

Yes, if it's actually worth anyone's time making strstr() fast in the case 
where the haystack has length three and the needle length two.

Amusingly enough, I haven't ever seen strstr() used to do any nontrivial 
string matching in any free software I've bothered to grep.

> But well, this was just reaching a low hanging fruit.

Suitably hacked, your code looks clearly correct.  But there are valid 
reasons not to mess with the strstr() in libc (fewer for memmem()); chief 
among them is that *if* there is an undetected bug in the code, *then* 
lots of stuff can break.

> For me it suffices and I won't put more efforts into improving or 
> lobbying it, its just not worth it.

Clearly, the tone of my email did not help convey my message.  (Perhaps I 
should just stop trying to write words of encouragement altogether --- it 
never goes according to plan and always seems to end in disaster.)  I do 
commend you for submitting improvements (and this is clearly an 
improvement); I was merely trying to point out that it will likely be an 
uphill battle, and that certain things are either wrong or can be done 
better than you have done.  Do go on, please!  (And I'm sorry if my 
previous email caused you particular dismay.)

Tor Myklebust
