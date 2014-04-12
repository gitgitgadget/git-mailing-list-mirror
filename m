From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: RE: git-remote-bzr: fatal: mark :399654 not declared
Date: Sat, 12 Apr 2014 16:20:41 -0500
Message-ID: <5349ae29eb97b_285f9032ec23@nysa.notmuch>
References: <8513837.uWFUjXk7Vu@descartes>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: =?UTF-8?B?UsO8ZGlnZXIgU29uZGVyZmVsZA==?= <ruediger@c-plusplus.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 12 23:30:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZ5Vn-0004Pm-A2
	for gcvg-git-2@plane.gmane.org; Sat, 12 Apr 2014 23:30:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757166AbaDLVaq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Apr 2014 17:30:46 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]:58129 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756878AbaDLVao convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Apr 2014 17:30:44 -0400
Received: by mail-oa0-f43.google.com with SMTP id eb12so7760603oac.30
        for <git@vger.kernel.org>; Sat, 12 Apr 2014 14:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=nxfyqAGZn5F/bW+ZPjLRG1/dF/j6He/yr3XgbaHiuYA=;
        b=UU+5+1N1rgoRh9VghkM1HBZaNHvdCI5y9TTFwHCeSMSjYhg7jImKfNMsCtZMzPqSnq
         NZOQng7bLi43LC864vXyuXLoO4Uid5Il713k0SU/poRpfM2D352E13nv+N00Gw+KRxM0
         u4kfbwdAFA6NUqOz4//XBR/mTKKIzvUTgPK7IJJCMy0rg900GZL/CDJLkz/yTE5tG7PD
         tVAbUgtxb1W50U9ZB4lPwZK82UD+3GflZ6dxsenz1fwaN/ooLtqDfvUgxoWm30hemmv8
         XB18uTOky3kuj5MkoTPC/jorpUvXMc0HOV1gzTp4W0lqBq3p/HzgEs14tJ1GEQM0Tk90
         nw0g==
X-Received: by 10.182.92.196 with SMTP id co4mr3612249obb.50.1397338244171;
        Sat, 12 Apr 2014 14:30:44 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id c7sm49538558oek.12.2014.04.12.14.30.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Apr 2014 14:30:42 -0700 (PDT)
In-Reply-To: <8513837.uWFUjXk7Vu@descartes>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246193>

R=C3=BCdiger Sonderfeld wrote:
> I'm using git-remote-bzr to access the GNU Emacs Bazaar repo.  I foll=
owed the=20
> guideline described here:=20
> https://lists.gnu.org/archive/html/emacs-devel/2013-05/msg00008.html
>=20
> Pulling and pushing worked flawless for several month.  But recently =
git=20
> bzr stopped working with the following error message:

Sorry for the late reply.

So basically your repository is screwed up. I just sent patches to the =
Git's
core so it doesn't happen again.

To recover the easiest is to remove these files: .git/bzr/origin/marks-=
*, in
your repository, and then run `git fetch`. However, when you do that ba=
sically
you have to fetch everything again.

You could also try this script I wrote[1]. If you run `git marks-check =
-mbzr -v
-f origin` it will find all the issues in the mark files and fix them. =
Then run
`git fetch` again.

Cheers.

[1] https://gist.github.com/felipec/10551806

--=20
=46elipe Contreras