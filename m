From: Jim Meyering <jim@meyering.net>
Subject: Re: [PATCH] * remote.c (valid_fetch_refspec): remove useless if-before-free test
Date: Wed, 20 Aug 2008 22:22:53 +0200
Message-ID: <878wursag2.fsf@rho.meyering.net>
References: <87k5ecx2pl.fsf@rho.meyering.net>
	<20080820194002.GC16626@blimp.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 20 22:24:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVuDq-0003s4-Pp
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 22:24:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756040AbYHTUW4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 16:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756003AbYHTUW4
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 16:22:56 -0400
Received: from smtp7-g19.free.fr ([212.27.42.64]:56818 "EHLO smtp7-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755953AbYHTUWz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 16:22:55 -0400
X-Greylist: delayed 111568 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Aug 2008 16:22:55 EDT
Received: from smtp7-g19.free.fr (localhost [127.0.0.1])
	by smtp7-g19.free.fr (Postfix) with ESMTP id 4D0C8B01D0
	for <git@vger.kernel.org>; Wed, 20 Aug 2008 22:22:54 +0200 (CEST)
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp7-g19.free.fr (Postfix) with ESMTP id 1D2ABB021A
	for <git@vger.kernel.org>; Wed, 20 Aug 2008 22:22:54 +0200 (CEST)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id E684A653FB; Wed, 20 Aug 2008 22:22:53 +0200 (CEST)
In-Reply-To: <20080820194002.GC16626@blimp.local> (Alex Riesen's message of
	"Wed, 20 Aug 2008 21:40:02 +0200")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93034>

Alex Riesen <raa.lkml@gmail.com> wrote:
> Jim Meyering, Tue, Aug 19, 2008 20:46:30 +0200:
>> We removed a handful of these useless if-before-free tests
>> several months ago.  This change removes a new one that snuck back in.
>
> Something used to crash in free when passed NULL. It's one of the
> reasons why some cross-platform projects have xfree which does the
> check (sometimes depending on platform). Admittedly, it is a long time
> since I saw such a platform (some old SunOS it was, I believe).

Right.  This was discussed at length back in February:

  http://thread.gmane.org/gmane.comp.version-control.git/74187
