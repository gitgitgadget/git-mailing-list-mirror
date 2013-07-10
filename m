From: Matt Schoen <mtschoen@gmail.com>
Subject: limit memory usage on large repositories
Date: Wed, 10 Jul 2013 17:27:57 -0500
Message-ID: <CAJj9RsTjp7j7Ew2pSttKRAZfZ6fLt9jL+Q_vmHQCi16FBBbK=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 11 00:28:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ux2s3-0000TC-Vv
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jul 2013 00:28:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754572Ab3GJW2U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jul 2013 18:28:20 -0400
Received: from mail-wg0-f47.google.com ([74.125.82.47]:59114 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754259Ab3GJW2T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jul 2013 18:28:19 -0400
Received: by mail-wg0-f47.google.com with SMTP id l18so6311740wgh.2
        for <git@vger.kernel.org>; Wed, 10 Jul 2013 15:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=kXmYf99q/HasCuq3Wobv641KKh3az8J3ZTLGMuJgjbM=;
        b=EZ/BoEjnSEqBsG68oPmxdCG/x2Y4LEWVUHqjT/tjd/DY4W/o3DibtidGg5nPz0T6fW
         RcygUtepDBeN6DrzxvZiUymbwH7ixmrzaM8xGdxBVi/ZeVBe7fGBAK1EpWNiy8HIXGnE
         w/6OotXeNGP5I+Zc4lCE5byFz2je+MwewngD2GGMkDB2fVBaieo81vBNbAdyjrbx2tfO
         r+ug9K8yspBIvl1U7rodwcKZ+eoVU7i9pPtvuskwNR6c6SrCLT5j9Rlt0HoezId5UyWe
         38A/oWPVlfcoBQkHx1dy9wheHnvW/YTnt1fe4FLPu3nvWuY31e+Z4sTkrseFk8eOycyP
         8tAg==
X-Received: by 10.194.1.226 with SMTP id 2mr19497939wjp.91.1373495298002; Wed,
 10 Jul 2013 15:28:18 -0700 (PDT)
Received: by 10.217.94.132 with HTTP; Wed, 10 Jul 2013 15:27:57 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230074>

Hi there,

I've been using git for some time now, and host my remote bare
repositories on my shared hosting account at Dreamhost.com.  As a
protective feature on their shared host setup, they enact a policy
that kills processes that consume too much memory.  This happens to
git sometimes.

By "sometimes" I mean on large repos (>~500MB), when performing
operations like git gc and git fsck and, most annoyingly, when doing a
clone.  It seems to happen in the pack phase, but I can't be sure
exactly.

I've messed around with the config options like pack.threads and
pack.sizeLimit, and basically anything on the git config manpage that
mentions memory.  I limit all of these things to 1 or 0 or 1m when
applicable, just to be sure. To be honest, I really don't know what
I'm doing ;)

Oddly enough, I'm having trouble reproducing my issue with anything
but git fsck.  Clones were failing in the past, but after a successful
git gc, everything seems to be ok(?)

Anyway, I'd like some advice on what settings limit memory usage, and
exactly how to determine what the memory usage will be with certain
values.

Thanks!
