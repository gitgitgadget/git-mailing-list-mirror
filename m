From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 2/2] Add Author and Documentation sections to git-for-each-ref.txt
Date: Sun, 13 Mar 2011 14:27:05 +0100
Message-ID: <4D7CC629.2020000@drmicha.warpmail.net>
References: <1299590170-30799-1-git-send-email-alcosholik@gmail.com> <1299590170-30799-3-git-send-email-alcosholik@gmail.com> <4D773570.4010803@drmicha.warpmail.net> <7voc5k9hfy.fsf@alter.siamese.dyndns.org> <20110310223732.GE15828@sigill.intra.peff.net> <AANLkTinzJ7C_Eym20Y3rP3d7hiviPBiCAfdwXGFa4P54@mail.gmail.com> <20110313030214.GB10452@sigill.intra.peff.net> <7vsjuril5r.fsf@alter.siamese.dyndns.org> <20110313064710.GA13135@sigill.intra.peff.net> <7vd3lviie7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Alexei Sholik <alcosholik@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 13 14:27:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PylKM-0006jS-Nh
	for gcvg-git-2@lo.gmane.org; Sun, 13 Mar 2011 14:27:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756276Ab1CMN1K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Mar 2011 09:27:10 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:42006 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756150Ab1CMN1H (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Mar 2011 09:27:07 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 79E8020824;
	Sun, 13 Mar 2011 09:27:06 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Sun, 13 Mar 2011 09:27:06 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=JXdKvDe18GpINFtYzVpddmtLWxs=; b=gcG1I3GR/2gPvqkAuL164gIifG2eBzbgcQe04Mxz6onkxmHpS2YgOEOpTkblyc0t9qNaUFjaPc42JLLLjXxmNO78QPwkryihIy+nhJY7qNBLrRd4J9XTOzqww4yVZetvdJ+2k/7Pku+47C5dD3Kuq9FoWv8iE5sGlwz94xKR9Xw=
X-Sasl-enc: tzx0hxOydQNjQtvXEI3d56hL8pwmZCZiSj/eXxppZC5d 1300022825
Received: from localhost.localdomain (p54859936.dip0.t-ipconnect.de [84.133.153.54])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 3E376442526;
	Sun, 13 Mar 2011 09:27:05 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <7vd3lviie7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168966>

Junio C Hamano venit, vidit, dixit 13.03.2011 08:33:
> Jeff King <peff@peff.net> writes:
> 
>> [1] I have mixed feelings about the aggressive rebasing. Our 'master' is
>> pretty stable, so I don't feel the need to build off the last tagged
>> release.
> 
> In a very busy project (like the kernel), it would make sense to build off
> of the last tagged release when your interaction with the upstream is
> primarily based on patch exchange. But I think that is primarily because
> the maintainer and the reviewer do not have to ask "where does this apply
> to?  It does not apply to my tree; please resend" if you did so. Because
> our "master" does not move so fast, sending a complete patch series based
> on any commit that was once at the tip of "master" works similarly well,
> especially because "am -3" works well in such an environment if "master"
> is never rewound.
> 
> But if your interaction with the upstream is merge based, I think it is
> preferrable to base your fork point as if you are the person at the
> upstream. There is no "where does this apply to" at that point, and you
> have a larger responsibility and say in the final shape of the history.
> 
> Namely (I know you know this, and I am writing this primarily for other
> people on the list):
> 
>  - an fix would be appropriate to be made on top of the oldest maintenance
>    track that contains the commit that introduced a bug (or even directly
>    on the buggy commit itself), as long as merging up from maint-O to
>    maint-N (O < N) to master is simple enough;
> 
>  - For enhancement patches that do not deserve to be backported to
>    maintenance branches, "master" is a good place to start.
> 
> For this topic, you could have said that this is a documentation bug fix
> and started the topic at the tip of maint, given that this is a fairly
> low-risk change, and that we haven't added any new file between maint and
> master that requires an evil merge to fix up.  Or you can say that this is
> very minor and not worth fixing in maintenance track to fork from master.
> 
>> Git-cherry sort of does this, but patch-ids miss a lot of cases: patches
>> tweaked in transit, patches applied on a different commit, or even
>> patches taken partially or split up. So I rebase frequently, and as
>> patches get picked up in master, the branches dwindle to empty.
>> Suggestions welcome if anybody else has figured out something clever.
> 
> A solution to string different iterations of the same patch together,
> perhaps using notes as the storage media, that makes it easier to view the
> changes between different iterations?  I think Shawn does something like
> that in Gerrit code review.
> 
> When I rebase, I tend to keep the base stable (in other words, I don't use
> "rebase" in order to change the base, but to rewrite individual patches),
> too keep comparison between iterations simpler, but I haven't found a
> satisfactory solution for such a comparison for changes near the tip of
> longer series.
> 

In a way it's comforting to know that even long-time contributors like
Jeff haven't found a good workflow for git.git patch lifetime management
yet. But there's progress, such as "commit --notes". I'm also fiddling
with refname notes (so you could store the cover-letter as a note to the
branch name) and have working code I'll send soon.

As far as keeping track of patch versions (without topgit) goes I've
been thinking about "mergy rebase". Before it sits around any longer,
I'll include a rough concept below.

And sorry for thread hijacking - it wasn't me :)

Michael

Say, you start developping a patch series on a branch "topic":

*--A1--B1--C1=topic

Then you rewrite/fixup your series:

*--A2--B2--C2=topic

The previous versions are lost (in the reflog).

With a mergy rebase, a rewrite/fixup would produce:

*--A1--B1--C1
 \  \   \   \
  ---A2--B2--C2=topic

That is, "log --first-parent topic" would always walk the current
version of the topic branch, but the previous one is still accessible:

*--A1--B1--C1
 \  \   \   \
  ---A2--B2--C2
   \  \   \   \
    ---A3--B3--C3
     \  \   \   \
      ---A4--B4--C4=topic

"log --second-parent C4" will give you the history of the patch C
through the different versions of ypur patch series.

(And yes, I have a WIP for --second-parent.)

Downside is that all those merges are evil, of course. But do not be
afraid...
