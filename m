From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 08/13] revert: Separate cmdline parsing from functional
 code
Date: Tue, 21 Jun 2011 12:00:30 -0500
Message-ID: <20110621170030.GM15461@elie>
References: <1308661489-20080-1-git-send-email-artagnon@gmail.com>
 <1308661489-20080-9-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 21 19:00:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZ4Jd-0007FB-2n
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 19:00:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756795Ab1FURAg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jun 2011 13:00:36 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:40851 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753509Ab1FURAf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2011 13:00:35 -0400
Received: by iyb12 with SMTP id 12so3008561iyb.19
        for <git@vger.kernel.org>; Tue, 21 Jun 2011 10:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=E+JmUl6CDjfhVV3IS6j8DWNlEEyHrPhLMfeidqEwetY=;
        b=HNGlSs2jgTVcy/0JuUrLkNJ+OWucaZD7OxxQFVc6ACXLqOjC9XVu1yf9nEiYryTF5Q
         nu6pOSH8dPtnU8wWrTsA0q6RH9SwaV46NL8oWXADTrti603RfezrqvnKzcLR5/eeILmD
         1seuo9i7UfabspyywEIY4UIQEeoRPkPPuVP/U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=B2DoN2vm1mzv6AEmlgKfNTeOdPNMGTnXbho+zbmCCZ+34W8q5MYvFh14u4Q0qhNhf2
         qR2ez9xQ4NwH/Jmij72sZ0gSaAJ9uLBr81xDMylx8eMRT1rlO+52zq5pzVMTe9otYE3x
         T3n7c4Tf4P4BSUG7/T/6EnW4EsfgWG/I6BKPc=
Received: by 10.231.117.35 with SMTP id o35mr6341256ibq.149.1308675634920;
        Tue, 21 Jun 2011 10:00:34 -0700 (PDT)
Received: from elie (adsl-69-209-79-158.dsl.chcgil.sbcglobal.net [69.209.79.158])
        by mx.google.com with ESMTPS id q15sm3888379ibb.48.2011.06.21.10.00.33
        (version=SSLv3 cipher=OTHER);
        Tue, 21 Jun 2011 10:00:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1308661489-20080-9-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176172>

Ramkumar Ramachandra wrote:

> Currently, revert_or_cherry_pick does too many things including
> argument parsing and setting up to pick the commits; this doesn't make
> a good API.  Simplify and rename the function to pick_commits, so that
> it just has the responsibility of setting up the revision walker and
> calling do_pick_commit in a loop.  Transfer the remaining work to its
> callers cmd_cherry_pick and cmd_revert.

Makes sense to me. :)

> Later in the series,
> pick_commits will serve as the starting point for continuation.

This sentence is a little cryptic.  The naive reader wonders
"continuation of what?"
