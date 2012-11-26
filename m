From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: Requirements for integrating a new git subcommand
Date: Sun, 25 Nov 2012 23:49:22 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20121126044922.GA14505@thyrsus.com>
References: <20121122053012.GA17265@thyrsus.com>
 <7vmwy5xe9n.fsf@alter.siamese.dyndns.org>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 05:50:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TcqeP-0008G3-IT
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 05:50:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753874Ab2KZEuS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2012 23:50:18 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:46529
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753861Ab2KZEuR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2012 23:50:17 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 295044065F; Sun, 25 Nov 2012 23:49:23 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vmwy5xe9n.fsf@alter.siamese.dyndns.org>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210408>

Junio C Hamano <gitster@pobox.com>:
> "Eric S. Raymond" <esr@thyrsus.com> writes:
> 
> > While the weave operation can build a commit graph with any structure
> > desired, an important restriction of the inverse (unraveling)
> > operation is that it operates on *master branches only*. The unravel
> > operation discards non-master-branch content, emitting a warning 
> > to standard error when it has to do so.
> 
> Imagine that I have a simple four-commit diamond:
> 
>     I---A
>      \   \
>       B---M
> 
> where Amy and Bob forked the initial commit made by Ian and created
> one commit each, and their branches were merged into one 'master'
> branch by a merge commit made by Mac.  How many state snapshots will
> I see when I ask you to unravel this?  Three, or four?

You will see four tree states.  I have managed to remove the
master-branch-only restriction.

> As to the procedural stuff, I think others have sufficiently
> answered already.  If I may add something, a new stuff typically
> start its life in contrib/ before it proves to be useful.

Thank you, I have submitted a documentation patch which folds
in the on-list discussion.

As a separate point...are you requesting that I submit my integration
patch to drop git-weave in contrib?  If so, I will of course comply.

But I will point out that git-weave is not a half-thought out
experiment; it is fully documented and has a functional test.  The
case for its usefulness is bolstered by one previous contrib script,
which the author has agreed to retire in favor of git-weave.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
