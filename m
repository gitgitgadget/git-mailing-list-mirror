From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] gitweb: tree view: eliminate redundant "blob"
Date: Tue, 3 Oct 2006 13:20:06 -0700 (PDT)
Message-ID: <20061003202006.72783.qmail@web31804.mail.mud.yahoo.com>
References: <200610031018.40273.jnareb@gmail.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 03 22:21:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUqkP-0008L5-E3
	for gcvg-git@gmane.org; Tue, 03 Oct 2006 22:20:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030318AbWJCUUJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Oct 2006 16:20:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030324AbWJCUUJ
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Oct 2006 16:20:09 -0400
Received: from web31804.mail.mud.yahoo.com ([68.142.207.67]:55648 "HELO
	web31804.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030318AbWJCUUH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Oct 2006 16:20:07 -0400
Received: (qmail 72785 invoked by uid 60001); 3 Oct 2006 20:20:07 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=24Lmh88DvGdPvgrG5TLcbuZJVRjT4c7j/zP+7XspQHnMDlwQ8v90RBj5n0Nc5GsmAc3EKznniLLmkOqSu+mhf8dqhuH2SBgd8ZRK81Nqaq9uayEfPq8FVFQ8gIHkeyYnGjV+4+BMzDNwVzJKD6M5cyd4X3ee2lRAEmQDGBNI4U4=  ;
Received: from [64.215.88.90] by web31804.mail.mud.yahoo.com via HTTP; Tue, 03 Oct 2006 13:20:06 PDT
To: Jakub Narebski <jnareb@gmail.com>, Junio C Hamano <junkio@cox.net>
In-Reply-To: <200610031018.40273.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28298>

--- Jakub Narebski <jnareb@gmail.com> wrote:
> On Tue, 3 Oct 2006, Junio C Hamano wrote:
> 
> > Honestly, I _hate_ to be in the position to decide in which
> > color the bikeshed should be, but sometimes that is what a
> > maintainer has to do.
> 
> Joys and tribulations of being maintainer... ;-)

Junio is doing an excellent job at maintaining GIT!  He's
tried to accomodate everyone, since this kind of flexibility
decides how many entities and companies adopt GIT and in return
this makes GIT better, by having those entities and companies
send back patches.  It is a well understood loop.

You should take a look at Linux and some subsystem's maintainers
"maintainership".  The worst thing by far that can happen to
a project being maintained is when "maintainership" becomes
the maintainer's _job_, as opposed to a professional (specializing
in a contingent field) who is doing maintainership in his spare
time. (i.e. the way it was in the 70s-80s with UNIX.)

Anyway, I digress, sorry.

> > By the same logic, the purpose of the tree view is to show
> > contents of a tree object.  If the user picks up the convention
> > for the short log that each listed commit can be clicked to
> > obtain details about it, it probably is natural for the user to
> > expect that each listed entry in the tree view can be clicked to
> > obtain details about it, so not showing the redundant tree/blob
> > link is in line with that.  And it would be consistent not to
> > give underline to the file or directory names.
> 
> I'd rather have underline for directory names to distinguish
> it even more from files (blob entries), even for monochromatic
> text display.

I strongly agree with Junio.  Intuition of gitweb spills in all
of its interfaces.  The nature of gitweb dictates that certain
things are clickable, simply because it is, after all, a web
interface to none other but GIT.

We don't need an overly explicit interface in gitweb, since gitweb
is not supposed to _teach_ git, but present it.

Take a look at other SCMs interfaces: perforce, cvs, clearcase, etc.

> I am of two mind about removing "redundant" links movement.
> 
> First, I don't thing that avoiding redundancy in _user interface_
> is a good argument. We sometimes add redundancy, for example in
> commitdiff view for each patch we have sha1 of blob in the gitweb
> header clickable, and obvously link, and we have the names of from
> and to files in diff header "hidden links" and clickable. I could
> agree with the argument about removing redundancy from the _code_,
> and/or with the argument about _uncluttering_ interface.
> 
> Second, removing "redundant" links coupled with the fact that
> the links the removed links duplicated cannot for mentioned resons
> have default links style, so it is harder to guess that they are
> links ("mystery meat navigation", although not in it's worst edition).
> So there is tradeoff. Uncluttering the interface and simplifying
> the code, but at the cost of gitweb interface being harder to beginners.

What "beginners" are you refering to?  GIT beginners or gitweb beginners?
gitweb is not supposed to be a teaching tool to GIT.

> It is a question of policy then, do we cater to beginner users, or to
> advanced users (which know/discovered that file name in tree view
> and commit subject/title line in shortlog are links to respectively
> blob view of a file and commit view of a commit).
> 
> Third, we should be consistent: either leave redundant links, perhaps
> separating it by putting it into separate "selflink" column (see for 
> example tags view), or remove redundat links where possible in all 
> views.

An absolutely excellent argument for the confines of a college course
paper or assignment on GUI.  Not very convicing to people with years
and years of experience in SCMs and what-not.

What we want is not some zelous argument about what is the "right"
way or the "proper" way (all very subjective) of doing the interface
of gitweb.  What we want is an intuitive and workable interface,
minimizing the number of eye movements, mouse movement, mouse clicks
to get to the information being sought.

    Luben
