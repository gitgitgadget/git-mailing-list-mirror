From: "Jacob Helwig" <jacob.helwig@gmail.com>
Subject: Re: git svn rebase totally confused; just need some sorta reset
Date: Mon, 29 Dec 2008 14:04:04 -0800
Message-ID: <8c9a060812291404m304e1920yd5ba7e40a6098b30@mail.gmail.com>
References: <cd7145c4-a4bb-4ef6-95db-7c4058b6774c@m16g2000vbp.googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: davetron5000 <davetron5000@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 29 23:06:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHQEq-0008AD-GL
	for gcvg-git-2@gmane.org; Mon, 29 Dec 2008 23:05:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753244AbYL2WEK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2008 17:04:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753126AbYL2WEJ
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Dec 2008 17:04:09 -0500
Received: from qw-out-2122.google.com ([74.125.92.25]:35578 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752861AbYL2WEI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2008 17:04:08 -0500
Received: by qw-out-2122.google.com with SMTP id 3so3872015qwe.37
        for <git@vger.kernel.org>; Mon, 29 Dec 2008 14:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=w0+ipgjMQ2BpXmDmpwOWlO+r6dS5pKKi0lH635mz8Ls=;
        b=VTs/0mzVgy/jaLKS6Rae9B+1+D5Q1oeyl+VcRgKyuCLS9li0iJ5S4XyIdEzoHCz8gs
         DqTfNv8dDhFD/KFwhmjyP8W5FtmQSiup/dAnoHIDSJSuYCE/4MXlANfi7RMZZmmBanD8
         gf5+WruIawzgRuj+ccJYunLb0QghzMQthU/ak=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=MiUVA4t0TcnEAx9OVCT6/cX4PiNBqD/di2Xyvih1ld3g9P5ryOTJK7qfD5Yj6fcG8S
         Dh42jTDd6UC3A1Fsb9C3ZEu+sc9dNJPujONVRmqT2MyyOb8kr6TlBv+nUHt0bDLD57A3
         tK216/2nTv3z3L+IOuL9k55E4DkcjsRt6O+yA=
Received: by 10.215.41.2 with SMTP id t2mr11744141qaj.371.1230588244252;
        Mon, 29 Dec 2008 14:04:04 -0800 (PST)
Received: by 10.214.216.7 with HTTP; Mon, 29 Dec 2008 14:04:04 -0800 (PST)
In-Reply-To: <cd7145c4-a4bb-4ef6-95db-7c4058b6774c@m16g2000vbp.googlegroups.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104132>

On Mon, Dec 29, 2008 at 13:39, davetron5000 <davetron5000@gmail.com> wrote:
> So, my repo is in a weird state.  I have committed my changes to svn
> via git svn dcommit, and it appears that the svn repository has all my
> changes.
>
> However, git svn rebase fails with conflicts, on almost every single
> commit I've made.  I think that ultimately, I merged a branch in
> numerous times and git seems confused.  BUT, I don't really care about
> preserving that; I just want my master branch to be clean.
>
> Is there a way I can basically say:  commit XXX is the same as the
> current HEAD of SVN, so treat things as if that's the case.  i.e.
> treat things the same as if I had just done a clean git svn clone.
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

git checkout local-branch-you-want-to-fix
git reset --hard name-of-your-git-svn-branch  (probably trunk, or
<prefix>/trunk, if you setup git-svn with the --prefix=<prefix>/
option).

This will wipe out anything you have in local-branch-you-want-to-fix,
and reset it to the same state that name-of-your-git-svn-branch is in.

-Jacob
