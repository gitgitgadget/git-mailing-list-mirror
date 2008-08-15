From: Jan Nieuwenhuizen <janneke-list@xs4all.nl>
Subject: Re: [TopGit PATCH] tg-create.sh: Introduce --add option to add a
 dependency.
Date: Fri, 15 Aug 2008 10:10:34 +0200
Organization: lilypond-design.org
Message-ID: <1218787834.7585.13.camel@heerbeest>
References: <1218637514.7561.30.camel@heerbeest>
	 <Pine.GSO.4.62.0808131100280.1278@harper.uchicago.edu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>, Jan Holesovsky <kendy@suse.cz>
To: Jonathan Nieder <jrnieder@uchicago.edu>
X-From: git-owner@vger.kernel.org Fri Aug 15 10:12:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTuPi-0004oo-Md
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 10:12:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752732AbYHOIKk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Aug 2008 04:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752691AbYHOIKj
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Aug 2008 04:10:39 -0400
Received: from edu-smtp-02.edutel.nl ([88.159.1.222]:34562 "EHLO
	edu-smtp-02.edutel.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752530AbYHOIKh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2008 04:10:37 -0400
Received: from heerbeest (unknown [88.159.206.46])
	by edu-smtp-02.edutel.nl (Postfix) with ESMTP id 765E611E65C;
	Fri, 15 Aug 2008 10:10:36 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by heerbeest (Postfix) with ESMTP id F273FDC070;
	Fri, 15 Aug 2008 10:10:35 +0200 (CEST)
In-Reply-To: <Pine.GSO.4.62.0808131100280.1278@harper.uchicago.edu>
X-Mailer: Evolution 2.23.6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92464>

On wo, 2008-08-13 at 11:20 -0500, Jonathan Nieder wrote:

Hi,

> Interesting - I had imagined changing dependencies working in an
> entirely different way.

Thanks!  This is quite interesting.  A few questions

> 
> 	$ git checkout -b P' P
> 	$ git rebase --onto B' B

.. is using rebase a robust solution?  We should provide a way to
recover after user intervention here?

> 	$ git checkout P
> 	$ git merge --no-ff --no-commit B'   (*)

Do you remember in what area the problem is here, that would make it a 
lot easier for me to look.

> 	$ git read-tree -u P'

Ouch, I'm feeling so git-unitiated here; what is read-tree doing 
differently from merge?  Isn't here a -m missing?

> The main problem I see with this story is that if B' is just B with some
> new changes added this is overly complicated.

Yes, that's my main gripe.  One of the use cases I'm looking at is
our ooo-build master branch; which includes ~300 topic branches.

Removing or [re-]adding one dependency using this rebase-by-merging 
approch would take ~7 minutes on my machine.

I'm now also looking at a .topundeps file, to support
the re-adding of a depenency using the cherry-pick approach...

Greetings,
Janneke. 

-- 
Jan Nieuwenhuizen <janneke@gnu.org> | GNU LilyPond - The music typesetter
http://www.xs4all.nl/~jantien       | http://www.lilypond.org
