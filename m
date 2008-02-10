From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH] RFC: git lazy clone proof-of-concept
Date: Sun, 10 Feb 2008 08:23:33 +0100
Message-ID: <e5bfff550802092323u3ec3c9c8uf6e92399395efd27@mail.gmail.com>
References: <200802081828.43849.kendy@suse.cz>
	 <alpine.LFD.1.00.0802081250240.2732@xanadu.home>
	 <200802091525.36284.kendy@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Nicolas Pitre" <nico@cam.org>, git@vger.kernel.org,
	gitster@pobox.com
To: "Jan Holesovsky" <kendy@suse.cz>
X-From: git-owner@vger.kernel.org Sun Feb 10 08:25:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JO6Yc-0002ci-6a
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 08:24:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759239AbYBJHXj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 02:23:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759235AbYBJHXi
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 02:23:38 -0500
Received: from rv-out-0910.google.com ([209.85.198.190]:47600 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759218AbYBJHXe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 02:23:34 -0500
Received: by rv-out-0910.google.com with SMTP id k20so3011948rvb.1
        for <git@vger.kernel.org>; Sat, 09 Feb 2008 23:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=uo57yZVgNdhVEOfaoIwkNIJszKpO7qRUjA3DCEDaJks=;
        b=g4RE5XTOaDYP88wwbrlDwKVrgWOB9ZuDzx4MFvMpbL6Jen9/xMSJVFkzPvOMAu4a7gV/zmLbdlHB7aNtgySSIPkmsdwCo04RcY2+MKO5nY1W7YYVHCDj73GY0cB9drCaNQ5HRlfw7SQQ6K0NJBjoqo3FrenzNNXME16lDPw7quk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CrFQ2OHNBF/NzAk5VUGnAjFMr+i7luChqgB4Bxw0N9vRaO4YlqyMtwr8GFEjYEKU96garaSCfHww2Y6lCdge9XgTLxZ69SdUUmuwFXFZlf5Wh4w80UEdgit1JJY+V02yT242h6oiAMqcmIyv84vECuk8wmfqgtWC6tkiVnzwlPo=
Received: by 10.141.167.5 with SMTP id u5mr9735902rvo.220.1202628213484;
        Sat, 09 Feb 2008 23:23:33 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Sat, 9 Feb 2008 23:23:33 -0800 (PST)
In-Reply-To: <200802091525.36284.kendy@suse.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73322>

On Feb 9, 2008 3:25 PM, Jan Holesovsky <kendy@suse.cz> wrote:
> Hi Nicolas,
>
> On Friday 08 February 2008 19:03, Nicolas Pitre wrote:
>
> > > I've provided a git import of OOo with the entire history; the problem is
> > > that the pack has 2.5G, so it's not too convenient to download for casual
> > > developers that just want to try it.
> >

Sorry to enter so late in this thread. I just would like to ask if you
have evaluated a different approach for casual developers.

The approach is the one used by Linux tree.

Linux git repository is not very big and can be downloaded with easy.
On the other end Linux history spans many more years then the repo
does.

The design choice here is two have *two repositories*, one with recent
stuff and one historical, with stuff older then version 2.6.12

We have to say that this choice come by accident due to Linus
switching from bitkeeper to git around 2.6.12 but today it's a more or
less a conscious choice because there exists the git historical repo,
converted from bk, and this repo is still kept separated, also if
technically could be grafted to the main one to create a super big
Linux repo.

Advantage of this approach are:

- Lean and fast everyday repos, where actual development occurs

- Easy clone also for casual users

- Possibility to have anyway the whole history when needed

A variation on this theme could be to have always two repos, one with
recent stuff, say last 5 years of development, and one with *the
whole* history, not only with old stuff as in the historical Linux
tree, in this case it's easier for people that need digging very old
changes to do this avoiding browsing two repos as occurs now with
Linux.

Marco

P.S: Idea here is that of a kind of cache memory for git repos ;-)
