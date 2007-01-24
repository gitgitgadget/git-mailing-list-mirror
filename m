From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: Rebasing stgit stacks
Date: Wed, 24 Jan 2007 12:37:15 +0000
Message-ID: <b0943d9e0701240437l33a53f64tfea8267b78bff421@mail.gmail.com>
References: <b0943d9e0701161442t6b93e0d6nd88364600f2809ee@mail.gmail.com>
	 <b0943d9e0701180105t7b01cb4di43b4db1fdc314bb7@mail.gmail.com>
	 <20070118205233.GK9761@nan92-1-81-57-214-146.fbx.proxad.net>
	 <eoq439$7ml$1@sea.gmane.org> <tnxirezueui.fsf@arm.com>
	 <20070122194756.GA4083@nan92-1-81-57-214-146.fbx.proxad.net>
	 <b0943d9e0701221458r77b2b48hfa41d3dffcb848d0@mail.gmail.com>
	 <20070123074945.GB4083@nan92-1-81-57-214-146.fbx.proxad.net>
	 <b0943d9e0701231403qefb28f0h91d3f599699b9908@mail.gmail.com>
	 <20070124000551.GC4083@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
To: "Yann Dirson" <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Wed Jan 24 13:37:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9hNS-0004k4-Lq
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 13:37:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbXAXMhS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Jan 2007 07:37:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbXAXMhS
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 07:37:18 -0500
Received: from nz-out-0506.google.com ([64.233.162.234]:50239 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751082AbXAXMhQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jan 2007 07:37:16 -0500
Received: by nz-out-0506.google.com with SMTP id s1so142266nze
        for <git@vger.kernel.org>; Wed, 24 Jan 2007 04:37:15 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TDbkUVn2tbvtdq9cawv6I0A1ak0KzchdgaBplgyahwS/g+Ui+UXyDjBxPsTNdK94OOXEDFdt0Tp1RTeryAxfMKVTCYXApyrlwXkHJixEsZU+KtEsiGM43LTiYO7DZW1YeAis2wcoKPXvshmW/2g+lydoOFhmyvuJ3MPW1bGND64=
Received: by 10.65.43.17 with SMTP id v17mr1037242qbj.1169642235749;
        Wed, 24 Jan 2007 04:37:15 -0800 (PST)
Received: by 10.65.133.13 with HTTP; Wed, 24 Jan 2007 04:37:15 -0800 (PST)
In-Reply-To: <20070124000551.GC4083@nan92-1-81-57-214-146.fbx.proxad.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37633>

On 24/01/07, Yann Dirson <ydirson@altern.org> wrote:
> On Tue, Jan 23, 2007 at 10:03:26PM +0000, Catalin Marinas wrote:
> > >I'll have to think more about that - I'm not sure I get you point.  By
> > >moving/cloning we keep (or could keep) the patches' history.  By
> > >importing we cannot do that.
> >
> > The 'pick' command could be (easily) fixed to preserve the history of
> > a patch (I'll add this to the todo list). The log commit would have
> > the picked patch's log as a parent rather than none.
>
> Right - "branch --clone" could also use that (or maybe it does already
> by design).  Together with this, "pick --fold" and possibly "sync"
> (although I never used the latter so I'm not 100% sure how it works)
> could register a merge, and sometime in the future we could use this
> information to be able to do some merging.  I'm not going to look
> into this soon, but I have this popping out regularly in my head ;)

'sync' is still experimental. I usually have the same patches on
different branches (i.e. a stable kernel branch for customers and a
more up-to-date branch for pushing patches upstream). I wanted a way
to automatically synchronise the changes made to some patches found in
both branches. This command folds the remote patch onto the current
one using a three-way merge. If they are identical, the current patch
shouldn't change. If they are not identical, it leads to conflicts
that have to be manually solved.

> > As I said, I'll first like to get a 1.0 out this spring.
>
> Yes.  Maybe we should get 0.12 out of the door soon, with some more
> bugs fixed.  I'm trying to finish putting out in a decent shape stuff
> about parent branches, git-fetch use and the other related issues
> mentionned those last days.  Maybe that will be ready before enough
> bugs are squashed for 0.12, but maybe not :)

Maybe I'll manage to get a new release out in about a week or so.

-- 
Catalin
