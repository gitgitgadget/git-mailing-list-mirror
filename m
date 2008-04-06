From: "seventh guardian" <seventhguardian@gmail.com>
Subject: Re: [bug] git-clone over ssh fails when repository has local commits
Date: Sun, 6 Apr 2008 19:06:40 +0100
Message-ID: <1caff7430804061106m49a60bc0wbbd9001394e83589@mail.gmail.com>
References: <1caff7430804060645s764f24f8y3d07ee8647ec8f25@mail.gmail.com>
	 <20080406161120.GB24358@coredump.intra.peff.net>
	 <1caff7430804060922seba4978qa13b123103b8282b@mail.gmail.com>
	 <20080406165655.GA26060@coredump.intra.peff.net>
	 <1caff7430804061011ye82e74v289dd3536b253bcb@mail.gmail.com>
	 <20080406175136.GB32399@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 06 20:07:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JiZHE-00023y-NK
	for gcvg-git-2@gmane.org; Sun, 06 Apr 2008 20:07:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751883AbYDFSGm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Apr 2008 14:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751898AbYDFSGm
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Apr 2008 14:06:42 -0400
Received: from el-out-1112.google.com ([209.85.162.181]:13130 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751623AbYDFSGl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Apr 2008 14:06:41 -0400
Received: by el-out-1112.google.com with SMTP id v27so698501ele.17
        for <git@vger.kernel.org>; Sun, 06 Apr 2008 11:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=l6uRlOxYbhNyZbR8dg7a4A7bX48nAsa1cl0o1GdB9Qg=;
        b=ublmWruvIw+iJk+zpQR6doJ/oIuUEWg9AfBskjTnLnawPrdXdxPeRgf1BAEkhG81d9wXOC38TlCz8KYOd0f/SFRLhtvFiaazSvAjpJii5AHr02r/I32DjsQTNTktNE/lFlGoXNSacRMxATEHcIWv+1xlVwQXLchiqnARaHNJvdU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=szsgJynuE/5AFyLxYy6ykU6WGji80sCyO3kgXYtpWFTtr03SyLMrHmODMvWYAUQJOQuVppNecrQb7pB/Ygt6JEqIEvRSCQWTCXNAMEMTsatATgb4IJiuujeiNSb3oOdsEObgibPRORV4uIWzxYUxVDxu/QFqfYX0Swt1BMafWPE=
Received: by 10.114.180.1 with SMTP id c1mr4931871waf.121.1207505200530;
        Sun, 06 Apr 2008 11:06:40 -0700 (PDT)
Received: by 10.114.126.18 with HTTP; Sun, 6 Apr 2008 11:06:40 -0700 (PDT)
In-Reply-To: <20080406175136.GB32399@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78904>

On Sun, Apr 6, 2008 at 6:51 PM, Jeff King <peff@peff.net> wrote:
> On Sun, Apr 06, 2008 at 06:11:12PM +0100, seventh guardian wrote:
>
>  Hmm. This _should_ just work, but something funny is going on. For some
>  reason the "local master" is telling us that his HEAD points to
>  f7a51afd, but we don't actually get that object.

This object is the correct HEAD, but it is a local commit (I rebase
all local changes so that they stay "on top" of the original code).

>  But I'm not quite sure
>  how we get into that situation; my guess is that there is something
>  confusing going on at the remote master, since the http fetching code is
>  not as strict and might fail to notice a missing object there. Is it
>  possible for us to see the remote master so we can take a look?

Sure, I just thought it would confuse more than it would help. I was
obviously wrong, as I'm actually using git:// instead of http://....
sorry... ;)

 I'm experiencing this with both these repo's, as I have committed
some local changes to them:

git://anongit.freedesktop.org/git/nouveau/mesa
git://anongit.freedesktop.org/git/nouveau/xf86-video-nouveau/

On the other hand, I don't have this issue with this repo, which
doesn't have any local commit:

git://anongit.freedesktop.org/git/mesa/drm/

Now that I look at the addresses, the "nouveau" part is common to the
problematic repo's. I'll make a local change on the last repo and see
if it also exhibits the problem. I'll report back ASAP.

Cheers,
  Renato
