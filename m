From: Frank Li <lznuaa@gmail.com>
Subject: Re: [PATCH 3/3] fallback SSH_ASKPASS when GIT_ASKPASS not set
Date: Thu, 25 Feb 2010 12:17:23 +0800
Message-ID: <1976ea661002242017v318ec3davb62087006d37f5e4@mail.gmail.com>
References: <1267024554-3288-1-git-send-email-lznuaa@gmail.com>
	 <40aa078e1002240734u1ef6364fp16fbce50caf575bd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: kusmabite@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 25 05:24:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkVGm-0005nA-SL
	for gcvg-git-2@lo.gmane.org; Thu, 25 Feb 2010 05:24:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932266Ab0BYEYI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 23:24:08 -0500
Received: from mail-yx0-f182.google.com ([209.85.210.182]:54687 "EHLO
	mail-yx0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932232Ab0BYEYG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 23:24:06 -0500
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Feb 2010 23:24:06 EST
Received: by yxe12 with SMTP id 12so909198yxe.33
        for <git@vger.kernel.org>; Wed, 24 Feb 2010 20:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type;
        bh=xqO9/+ZfQs4BLl6ckLxgu+cmYseFOU29fTu9twNy9OM=;
        b=ulLs7eh4FAonKm3uh1UIUI8CWJYVi59X7UN2OT+rxcO9WSmUmG1aAVV107/TEAbDCQ
         rsCP6R3WKmtSFl1MbvtcbGLthhu12x2K4s+MNjojX3eyWasRXJlfzC+65RItGnxUIoQy
         CLKwi+l/y2yQlrLQwRke5Xk0jgErdykHt9ZLc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=oHdsHs9eNliODlbkqO9bgJPDyM6jPPwbBHtC2n03uhEdf3x4VEKxMUC+hgjkTTmwIt
         j6mX1AUTUVuZiX8GG2cphorSqlUsFotLrAq/Rc1NhLy6c+2dFwV5wDzsqwShVYK+9lUK
         hVa92B2JDTltVXwJgc/U4dNwRif0IOho0QZLo=
Received: by 10.150.55.27 with SMTP id d27mr133621yba.124.1267071443309; Wed, 
	24 Feb 2010 20:17:23 -0800 (PST)
In-Reply-To: <40aa078e1002240734u1ef6364fp16fbce50caf575bd@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141026>

>
> Since there's a maximum total size of the environment on Windows
> (64kib), perhaps it's better to not increase the environment-size more
> than necessary and instead check both variables when used? I must
> admit doing so gives me a kind of yuck-feeling, but at least it should
> also make non-builtins (like git-svn, which AFAICT is what you're
> fixing) work consistently even if it's not called through the
> git-wrapper...
>

Git-svn use the same way, please read first patch.
