From: Sam Vilain <sam@vilain.net>
Subject: Re: git-submodule getting submodules from the parent repository
Date: Wed, 02 Apr 2008 12:05:49 +1300
Message-ID: <47F2BFCD.5070202@vilain.net>
References: <32541b130803291535m317e84e6p321ebccd5dedaab3@mail.gmail.com>	 <47EECF1F.60908@vilain.net>	 <D0F821FA-AF53-4F1F-B9CC-58346828FA15@orakel.ntnu.no>	 <47EFD253.6020105@vilain.net>	 <C38585A9-F09C-4A5B-8E72-6F3127DB2BB9@orakel.ntnu.no>	 <32541b130803301603u65d1b6b6ladac0f6200433e5f@mail.gmail.com>	 <834174D1-82F4-4438-9854-762F416BB5EF@orakel.ntnu.no> <32541b130803311436t7b5041a4pabface15aad8ce63@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 02 01:06:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgpYv-0007ms-VP
	for gcvg-git-2@gmane.org; Wed, 02 Apr 2008 01:06:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753865AbYDAXF5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2008 19:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754582AbYDAXF5
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Apr 2008 19:05:57 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:36440 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753724AbYDAXF4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2008 19:05:56 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 57EFF21C995; Wed,  2 Apr 2008 12:05:54 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb (2006-10-05) on 
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.1.7-deb
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTP id DAC4821C98F;
	Wed,  2 Apr 2008 12:05:49 +1300 (NZDT)
User-Agent: Icedove 1.5.0.12 (X11/20070606)
In-Reply-To: <32541b130803311436t7b5041a4pabface15aad8ce63@mail.gmail.com>
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78667>

Avery Pennarun wrote:
> I even *use* git-submodule and had to modify my build scripts because
> "git submodule init" and "git submodule update" don't seem to kick in
> automatically for some reason.

The reason is that not everyone wants that by default.  Perhaps it is a
good idea for it to be default behaviour; but all in good time.  It can
be a user-selected option to clone first.

> The ideal situation would be to have
> git just manage the version control without having to babysit it, of
> course.

I can understand the motivation to write such disparaging remarks;
however it may be more productive to come up with good ideas about how
it can be made to work better for you, without getting in the way of
other users.  patches are even better!

>>  If I understand you correctly, you want to be forced to create a
>>  branch and push to that?  I don't think that works well with many
>>  developers pushing to a shared repository (my situation),
> 
> Hmm, this is curious.  If you're *not* using submodules, then I don't
> think you can push successfully without being on a branch, can you?

Sure, you could;

  git push origin HEAD:branchname

However I think the right solution to this is to name the branch
appropriately somehow, so that the default push operation works.

> If you 'git checkout -b branchname' inside a submodule, then 'git
> push' will do the right thing, so I'm not sure what you'd want to be
> more automagical than that.

Well, where did you get the branch name from?  That's the part that
requires user intervention.  You could make an educated guess, such as
with git name-rev, but it would not necessarily be the right guess - so
user confirmation of the choice would be desirable.

Sam.
