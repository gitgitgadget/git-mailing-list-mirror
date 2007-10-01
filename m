From: Steven Walter <stevenrwalter@gmail.com>
Subject: Re: [PATCH] Don't checkout the full tree if avoidable
Date: Mon, 1 Oct 2007 09:12:27 -0400
Message-ID: <20071001131227.GA24494@dervierte>
References: <1191000259190-git-send-email-stevenrwalter@gmail.com> <7vejgftgef.fsf@gitster.siamese.dyndns.org> <20071001110855.GB10079@muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Oct 01 15:13:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcL5M-0006CX-7s
	for gcvg-git-2@gmane.org; Mon, 01 Oct 2007 15:13:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755261AbXJANNH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2007 09:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755252AbXJANNG
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Oct 2007 09:13:06 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:5340 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754070AbXJANNE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2007 09:13:04 -0400
Received: by wa-out-1112.google.com with SMTP id v27so4549194wah
        for <git@vger.kernel.org>; Mon, 01 Oct 2007 06:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=q5xCqhBDyAjMd2dKi5g/jEz6mcbR6LXorimXTd9yQCw=;
        b=tp40hahgGw9RU3UtzNdaemqBWJWuF1bkDxg1JgLObW74ikKoRYJOT7iOzS3HYpKRbXchj85zMLMcHLWNDs4HSKouJ3EXixJTbLAb1q4j1Erm5VDGMismxihtrzrbNvSD58oYlIGAVtcXHgmszy60Dwgip7cjkqawquq7242vp+8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=qFsFpRJKgnhWLDJJ6x0Ga9j9axRbhIypqKcqdcWm3YQUz8bk1QbbdGqGOoRQQqmI4RpUzhLzFr7tHId+w8n08viyU+rN6XbTTfWQiO04BIHq72oF3Y338qtRf6XYZmt1MxnMuO08HiSGzUsyr1bq/liyDKuQbuP2011cOoE98Uk=
Received: by 10.115.60.1 with SMTP id n1mr707035wak.1191244383342;
        Mon, 01 Oct 2007 06:13:03 -0700 (PDT)
Received: from dasbrennen.isa-geek.org ( [76.177.36.23])
        by mx.google.com with ESMTPS id 36sm7472587nzk.2007.10.01.06.13.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 01 Oct 2007 06:13:01 -0700 (PDT)
Received: by dasbrennen.isa-geek.org (Postfix, from userid 1000)
	id 2EDFDD84DB6; Mon,  1 Oct 2007 09:12:27 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20071001110855.GB10079@muzzle>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59613>

On Mon, Oct 01, 2007 at 04:08:55AM -0700, Eric Wong wrote:
> Steven Walter wrote:
> > One criticism of the patch: the trees_match function probably needs to
> > be re-written.  My SVN::Perl-foo is weak.
> 
> Yep :)
> 
> Steven:
> 
> How does the following work for you?  Which version of SVN do you have,
> by the way?  I just found a bug with the way SVN::Client::diff() is
> exported for SVN 1.1.4, hence the SVN::Pool->new_default_sub usage.

swalter@sentra:~% svn --version
svn, version 1.3.2 (r19776)

This version works great; seems to have exactly the same behavior as my
patch.  Verified that it still falls back to the do_update code when
trees_match fails.
-- 
-Steven Walter <stevenrwalter@gmail.com>
"A human being should be able to change a diaper, plan an invasion,
butcher a hog, conn a ship, design a building, write a sonnet, balance
accounts, build a wall, set a bone, comfort the dying, take orders,
give orders, cooperate, act alone, solve equations, analyze a new
problem, pitch manure, program a computer, cook a tasty meal, fight
efficiently, die gallantly. Specialization is for insects."
   -Robert Heinlein
