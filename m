X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Colourise git-branch output
Date: Mon, 11 Dec 2006 17:11:24 -0800
Message-ID: <7v7iwx2a0z.fsf@assigned-by-dhcp.cox.net>
References: <200612112210.08327.andyparkins@gmail.com>
	<BAYC1-PASMTP114CF00792AB16B95C1597AED70@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 12 Dec 2006 01:11:36 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <BAYC1-PASMTP114CF00792AB16B95C1597AED70@CEZ.ICE>
	(seanlkml@sympatico.ca's message of "Mon, 11 Dec 2006 19:38:57 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34051>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtwB9-0005NP-Ax for gcvg-git@gmane.org; Tue, 12 Dec
 2006 02:11:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1750808AbWLLBL2 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 11 Dec 2006
 20:11:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750804AbWLLBL1
 (ORCPT <rfc822;git-outgoing>); Mon, 11 Dec 2006 20:11:27 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:61766 "EHLO
 fed1rmmtao03.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1750808AbWLLBL0 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 11 Dec 2006
 20:11:26 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao03.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061212011126.UHOH29122.fed1rmmtao03.cox.net@fed1rmimpo02.cox.net>; Mon, 11
 Dec 2006 20:11:26 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id xdBc1V00k1kojtg0000000; Mon, 11 Dec 2006
 20:11:37 -0500
To: Sean <seanlkml@sympatico.ca>
Sender: git-owner@vger.kernel.org

Sean <seanlkml@sympatico.ca> writes:

> On Mon, 11 Dec 2006 22:10:08 +0000
> Andy Parkins <andyparkins@gmail.com> wrote:
>
>> +int git_branch_config(const char *var, const char *value)
>> +{
>> +	if (!strcmp(var, "branch.color")) {
>> +		branch_use_color = git_config_colorbool(var, value);
>> +		return 0;
>> +	}
>> +	return git_default_config(var, value);
>> +}
>
> As Junio already highlighted, the "branch.*" namespace is for actual
> branch names.  This config option should go into "color.branch" or some
> other spot.

I didn't.  And "branch.color = auto" is actually fine.

The problematic case is "branch.color.remote = purple".


