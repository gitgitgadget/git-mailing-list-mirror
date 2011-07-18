From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 08/17] revert: Separate cmdline parsing from functional
 code
Date: Mon, 18 Jul 2011 16:03:00 -0500
Message-ID: <20110718210300.GA6941@elie.gateway.2wire.net>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
 <1310396048-24925-9-git-send-email-artagnon@gmail.com>
 <20110712182046.GD14120@elie>
 <CALkWK0mQ0M7ZjJk=dwZjuK=fp4p1+Cz4OfeWpdi+CTO1pZVH0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 18 23:03:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QiuyB-0000sO-O8
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 23:03:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929Ab1GRVDK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jul 2011 17:03:10 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:43315 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750880Ab1GRVDJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2011 17:03:09 -0400
Received: by ywe9 with SMTP id 9so1507409ywe.19
        for <git@vger.kernel.org>; Mon, 18 Jul 2011 14:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=xvu5x1MDN5XNY/liDqUlQvOJBTHpf42ose0o9grPKXE=;
        b=SAkfoQXDrazUAZBAYNAm5BW3tQJpAVernptG/UcMrGSUhufp/qJzH+z2e4KrJZlslR
         iKbgpA5L9v1e/2T/gwCNhrD40Rpqdm+xPBMNq46m5F9GlfZLO2nTGSfu1fGCyE/Zjfg5
         cDbAtGDcWtrsSgUjABQGsnDDf4ULvq9j8Ea+w=
Received: by 10.236.78.131 with SMTP id g3mr9388257yhe.153.1311022988012;
        Mon, 18 Jul 2011 14:03:08 -0700 (PDT)
Received: from elie.gateway.2wire.net (adsl-69-209-74-225.dsl.chcgil.sbcglobal.net [69.209.74.225])
        by mx.google.com with ESMTPS id e24sm172580yhk.51.2011.07.18.14.03.06
        (version=SSLv3 cipher=OTHER);
        Mon, 18 Jul 2011 14:03:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0mQ0M7ZjJk=dwZjuK=fp4p1+Cz4OfeWpdi+CTO1pZVH0Q@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177410>

Ramkumar Ramachandra wrote:

> New commit message.
>
> revert: Separate cmdline parsing from functional code
>
> Currently, revert_or_cherry_pick sets up a default git config, parses
> command-line arguments, before preparing to pick commits.  This makes
> for a bad API as the central worry of callers is to assert whether or
> not a conflict occured while cherry picking.  The current API is like:
>
> if (revert_or_cherry_pick(argc, argv, opts) < 0)
>    print "Something failed, I'm not sure what"

Nice.  That's much clearer.

[...]
> Later in the series, pick_commits will serve as the starting point for
> continuing a cherry-pick or revert.

With the addition of "also" between will and serve, it looks good to
me now.  Thank you.
