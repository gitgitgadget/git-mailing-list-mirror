From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: What's not in 'master', and likely not to be in, until 1.5.4
Date: Mon, 21 Jan 2008 00:35:34 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0801210009290.13593@iabervon.org>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com> <1200022189-2400-2-git-send-email-mlevedahl@gmail.com> <7v1w8o4ws0.fsf@gitster.siamese.dyndns.org> <30e4a070801111252s4e17b9c4m62adeb9032963e66@mail.gmail.com> <7v63xzzszp.fsf@gitster.siamese.dyndns.org>
 <478855B5.9070600@gmail.com> <7vbq7ry405.fsf@gitster.siamese.dyndns.org> <47885B2C.8020809@gmail.com> <7v7iify2wm.fsf@gitster.siamese.dyndns.org> <4788BFA8.2030508@gmail.com> <7vwsqeubj8.fsf@gitster.siamese.dyndns.org> <47891658.3090604@gmail.com>
 <7vbq7qssd7.fsf@gitster.siamese.dyndns.org> <47893E1A.5020702@gmail.com> <7v4pdislrf.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0801132224540.8333@wbgn129.biozentrum.uni-wuerzburg.de> <7vir1xmazm.fsf@gitster.siamese.dyndns.org>
 <7v63xrh3mw.fsf_-_@gitster.siamese.dyndns.org> <7vfxwvfmd8.fsf_-_@gitster.siamese.dyndns.org> <7vr6gb3nv1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 21 06:36:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGpKI-0002dQ-GF
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 06:36:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751900AbYAUFfg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 00:35:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751690AbYAUFfg
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 00:35:36 -0500
Received: from iabervon.org ([66.92.72.58]:57646 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751458AbYAUFff (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 00:35:35 -0500
Received: (qmail 24013 invoked by uid 1000); 21 Jan 2008 05:35:34 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 21 Jan 2008 05:35:34 -0000
In-Reply-To: <7vr6gb3nv1.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Content-ID: <alpine.LNX.1.00.0801210023161.13593@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71221>

On Sun, 20 Jan 2008, Junio C Hamano wrote:

> Here is an update to the list I sent earlier.
> 
> Topics that I thought may deserve attention, discussion and
> eventual inclusion but are not 1.5.4 material.
> 
> I think these two could be part of 1.5.4, but I left them out of
> 1.5.4-rc4 (IOW, I do not think they should be on this list):
> 
>  * marking output from "diff --{no,src,dst}-prefix" as a non-git
>    diff (me)
> 
>    Linus had an objection but I think I made a reasonable
>    argument against that.  Haven't heard back since then, so
>    this is in limbo.

If Linus is still not happy with it, we could instead require that the 
prefixes have at least one slash, not at the beginning, and figure that 
'a/foo/' 'b/foo/' intends the effect it will have on git-apply. The effect 
of --no-prefix on git-apply is kind of incoherent, so that's more sensible 
to prohibit.

> I suspect it might be a good idea to make an early declaration
> that 1.5.5 is to resolve the above listed issues plus the ones
> already in 'pu' (and nothing else), and have a fairly short
> cycle after 1.5.4.

I've got 4 topics that I've been holding back until 1.5.4 is out:

 * Use fewer connections to perform git-native fetches (this is actually 
   from before transport.c made it to master, and I forgot about it until 
   I was rebasing stuff and it didn't go away).

 * Make checkout a builtin (includes a certain amount of infrastructure 
   improvement for programs that might wants to read multiple trees into 
   the same index in memory in sequence)

 * Generate a cover letter from format-patch (originally Dscho's patch; I 
   reworked a bunch of it)

 * Let the user provide aliases for URL patterns (should be useful for 
   groups whose members don't all have the same best access to a remote
   repository)

If you want to have cycles that only handle stuff that's been submitted 
beforehand, it doesn't make sense to have a feature freeze beforehand, and 
therefore only take patches in that cycle from people who ignore your 
wishes. I think in order to do that sort of thing, we'd need a tree run 
like -mm, maintained by somebody whose attention won't be taken away from 
the mainline release process by managing patches that are cooking.

	-Daniel
*This .sig left intentionally blank*
