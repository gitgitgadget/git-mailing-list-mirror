From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] Added hint about using .gitignore in git status while
  printing untracked files
Date: Thu, 18 Feb 2010 12:16:48 +0100
Message-ID: <4B7D21A0.4000706@drmicha.warpmail.net>
References: <e72faaa81002180148k47881f47qdfd5d268e4b2b44@mail.gmail.com> <alpine.DEB.2.00.1002181058450.11095@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	Git List <git@vger.kernel.org>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Thu Feb 18 12:19:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ni4Pc-0001rn-0W
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 12:19:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757461Ab0BRLTK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2010 06:19:10 -0500
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:36830 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754757Ab0BRLTI (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Feb 2010 06:19:08 -0500
Received: from compute2.internal (compute2 [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 37C9FE1C2B;
	Thu, 18 Feb 2010 06:19:08 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Thu, 18 Feb 2010 06:19:08 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=IIuawNhJfezxvSbTjFaG0ZggF0s=; b=BC0y9ozhrHP07hDa0R7BwHXNMKfjo2TSLgjZ1+i50Q+9nCQ8itvse272s00vag3LC9wvTGx0kiZm6eGj7hSbX/GML7MoJkbXAaixHoXJGz9G27K18DQdYMuUbL1d+qpavCDN0YilXk9delTm0RuF79byyZqQwfMWgH0kZeIhO9A=
X-Sasl-enc: gex7D/S08bBZJaB/7UMwnmhaWlvgOc+u5Dra/Duc4WQD 1266491947
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 7439DAD39;
	Thu, 18 Feb 2010 06:19:07 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.8pre) Gecko/20100201 Lightning/1.0b2pre Shredder/3.0.2pre
In-Reply-To: <alpine.DEB.2.00.1002181058450.11095@ds9.cixit.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140317>

Peter Krefting venit, vidit, dixit 18.02.2010 10:59:
> Pavan Kumar Sunkara:
> 
>> +	color_fprintf_ln(s->fp, c, "#   (add it's path to .gitignore to
>> intentionally untrack it)");
> 
> That should be "its", not "it is".
> 

Also, an "or" may make things clearer, and "untrack" is wrong: to
untrack is to stop tracking, but this is about untracked files. So, how
about:

---
 wt-status.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 5807fc3..f17300f 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -100,6 +100,7 @@ static void
wt_status_print_untracked_header(struct wt_status *s)
 	if (!advice_status_hints)
 		return;
 	color_fprintf_ln(s->fp, c, "#   (use \"git add <file>...\" to include
in what will be committed)");
+	color_fprintf_ln(s->fp, c, "#   (or add its path to .gitignore to
ignore it permanently)");
 	color_fprintf_ln(s->fp, c, "#");
 }

--
