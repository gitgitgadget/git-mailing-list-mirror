From: Matt McClure <matthewlmcclure@gmail.com>
Subject: Re: Avoiding broken Gitweb links and deleted objects
Date: Wed, 22 May 2013 09:32:12 -0400
Message-ID: <CAJELnLEGr7eG9W2WvcVjWi7rT6EUhBDVdtfx6Xjp15duB0E9kw@mail.gmail.com>
References: <CAJELnLFrfY=-gOFEe0cJHuyT4UNjbTm8hXMxAmzmQHVbz4iEbg@mail.gmail.com>
	<518C8EAC.6000106@viscovery.net>
	<7vzjw349y0.fsf@alter.siamese.dyndns.org>
	<CABjHNoT+Kvm5j4W+c2KOd+0mdu8tPCFDcEAWjxp0OcUXf1t4Lg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: William Swanson <swansontec@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 22 15:32:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uf99N-0002NC-Qx
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 15:32:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753984Ab3EVNcO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 May 2013 09:32:14 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:38160 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753042Ab3EVNcN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 May 2013 09:32:13 -0400
Received: by mail-pd0-f181.google.com with SMTP id p11so1697750pdj.12
        for <git@vger.kernel.org>; Wed, 22 May 2013 06:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=mbTPLvyv+CItZyesoK4d8doSBsTzNtsLvxX2fzkfoDU=;
        b=kuTV29uwR7e/8ZBU5OjkAoXvvpDmS5mMSE2y7s1Rze310WD0ra9iRHF7Bxs9ZxvOTv
         3ZT9I5OIWJ0rXa3z0XzhqDGYFc/IeI+4saz40nyJUcnjjtMwqhu0kvyYDC0c4ge68VqH
         c/xQ+ggGBkuZlKjU/wIqFj+7bzmJwE0Y96xbrmo6j/sHRCmnmvXz2/2sd20CexM184rl
         jPbWo/rmxZq/oIMxE0RMUX0L/gIlSzclnH9D0YcWBv7LDXj0yjOhe6OM1E6Z6Hlj/vjB
         JQKCMw/TdMxW2GCpUNhyuYzKaHbecyy3HLLZyzhLuKtgMGzL71Rhg09aGRJfyQXHPwHr
         xTwg==
X-Received: by 10.68.56.231 with SMTP id d7mr7793373pbq.49.1369229532806; Wed,
 22 May 2013 06:32:12 -0700 (PDT)
Received: by 10.68.15.98 with HTTP; Wed, 22 May 2013 06:32:12 -0700 (PDT)
In-Reply-To: <CABjHNoT+Kvm5j4W+c2KOd+0mdu8tPCFDcEAWjxp0OcUXf1t4Lg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225157>

On Fri, May 10, 2013 at 3:34 AM, William Swanson <swansontec@gmail.com> wrote:
> I started working on something like this a few weeks ago, but
> eventually came to the conclusion that this information does not
> belong in the commit graph itself.
>
> A better approach, I think, would be to enhance the reflogs to the
> point where they can provide this information in a reliable manner.

Is there a way to push/pull reflogs among different repositories?

In my original scenario:

1. the commits are created on a developer machine
2. pushed to a central origin repository running Gitweb
3. the branch is rebased on the developer machine
4. the branch is push --force'd to the origin

Later, git push tells me:

    warning: There are too many unreachable loose objects; run 'git
prune' to remove them.

or I want to delete old topic branch HEADs to improve performance.

But I never want to let Git delete the underlying commit objects since
there could be Gitweb links pointing at them.

-- 
Matt McClure
http://matthewlmcclure.com
http://www.mapmyfitness.com/profile/matthewlmcclure
