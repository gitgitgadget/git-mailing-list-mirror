From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [RFC/PATCH] clone: introduce clone.submoduleGitDir to relocate
 $GITDIR
Date: Tue, 16 Apr 2013 11:39:43 -0400
Message-ID: <516D70BF.3050006@xiplink.com>
References: <1365881007-25731-1-git-send-email-artagnon@gmail.com> <7vy5ck4m6b.fsf@alter.siamese.dyndns.org> <CALkWK0mvtRhFc0_4883ATNaYpb+kDwpV9VxeAoqJy5HxNQ6vgg@mail.gmail.com> <516C21CF.5080705@xiplink.com> <7vvc7nu1hu.fsf@alter.siamese.dyndns.org> <CALkWK0n0y6OPJvYjNeEbUx_CC58vHRRLCsmJtws+RKyv3wRTwQ@mail.gmail.com> <20130415184347.GA21170@sigill.intra.peff.net> <CALkWK0nUzbt6R=raWaxxVgAthcUo7E+_FS0rPDDfumgeecHiZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 17:39:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1US7z0-0003wU-SC
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 17:39:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935816Ab3DPPjn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 11:39:43 -0400
Received: from smtp154.ord.emailsrvr.com ([173.203.6.154]:58320 "EHLO
	smtp154.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935783Ab3DPPjm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 11:39:42 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp20.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id A92411C0132;
	Tue, 16 Apr 2013 11:39:41 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp20.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 41E2F1C00BE;
	Tue, 16 Apr 2013 11:39:41 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <CALkWK0nUzbt6R=raWaxxVgAthcUo7E+_FS0rPDDfumgeecHiZg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221425>

On 13-04-16 04:13 AM, Ramkumar Ramachandra wrote:
> Jeff King wrote:
>> So there is some information that is per-clone (the objects, the remote
>> tips), but there is some information that is per-submodule (where our
>> local branches are, the index, the worktree). I can see why it is
>> advantageous to share the per-clone information between similar clones
>> (because it avoids disk space and network transfer). But I do not think
>> you can escape having some form of per-submodule repo, even if it is a
>> thin git-new-workdir-ish repo that points back to a parent repo for the
>> clone.
> 
> I want the flexibility to do the following:
> 
> 1. Do a "simple clone", where the clone contains the GITDIR embedded
> in the worktree.  This is the most common case, and there is no reason
> to complicate it.  I can optionally attach additional workdirs to this
> clone.  I can also optionally relocate the GITDIR at a later date, if
> I feel the need to do so.
> 
> 2. Attach a worktree to any object store without having to write a
> gitfile and set core.worktree by hand.  The limitation is that you
> can't have two submodules from two different superprojects sharing the
> same object store (since both of them are worktrees).  However, for
> the purpose of working on the submodule repository as an independent
> repository (this is a very common case for me), I can attach a new
> "workdir" to the GITDIR very easily.

Doesn't contrib/workdir/git-new-workdir do this?

		M.
