From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] Documentation fix: git log -p does not imply -c.
Date: Mon, 07 Mar 2011 16:21:54 -0800
Message-ID: <7vsjuyzckd.fsf@alter.siamese.dyndns.org>
References: <20110307191218.GA20930@sigill.intra.peff.net>
 <1299535063-1020-1-git-send-email-haircut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>
To: Adam Monsen <haircut@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 08 01:28:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwkmP-0005tq-AW
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 01:28:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756836Ab1CHA1z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Mar 2011 19:27:55 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43408 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752323Ab1CHA1x (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Mar 2011 19:27:53 -0500
X-Greylist: delayed 403 seconds by postgrey-1.27 at vger.kernel.org; Mon, 07 Mar 2011 19:27:53 EST
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6FC72459F;
	Mon,  7 Mar 2011 19:23:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=A+zPturSNugz+ONqG7GxhTM46lo=; b=n/GRET6hyHA4XfVoC9gY
	EdMoxOOXFUxIdKcRa1AiB525r9LiPubk9vaC343b/rH03Ce9t6tPyYEwT0/aFj/6
	SoAWQvlyiaPwXFu1CEyWklAv5OV1okIEElQBtt+jrjd5St4nbazbSxMceHDcgHEV
	uxG/9pDpZK/Hid87tTMa+Ew=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=omb/lIxkRJXDAuSQlP/iB20J8TXvurmmqahceWPgrjUtnr
	iGyTG3kaYgiGW5a3lsU1VG0PtA43jTS85nfnLaYgmbxh8D9IyU8js7xVzro/KCb7
	dtATXE5dxK8g0TGmrUc26i064HSwA6W+dIbJcpmI7Z6PFV0gviWmRpokCQIr0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2DD6E459D;
	Mon,  7 Mar 2011 19:23:28 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id CB6F2459C; Mon,  7 Mar 2011
 19:23:22 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4A07271A-491A-11E0-9838-B86344810875-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168624>

Adam Monsen <haircut@gmail.com> writes:

> This is really Peff's patch, I
> * fixed a typo (vie -> view)
> * am sending it as an acutal patch in case that's easier to apply than
>   a diff in an email

Thanks.  Such a patch to summarize the discussion so far is greatly
appreciated.

>  Documentation/diff-generate-patch.txt |   10 ++++++----
>  1 files changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/diff-generate-patch.txt b/Documentation/diff-generate-patch.txt
> index 3ac2bea..5d478c1 100644
> --- a/Documentation/diff-generate-patch.txt
> +++ b/Documentation/diff-generate-patch.txt
> @@ -74,10 +74,12 @@ separate lines indicate the old and the new mode.
>  combined diff format
>  --------------------
>  
> -"git-diff-tree", "git-diff-files" and "git-diff" can take '-c' or
> -'--cc' option to produce 'combined diff'.  For showing a merge commit
> -with "git log -p", this is the default format; you can force showing
> -full diff with the '-m' option.
> +Any diff-generating command can take the `-c` or `--cc` option to
> +produced a 'combined diff' when showing a merge. This is the default

s/produced/produce/, I think.

> +format when showing merge conflicts with linkgit:git-diff[1] or a merge
> +commit with linkgit:git-show[1]. Note also that you can view the full
> +diff with the `-m` option.

This "Note" is a bit unclear what command it applies to, isn't it?  I know
it applies to all the commands mentioned in the previous sentence in the
paragraph, but we are not writing the documentation for me, so perhaps 

	Note also that you can give the `-m' option to any of these
	commands to force generation of diffs with individual parents of a
	merge.

Also -c and --cc are technically _not_ about "showing merge conflicts".
It is about "showing a merge commit".  I don't know if we want to teach
the distinction in this part of the document, though.

If you resolve a conflicted merge taking the results from only one side
for a given hunk, --cc won't show anything.  If on the other hand, you
futz with a clean merge so that your result does not match with any
parent, --cc will show it.

Cf.

 http://thread.gmane.org/gmane.comp.version-control.git/89415
