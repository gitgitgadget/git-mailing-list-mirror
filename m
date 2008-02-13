From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] add--interactive: handle initial commit better
Date: Wed, 13 Feb 2008 05:11:10 -0800 (PST)
Message-ID: <m3fxvxc87u.fsf@localhost.localdomain>
References: <C50196C5-B0C5-4536-AD4A-0F9C553782EE@gmail.com>
	<20080213101649.GA18444@coredump.intra.peff.net>
	<20080213105051.GA26522@coredump.intra.peff.net>
	<20080213112504.GA26627@coredump.intra.peff.net>
	<alpine.LSU.1.00.0802131213270.30505@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, "Rhodes, Kate" <masukomi@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 13 14:12:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPHOx-0000wV-Gy
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 14:11:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753792AbYBMNLQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2008 08:11:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754889AbYBMNLQ
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 08:11:16 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:14080 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753755AbYBMNLP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 08:11:15 -0500
Received: by ug-out-1314.google.com with SMTP id z38so736160ugc.16
        for <git@vger.kernel.org>; Wed, 13 Feb 2008 05:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=VOoz4mREWhBs/VrOShOjzLWhm7yI6y8tQwC5oHcbpKI=;
        b=Ah4hJ1PSIljasxRcV4S9ntBH2sH2Bz6aqPESw8/27kFiHKs1QK3CVwkWEoaDzYWvX1W/6IqXUG8g+AbapnMDOpB4D8wTtz2C/l67vg8rWolFtyqoOb/hS17FJ8ayzwDlUI8c/GzL6RZzPBk1CQF5+FQN8jqLnx8zexKfGmmE6vU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=j18g9yBnvN4FoIU5D3IrzIQHv/BxAgrf97hTqYyE2ExJaHVUQNuDOEWZsT2uQxXxkXjMchWY1PkrhJ0FdqsWFiVm3ndWHKukwUMDitblGTAgFlmT4pZlK4rvquNU9NR7G38P20g1lYLIMW29LzT0W3n2XeZksV3eL1KS5AlVbss=
Received: by 10.150.195.21 with SMTP id s21mr959050ybf.114.1202908271751;
        Wed, 13 Feb 2008 05:11:11 -0800 (PST)
Received: from localhost.localdomain ( [83.8.196.88])
        by mx.google.com with ESMTPS id d25sm3069055nfh.33.2008.02.13.05.11.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 13 Feb 2008 05:11:10 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m1DDB5Rn004124;
	Wed, 13 Feb 2008 14:11:06 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m1DDB2CN004121;
	Wed, 13 Feb 2008 14:11:02 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <alpine.LSU.1.00.0802131213270.30505@racer.site>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73785>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Wed, 13 Feb 2008, Jeff King wrote:
> >  	}
> > +	if (!hashcmp(sha1, empty_tree.sha1))
> > +		return &empty_tree;
> >  	return NULL;
> >  }
> 
> Heh.  This is cute.  But it is also a bit hard to reference, no?  I mean, 
> you have to remember the SHA-1 of it...
> 
> Maybe {} ?

Or NULL? You can do this even without modifying git code, I think, by
adding refs/NULL with appropriate sha-1...

^{tree} I think resolves to HEAD^{tree}

-- 
Jakub Narebski
Poland
ShadeHawk on #git
