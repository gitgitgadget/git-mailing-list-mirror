From: Stephen & Linda Smith <ischis2@cox.net>
Subject: Re: [PATCH V5 2/2] user-manual: add section documenting shallow clones
Date: Tue, 29 Dec 2015 14:47:17 -0700
Message-ID: <4187709.UG5bg1kMPP@thunderbird>
References: <xmqqfuymji50.fsf@gitster.mtv.corp.google.com> <1451415296-3960-1-git-send-email-ischis2@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Git List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 29 22:47:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aE272-0008JN-LV
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 22:47:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753713AbbL2VrV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2015 16:47:21 -0500
Received: from fed1rmfepo203.cox.net ([68.230.241.148]:37362 "EHLO
	fed1rmfepo203.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751184AbbL2VrT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 16:47:19 -0500
Received: from fed1rmimpo306 ([68.230.241.174]) by fed1rmfepo203.cox.net
          (InterMail vM.8.01.05.15 201-2260-151-145-20131218) with ESMTP
          id <20151229214718.LMGW26406.fed1rmfepo203.cox.net@fed1rmimpo306>
          for <git@vger.kernel.org>; Tue, 29 Dec 2015 16:47:18 -0500
Received: from thunderbird ([68.231.74.134])
	by fed1rmimpo306 with cox
	id zZnH1r00P2tqoqC01ZnJLB; Tue, 29 Dec 2015 16:47:18 -0500
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A020204.5682FF66.0109,ss=1,re=0.000,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.0 cv=LKq4tuq9 c=1 sm=1
 a=/Rt4pg3TtX3KzfzhvVoEow==:17 a=kviXuzpPAAAA:8 a=wUQvQvOEmiQA:10
 a=TSbVqHtbAAAA:8 a=VwQbUJbxAAAA:8 a=7iLZvQifxHo-dBs9yt4A:9 a=CjuIK1q_8ugA:10
 a=x8gzFH9gYPwA:10 a=/Rt4pg3TtX3KzfzhvVoEow==:117
X-CM-Score: 0.00
Authentication-Results: cox.net; none
Received: from thunderbird.localnet (thunderbird [127.0.0.1])
	by thunderbird (Postfix) with ESMTP id 36BBB1402B9;
	Tue, 29 Dec 2015 14:47:18 -0700 (MST)
User-Agent: KMail/5.0.2 (Linux/4.3.0-2-generic; KDE/5.15.0; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283151>

On Tuesday, December 29, 2015 11:24:00 AM Junio C Hamano wrote:
> "Stephen P. Smith" <ischis2@cox.net> writes:
> 
> > Rather than merely pointing readers at the 1.5 release notes to
> > learn about shallow clones, document them formally.
> >
> > Signed-off-by: Stephen P. Smith <ischis2@cox.net>
> > ---
> 
> Thanks.  I do not think the reference to RelNotes were meant for the
> end-user readers, though.  That was a hint for whoever is working to
> clear the "todo" items from that list i.e. you ;-> ).

Actually that was a suggested update[1].   Do you still think I should replace it?

[1] http://article.gmane.org/gmane.comp.version-control.git/282831
> 
> > +[[how-to-get-a-git-repository-with-minimal-history]]
> > +How to get a Git repository with minimal history
> > +------------------------------------------------
> > +
> > +A <<def_shallow_clone,shallow clone>>, with its truncated
> > +history, is useful when one is interested only in recent history
> > +of a project and getting full history from the upstream is
> > +expensive.
> > +
> > +A <<def_shallow_clone,shallow clone>> is created by specifying
> > +the linkgit:git-clone[1] `--depth` switch. The depth can later be
> > +changed with the linkgit:git-fetch[1] `--depth` switch, or full
> > +history restored with `--unshallow`.
> > +
> > +Merging inside a <<def_shallow_clone,shallow clone>> will work as long
> > +as the merge base is in the resent history.  If the merge base is not
> 
> recent?

I had that fixed and then managed to corrupt my working branch losing the change.

> 
> > +present then the merge would be of un-related histories.  This
> > +limitaion is fundamental and will not be removed.
> 
> I think "fundamental and will not change" is much less important
> than the "huge conflicts, making the result of 'clone --depth=<n>'
> not very useful to perform merges in", which is what the users would
> need to know before deciding to use this feature.

OK

> 
> > +
> >  [[sharing-development-examples]]
> >  Examples
> >  --------
> > @@ -4645,9 +4664,6 @@ standard end-of-chapter section?
> >  
> >  Include cross-references to the glossary, where appropriate.
> >  
> > -Document shallow clones?  See draft 1.5.0 release notes for some
> > -documentation.
> > -
> >  Add a section on working with other version control systems, including
> >  CVS, Subversion, and just imports of series of release tarballs.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
