From: "Michael J Gruber" <git@drmicha.warpmail.net>
Subject: Re: [PATCH 1/2] diff: introduce --stat-lines to limit the stat lines
Date: Sun, 01 May 2011 10:27:08 +0200
Message-ID: <1304238428.8704.1446945897@webmail.messagingengine.com>
References: <5f16db0f3730be70ff522e63fbd491dc910c34d0.1304089050.git.git@drmicha.warpmail.net>
 <7voc3pyqy4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 01 10:27:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGS0P-0004cJ-3w
	for gcvg-git-2@lo.gmane.org; Sun, 01 May 2011 10:27:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752580Ab1EAI1N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 May 2011 04:27:13 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:59673 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752343Ab1EAI1J (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 May 2011 04:27:09 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 9985520A10;
	Sun,  1 May 2011 04:27:08 -0400 (EDT)
Received: from web1.messagingengine.com ([10.202.2.211])
  by compute5.internal (MEProxy); Sun, 01 May 2011 04:27:08 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:from:to:cc:mime-version:content-transfer-encoding:content-type:references:subject:in-reply-to:date; s=smtpout; bh=XwmM3zZAlUoRHd324B2gv07jW1k=; b=SEbmak3FjUNDJkwK/7gK7K+NRvKKnM/P4NOKfRQll1ADWwiRL6JYUwE+ARec+Qh+r+XlmPo/b9B/aFgNqkzsRH0eRM713z4clH0R3FWD9qTV9JVgYKUXG+FR+cER+SlGPKMAS5qH7GM19dQ5v5v6iORsgYU960lrsNBLSTK9S3I=
Received: by web1.messagingengine.com (Postfix, from userid 99)
	id 77B4D3CEF59; Sun,  1 May 2011 04:27:08 -0400 (EDT)
X-Sasl-Enc: 5R8oPiqNY/DLNWpfQp0Dz4uBthN+VCmx3VRSRa8glMf9 1304238428
X-Mailer: MessagingEngine.com Webmail Interface
In-Reply-To: <7voc3pyqy4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172532>

On Fri, 29 Apr 2011 09:15 -0700, "Junio C Hamano" <gitster@pobox.com>
wrote:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
> > I would even consider a default of 10 (i.e. show a 20 line stat in full,
> > abbreviate larger ones) to be sensible but have refrained from such a
> > behaviour change.
> >
> > We have hardcoded defaults for width (80) and name-width (50), so having
> > one for lines should be okay also. Can I has tis wiz default? ;)
> 
> The terminal has fixed width to be apportioned but has an infinite height
> with scrolling, so that comparison is somewhat bogus.
> 
> This should be called "count", not "lines".  Anticipate a future where we
> introduce a variant of --stat (in a way similar to how --numstat is a
> variant of --stat) that displays its result with two lines per entry.
> 
> Also getting (N+1) "lines" output for specifying N feels very unnatural.
> 
It's actually 2*(N+1): The first and last N, plus the "..." line.

With "count" I would expect to see the first N lines/items. That's even
simpler to do. Do you think that makes more sense then head+tail?

Michael
