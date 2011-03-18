From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH/RFD 0/2] revision.c: --merges, --no-merges and --merges-only
Date: Fri, 18 Mar 2011 10:42:17 +0100
Message-ID: <4D8328F9.9050100@drmicha.warpmail.net>
References: <cover.1300359256.git.git@drmicha.warpmail.net> <20110317195905.GG20508@sigill.intra.peff.net> <4D831043.1060709@drmicha.warpmail.net> <20110318090724.GB16703@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 18 10:45:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0WFk-0003t6-OJ
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 10:45:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932384Ab1CRJps (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2011 05:45:48 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:47408 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932336Ab1CRJpr (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Mar 2011 05:45:47 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id A0A7B208D2;
	Fri, 18 Mar 2011 05:45:46 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Fri, 18 Mar 2011 05:45:46 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=mSzQ3pN48Yt7rEJy+joecXa4kqs=; b=cei/d9oKgxV4lmRrhJzNAHkuxKOBTtCrBz5xRCauZEw0oivgDk7hlkzIRuYzWYgXee5WhL2ICm762o5qjWnRNdF8A5B32bJEzt2q1//tRwyEadMWtyEK+ZeeFnVeHF+q0GajUI3PpaJeG0jGloifkXM3FYtM283k60QnP36S8wc=
X-Sasl-enc: zS3sF02mKovxjOLSeOxZ8A2VAYDuqUilvfNu+D5Rmvy4 1300441546
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 07D36409138;
	Fri, 18 Mar 2011 05:45:45 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <20110318090724.GB16703@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169306>

Jeff King venit, vidit, dixit 18.03.2011 10:07:
> On Fri, Mar 18, 2011 at 08:56:51AM +0100, Michael J Gruber wrote:
> 
>>> However, this is totally changing the meaning of an option to plumbing
>>> like rev-list (among others). Is it worth the breakage? If so, what's
>>> the migration plan? Did I miss a discussion somewhere?
>>
>> You missed only the "D" in RFD :)
> 
> I saw it, I was just expecting you to start the "D" with some text. :)

According to my expectation, I get many more responses doing it this way :)

I'll try to be good next RFD-time, and I'll reshape my series according
to n-state.

Maybe you can help me understand this one:

int parse_opt_tertiary(const struct option *opt, const char *arg, int unset)
{
        int *target = opt->value;
        *target = unset ? 2 : 1;
        return 0;
}

This is no tri-state, is it? (It's used only for the undocumented
--autoupdate option to rerere.) I guess it's more like unset/yes/no,
which, admittedly, counts to 3, but still.

Anyway, I won't try parse_optifying revision.c

Michael
