From: Petr Baudis <pasky@suse.cz>
Subject: Re: Default exclude rules for Git
Date: Fri, 19 Sep 2008 18:33:12 +0200
Message-ID: <20080919163311.GH10544@machine.or.cz>
References: <1221755370-6817-1-git-send-email-kirr@landau.phys.spbu.ru> <1221755370-6817-2-git-send-email-kirr@landau.phys.spbu.ru> <36ca99e90809181038o74c73121j59849b3f24fe6469@mail.gmail.com> <alpine.LNX.1.00.0809181526190.19665@iabervon.org> <20080919050612.GA4423@roro3> <20080919142211.GE10360@machine.or.cz> <7v8wtouoit.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kirill Smelkov <kirr@landau.phys.spbu.ru>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Bert Wesarg <bert.wesarg@googlemail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 19 18:34:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kgiw4-00016J-D3
	for gcvg-git-2@gmane.org; Fri, 19 Sep 2008 18:34:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753407AbYISQdP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Sep 2008 12:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753341AbYISQdP
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Sep 2008 12:33:15 -0400
Received: from w241.dkm.cz ([62.24.88.241]:60290 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752851AbYISQdO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Sep 2008 12:33:14 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 10C5E393A370; Fri, 19 Sep 2008 18:33:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v8wtouoit.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96299>

On Fri, Sep 19, 2008 at 08:46:34AM -0700, Junio C Hamano wrote:
> I do not see a need to change any canned template shipped with git.  I
> actually think it is a grave regression to add anything arbitrary, even if
> one person happens to think the choice is conservative, to the set of
> tool-wide ignore patterns.  And here is why.
> 
> I haven't personally seen any project that wants its users to _edit_ a
> file whose names end with ".a" or ".o" and track it.  That does not
> however mean that there can be no project and/or environment that validly
> wants to track files with ".o" suffix (isn't it the case that windows shop
> use ".obj" for object files and ".o" suffix do not have any particular
> meaning to them?)  By placing "*.o" to tool-wide ignore file, your version
> of git is making life for participants in such a project harder because
> they can now easily forget to add a newly created "*.o" files (status
> won't show them).  The tool should be extremely conservative not to
> encourage such mistakes.
> 
> The best place to express such a project wide policy (e.g. "in this
> project, '*.o' files will never, or rarely if ever, be tracked and we
> expect our developers to appreciate not seeing them in status output by
> default") is a tracked .gitignore file.

Yes, but the idea here is to give both the projects and the users
sensible default to work on, in case of users even one that might change
system to system based on tools behavior. It is that VAST MAJORITY of
projects won't care about object or (most kinds of) hidden files, so to
me it makes sense to make people opt out instead of opt in.

If a particular policy is unsuitable for some (rare) project, it can
still undo the ignore rules by adding !*.o to its .gitignore file. The
only issue is that this gets noticed first time a particular new ignore
pattern appears, and I admit I don't have a good solution here.

-- 
				Petr "Pasky" Baudis
The next generation of interesting software will be done
on the Macintosh, not the IBM PC.  -- Bill Gates
