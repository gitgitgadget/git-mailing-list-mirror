From: "Marc Fargas" <telenieko@telenieko.com>
Subject: git-svn: Having a "rare" structure
Date: Wed, 5 Nov 2008 11:04:14 +0100
Message-ID: <2686a05b0811050204v59edc4a3h7f9ce6c6ecd13058@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 05 11:06:06 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxfGW-0005qC-02
	for gcvg-git-2@gmane.org; Wed, 05 Nov 2008 11:05:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754230AbYKEKES (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Nov 2008 05:04:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754210AbYKEKES
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Nov 2008 05:04:18 -0500
Received: from yx-out-2324.google.com ([74.125.44.28]:1257 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754168AbYKEKER (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Nov 2008 05:04:17 -0500
Received: by yx-out-2324.google.com with SMTP id 8so1358910yxm.1
        for <git@vger.kernel.org>; Wed, 05 Nov 2008 02:04:16 -0800 (PST)
Received: by 10.100.93.19 with SMTP id q19mr376697anb.156.1225879455001;
        Wed, 05 Nov 2008 02:04:15 -0800 (PST)
Received: by 10.100.7.20 with HTTP; Wed, 5 Nov 2008 02:04:14 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100153>

Hi all,

First of all, please CC responses to me as I'm not subscribed to this list ;)

On the subject, I use git-svn to for most of my stuff and also to
"interact" with some SVN projects out there, there's one that is
driving me mad.

The Django project has a (somehow) rare SVN structure that I almost
managet to make git-svn understand, but a recent "rarity" to the
structure broke it again and I haven't succeeded in making git-svn
understand it, so I'm trying to get some guidance on how to make
git-svn understand the structure.

Right know the Django SVN repo is like that:
browse: http://code.djangoproject.com/browser/django
svn url:  http://code.djangoproject.com/svn/django

trunk/
tags/notable_moments/
tags/releases/
branches/*
branches/features/
branches/releases/

Until now, the last two didn't exist and git-svn was working nicely,
but now "features" and "releases" were created, and git-svn is taking
them as if they were branches, while they arent (branches are in
subdirectories of those two).

My git repo was done like that until now:

    git svn init --prefix svn/
http://code.djangoproject.com/svn/django -T trunk -b branches -t
'tags/*/*'
    git svn fetch

With that, git-svn understood that tags were in the subdirectories of
tags/{notable_moments,releases}/ but I can't do that with the branches
as there are branches also in the top branches/ directory.

I do not really care about those branches on the top directory as
those are old, so I really only need git-svn to understand the
{features,releases}/* thing. So:

How can I do something like "-b branches/{features,releases}/*" making
git-svn ignore the other top-level branches? Or, can I make it
understand both, the top-level ones and the ones inside those two
subdirectories?

Note that I just gueesed the "-b branches/{features,releases}/*"
thing; I didn't try it, tryiing takes lots of time and bandwidth ;\\

Thanks for all,
Marc
-- 
http://www.marcfargas.com - will be finished someday.
