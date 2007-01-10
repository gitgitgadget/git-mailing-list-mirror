From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH] Add contrib/stg-gitk: helper script to run gitk
Date: Wed, 10 Jan 2007 23:47:33 +0000
Message-ID: <b0943d9e0701101547v5e18bdf8xcc34cf78ea5f1f9f@mail.gmail.com>
References: <20070108220918.18329.30083.stgit@gandelf.nowhere.earth>
	 <b0943d9e0701090202v7951076cg7c86c0f5499c7d60@mail.gmail.com>
	 <20070109220332.GD17093@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "GIT list" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 11 00:47:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4nAP-00084A-4c
	for gcvg-git@gmane.org; Thu, 11 Jan 2007 00:47:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965241AbXAJXre (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 Jan 2007 18:47:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965245AbXAJXre
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jan 2007 18:47:34 -0500
Received: from nz-out-0506.google.com ([64.233.162.227]:24626 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965241AbXAJXrd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jan 2007 18:47:33 -0500
Received: by nz-out-0506.google.com with SMTP id s1so212804nze
        for <git@vger.kernel.org>; Wed, 10 Jan 2007 15:47:33 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=R4+Hn/0AUlVoiAj/K5ZCbTsjF1ozJ6Odc0x4MjfoRSrzcpb3fTGy1sHHrvELKvqXePAjwjnC69CDprp2c9AExsKOY4VIUIV/HYHdpjwzOpc8rYi5BovGbqE/eOwngDelfrMVx9K934dcqsdccwXrVaruIkNFZM4SSrakL/wVe3o=
Received: by 10.65.251.17 with SMTP id d17mr1340460qbs.1168472853181;
        Wed, 10 Jan 2007 15:47:33 -0800 (PST)
Received: by 10.65.133.13 with HTTP; Wed, 10 Jan 2007 15:47:33 -0800 (PST)
To: "Yann Dirson" <ydirson@altern.org>
In-Reply-To: <20070109220332.GD17093@nan92-1-81-57-214-146.fbx.proxad.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36540>

On 09/01/07, Yann Dirson <ydirson@altern.org> wrote:
> On Tue, Jan 09, 2007 at 10:02:06AM +0000, Catalin Marinas wrote:
> > There is 'stg series --graphical' that invokes gitk.
>
> For some reason I did not look for this functionality in that place :)
>
> But it is a bit different, in that unapplied patches appear detached
> from the whole history.  Possibly out of personal taste, I do not find
> this very useful, and prefer to see them as "gitk --all" shows them.

I've never tried 'gitk --all' but I'm OK with changing the way
--graphical option displays the patches.

> > Maybe the 'show' command could have a similar option.
>
> Hm, not sure.  "show" is about a patch, not a stack.

'show' can also display a range of patches.

> That makes me think that such command names like "show" are a bit too
> general: stgit uses "show" for patches, but nothing says it is for a
> patch and not a series.

This was initially a re-implementation of 'git show' that was able to
understand patch names (you can also give any commit id as argument).
I later extended it to accept patch ranges.

> Also, when presenting GIT/StGIT to co-workers, I found them to be
> confused by eg. "stg push" and "stg commit" having different semantics
> than "git push" and "git commit".

As I said in a different e-mail, push/pop were the command names used
by quilt. I agree that they are confusing. Maybe we could change
commit/uncommit to store/unstore or something else (but I would like
to keep push/pop).

I don't like the idea of command aliases that much, it looks like
unneeded complexity. You can use the bash aliases if you want (i.e.
'alias stg-ppush="stg push"').

-- 
Catalin
