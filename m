From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC] Should "log --cc" imply "log --cc -p"?
Date: Tue, 05 Feb 2013 09:58:27 +0100
Message-ID: <5110C9B3.10102@drmicha.warpmail.net>
References: <7vmwvl6lj9.fsf@alter.siamese.dyndns.org> <510F95D7.6010107@drmicha.warpmail.net> <7vfw1c3ujo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 05 09:58:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2eMb-0000Gg-N0
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 09:58:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755626Ab3BEI61 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2013 03:58:27 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:35891 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754380Ab3BEI60 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Feb 2013 03:58:26 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 49F2B20B46;
	Tue,  5 Feb 2013 03:58:26 -0500 (EST)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute3.internal (MEProxy); Tue, 05 Feb 2013 03:58:26 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=1BoDwZo12uNj/suwnJJIQi
	n4eQY=; b=nR4+X3AJNVSQX0gxzKLDL6ciCA+DH3qJ8cRwDjgFubwmUDsO5PvfFN
	kLNMXtiSFidmRvcqLjQTSbMLq/Co++F7W93dH2p+jjUytJ1OkdzpnZw8CORJagaN
	kwN3Rg9yJI6ixL/MYvnO8WN6mXgYrMXPz7kdbkHsbptqpXXB3eP3o=
X-Sasl-enc: 3wqORqZQg85vAdc+t8KIkFIfBT111gavbpOcS466uRvq 1360054705
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id C07EA4827E8;
	Tue,  5 Feb 2013 03:58:25 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130110 Thunderbird/17.0.2
In-Reply-To: <7vfw1c3ujo.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215470>

Junio C Hamano venit, vidit, dixit 04.02.2013 17:36:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> But diffs are on here ("-p"), it's just that the default diff option for
>> merges is to not display them. Well, I admit there's two different ways
>> of thinking here:
>>
>> A) "git log -p" turns on diffs for all commits, and the default diff
>> options is the (non-existing) "--no-show" diff-option for merges.
>>
>> B) "git log -p" applies "-p" to all commits except merge commits.
>>
>> I'm strongly in the A camp,...
> 
> I can personally be trained to think either way, but I suspect that
> we already came halfway to
> 
>   C) "-p" asks for two-way patches, and "-c/--cc" ask for n-way
>      patches (including but not limited to n==2); it is not that -p
>      asks for patch generation and others modify the finer behaviour
>      of patch generation.
> 
> "git log/diff-files -U8" do not need "-p" to enable textual patches,
> for example.  It is "I already told you that I want 8-line context.

That's a good point that I wasn't aware of.

> For what else, other than showing textual diff, do you think I told
> you that for?" and replacing "8-line context" with various other
> options that affect patch generation will give us a variety of end
> user complaints that would tell us that C) is more intuitive to
> them.
> 
> But I do not feel very strongly that I am *right* on this issue, so
> I won't do anything about it hastily right now.

I'm not sure how many of these we have already, but to me it indicates
that we should turn diffs on for log with any diff option that only
makes sense with a diff. That would make the ui more consistent without
taking anything away.

For scripting/aliasing purposes, we have "-s" in order to override any
implied "-p" (as I just learned).

Michael
