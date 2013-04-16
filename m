From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [RFC/PATCH] clone: introduce clone.submoduleGitDir to relocate
 $GITDIR
Date: Tue, 16 Apr 2013 11:46:09 -0400
Message-ID: <516D7241.8050901@xiplink.com>
References: <1365881007-25731-1-git-send-email-artagnon@gmail.com> <7vy5ck4m6b.fsf@alter.siamese.dyndns.org> <CALkWK0mvtRhFc0_4883ATNaYpb+kDwpV9VxeAoqJy5HxNQ6vgg@mail.gmail.com> <516C21CF.5080705@xiplink.com> <7vvc7nu1hu.fsf@alter.siamese.dyndns.org> <516C4A52.1080908@xiplink.com> <7va9ozsk60.fsf@alter.siamese.dyndns.org> <CALkWK0=2+RY0cRSJD4pbHxPuqffDEqiwc7m0+Fzk7d8=wLvULQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junio@pobox.com>, Git List <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 17:46:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1US85G-0004IT-FH
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 17:46:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934696Ab3DPPqJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 11:46:09 -0400
Received: from smtp154.ord.emailsrvr.com ([173.203.6.154]:56170 "EHLO
	smtp154.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964960Ab3DPPqH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 11:46:07 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp20.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id E95211C0184;
	Tue, 16 Apr 2013 11:46:06 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp20.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 6035E1C0196;
	Tue, 16 Apr 2013 11:46:06 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <CALkWK0=2+RY0cRSJD4pbHxPuqffDEqiwc7m0+Fzk7d8=wLvULQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221427>

On 13-04-16 04:21 AM, Ramkumar Ramachandra wrote:
> Junio C Hamano wrote:
>> It does not relieve "git add" (or "git submodulea add") from the
>> responsibility of moving .git directory.  It only reduces the need
>> to do so.
>>
>> When the user says "add" and the repository has .git directory in
>> it, "add" (or "submodule add") is still responsible for relocating
>> it.
> 
> Since you're so stubborn about it, I suppose 'git add' could call a
> function in my "new first-class program to attach detach
> worktrees/workdirs and relocate GITDIRs" as a last resort (if the user
> somehow managed to put a GITDIR in the submodule worktree despite our
> well-designed tools).  But last resort is not what we should be
> discussing now: we're discussing what the design should ideally be.
> And ideally, I think we both agree that it's best if init/clone did
> the relocation.

If that's the question, then put me on the "disagree" side.  I just don't see
why that approach is "best", especially if the intention is "to make 'git
add' DTRT wrt submodules, and deprecate 'git submodule add'".

		M.
