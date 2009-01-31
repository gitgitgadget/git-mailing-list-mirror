From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: Newbie question regarding 3way merge order.
Date: Sat, 31 Jan 2009 09:57:24 +0900
Message-ID: <20090131095724.6117@nanako3.lavabit.com>
References: <871vulda2r.fsf@gigli.quasi.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: "Raimund Berger" <raimund.berger@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 31 01:58:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LT4CD-0000mA-Ex
	for gcvg-git-2@gmane.org; Sat, 31 Jan 2009 01:58:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754160AbZAaA52 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 19:57:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754126AbZAaA52
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 19:57:28 -0500
Received: from karen.lavabit.com ([72.249.41.33]:46123 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753797AbZAaA51 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 19:57:27 -0500
Received: from d.earth.lavabit.com (d.earth.lavabit.com [192.168.111.13])
	by karen.lavabit.com (Postfix) with ESMTP id DE42FC8406;
	Fri, 30 Jan 2009 18:57:26 -0600 (CST)
Received: from 8540.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id N0G62LNOS8RE; Fri, 30 Jan 2009 18:57:26 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=YO0QYTiXAnooZcOeCO6JuR7gAbODFArBnqLLdKKZtEsOk0XxdRH9veKFMyywFJ3rcz+77yFiOYykiGDM9sAq7Q0I1rP9CQrLDq9ar3k6kdFKOakrI7biL2d0geTxgEjmbKJIWyS+rqc8rZT2t6bjIQagj89tvuVtehcRsBElawY=;
  h=From:To:Cc:Subject:In-Reply-To:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <871vulda2r.fsf@gigli.quasi.internal>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107895>

Quoting "Raimund Berger" <raimund.berger@gmail.com>:

> The question is whether a (3way) merge is commutative, purely in terms
> of content (i.e. disregarding commit history for now). Iow if no matter
> in which order I merge A and B, i.e. A into B or B into A, I'd be
> guaranteed to arrive at the same content.

I think three-way merge of A into B and B into A will produce the same
result when the merge doesn't conflict (when it does, you will get the
conflict markers and text from A and B in a different order depending on
the direction of the merge).

> The reason I ask is obvious I guess. What basically interests me is if I
> gave a bunch of topic branches exposure on a test branch and, after
> resolving issues, applied them to stable, that I could be 100% sure to
> not introduce new issues content wise just by applying merges in a
> different order or form (rebase, patch set).

I don't think you can make a blanket conclusion like that by only knowing
that merging A into B and merging B into A would produce the same result.

If you merge topics A, B, and C in this order into your current state O,
there may not be any conflict, but if you merge the same topics to the
same current state in different order, C, B and then A for example, you
may get conflicts that breaks the merge. The commutativeness only says
that merge of A into O will produce the same result as merge of O into A.
It doesn't say anything about what would happen when you merge B to O.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
