From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 16/18] revert: Remove sequencer state when no commits are
 pending
Date: Wed, 27 Jul 2011 17:48:30 +0200
Message-ID: <20110727154830.GA29924@elie>
References: <1311736755-24205-1-git-send-email-artagnon@gmail.com>
 <1311736755-24205-17-git-send-email-artagnon@gmail.com>
 <20110727051755.GK18470@elie>
 <CALkWK0noPtLgr_t=DC_XFdLrWUNCLhUd00Mw1HbmWRJjeT4jew@mail.gmail.com>
 <20110727141006.GA24785@elie>
 <CALkWK0k8Lra7LkGJXoXScnGUjrag-xgNptaB_JCiAsgemTq0eQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 27 17:48:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qm6Lu-0001O3-JP
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jul 2011 17:48:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754508Ab1G0Psu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jul 2011 11:48:50 -0400
Received: from mail-ey0-f171.google.com ([209.85.215.171]:46054 "EHLO
	mail-ey0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753227Ab1G0Pss (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2011 11:48:48 -0400
Received: by eye22 with SMTP id 22so2043213eye.2
        for <git@vger.kernel.org>; Wed, 27 Jul 2011 08:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=e8rtMz47at0JFT/d0pTJ0riwC9InwpvKaMjJIIic3cI=;
        b=JYGvcfLKazsofRQuioDeWLc4R85sjhSGA1qDkzsXgFzZ8CQoiccoymem18jJVKYqMl
         HzUKFpmcgRKC3M2faJTpU4Effd1ib6hGuTgmBNkGdInfjyn4lgvZ2CTMtldM8MzjdPL9
         p/gbb5AlyWxZY0KG9ZpLzBecmBYzzRLarUwNg=
Received: by 10.213.106.20 with SMTP id v20mr23498ebo.51.1311781725181;
        Wed, 27 Jul 2011 08:48:45 -0700 (PDT)
Received: from elie (adsl-165-157-240.teol.net [109.165.157.240])
        by mx.google.com with ESMTPS id v20sm5567eeh.12.2011.07.27.08.48.42
        (version=SSLv3 cipher=OTHER);
        Wed, 27 Jul 2011 08:48:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0k8Lra7LkGJXoXScnGUjrag-xgNptaB_JCiAsgemTq0eQ@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177975>

Ramkumar Ramachandra wrote:

> Hm, yes.  I'd definitely like to see a tighter coupling between "git
> commit" and the sequencer as it becomes more generalized.
> Would you advocate this specific change now?  If so, I'll write an
> implementation right away.  I was wondering whether you'd like such a
> tight coupling at this stage.

If "tight coupling" means "builtin/commit.c calls a function declared
in sequencer.h", then yes, I think it should be fine.

In an ideal world it would also be exposed as plumbing ("git
cherry-pick --commited"?), for use by hypothetical porcelains that
want to use "git commit-tree" et al to simulate what git commit does.
But probably best to wait on that part until someone needs it and can
tell what a good interface would look like.

Thanks for explaining.
Jonathan
