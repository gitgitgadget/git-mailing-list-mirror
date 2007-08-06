From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: Some ideas for StGIT
Date: Mon, 6 Aug 2007 10:49:21 +0100
Message-ID: <b0943d9e0708060249h4a3f59bobfac8f9014aca82f@mail.gmail.com>
References: <1186163410.26110.55.camel@dv>
	 <20070803232351.GC30277@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Pavel Roskin" <proski@gnu.org>, git@vger.kernel.org
To: "Yann Dirson" <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Mon Aug 06 11:49:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHzDL-0004cJ-VC
	for gcvg-git@gmane.org; Mon, 06 Aug 2007 11:49:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761421AbXHFJtY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Aug 2007 05:49:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760373AbXHFJtY
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 05:49:24 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:4840 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755156AbXHFJtX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2007 05:49:23 -0400
Received: by ug-out-1314.google.com with SMTP id j3so612351ugf
        for <git@vger.kernel.org>; Mon, 06 Aug 2007 02:49:22 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MkMiLtD6uBJfFjyp1f3r5UhlooiMglBHSiw6Lc3PU3EwH7EIv+R8WhDfRqO0nOgSH+Mvre2YFDtFGrNRnbbS8gsS9eGejKpBYDGw9GYuSOXTxhcAT4Uccp/LsxAc2MTYsave3WhQk5mCVXS7s0FpBjIMtnndTAM/J2TTtzuJBEw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tFYsoovdgJW0+bcQcKDSyKCpUCRuh6aeGtTxLoKpfnMz8Q5t3bVG2eHqELa6jiNy6jizUij9wlMW0qzcjNdRYom0MRaE2h3RAJSlAW+bwSP1ISgakTonUJdj7EXr8QY0q1xJ89F+SpEl/ERQZiXisFtRTDQxZbIiWWy9/rWehPU=
Received: by 10.67.26.7 with SMTP id d7mr5060679ugj.1186393761896;
        Mon, 06 Aug 2007 02:49:21 -0700 (PDT)
Received: by 10.66.255.6 with HTTP; Mon, 6 Aug 2007 02:49:21 -0700 (PDT)
In-Reply-To: <20070803232351.GC30277@nan92-1-81-57-214-146.fbx.proxad.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55132>

On 04/08/2007, Yann Dirson <ydirson@altern.org> wrote:
> On Fri, Aug 03, 2007 at 01:50:10PM -0400, Pavel Roskin wrote:
> >  I see
> > "stg new -s" is supposed to show the changes, but it's currently broken.
> > This is run in a clean StGIT repository with no patches:
> >
> > $ stg new -s foo
>
> Hm, I'm not sure what -s would be supposed to show here, since we're
> asking for the creation of a patch, which currently always starts
> empty.

The story for the 'new -s' option was that with StGIT (not possible
with Quilt), one can start modifying the local tree and only create a
patch afterwards. The newly created patch is always empty, even if
there were local changes and showing them was useful for writing the
patch description. One can use refresh for checking the changes in.
Indeed, the 'new' command can be improved to have part of the
'refresh' functionality, though I don't really like this duplication.

> Especially confusing is that if there are already applied patches, the
> diff shown is the one of the previous top patch

Are you sure it doesn't only show the local changes (which you might
want to add in a new patch)?

> - and if there is no
> applied patches, we get the exception you noticed.

That's a bug, indeed.

> I guess -s should be removed for 0.13.1.

I'll still like to keep it for the rare cases when I use the diff to
write the patch description.

> I also tried with "stg refresh -m ''" to see if it caused the same
> problem, but it appears to have another problem instead: it does not
> refresh the patch description at all.
>
> My guess is that we should not allow empty patch description (and
> maybe fill it with provided patchname).

I think we should put some default patch description.

-- 
Catalin
