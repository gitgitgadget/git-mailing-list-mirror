From: Dun Peal <dunpealer@gmail.com>
Subject: Pushing symbolic references to remote repositories?
Date: Fri, 21 Dec 2012 11:53:15 -0800
Message-ID: <CAD03jn5ACZyxJM9LEOSJov3BsT3W1N0sV3WYwcerJciMSpmSPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 21 21:00:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tm8lN-0007nl-LE
	for gcvg-git-2@plane.gmane.org; Fri, 21 Dec 2012 21:00:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752559Ab2LUT7v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2012 14:59:51 -0500
Received: from mail-vc0-f169.google.com ([209.85.220.169]:53597 "EHLO
	mail-vc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751976Ab2LUT7u (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2012 14:59:50 -0500
X-Greylist: delayed 393 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Dec 2012 14:59:50 EST
Received: by mail-vc0-f169.google.com with SMTP id gb23so5505656vcb.14
        for <git@vger.kernel.org>; Fri, 21 Dec 2012 11:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=LtJ9n502SsHtP34GyZ9tyXv1G0UAIDZocVL72lofV9A=;
        b=WeLSoMFrWwYwsONhilw+AUlHgM0LZx5dfIuy3mPhAMBGNVZdPZEDkNbop9N1x9ItfI
         uBo/sZo1nsPNLjcIzOogQTKbz9j+4nfWSeAOjjFyzBrMJF7kfphQuZ9g/2Ntovik7rHW
         IcRArc/S8LkNFL6ZFW/MxvPni9nLm5oSnN8yj/mlOC6KGE3UhYdiL4lRI0VtlijLKwF/
         sAo30I8y6O/Q/n8Q6LC0ORLxmFHx2irx/ZdmfM6SBsKkYxyM1lc6HrtOtAVuCfUEbT9G
         rm3GEj42QF/kQ+tUg3S7ouDZ8wPxDpK3Y3bLsArw5Ls6P/wEPfV8E+5q/RPJi0mTKMxC
         Lcww==
Received: by 10.58.67.199 with SMTP id p7mr22242960vet.40.1356119595960; Fri,
 21 Dec 2012 11:53:15 -0800 (PST)
Received: by 10.58.255.73 with HTTP; Fri, 21 Dec 2012 11:53:15 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212008>

Hi,

I need to share a symbolic reference - essentially, a named pointer to
another reference - among multiple repositories.

As shown in the code below, I can successfully create a local
symbolic-ref `foo_ptr` to branch `foo`, but can't push it to a remote,
in this case `origin`:

$ git branch foo; git symbolic-ref foo_ptr refs/heads/foo; git rev-parse foo_ptr
fbfec27dc6d42d48ca5d5b178caa34c666a4c39b
$ git push origin foo foo_ptr
error: dst ref refs/heads/foo receives from more than one src.

Is there a clean and reliable way to do that, or are symbolic
references just not meant to be shared?

Thanks, D.
