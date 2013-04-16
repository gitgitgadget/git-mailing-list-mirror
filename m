From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [RFC/PATCH] clone: introduce clone.submoduleGitDir to relocate
 $GITDIR
Date: Tue, 16 Apr 2013 11:46:07 -0400
Message-ID: <516D723F.9070204@xiplink.com>
References: <1365881007-25731-1-git-send-email-artagnon@gmail.com> <7vy5ck4m6b.fsf@alter.siamese.dyndns.org> <CALkWK0mvtRhFc0_4883ATNaYpb+kDwpV9VxeAoqJy5HxNQ6vgg@mail.gmail.com> <516C21CF.5080705@xiplink.com> <7vvc7nu1hu.fsf@alter.siamese.dyndns.org> <CALkWK0n0y6OPJvYjNeEbUx_CC58vHRRLCsmJtws+RKyv3wRTwQ@mail.gmail.com> <516C4BEB.7030507@xiplink.com> <CALkWK0kEQ+mCxkaqUusyaEpx350qNrJ8UPoeo7+hEVGEUbtaxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 17:46:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1US85F-0004IT-Vk
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 17:46:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964965Ab3DPPqG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 11:46:06 -0400
Received: from smtp154.ord.emailsrvr.com ([173.203.6.154]:36602 "EHLO
	smtp154.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964960Ab3DPPqF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 11:46:05 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp20.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id 0D6241C019B;
	Tue, 16 Apr 2013 11:46:05 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp20.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 798EE1C0121;
	Tue, 16 Apr 2013 11:46:04 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <CALkWK0kEQ+mCxkaqUusyaEpx350qNrJ8UPoeo7+hEVGEUbtaxQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221426>

On 13-04-16 04:17 AM, Ramkumar Ramachandra wrote:
> Marc Branchaud wrote:
>> If "git add" is all about specifying what lives under paths in the worktree,
>> what's wrong with letting "git add" go beyond specifying just files?
>>
>> Syntax aside for the moment, I think a command like
>>         git add git-repo-reference foo
>> is perfectly natural:  It specifies what is inside worktree path foo.
> 
> I never said "just files".  Files, directories, symlinks and
> submodules are all "things in the worktree", and all fine.  Remote
> URLs, on the other hand, have nothing to do with the worktree.

But they have everything to do with submodules.  You need a URL to identify a
submodule.  If you want a submodule in your worktree, at some point you have
to specify the submodule's URL.

I really feel like I'm missing something here.  You seem to be saying that
it's wrong to let "git add" interpret a URL as a submodule.  Instead you seem
to want to have some other mechanism create the files, directories and
symlinks that make up a submodule, so that "git add" can then operate with
the purity you desire.  That's what I don't understand.

As a submodule user, I want to "git add" a submodule.  I don't see why it's
necessary to have more than one command to do that.  But if you're saying
that it's fine for "git add" to work this way, then I don't see the point of
the proposed change to "git clone".

		M.
