From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: Importing from tarballs; add, rm, update-index?
Date: Fri, 12 Jan 2007 22:04:03 +0100
Message-ID: <20070112210403.GB6262@xp.machine.xx>
References: <6efbd9b70701120541n5dc4d0e1va50ae96543d8c80@mail.gmail.com> <7virfct737.fsf@assigned-by-dhcp.cox.net> <slrneqfnb8.a6s.Peter.B.Baumann@xp.machine.xx> <7vejq0t4ij.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Jan 12 22:10:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5Tey-00086N-Lm
	for gcvg-git@gmane.org; Fri, 12 Jan 2007 22:10:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030502AbXALVJ6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Jan 2007 16:09:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030504AbXALVJ5
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jan 2007 16:09:57 -0500
Received: from matlock.hofmann.stw.uni-erlangen.de ([131.188.24.35]:43095 "HELO
	mail.hofmann.stw.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1030502AbXALVJ5 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Jan 2007 16:09:57 -0500
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Jan 2007 16:09:56 EST
Received: (qmail 3640 invoked by uid 0); 12 Jan 2007 21:03:11 -0000
Received: from p54aa89f5.dip0.t-ipconnect.de (HELO localhost) (p.b@hofmann.stw.uni-erlangen.de@84.170.137.245)
  by mail.hofmann.stw.uni-erlangen.de with SMTP; 12 Jan 2007 21:03:11 -0000
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vejq0t4ij.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36712>

On Fri, Jan 12, 2007 at 11:43:32AM -0800, Junio C Hamano wrote:
> Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de>
> writes:
> 
> > Me doesn't really like the new semantics of "git-add", because it does
> > two seperate things - it adds new files and it refreshes the content of
> > previously known files.
> 
> http://thread.gmane.org/gmane.comp.version-control.git/32452/focus=32792
> 

[For the readers conveniance I added the above mail below.]

Yes. I fully second Linus opinion. But I think there should be a difference in
adding completly new content to the index (number of entries in the index grows)
or replacing content in the index.

That's what I'm aiming for.

-Peter

?> 
?> If the "create file; git add; edit file; git commit" confusion isn't
?> blisteringly obvious to the git maintainers then I think I have to
?> give up here.
?> 
?> And this isn't just CVS-induced brain damage.
?
?I'm sorry, but you are wrong.
?
? It really _is_ CVS-induced brain damage, and I'm trying to teach you. You 
? can give up, but that's really "refuse to see the damage that systems like 
? RCS and CVS has done to the world"
? 
? The fundamental brain damage that CVS (and RCS, and SVN, and just about 
? anything else) has had is thinking that "filenames" (and sometimes this is 
? "fixed" to be "file ID's") are somehow special, and a totally separate 
? thing from "file contents".
? 
? Really. It's a BUG. It's a deficiency in CVS and friends. And it's a 
? deficiency that you have gotten so used to that you don't even see that 
? it's simply obviously NOT TRUE.
? 
? You _cannot_ have a filename without the contents of that filename. That 
? whole concept doesn't make sense, except in the twisted AND WRONG mental 
? model of "files have identities even without content".
? 
? The whole point of git is that it is about "project state" and the history 
? that binds those states together. People have kind of come to accept that, 
? and a lot of people realize what it means, but I don't think you've really 
? accepted what it means for something as simple as a "git add" command.
? 
? Again, totally ignore the index. Imagine that it doesn't exist. Imagine 
? that you never actually learnt about it, and that none of the 
? documentation ever mentions it, and just ask yourself:
? 
? 	"What does 'adding a file' really mean?"
? 
? I mean _really_. It cannot be about the "filename", because a filename 
? simply doesn't have any meaning alone. Remember what git is all about.
? 
? No, when you do a "git add", YOU DO NOT TALK ABOUT FILENAMES AT ALL.
? 
? 	NOT EVEN CLOSE!
? 
? No. Git is, and has always been, all about tracking project content. The 
? fact that CVS is crap, and thinks that "filenames" are special (and this 
? causes major problems when you do renames), and the fact that SVN is crap, 
? and things that "file identities" are special (and this causes major 
? problems when you split a file or when two files join) is very much about 
? THEIR F*CKING IDIOTIC FUNDAMENTAL BRAINDAMAGE!
? 
? So take five minutes to really think about that. Take an hour. Take a 
? week. Ponder it.
? 
? What does it mean to "add" something to a project? It has _nothing_ to do 
? with "filenames". Yeah, the filename obviously exists, but it's not 
? something that exists on its own. You add the ONLY thing that git tracks. 
? 
? You add CONTENT.
? 
? When you do "git add file.c" you aren't adding a filename to the list of 
? files that git knows about. Not even CLOSE. No. You are really adding 
? _content_ to the project you are tracking. You haven't bound it to a 
? commit yet, but it's there. It's there both conceptually, and very much in 
? a real technical sense too (you've literally added the git object that 
? that file describes to the object database - the "commit" and "tree" 
? objects to tie it all together is just waiting to be added, but they 
? really just expose it - the actual file object has already been created 
? when you do "git add".)
? 
? So yes, you very much ARE talking about CVS braindamage. The reason why
? 
? 	git add file.c
? 	echo New line >> file.c
? 	git commit
? 
? commits the _old_ content, is very much because git is ALL ABOUT THE 
? CONTENT. It has _never_ been about filenames. And it _shouldn't_ be about 
? filenames, because that would be BUGGY AND BROKEN.
? 
? Sorry for shouting, but as long as you think "git add" adds a filename, 
? you're just not getting it. And I think it's really sad that you don't 
? even seem to understand that yes, this _is_ braindamage that has been 
? forced upon you by decades of mental rape done by bad source control 
? systems.
? 
? Please. File identities are _bad_ in the SVN kind of setting. The CVS kind 
? of "filename == file identity" is even _worse_, but it's still exactly the 
? same disease. It's the disease of thinking that metadata is somehow 
? "different" from real data, and that "files" have identities that are 
? somehow separate from the data they contain.
? 
? Face it, git is consistent, and if it acted the way you seem to expect it 
? to act, it would actually be a BUG. Exactly because you cannot and MUST 
? NOT think that "filename" is something that has meaning without "file 
? content" (or "file type" and "file permissions" - they all go together).
? 
? And notice? NONE OF THIS HAS ANYTHING AT ALL TO DO WITH 'INDEX'!! The 
? explanation above is not "this is how the index works". It's a much more 
? fundamnetal issue of getting the right mental model, where the only thing 
? that matters is contents.
? 
? So even without an index, "git add" should work the way it works, once you 
? can just let go of the broken model that is CVS.
? 
? Please. Join me, Luke. The power of the git side is stronger. I am your 
? father. 
? 
?			Linus
