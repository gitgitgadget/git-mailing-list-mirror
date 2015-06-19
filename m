From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Visualizing merge conflicts after the fact (using kdiff3)
Date: Fri, 19 Jun 2015 10:34:23 +0200
Message-ID: <5583D40F.7030300@drmicha.warpmail.net>
References: <557F791D.3080003@nextest.com>	<87b840d8c73fd7e4e7597e2fd835c703@www.dscho.org>	<5582B8EC.1060205@drmicha.warpmail.net> <xmqqsi9pf1q2.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Eric Raible <raible@nextest.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Fri Jun 19 10:34:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5rl5-0000ZN-Lz
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 10:34:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754416AbbFSIed (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 04:34:33 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:33560 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932348AbbFSIe0 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Jun 2015 04:34:26 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 8481120ACD
	for <git@vger.kernel.org>; Fri, 19 Jun 2015 04:34:25 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute5.internal (MEProxy); Fri, 19 Jun 2015 04:34:25 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=voqu9SKVmtkdktY9wRfHJGFExA4=; b=ntSs7W
	YCcEf346y+reEYnNaOaDlW1baDN11fsWZijUg1nYxg8HeR5UeLvDJvnurrknQ/qu
	lYq7SdXOMdl8sWZfMrYak9VxBNUbWHFNaxGM3PnaiKnHobIreVyhuRPcqqspQagY
	i8x5Qux1pN6ysJSan2/F6x+njHQ4rCpfwmxjY=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=voqu9SKVmtkdktY
	9wRfHJGFExA4=; b=Wj0uBSspmGGw7UDv0Ts1HeBPAim/8cDTTp7YdNRB+yx4OTC
	icHOeF1+QyG5nTZ6vHNPYfgycTdk1Hs7Ou9ZCtS9qqfN5moXDnZ8x72Sh4ojBx70
	LkkkkLPlw+2Mi/zbf2dRRmvnC6bLkNmLSkdtWCTAt8qyX4Bcw6W0sQfGxp88=
X-Sasl-enc: uZi+lQZm0cOPKHnbVqu3pJtMRHSHnsSINZoDthED49yD 1434702865
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id BB1556800EB;
	Fri, 19 Jun 2015 04:34:24 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <xmqqsi9pf1q2.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272108>

Junio C Hamano venit, vidit, dixit 18.06.2015 17:57:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> This type of request comes up often (for a reason). I'm wondering
>> whether we could support it more systematically, either by exposing the
>> steps above as a command, or by storing the unresolved merge somewhere
>> (leveraging stash or rerere).
> 
> Perhaps 'tr/remerge-diff' (on 'pu') is of interest?
> 

Ingenious!

To me, this seems to be the most useful view if you want to understand a
merge just from the parents and the merge commit. Since you would use
that for individual commits only, the cpu cycles are well spent.

As and added benefit, tr/remerge-diff merges to current next with
conflicts (oid...) so that you get to test it on its own merge!

I haven't reviewed remerge-diff but merged it on top of my own local
additions and ran the full test suite successfully. Any big blocker to
watch out for?

Michael
