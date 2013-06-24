From: Greg Freemyer <greg.freemyer@gmail.com>
Subject: Basic git-archive --remote question
Date: Mon, 24 Jun 2013 15:53:56 -0400
Message-ID: <CAGpXXZJuC09t8-5d=p4KNs9rQ-S347eBNuKcKWFhXZTnkLW0sA@mail.gmail.com>
References: <CAGpXXZJifb1KmR8=VZVW+1MKjyo7HOq=OgU_rcHs-vc5ezfG6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 24 21:54:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrCqP-0006XN-5E
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 21:54:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138Ab3FXTy3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 15:54:29 -0400
Received: from mail-wg0-f52.google.com ([74.125.82.52]:55359 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750784Ab3FXTy2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 15:54:28 -0400
Received: by mail-wg0-f52.google.com with SMTP id b12so8748375wgh.7
        for <git@vger.kernel.org>; Mon, 24 Jun 2013 12:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=qSDKsh6tP2aApXX26WmH4Ax2Bykv8Y60rInBPu5sSYs=;
        b=c6Uf1wqzrtgvfckQxMNuWiIFzuCeTDJSk1oPvyrIZljsoJCEA96p0bKJmXLu7iXFEf
         GvO8xRDgX/8IMa2PDd5OyQazN1YulS+kPqOpmAjdJhWcBfGV/nMi/M39USuKakC5HELL
         h125oMT/7pHwy/zcwSK/lV713heJQYhyzP1nQj4LWy/0GPQ0vBoLJh/CKUz89DS55Tl5
         tj1MeCfcJ1f9Ekg6/yFmzD5QZtrkbRXvFLIcd2AKCFFaPTaQ/nhmXaZmJM80+I8Rtp4Y
         GO35WxRvYVAWG8AsOnqs5YqB3gERr6zZWndmjZaETy7e6IJ500JNa5j0R/Y3nYZmQ7yh
         BOyw==
X-Received: by 10.194.108.132 with SMTP id hk4mr17386280wjb.43.1372103667065;
 Mon, 24 Jun 2013 12:54:27 -0700 (PDT)
Received: by 10.181.13.72 with HTTP; Mon, 24 Jun 2013 12:53:56 -0700 (PDT)
In-Reply-To: <CAGpXXZJifb1KmR8=VZVW+1MKjyo7HOq=OgU_rcHs-vc5ezfG6w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228909>

I'm trying to create a tarball from a git tag and I can't get the
syntax right.  The documentation is not very clear.

Can someone help me?

== details

git v1.8.1.4

The upstream git repo is at: https://github.com/dkovar/analyzeMFT

Here's a few attempts using git as the protocol:

> git archive --format=tar --remote=github.com:dkovar/analyzeMFT.git v2.0.4

Permission denied (publickey).
fatal: The remote end hung up unexpectedly

> git archive --format=tar --remote=git://github.com/dkovar/analyzeMFT v2.0.4

fatal: remote error
   Your Git client has made an invalid request:
   003agit-upload-archive /dkovar/analyzeMFT

> git archive --format=tar --remote=//github.com/dkovar/analyzeMFT v2.0.4

remote: fatal: '//github.com/dkovar/analyzeMFT.git' does not appear to
be a git repository
fatal: sent error to the client: git upload-archive: archiver died with error
remote: git upload-archive: archiver died with error

The github page also says I can use ssh with git as the user, but that
complains I don't have the private key (which I don't):

git archive --format=tar
--remote=ssh://git@github/com/dkovar/analyzeMFT.git v2.0.4


Thanks
Greg
