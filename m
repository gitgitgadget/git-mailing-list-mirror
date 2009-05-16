From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH] new test fails "add -p" for adds on the top line
Date: Sat, 16 May 2009 19:25:29 +0900
Message-ID: <20090516192529.6117@nanako3.lavabit.com>
References: <1c5969370905152010m486a8b85s96334e99e6c54ad5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
To: Matt Graham <mdg149@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 16 12:26:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5H5r-0000g7-4S
	for gcvg-git-2@gmane.org; Sat, 16 May 2009 12:26:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755356AbZEPK0H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 May 2009 06:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755204AbZEPK0F
	(ORCPT <rfc822;git-outgoing>); Sat, 16 May 2009 06:26:05 -0400
Received: from karen.lavabit.com ([72.249.41.33]:44904 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753668AbZEPK0E (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 May 2009 06:26:04 -0400
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id 1C00811B7DD;
	Sat, 16 May 2009 05:26:04 -0500 (CDT)
Received: from 2205.lavabit.com (212.62.97.20)
	by lavabit.com with ESMTP id 6JWYU43BU103; Sat, 16 May 2009 05:26:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=J4uWSiKXqxAhW3LFqOLL7RuYd34BF8FmaRZKYEL+Sa9bd+XWRkNu6uZcva2eJDetBVxgHByLk2dx9yfY5kMMVUGCm96/thBgxrvL6I3UW71HS3z6yt+N0qprIhXCiRv+UxIystSyEN0bMoUCXBz1g6A5kxvGw1Eqz5iBTSpFz7U=;
  h=From:To:Cc:Subject:In-Reply-To:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <1c5969370905152010m486a8b85s96334e99e6c54ad5@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119352>

Quoting Matt Graham <mdg149@gmail.com>:

> add -p doesn't work for some diffs.  diffs adding a new line at the top of
> the file with other adds later in the file are one way to trigger the problem.
>
> during add -p, split the diff and then answer y for all segments.  the file
> won't have been added to the index.
>
> Signed-off-by: Matthew Graham <mdg149@gmail.com>

I tried "git-add -p" from different versions and I found out that versions before the commit 0beee4c6dec15292415e3d56075c16a76a22af54 doesn't have this problem.

commit 0beee4c6dec15292415e3d56075c16a76a22af54
Author: Thomas Rast <trast@student.ethz.ch>
Date:   Wed Jul 2 23:59:44 2008 +0200

    git-add--interactive: remove hunk coalescing
    
    Current git-apply has no trouble at all applying chunks that have
    overlapping context, as produced by the splitting feature. So we can
    drop the manual coalescing.
    
    Signed-off-by: Thomas Rast <trast@student.ethz.ch>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
