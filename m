From: Florian Achleitner <florian.achleitner2.6.31@gmail.com>
Subject: Re: GSOC Proposal draft: git-remote-svn
Date: Tue, 03 Apr 2012 09:49:40 +0200
Message-ID: <2576556.3d3popQR3z@flomedio>
References: <11292500.AVmZFUUvNi@flobuntu> <2487557.B8qfnaixh3@flomedio> <20120402205659.GA13725@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	David Barr <davidbarr@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Andrew Sayers <andrew-git@pileofstuff.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 03 09:50:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEyVK-0003ie-Qt
	for gcvg-git-2@plane.gmane.org; Tue, 03 Apr 2012 09:50:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752866Ab2DCHuH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Apr 2012 03:50:07 -0400
Received: from mailrelay.tu-graz.ac.at ([129.27.2.202]:28402 "EHLO
	mailrelay.tugraz.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751333Ab2DCHuF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2012 03:50:05 -0400
Received: from flomedio.localnet (91-115-91-234.adsl.highway.telekom.at [91.115.91.234])
	(authenticated bits=0)
	by mailrelay2.tugraz.at (8.14.4/8.14.4) with ESMTP id q337ng8p016510
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 3 Apr 2012 09:49:42 +0200 (CEST)
User-Agent: KMail/4.7.3 (Linux/3.0.0-17-generic; KDE/4.7.4; x86_64; ; )
In-Reply-To: <20120402205659.GA13725@burratino>
X-TUG-Backscatter-control: qyH/vN2riZ/masrHmZoJqQ
X-Spam-Scanner: SpamAssassin 3.003000 
X-Spam-Score-relay: 0.6
X-Scanned-By: MIMEDefang 2.70 on 129.27.10.19
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194603>

Hi!

I'm curiously watching the discussion I kicked off with my proposal. Before 
refining the proposal I think I will let the discussion continue at the moment.
But just to clarify some things:
You know I'm rather new to this topic. I've used svn and git, I know what git 
plumbing is about, but I haven't used plumbing commands to write something 
into git yet. So I can't tell from experience if it would be good or not, 
compared to fast-import.
So please explain what's the advantage/disadvantage of which design decision.
That makes it easier to get the point.

I'm also not yet familiar with svn's internals and what properties they use 
for what. 
So there are several questions I simply don't have an answer for.
I know that you have discussed several issues in a huge lot of mails on this 
list. I'm watching and learning currently.

Jonathan wrote about a script "floating around". What's that?
Is it somewhere in a tree in some repo, is at a patch somewhere in a mail on 
the list, is it in git.git in some branch?? 
How does one find catch floating scripts?

And two clarifications about what I meant in the proposal:

On Monday 02 April 2012 16:30:14 Ramkumar Ramachandra wrote:
> Are you planning to extend svn-fe to do the mapping, write it as a
> separate program, or write it into the remote helper? I personally
> don't mind if the mapping is done in Perl (like in git-svn or SBL) as
> opposed to C; mapping is just parse-intensive.

I personally don't like Perl. :p (I would use python if i need a scripting 
language).
As far as I've seen, svn-fe is a 5-liner calling functions in vcs-svn/. So I 
thought there is no point of piping something through svn-fe in the remote-
helper. I thought I would use those functions like svn-fe does.
I thought about vcs-svn/ being a library for svn interaction that the remote-
helper, and svn-fe, and svn-fi (?) are using.

On Monday 02 April 2012 15:57:00 Jonathan Nieder wrote:
> Florian Achleitner wrote:
> Because of the above:
> > 1. Write a new bi-directional remote helper in C.
> 
> The word "new" makes me worried that you'd be throwing away whatever
> work already exists. :)

Probably I missed something. 
But all I've seen that is directly a remote-helper is a bash script which 
basically calls a pipeline from svnrdump | svn-fe | fast-import [2]. 
I'm not planning to write a longer program in bash. (I personally use bash 
only for things that fit on one terminal height).

Bash and Perl are not my favourites ;)

[1] https://github.com/divanorama/git/blob/remote-svn-alpha_v2/contrib/svn-
fe/git-remote-svn-alpha

Cheers,
Florian
