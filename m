From: Michael J Gruber <drmicha@warpmail.net>
Subject: Re: git format-patch should honor notes
Date: Wed, 08 Dec 2010 09:20:52 +0100
Message-ID: <4CFF3FE4.4080104@warpmail.net>
References: <4CFEACC5.70005@redhat.com> <20101207221151.GC1036@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Eric Blake <eblake@redhat.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 08 09:23:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQFJ2-0003FD-8U
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 09:23:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754296Ab0LHIXP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Dec 2010 03:23:15 -0500
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:45074 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753335Ab0LHIXO (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Dec 2010 03:23:14 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 7D645760;
	Wed,  8 Dec 2010 03:23:14 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 08 Dec 2010 03:23:14 -0500
X-Sasl-enc: Qs522eTI0qlS1kwLgclCzJXZ5+78R9jEFehSS40IgLi0 1291796593
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 6CE3C403C52;
	Wed,  8 Dec 2010 03:23:13 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.12) Gecko/20101103 Fedora/1.0-0.33.b2pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.6
In-Reply-To: <20101207221151.GC1036@sigill.intra.peff.net>
X-Enigmail-Version: 1.1.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163177>

Jeff King venit, vidit, dixit 07.12.2010 23:11:
> On Tue, Dec 07, 2010 at 02:53:09PM -0700, Eric Blake wrote:
> 
>> My workflow is that I post patch series for upstream review via 'git
>> send-email'.  Often, that results in feedback that requires me to
>> amend/rebase my series, and post a v2 or v3 of the series.  By adding
>> 'git config notes.rewriteRef refs/notes/commits', I can add notes that
>> will carry across my rebase, and remind me what I changed in v2 (for
>> example, git notes add -m 'v2: fix foo, per mail xyz@example.com').
>> This is handy for me, and I think it is also handy for reviewers -
>> someone who took the time to read through v1 should know what I changed
>> in response to their comments, and only have to focus in on commits with
>> changes, rather than on the entire resent series.
> 
> Yeah, that is a workflow that some others have mentioned using here,
> too. And I think there is general agreement that notes should go after
> the "---" in format-patch. We just need a working patch.
> 
> Thomas posted one in February:
> 
>   http://article.gmane.org/gmane.comp.version-control.git/140819
> 
> But there were some issues and it never got polished. Michael suggested
> that he does something similar here:
> 
>   http://article.gmane.org/gmane.comp.version-control.git/140819
> 
> but there was no indication on whether it happens manually or if he has
> a patch. I don't know if anything else has happened in that area. I'm
> sure if you feel like working on a patch it would be well received.
> 
> -Peff

I do it with ":r!git notes show" in vim (after "/---"), which has the
advantage over "format-patch --show-notes" that the notes are not
indented nor preceded by a "Notes:" header. (I wouldn't mind the
latter.) This is comfortable enough to have kept me from writing a patch.

Also, in order to be really useful, I would need a place to store the
cover letter also. I was experimenting a while back with a design for
annotating branchnames which "basically" worked but haven't had time to
really implement it. If I remember correctly, I had to set up some
"bogus" refs to keep my notes from being garbage collected and was still
figuring out the best place to put them. I'll dig it up when I have time to.

Michael
