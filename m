From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH] Always output a trailing space conflicted merge markers.
Date: Wed, 01 Jul 2009 12:42:20 +0900
Message-ID: <20090701124220.6117@nanako3.lavabit.com>
References: <1246322461-24742-1-git-send-email-nelhage@mit.edu> <7v1vp15ppi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Nelson Elhage <nelhage@MIT.EDU>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 01 05:42:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLqih-0007cj-6e
	for gcvg-git-2@gmane.org; Wed, 01 Jul 2009 05:42:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754663AbZGADml (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2009 23:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753858AbZGADmk
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jun 2009 23:42:40 -0400
Received: from karen.lavabit.com ([72.249.41.33]:49253 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753196AbZGADmk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2009 23:42:40 -0400
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id D6AE211B7F6;
	Tue, 30 Jun 2009 22:42:43 -0500 (CDT)
Received: from 4662.lavabit.com (212.62.97.20)
	by lavabit.com with ESMTP id AD0POMWTBJBH; Tue, 30 Jun 2009 22:42:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=JSmUFRLxBb4BvzaavNL+lgl6ApQBNCDknX8dAlxm/S9rGHRIzUSCYorurLn65/GnvCiauxxssXxaus8zAVary6FnyMbvICasXvOD+NT6elVUjbhAX5DQ3xvUVtVu6NP+Q+k/znQKCKcAimrGYlFgF+JfFK5tHQdRvi4YmcfEcP4=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <7v1vp15ppi.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122564>

Quoting Junio C Hamano <gitster@pobox.com>:

> Nelson Elhage <nelhage@MIT.EDU> writes:
>
>> Some tools, such as emacs' smerge-mode, except that diff3-style merge
>> conflict markers always include a trailing space (and optional
>> description) after the marker, and so fail to correctly detect
>> git's (notably the '|||||||' base marker, for which git never outputs a
>> trailing space).
>>
>> (See http://emacsbugs.donarmstrong.com/cgi-bin/bugreport.cgi?bug=3553
>> for the emacs issue)
>>
>> Signed-off-by: Nelson Elhage <nelhage@mit.edu>
>> ---
>>  xdiff/xmerge.c |   11 ++++++++---
>>  1 files changed, 8 insertions(+), 3 deletions(-)
>
> Thanks, but I think you also need to update the test scripts.
>
> Don't you want some new tests to protect this from getting broken
> in the future by other people yourself, too?

I don't know what future breakages Nelson wants to protect his code from, but this change breaks the test for union merge in t6026-merge-attr.sh.

It isn't that the test script expects no space after the conflict marker, but with Nelson's patch, the union merge no longer works.

I request this patch to be dropped.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
