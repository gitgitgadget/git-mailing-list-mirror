From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH v2 0/2] user-manual: new "getting started" section
Date: Tue, 17 Nov 2009 12:28:15 -0500
Message-ID: <20091117172815.GH31767@fieldses.org>
References: <7vr5ss64e5.fsf@alter.siamese.dyndns.org> <94a0d4530910241316r3fc4136emd036d18aa45a4192@mail.gmail.com> <7vy6n02mrk.fsf@alter.siamese.dyndns.org> <94a0d4530910250243k4cbc3c18l5e018a05e5afdb2d@mail.gmail.com> <20091025111438.GA11252@progeny.tock> <94a0d4530911111515q643e263bn3adc6b47cd968d3d@mail.gmail.com> <4AFBF18E.7070906@drmicha.warpmail.net> <20091114060600.6117@nanako3.lavabit.com> <94a0d4530911161452xe82858el322a1985341bf13c@mail.gmail.com> <20091117210625.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Hannu Koivisto <azure@iki.fi>, Jeff King <peff@peff.net>,
	Wincent Colaiuta <win@wincent.com>,
	Matthias Lederhofer <matled@gmx.net>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Tue Nov 17 18:28:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NARqU-0001f6-0s
	for gcvg-git-2@lo.gmane.org; Tue, 17 Nov 2009 18:28:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755660AbZKQR1t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2009 12:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755543AbZKQR1t
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Nov 2009 12:27:49 -0500
Received: from fieldses.org ([174.143.236.118]:45860 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755046AbZKQR1s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2009 12:27:48 -0500
Received: from bfields by fieldses.org with local (Exim 4.69)
	(envelope-from <bfields@fieldses.org>)
	id 1NARqi-0000HD-0d; Tue, 17 Nov 2009 12:28:16 -0500
Content-Disposition: inline
In-Reply-To: <20091117210625.6117@nanako3.lavabit.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133093>

On Tue, Nov 17, 2009 at 09:06:25PM +0900, Nanako Shiraishi wrote:
> David's proposal introduced two magic tokens STAGE and WORKTREE.
> 
>   git diff STAGE WORKTREE   (like "git diff" today)
>   git diff HEAD WORKTREE    (like "git diff HEAD" today)
>   git diff WORKTREE HEAD    (like "git diff -R HEAD" today)
>   git diff HEAD STAGE       (like "git diff --cached" today)
>   git diff commit STAGE     (like "git diff --cached commit" today)
> 
> This looks nice on surface, but I think the apparent niceness 
> is shallow. If of course has a small problem of introducing an 
> obvious backward incompatibility. You can't use a branch whose 
> name is STAGE anymore, but a deeper problem is that these two 
> magic tokens pretend to be refs. But they do so only to the diff 
> command. I don't see how you can make them sanely be usable to 
> other commands like "git log v1.0.0..WORKTREE".

Doesn't appear that refs have to point to commits; e.g., on the linux
project:

	git log v2.6.11-tree..v2.6.32-rc7
	error: Object 5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c is a tree, not a
	commit
	fatal: Invalid revision range v2.6.11-tree..v2.6.32-rc7


You might be able to add some extra syntax to prevent conflicts with
branch names.  Uh, :STAGE, :WORKTREE ??  But I think that conflicts with
something else.  And the "magic tokens" get a little uglier and harder
to remember.  Bah.

--b.
