From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Fix for normalization of foreign idents
Date: Mon, 6 Sep 2010 16:07:19 -0500
Message-ID: <20100906210719.GD26371@burratino>
References: <1282599032-11369-1-git-send-email-marcus@mc.pp.se>
 <20100823213531.GD2120@burratino>
 <yf97hjhrol5.fsf@chiyo.mc.pp.se>
 <yf9vd6j5hti.fsf@mc.pp.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Marcus Comstedt <marcus@mc.pp.se>
X-From: git-owner@vger.kernel.org Mon Sep 06 23:09:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsiwS-0003C4-P2
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 23:09:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755235Ab0IFVJY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Sep 2010 17:09:24 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:42427 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751219Ab0IFVJX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 17:09:23 -0400
Received: by qwh6 with SMTP id 6so4127053qwh.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 14:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Wk9sZyR8I43xW/XCcqUNu15r1MwFyhyKalt29cCFH9w=;
        b=bxgFSYkUzMVNyTR+DhXriXEZAVEq6MGq6sliea+gMZgAVZXZvtQx7UTSm2yBWvXs9u
         u8ZlF7OMDISjyEf4Ah/QR8FxgSEt+bvZN2q2dCzcMoXo2azNguiiKMGtSAVttQxHzqAR
         Kp9Aajrv5gWoRYksky53oAbhSYrno0nWCnu5E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Ed0gV8UB4QX7y6yBCCOchi552Yt8RZJ9GVDyIafnao/d3E+XHgbuX0OPk5Utj+xEfJ
         SI3J7xT6j2pb8m0Cd/slsKad3gAddAendAVJVvJCzOO0OfhkUuV5MHrXZmB2Rr6XWyvW
         tE1huM9fSk3mEM2RFzNIoTOAwbHgM0K9+A3wY=
Received: by 10.224.29.10 with SMTP id o10mr591640qac.227.1283807362725;
        Mon, 06 Sep 2010 14:09:22 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id t24sm6084195qcs.11.2010.09.06.14.09.21
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 06 Sep 2010 14:09:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <yf9vd6j5hti.fsf@mc.pp.se>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155623>

Hi Marcus,

Marcus Comstedt wrote:

> Was this patch simply forgotten, or are there some remaining
> concerns about it?

I assume it is just that no one using the $ident$ feature took a
look at it, which leaves us without a sanity-check that it
consistently works and improves things.

If you have the time, a test and documentation might help (the former
plays the role of an artificial user, who can describe the feature and
will make noise if we break it with future changes).

> Should I submit a new patch which simply fixes the inconsistency
> which breaks checkout, and leaves the removal of foreign idents
> on commit to user interaction or hook scripts, as suggested by
> Jonathan?  That would at least restore deterministic behavior...

That doesn't sound necessary to me.
