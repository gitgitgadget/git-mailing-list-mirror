From: "Marco Costalba" <mcostalba@gmail.com>
Subject: [RFC] repack vs re-clone
Date: Sun, 10 Feb 2008 09:25:49 +0100
Message-ID: <e5bfff550802100025k616ccff5ib2917d283eeb0ff0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "gi mailing list" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 10 09:26:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JO7W6-0004zf-D0
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 09:26:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756077AbYBJIZv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 03:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756041AbYBJIZv
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 03:25:51 -0500
Received: from rv-out-0910.google.com ([209.85.198.190]:59759 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755562AbYBJIZu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 03:25:50 -0500
Received: by rv-out-0910.google.com with SMTP id k20so3021650rvb.1
        for <git@vger.kernel.org>; Sun, 10 Feb 2008 00:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=PSN/6PMkEhJBGxRZST93iwhgC0fjArzvn6krUcFc7/s=;
        b=vp+KbmYDrtetdfN6GxDVr0Eqb0v2NnR9tCf9RM4kp2DEL3hd7NstqA9867vK//qtoF5em4g5WKRLjFjVFUJ8ID8wD4+zSYs8NJgDYnLyM9br27y5CE/iTZRUSkTkvD+MopKlvsw5EjvdoIelhsjXTczJtzzXhQQ2Bdslt5sy08w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=H6y8oAUzuGmMSoHiMiDUa8ExvLhDBIo/d0NRvDlEnaHKJk1fV6o6Aq/Ze/5t4A3NOmxL80zdifz4XSvgfga0aHGlfh+Cu++4Az5Icp0j34YWjySyMDpWXcnjuXgYWYPiL0n0nPt7a/ZJXvpgQ3fnAToynLOc17rKipooxtfG8Fg=
Received: by 10.141.15.19 with SMTP id s19mr9755544rvi.161.1202631949994;
        Sun, 10 Feb 2008 00:25:49 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Sun, 10 Feb 2008 00:25:49 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73325>

Sometime I found myself re-cloning entirely a repository, as example
the Linux tree, instead of repackaging my local copy.

The reason is that the published Linux repository is super compressed
and to reach the same level of compression on my local copy I would
need to give my laptop a long night running.

So it happens to be just faster to re-clone the whole thing by upstream.

Also repackaging a big repo in the optimal way is not so trivial, you
need to understand quite advanced stuff like window depth and so on
and probably the pack parameters used upstream are easily better then
what you could 'guess' trying yourself. Or simply you don't have
enough RAM as would be needed.

On the other end it would be interesting to know, before to start the
new clone, what is the real advantage of this, i.e. what is the
repository size upstream.

So I would like to ask if anyone would consider useful:

- A command like 'git info' or something like that that prints size of
local and upstream repository (among possibly other things)

- An option like 'git repack --clone' to instruct git to download and
use current upstream packs instead of trying to recreate new ones.


Marco
