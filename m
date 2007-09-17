From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH] git-merge: add option --no-ff
Date: Mon, 17 Sep 2007 16:12:56 +0200
Message-ID: <8c5c35580709170712v2f5df7b1w8fa0377b69f24988@mail.gmail.com>
References: <11900314321506-git-send-email-hjemli@gmail.com>
	 <46EE7584.8010202@op5.se>
	 <8c5c35580709170616i49a8836hb60423c5eebf601d@mail.gmail.com>
	 <Pine.LNX.4.64.0709171422340.28586@racer.site>
	 <8c5c35580709170638mc0c8279pa86d71bd79fd3084@mail.gmail.com>
	 <Pine.LNX.4.64.0709171454031.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Andreas Ericsson" <ae@op5.se>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	"Eric Wong" <normalperson@yhbt.net>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Sep 17 16:13:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXHLx-0001ZR-Sf
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 16:13:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754778AbXIQOM7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 10:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754154AbXIQOM7
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 10:12:59 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:3379 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753194AbXIQOM6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 10:12:58 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2045685wah
        for <git@vger.kernel.org>; Mon, 17 Sep 2007 07:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=VxU1iDvYT9SOz0hsMdlFQcz2mqQyygyGj4K3uO2eN94=;
        b=AN1Tl2iNKSV+sdRad4SFeCPXSxL4WumsZbzvgyRxBBasPAEytmjPGJrULNRL2bBSpXgbVZkMbNs0790tdbN11c224y/0DNNXVUAtL5EFwL5Om8p7O4Hda685050+/p1GBj9OkaOBoJbFVQOtLPicD8VqH6gNWBPKyiA8m3fdIf4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=a/eD+87icV4Borppq/7VHPodm6jzkKFJxuFpE5jOIVGG7xXjCApiyF84suLYXjNeghjd97g1gVyCG+xxFEoFMm+JE5leAAA7gj+xJ3N1RrI1dk1GLeSO9nuvems2zE2ebRwBiQH5ggN5wpRv8ogM3e4JwCIMptSARh0JZGordoY=
Received: by 10.114.190.6 with SMTP id n6mr1927613waf.1190038376512;
        Mon, 17 Sep 2007 07:12:56 -0700 (PDT)
Received: by 10.115.73.2 with HTTP; Mon, 17 Sep 2007 07:12:56 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0709171454031.28586@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58447>

On 9/17/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> But then, I do not use svn branches here, and that might be the problem?

Probably. The case I'm trying to solve is:
  -git-svn branch A is merged into git-svn branch B
  -A is a fast-forward of B

This might look unrealistic, but it happened to me today when I wanted
to merge a feature-branch into a relase-branch. The release-branch had
previously been merged into the feature-branch (to get a few
bugfixes), but the release-branch had not changed since this merge. So
when merging the feature-branch into the release-branch it just
fast-forwarded, leaving me with an 'un-dcomittable' release-branch. I
obviously could have done the merge in subversion (haha!), but doing
it in git preserves the correct history.

Btw: I have redone the merge with --no-ff, and dcommit then worked
like a charm ;-)

-- 
larsh
