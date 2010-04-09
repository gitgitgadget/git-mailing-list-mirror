From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Re*: [PATCH v9] Documentation/remote-helpers: Add invocation
 section
Date: Fri, 09 Apr 2010 10:06:25 +0800
Message-ID: <4BBE8BA1.1080101@drmicha.warpmail.net>
References: <g2vf3271551004062257ycbda64d3z3d3004d802a03fc3@mail.gmail.com> <7vsk77e20r.fsf@alter.siamese.dyndns.org> <n2nf3271551004070950ucf314b40g56087d49dfbd29f1@mail.gmail.com> <20100407224942.GA20239@progeny.tock> <7vzl1eamss.fsf@alter.siamese.dyndns.org> <h2ifabb9a1e1004081152hbca48fbex11134249aef9df14@mail.gmail.com> <7vfx3567e2.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Gabriel Filion <lelutin@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 09 04:06:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O03cK-0005I2-BK
	for gcvg-git-2@lo.gmane.org; Fri, 09 Apr 2010 04:06:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154Ab0DICGe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Apr 2010 22:06:34 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:36480 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750887Ab0DICGe (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Apr 2010 22:06:34 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id E6A3EEAC2A;
	Thu,  8 Apr 2010 22:06:32 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Thu, 08 Apr 2010 22:06:32 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=aDFmcKZU+umUv59Q22RzitmRR5k=; b=kclvO0+yiEavi+HdKp1t5/GXBfDJ26MiOkCUfcJBvDpLP0FUCr1DTDo2R7nplluVV+S5PcQ6HbS5qErOduOZorWQAo/r7pM/t/QsRlTWQYl50Qkj8vUU9y49oHKkuhqZeyM/M/5pF1kNKoV2wrS0yOo0KwuOUrKWNaOit2lKsuY=
X-Sasl-enc: xyFKk25rB+pEDB16C7mgxpJ3aWijZgyAfrKRs7PpJVNl 1270778792
Received: from localhost.localdomain (unknown [202.113.236.7])
	by mail.messagingengine.com (Postfix) with ESMTPSA id EBBEF35019;
	Thu,  8 Apr 2010 22:06:28 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.10pre) Gecko/20100319 Lightning/1.0b2pre Shredder/3.0.5pre
In-Reply-To: <7vfx3567e2.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144389>

Junio C Hamano venit, vidit, dixit 09.04.2010 04:01:
> Sverre Rabbelier <srabbelier@gmail.com> writes:
> 
>> Hmmm, perhaps we should update SubmittingPatches to say something
>> about that? The section that talks about what to base your patch
>> against is not very explicit in that aspect.
> 
> Ok, here is a rough draft.
> 
>  Documentation/SubmittingPatches |   52 ++++++++++++++++++++++++++++++--------
>  1 files changed, 41 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> index c686f86..1d403ee 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -53,6 +53,37 @@ But the patch submission requirements are a lot more relaxed
>  here on the technical/contents front, because the core GIT is
>  thousand times smaller ;-).  So here is only the relevant bits.
>  
> +(0) Decide what to base your work on.
> +
> +The general principle is always to base your work on the oldest branch
> +that your change is relevant to.
> +
> + - A fix for a bug that has been with git from older releases should be
> +   included in both the upcoming feature release and the current
> +   maintenance release.  Try to base your work on the 'maint' branch.  A
> +   work to kill a bug that is in 'master' but not in 'maint' should be
> +   based on 'master'.
> +
> + - A fix for a bug that is not yet in 'master' is the best bug to kill.
> +   If you can find the topic that introduces the regression, base your
> +   work on the tip of the topic.  "log --first-parent master..pu" would be
> +   a good way to find the tips of topic branches.
> +
> + - A new feature should be based on the 'master' branch in general.
> +
> + - If your new feature depends on some other topics that are not in
> +   'master' yet, and if it relies only on one topic, base your work on the
> +   tip of that topic.  If it depends on too many topics that are not in
> +   'master', you can privately start working on 'next' or even 'pu' and
> +   send out your patches for discussion, but it is possible that your
> +   maintainer may ask you to wait and rebase your changes on 'master'
> +   after some of the larger topics your topic depends on graduate to
> +   'master'.
> +
> + - Base corrections and enhancements on a topic that are not in 'master'
> +   yet but already merged to 'next' on the tip of the topic.  If the topic
> +   has not been merged to 'next', it is Ok to add a note that the patch is
> +   a trivial fix and can be squashed into the series.
>  
>  (1) Make separate commits for logically separate changes.
>  
> @@ -170,17 +201,16 @@ patch, format it as "multipart/signed", not a text/plain message
>  that starts with '-----BEGIN PGP SIGNED MESSAGE-----'.  That is
>  not a text/plain, it's something else.
>  
> -Note that your maintainer does not necessarily read everything
> -on the git mailing list.  If your patch is for discussion first,
> -send it "To:" the mailing list, and optionally "cc:" him.  If it
> -is trivially correct or after the list reached a consensus, send
> -it "To:" the maintainer and optionally "cc:" the list for
> -inclusion.
> -
> -Also note that your maintainer does not actively involve himself in
> -maintaining what are in contrib/ hierarchy.  When you send fixes and
> -enhancements to them, do not forget to "cc: " the person who primarily
> -worked on that hierarchy in contrib/.
> +Unless your patch is a very trivial and an obviously correct one,
> +first send it with "To:" set to the mailing list, with "cc:" listing
> +people who are involved in the area you are touching (the output from
> +"git blame $path" and "git shortlog --no-merges $path" would help to
> +identify them), to solicit comments and reviews.  After the list
> +reached a consensus that it is a good idea to apply the patch, re-send
> +it with "To:" set to the maintainer and optionally "cc:" the list for
> +inclusion.  Do not forget to add trailers such as "Acked-by:",
> +"Reviewed-by:" and "Tested-by:" after your "Signed-off-by:" line as
> +necessary.

I'm wondering how necessary that flipping of to and cc is. It means one
has to switch one's send-email config between RFCs and actual patches.
It also means I should send fewer patches to you (Junio) directly (in
addition to cc'ing the list), which is probably the intention :)
OK, I've learned about aliasesfile (and wondered about the different
wording compared to aliasfiletype) meanwhile, so no problem...

>  
>  
>  (4) Sign your work
