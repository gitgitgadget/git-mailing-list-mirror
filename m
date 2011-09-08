From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 0/5] RFC: patterns for branch list
Date: Thu, 08 Sep 2011 11:20:14 +0200
Message-ID: <4E6888CE.8070307@drmicha.warpmail.net>
References: <4E5607E0.1050300@drmicha.warpmail.net> <cover.1314259226.git.git@drmicha.warpmail.net> <20110825175301.GC519@sigill.intra.peff.net> <4E5759B1.50705@drmicha.warpmail.net> <7vwre0dsdy.fsf@alter.siamese.dyndns.org> <20110907195319.GC13364@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Michael Schubert <mschub@elegosoft.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 08 11:20:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1amY-0002fp-Dz
	for gcvg-git-2@lo.gmane.org; Thu, 08 Sep 2011 11:20:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932524Ab1IHJUU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Sep 2011 05:20:20 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:51029 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932351Ab1IHJUS (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Sep 2011 05:20:18 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id A25642AB6E;
	Thu,  8 Sep 2011 05:20:17 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 08 Sep 2011 05:20:17 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=oRCukki4jYWV4beVrTOyH1
	sG/ko=; b=pJSRBAAcp7L2URTK9VYgj5VuNwUoIASDJHI/WX3p52dxo8jcCry/es
	fJq3YBhcsqJUV3hBDrliQMWQHWNS8FqYVSFq1mdTVQ18EIgE4f/PQfioyLOzxXC1
	BtLmlHoIeqxnmUj+I0lwon9yisgG8YXKMIXJO+4TkWymnFZI0ACAo=
X-Sasl-enc: uCynjJguHbPCNwGHWR/qa0Tzqo/dmrpQO2+ymk+y5ICC 1315473617
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id E3898A20A65;
	Thu,  8 Sep 2011 05:20:16 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0) Gecko/20110816 Thunderbird/6.0
In-Reply-To: <20110907195319.GC13364@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180956>

Jeff King venit, vidit, dixit 07.09.2011 21:53:
> On Fri, Aug 26, 2011 at 09:55:37AM -0700, Junio C Hamano wrote:
> 
>> As we use fnmatch() and not match_pathspec() for this pattern matching,
>> "git branch peff/" will not list all the topics under the peff/ hierarchy
>> (your example "git branch peff/\*" would be the way), but I would imagine
>> that we may someday want to update it to allow the leading path match
>> here. And at that point, distinction between
>>
>> 	git branch peff  ;# to create a "peff" branch
>>         git branch peff/ ;# to list "peff/" branches, as "peff/" itself is
>>         		 ;# an invalid branch name and your auto listing
>>                          ;# heuristic kicks in
>>
>> while it might be very useful for experts, becomes too subtle and would
>> confuse new people. We should instead require an explicit -l/--list, and
>> not use the auto listing heuristics (it is fine for -v to imply -l).
> 
> Sorry, I'm atrociously behind on reviewing this topic. But FWIW, I
> completely agree with this. Detecting invalid branch formats is much too
> subtle and error prone, and we are better off making a short and
> easy-to-type version of "--list".

We all agreed on that, you didn't miss anything ;)

Michael
