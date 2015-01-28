From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Score in diff-format
Date: Wed, 28 Jan 2015 15:32:38 +0100
Message-ID: <54C8F306.1000001@drmicha.warpmail.net>
References: <20150128062309.GA29506@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Mike Hommey <mh@glandium.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 28 21:29:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YGZF7-0006no-Dt
	for gcvg-git-2@plane.gmane.org; Wed, 28 Jan 2015 21:29:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933201AbbA1U3g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2015 15:29:36 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:60658 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756091AbbA1U3d (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Jan 2015 15:29:33 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 445A420AC5
	for <git@vger.kernel.org>; Wed, 28 Jan 2015 09:34:22 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute6.internal (MEProxy); Wed, 28 Jan 2015 09:34:22 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=3xpqnHKZlmpQfFLVm5+Cd7
	4iBYs=; b=o9Ko6nzMx3+PIKud0QwUqmtre9p4kbG7V0+kni15kQGGAhQei8YTRQ
	ClA5qvV1gPtSQe28VFaiUBnTx++e3hJzU0pEbjN7cqGye6kuY3h54nQrKi0QOSat
	gC8ZT02C2z3RP/oZh5pkQP042nZ480jEokEc2R8/UYaaYNsKLkYrM=
X-Sasl-enc: saJGK8+maBOU2sLMS80m6rzfIfPNffS35QEySagk5Df6 1422455653
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id ED9F668012F;
	Wed, 28 Jan 2015 09:33:29 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <20150128062309.GA29506@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263109>

Mike Hommey schrieb am 28.01.2015 um 07:23:
> Hi,
> 
> diff-format.txt says this:
> 
>   An output line is formatted this way:
>   (snip)
> 
>   That is, from the left to the right:
> 
>   (snip)
>   . status, followed by optional "score" number.
> 
>   (snip)
>   Status letters C and R are always followed by a score (denoting the
>   percentage of similarity between the source and target of the move or
>   copy), and are the only ones to be so.
>
> As I read this last paragraph, the following is not supposed to happen:
> $ git diff-tree 926b1ec63ee045503f609e88ca445b94c06bd5d7 --abbrev -r -C -B
> 926b1ec63ee045503f609e88ca445b94c06bd5d7
> :100644 100644 81ac702... 7ab0cf4... M087       contrib/subtree/INSTALL
> 
> It however makes sense that it happens, and it looks like a case of the
> documentation being outdated or confusing. Or am I interpreting it wrong?

I'd say it depends on the definition of "so". The documentation is
correct if you read "so" as "*always* followed by a score". I guess you
read it as "followed by a score".

Percentages with M are not mentioned in diff-format, but they are a
consequence of "-B" processing. Maybe we could mention that?

Michael
