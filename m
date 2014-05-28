From: worley@alum.mit.edu (Dale R. Worley)
Subject: Re: Git chokes on large file
Date: Wed, 28 May 2014 14:18:31 -0400
Message-ID: <201405281818.s4SIIV5n026003@hobgoblin.ariadne.com>
References: <201405271647.s4RGlDJc024596@hobgoblin.ariadne.com>
	<CACsJy8BM1f1pJPzGPf--a-kUim6wyX+Mr1AfMupY3mpREY+8DA@mail.gmail.com> <xmqqbnuhesm5.fsf@gitster.dls.corp.google.com>
Cc: pclouds@gmail.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 28 20:18:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpiQw-0007mU-Hx
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 20:18:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751487AbaE1SSe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2014 14:18:34 -0400
Received: from qmta05.westchester.pa.mail.comcast.net ([76.96.62.48]:33508
	"EHLO qmta05.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751020AbaE1SSd (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 May 2014 14:18:33 -0400
Received: from omta03.westchester.pa.mail.comcast.net ([76.96.62.27])
	by qmta05.westchester.pa.mail.comcast.net with comcast
	id 7W8z1o0050bG4ec55WJYGq; Wed, 28 May 2014 18:18:32 +0000
Received: from hobgoblin.ariadne.com ([24.34.72.61])
	by omta03.westchester.pa.mail.comcast.net with comcast
	id 7WJY1o00V1KKtkw3PWJYr2; Wed, 28 May 2014 18:18:32 +0000
Received: from hobgoblin.ariadne.com (hobgoblin.ariadne.com [127.0.0.1])
	by hobgoblin.ariadne.com (8.14.7/8.14.7) with ESMTP id s4SIIW2j026004;
	Wed, 28 May 2014 14:18:32 -0400
Received: (from worley@localhost)
	by hobgoblin.ariadne.com (8.14.7/8.14.7/Submit) id s4SIIV5n026003;
	Wed, 28 May 2014 14:18:31 -0400
In-reply-to: <xmqqbnuhesm5.fsf@gitster.dls.corp.google.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1401301112;
	bh=AxTR2frbO/jKGdUNdmBQmXutY9aRCyJYgTcQ57RAldI=;
	h=Received:Received:Received:Received:Date:Message-Id:From:To:
	 Subject;
	b=X2q/nf2G1jujHD12zYmCIkrs0qKdP7R8dpbobrIV+/6x8eQJKMR5xlGkA0BRM/tPX
	 dzpeCrinKaj5kHafIClAHaE3lJDovys2apYqjHtIZB/M80m3aUX68bn18eRszaC1Cx
	 tfpUq0EEzm5yxlm12xbpGR1ZTtulIBLCwzmZe0t/59PD7zHdxGig089rlh24kDr6dJ
	 Ddwnci1zOdYDSki+R2bBa6ZnBZPOGzdwdJfmF7pe1eahvbjSLWXK7yzLboeP6mUqTR
	 Qe6MjvcYb7KXdtL4Up5RoCtAavzFt07N+N4GASNEzeOGH8ByTWF8nAe4dbpj/oR5Ol
	 jzCmBS8ur+zyw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250306>

> From: Junio C Hamano <gitster@pobox.com>

> You need to have enough memory (virtual is fine if you have enough
> time) to do fsck.  Some part of index-pack could be refactored into
> a common helper function that could be called from fsck, but I think
> it would be a lot of work.

How much memory is "enough"?  And how is it that fsck is coded so that
the available RAM is a limit on which repositories can be checked?
Did someone forget that RAM may be considerably smaller than the
amount of data a program may have to deal with?

Dale
