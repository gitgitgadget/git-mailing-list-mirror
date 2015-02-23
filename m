From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: What's cooking in git.git (Feb 2015, #06; Sun, 22)
Date: Mon, 23 Feb 2015 14:53:52 +0100
Message-ID: <54EB30F0.4010404@drmicha.warpmail.net>
References: <xmqqk2z9vd38.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 23 14:54:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YPtSZ-0003nz-OE
	for gcvg-git-2@plane.gmane.org; Mon, 23 Feb 2015 14:54:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752641AbbBWNx5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2015 08:53:57 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:42037 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752592AbbBWNxz (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Feb 2015 08:53:55 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id A0973208E0
	for <git@vger.kernel.org>; Mon, 23 Feb 2015 08:53:53 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute5.internal (MEProxy); Mon, 23 Feb 2015 08:53:54 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=SaQqo1ll59EQfCLZ/boXAP
	E62I0=; b=q0/vTVcdnH84RTwPqB0IahdJY8Zkf+NhQqzD3absGCm3CCJOa3CAAm
	8JieK4d8o0/0pPd7D8rnkiKENVTEMFpYRnWdVNaAKsJB/Kgm/J6hcVYvXFoILoUe
	Wk3/Rwh0Ae9tDzX8WB3EOcLbpjOtSHaXLVe+lxKPTrdzHhzZ2zvTw=
X-Sasl-enc: pm4AhEHPCt+GDG6wVOUJ024Pc3U5XXntImqtCPsMbqR9 1424699634
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id D31B4C002A5;
	Mon, 23 Feb 2015 08:53:53 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <xmqqk2z9vd38.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264258>

Junio C Hamano venit, vidit, dixit 22.02.2015 22:41:

> [Stalled]
> 
> * nd/list-files (2015-02-09) 21 commits
>  . t3080: tests for git-list-files
>  . list-files: -M aka diff-cached
>  . list-files -F: show submodules with the new indicator '&'
>  . list-files: add -F/--classify
>  . list-files: show directories as well as files
>  . list-files: do not show duplicate cached entries
>  . list-files: sort output and remove duplicates
>  . list-files: add -t back
>  . list-files: add -1 short for --no-column
>  . list-files: add -R/--recursive short for --max-depth=-1
>  . list-files: -u does not imply showing stages
>  . list-files: make alias 'ls' default to 'list-files'
>  . list-files: a user friendly version of ls-files and more
>  . ls-files: support --max-depth
>  . ls-files: add --column
>  . ls-files: add --color to highlight file names
>  . ls-files: buffer full item in strbuf before printing
>  . ls_colors.c: highlight submodules like directories
>  . ls_colors.c: add a function to color a file name
>  . ls_colors.c: parse color.ls.* from config file
>  . ls_colors.c: add $LS_COLORS parsing code
> 
>  A new "git list-files" Porcelain command, "ls-files" with bells and
>  whistles.
> 
>  No comments?  No reviews?  No interests?

I like the result a lot (I admit - I like colors in terminals).
Since the aim is a user facing command I'm wondering whether the status
symbols really should be those from "ls-files" or rather those from
"status -s" (and diff --name-files). (Yes, that would require two chars.)

status, status -s and the like are in an ordinary user's tool box.
ls-files isn't, at least not with "-t", which we even mark as deprecated.

That makes me wonder, though, how difficult it would be to
wt_status_collect_unchanged() and to leverage the status machinery
rather than ls-files.

Michael
