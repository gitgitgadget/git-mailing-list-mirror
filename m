From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: cherry-pick applies some other changes than the specified one?
Date: Mon, 21 Mar 2011 14:58:46 -0500
Message-ID: <20110321195846.GA4277@elie>
References: <AANLkTikE5AqJyShN+GfFYe0kBS=ShGnKQcnwbarNZrjm@mail.gmail.com>
 <7vwrjssbfk.fsf@alter.siamese.dyndns.org>
 <4D877FAD.9000807@viscovery.net>
 <4D879516.3060204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 20:59:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1lFk-00053g-NO
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 20:59:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754337Ab1CUT64 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 15:58:56 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:44307 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754313Ab1CUT6z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 15:58:55 -0400
Received: by yxs7 with SMTP id 7so2585712yxs.19
        for <git@vger.kernel.org>; Mon, 21 Mar 2011 12:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=koofN056iRwiiJ2sZaMjHmOkOYzbQ4o9R2gpseFME1c=;
        b=lYnNGa71kKNxnMJW2ZGE1nWnrF4bMStM2F3Ii9pmSCrufVfKv9PonZHBK+twoWO4bN
         gEkQEAkeRhw1fbumEcE1BAUs8rJijBeh23j1Ik91i0K0NTKjnYXBd7QCjPgUOwCPAy57
         tJA2CbkGf4KlBRA0Y2+5ELUW9PKQu79HKTnnw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=OY0JlQqj9FksfuqXvqBTUpD1ki9l8PPhKCV4YV7rVjsP6KmKm/72bb1jUy08kEPs1U
         7BQ43hK8H3w4NnFNiD3equvDd+rPWTIEJgmvfzBCfAhX/mw7nsTJOr0Lv8hqYU1nagPo
         Rdw46nLOs6dEQQgftkIp2SwljXanCi7WkhCI4=
Received: by 10.236.79.193 with SMTP id i41mr5925110yhe.204.1300737533787;
        Mon, 21 Mar 2011 12:58:53 -0700 (PDT)
Received: from elie (adsl-69-209-56-53.dsl.chcgil.ameritech.net [69.209.56.53])
        by mx.google.com with ESMTPS id x53sm3159629yhc.34.2011.03.21.12.58.51
        (version=SSLv3 cipher=OTHER);
        Mon, 21 Mar 2011 12:58:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4D879516.3060204@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169656>

Piotr Krukowiecki wrote:

> I think I even suspected this might have something to do with the merge
> conflict and tried to make git-diff show me exact change between working
> tree and index/HEAD (ignoring the merge), so I can verify the file indeed
> only have the change I did, but I could not find such option.
> Does it exists? 

Sure.  The index contains multiple competing versions, which you can
see with "git ls-files -u".  To compare the working tree and one of
those use "git diff --base / --ours / --theirs" (or -1 / -2 / -3).

To view changes relative to a particular commit, use "git diff <commit>".
For example, "git diff HEAD".  The git-diff(1) manpage (shown by
"git diff --help") explains.

Hope that helps,
Jonathan
