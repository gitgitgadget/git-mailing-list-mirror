From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: sane, stable renames; when a commit should commit twice
Date: Sun, 23 Dec 2007 13:26:24 +1100
Message-ID: <ee77f5c20712221826r5945a6d0x8a84eae98c85b25b@mail.gmail.com>
References: <20071223020310.GA22450@freedbms.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Zenaan Harkness" <zen@freedbms.net>
X-From: git-owner@vger.kernel.org Sun Dec 23 03:26:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J6GYE-0001zh-3m
	for gcvg-git-2@gmane.org; Sun, 23 Dec 2007 03:26:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754147AbXLWC00 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Dec 2007 21:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752855AbXLWC00
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Dec 2007 21:26:26 -0500
Received: from rv-out-0910.google.com ([209.85.198.187]:53635 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752745AbXLWC0Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Dec 2007 21:26:25 -0500
Received: by rv-out-0910.google.com with SMTP id k20so985999rvb.1
        for <git@vger.kernel.org>; Sat, 22 Dec 2007 18:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ZY6QOmvg17RCRAY5a0w3SLQlLAM3U6GW7Q2t1ZYyQQU=;
        b=w87tLdgnXykdUkV/jgdx3B2U5/e1UDLUMNp1v+xFpWocVIDS3U3hN1i2HxWGBXJcSmBDIvTIemv+DZKsIkCFHjvPdMJgTuGNrdVItPTW86k0wRSorbWaaLzAdqS54Np5Fc6oPKWz+KT8DEjUF0ic5DWfly0wPx8IJu1I9Z4H64c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=f92qwreizuz/JGTszLCSVPo5fEs/51bTotdFV2sqsh/j8NoACm7zwM8NPGh5nyD6dTy0+VjpbIO85piL3J606k5SJOcB71rA+YOYynQYzQzeK63fydKrC0KzGSNHZu+X3onBLLGWDhjy7gfe3QpqiNnCGcOdUMDCD6aG2WV9tos=
Received: by 10.141.142.15 with SMTP id u15mr1663996rvn.53.1198376784533;
        Sat, 22 Dec 2007 18:26:24 -0800 (PST)
Received: by 10.141.115.4 with HTTP; Sat, 22 Dec 2007 18:26:24 -0800 (PST)
In-Reply-To: <20071223020310.GA22450@freedbms.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69161>

On Dec 23, 2007 1:03 PM, Zenaan Harkness <zen@freedbms.net> wrote:
> When should a commit, commit twice?
>
> When one or more git mv file renames/ moves are involved.
>
> In such a case the commit ought to be split into two. Perhaps move the
> files in the first commit, then make the changes needed to support the
> move in the build chain (including changes in the moved files) in the
> second commit.
>
> This keeps a clean record of the move, making the move, and the
> associated changes (as two commits) a clean cherry.
>
> Does this make sense?

Not particularly. Git commits are not (conceptually) changes or
deltas; they are snapshots of a tree of files at a particular time.
How does the tree state at your above first commit make any sense? It
is broken. Git's rename/move detection is smart enough to notice that
a rename + small-changes is close enough to a rename, so just trust
that to get it right.


Dave.
