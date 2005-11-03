From: "Peter Eriksen" <s022018@student.dtu.dk>
Subject: Re: little conundrum
Date: Thu, 3 Nov 2005 19:10:03 +0100
Message-ID: <20051103181002.GA26437@bohr.gbar.dtu.dk>
References: <200511031741.20496.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Nov 03 19:13:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXjXO-0000xA-PW
	for gcvg-git@gmane.org; Thu, 03 Nov 2005 19:10:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030401AbVKCSKG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Nov 2005 13:10:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030405AbVKCSKG
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Nov 2005 13:10:06 -0500
Received: from bohr.gbar.dtu.dk ([192.38.95.24]:57324 "HELO bohr.gbar.dtu.dk")
	by vger.kernel.org with SMTP id S1030401AbVKCSKF (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Nov 2005 13:10:05 -0500
Received: (qmail 28265 invoked by uid 5842); 3 Nov 2005 19:10:03 +0100
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <200511031741.20496.alan@chandlerfamily.org.uk>
User-Agent: Mutt/1.5.7i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11080>

On Thu, Nov 03, 2005 at 05:41:20PM +0000, Alan Chandler wrote:
> I have a little problem I am trying to solve.  Tried a few things and got 
> nowhere, so I thought I would ask here.
> 
> I have two directories one of which contains a tree of source code that was an 
> original software package that I downloaded.  The other contains the result 
> of some unfinished - but quite substancial changes that I had made to that 
> source code.  Since this was some time ago, I don't have any records, but it 
> is quite possible that I added and removed quite a few files.
> 
> I would like to make myself a git repository that contains at the start, an 
> initial commit of the original downloaded source code, and a second commit on 
> the top of that that contains the the current state of play after the changes 
> I have made.

What I read from this, is that you could do something like (with Git,
but I suppose Cogito is very similar):

]cd original
]git-init-db
]git-add all-the-files
]git-commit -m "Initial import"
]cp -rf ../modified/* .
]git-status
...fix things up adding and deleting files
]git-commit -m "First big change

The point is, I think git-status will tell you about any
modifications you have made by just overwriting the original
tree with the modified one.

Peter
