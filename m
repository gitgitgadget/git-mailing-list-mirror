From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: Behavior of 'git add \*.txt': bug or feature?
Date: Thu, 17 Sep 2009 16:25:26 +0200
Message-ID: <20090917142526.GA28878@localhost>
References: <vpqljke7jv8.fsf@bauges.imag.fr> <7vbplazl7s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 17 16:25:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MoHvb-00061W-ST
	for gcvg-git-2@lo.gmane.org; Thu, 17 Sep 2009 16:25:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751923AbZIQOZd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2009 10:25:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751595AbZIQOZd
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Sep 2009 10:25:33 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:41651 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751255AbZIQOZc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2009 10:25:32 -0400
Received: by fxm17 with SMTP id 17so62864fxm.37
        for <git@vger.kernel.org>; Thu, 17 Sep 2009 07:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:bcc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=ed7UNA5k/ylSDimpKSiUJWY5ZE4umjDxfu6GU+l2Pq0=;
        b=VnbSrWy3ZSnj0Uja8saVN+n2NdafG2gJR6GOfmNYCH8YbbVvkCmVoS3VPZY2PMeeKb
         33sludT1foyyQRi69mDVXVH41u9agCi1BRwH6FKP5du+tFHp9aeiykDzoI3cO0K753I7
         wV+h07dO6ygJUQeutjaNrwQMdZ2FRY813Ylnc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=t6m1568dABFfg60fiyX4qMYzGe0XaCyVMCOYehvYePBaNoyYM8Hi5SKtBgifesZ/S1
         3vRE3Mnj9KN+o1EiKBaDd8/CdiYcPt2069y1heaC07yPUCbaG6oMZPNq2FHdKUSeUkcO
         QxaAk6f7XjXsmGkXVWUCYLh9QPqtIE9PKIsOA=
Received: by 10.86.211.38 with SMTP id j38mr646700fgg.26.1253197535111;
        Thu, 17 Sep 2009 07:25:35 -0700 (PDT)
Received: from darc.lan (p549A4B63.dip.t-dialin.net [84.154.75.99])
        by mx.google.com with ESMTPS id l12sm1517490fgb.17.2009.09.17.07.25.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 17 Sep 2009 07:25:33 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1MoHvK-0007Zw-Qv; Thu, 17 Sep 2009 16:25:26 +0200
Content-Disposition: inline
In-Reply-To: <7vbplazl7s.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128759>

On Wed, Sep 16, 2009 at 01:30:15PM -0700, Junio C Hamano wrote:

> I strongly suspect that it comes from the fact that we have two
> definitions and three implementations of pathspec-aware tree traversal.
> One family is unaware of shell-glob wildcards (they only do leading
> directory path match) while the other know both leading directory path and
> shell-glob.

We had a discussion about this in January:

	Subject: Re: [PATCH 3/3] implement pattern matching in ce_path_match
	Message-ID: <7vljtd20m6.fsf@gitster.siamese.dyndns.org>
	http://article.gmane.org/gmane.comp.version-control.git/105679

I was going to fix it, but motivation left me after the above discussion,
since I don't really care about this feature.

Clemens
