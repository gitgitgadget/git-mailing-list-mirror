From: Bryan Donlan <bdonlan@gmail.com>
Subject: Re: [git-svn] [FEATURE-REQ] track merges from git
Date: Wed, 26 Aug 2009 15:06:14 -0400
Message-ID: <3e8340490908261206xc4156c4mb46e4c7de264df11@mail.gmail.com>
References: <4A9565ED.4010608@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ximin Luo <xl269@cam.ac.uk>
X-From: git-owner@vger.kernel.org Wed Aug 26 21:06:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgNpZ-0004Jl-3g
	for gcvg-git-2@lo.gmane.org; Wed, 26 Aug 2009 21:06:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752907AbZHZTGf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2009 15:06:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752837AbZHZTGf
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Aug 2009 15:06:35 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:59160 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752784AbZHZTGe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2009 15:06:34 -0400
Received: by ewy2 with SMTP id 2so479621ewy.17
        for <git@vger.kernel.org>; Wed, 26 Aug 2009 12:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=C+F5G+5QZIjndqTU441E74d4JrhX/GBJMNUyJ0fNcIM=;
        b=isjoGhZA3iafpx35T1nTYEQSO7/1y0XELkiPqnaf88TsX+6cayxedIXTLv43/Cma4F
         OWlt4Tee09Qxx7j4n2ypM6iz7gpUWSAVaQF55VkUT1OxRX1cJOzhVJ34Dt1f2DUlVWXg
         gsWYMu3+KtdKndB28gFTLUr47pj9pgj82KrwY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=vdw2akhg2GmRk++cgNLX9ac7mSDy3HftsnNI6kH7YBPMCJo2CO8Ikz99JYj9sQ5vM0
         Qq2Vcz/KJ7i17DZR9PECpBEMkEib9sKzK5qSb9KZ65vceJy0hs2QzGWS9Kj0re7vFcy2
         NgUo5xoaOzMO/UJvCT5Rxcjk6t/h7psneCWTA=
Received: by 10.216.90.203 with SMTP id e53mr493691wef.86.1251313594099; Wed, 
	26 Aug 2009 12:06:34 -0700 (PDT)
In-Reply-To: <4A9565ED.4010608@cam.ac.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127114>

On Wed, Aug 26, 2009 at 12:42 PM, Ximin Luo<xl269@cam.ac.uk> wrote:
> Hi,
>
> I'm have 2 separate svn projects from googlecode imported into a single git
> repo. One is a semi-fork of the other, so I thought I'd be able to use git's
> merge feature to repeatedly merge from the mother project (and possibly vice
> versa too).
>
> However, this doesn't happen. I "git pull" and this works fine, but when I "git
> svn dcommit" back into svn, this rewrites my git history and it loses track of
> the merge (and next time I try to pull, the same conflicts appear).
>
> For now I just have a .git/info/grafts, but this doesn't get exported anywhere,
> so if other people "git svn clone" from svn, or "git clone" from my git repo,
> they don't get the merge information.
>
> It would be nice if git-svn saved the merge info somewhere instead of getting
> rid of it. #git tells me this is impossible at the moment, hence the mail.
> Relevant parts of the convo are pasted below.
>
> I understand if this is a low priority, but I don't think it would be a major
> PITA to implement (some suggestions are listed in the convo log). And it'd be
> useful for people converting from svn to git.
>
> Thanks for your time.
>
> X
>
> P.S. please don't troll me.

For the particular use case you have, I suspect svk would be a better
tool for merging between those two projects...
git-svn is rather specifically designed to only deal with a single
upstream repository, you see, and it isn't very easy to change this to
accept multiple repos.
