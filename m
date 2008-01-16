From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH v2] Do not show "diff --git" metainfo with --no-prefix
Date: Wed, 16 Jan 2008 15:39:10 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0801161524390.13593@iabervon.org>
References: <c0f2d4110801150559x155ffabaj6bea52715522a070@mail.gmail.com> <alpine.DEB.1.00.0801151444180.5289@eeepc-johanness> <c0f2d4110801150758t68714570y83e1e74acbb67325@mail.gmail.com> <alpine.LNX.1.00.0801151728120.13593@iabervon.org>
 <7vhched3kw.fsf@gitster.siamese.dyndns.org> <7v4pded1rk.fsf_-_@gitster.siamese.dyndns.org> <7v7iiabjyh.fsf_-_@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0801151902080.2806@woody.linux-foundation.org> <alpine.LFD.1.00.0801151919440.2806@woody.linux-foundation.org>
 <alpine.LNX.1.00.0801152256480.13593@iabervon.org> <alpine.LFD.1.00.0801152017490.2806@woody.linux-foundation.org> <7v1w8hploy.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Chris Ortman <chrisortman@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 21:39:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFF35-0003i6-4a
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 21:39:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752654AbYAPUjT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 15:39:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752487AbYAPUjS
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 15:39:18 -0500
Received: from iabervon.org ([66.92.72.58]:59002 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750993AbYAPUjR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 15:39:17 -0500
Received: (qmail 32711 invoked by uid 1000); 16 Jan 2008 20:39:10 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 16 Jan 2008 20:39:10 -0000
In-Reply-To: <7v1w8hploy.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70743>

On Wed, 16 Jan 2008, Junio C Hamano wrote:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
> > That's why tying "--git" together with any prefix handling is wrong: 
> > because it's a totally different issue. It's true that "git-apply" right 
> > now doesn't understand these things, but assuming we want to teach 
> > git-apply to apply to subprojects eventually (we do, don't we?) we'll 
> > eventually have to teach it.
> 
> That's all correct but
> 
>  * currently diff does not recurse, nor apply does not apply
>    recursively;
> 
>  * "git diff" that comes with 1.5.4, if we do not do anything,
>    can produce a diff that will be rejected by the stricter
>    check "git apply" has when used with --no-prefix and friends;
> 
>  * submodule aware versions of "git diff" can be told to add
>    "--mark-as-git-diff" when it passes "--src-prefix=a/git-gui"
>    and "--dst-prefix=b/git-gui" when it recurses internally, to
>    defeat what my proposed patch does.

Or it could pass an option to include the intermediate portion as part of 
the name rather than as part of the prefixes. And git-apply would probably 
be a lot happier to have confirmation that certain files are supposed to 
be from a submodule, which could be handled by including that option in 
the header after --git.

	-Daniel
*This .sig left intentionally blank*
