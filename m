From: "Denis Bueno" <dbueno@gmail.com>
Subject: Git clone fatal when using git-shell account
Date: Mon, 30 Jun 2008 14:05:13 -0400
Message-ID: <6dbd4d000806301105x77b853caj404a1001dc4749a7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 30 20:06:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDNlW-000318-Ij
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 20:06:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753502AbYF3SFR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 14:05:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752064AbYF3SFR
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 14:05:17 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:38446 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751308AbYF3SFP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 14:05:15 -0400
Received: by fg-out-1718.google.com with SMTP id 19so798811fgg.17
        for <git@vger.kernel.org>; Mon, 30 Jun 2008 11:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=fgFYWk2HyznXBHOOfgwBSQFcJBwFXESla1IFHfJVG4o=;
        b=afYcP7VF7qZTpvojj2+DZZv3G+AIWLAJDzXi5uOzp9ubRZ39iPmvxOIkHyx8Dm5gvz
         YNXvBwpHcgdpuVgH0JpJRF6sVmDyk2e+eLDIvWiDoxXDMw+q+3+bmYu9JvHavW8/i6Ic
         jitog8uYEQQ4ivubfA66V+oqZ3bkWN/uoBhJ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=FisRFYX6buOM+E9lbGuHnFJlOLk9EOJqymDaDqf0RTl75SdyN7Exv5UpjUdaN6Ge33
         D66r/AIge+ipFwuLAJgL2dnujAHzhFxCi19IoHnWwJvWKdH0tTB9jRodYuijy3dcBj4l
         fYVKiXT1rF52KXyyXFNQFgIk2xmVVzoxw2iT8=
Received: by 10.86.27.19 with SMTP id a19mr6510800fga.56.1214849113516;
        Mon, 30 Jun 2008 11:05:13 -0700 (PDT)
Received: by 10.86.30.2 with HTTP; Mon, 30 Jun 2008 11:05:13 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86927>

I have a machine containing a "central" git repo, which I access via
SSH using an account that uses /bin/bash.  From my laptop, doing a
clone works.  But when I change the shell on the central machine to
git-shell (which is listed in /etc/shells), the clone fails.

Clone using /bin/bash:

    tmp[82] > git clone ssh://cameron@churn/Users/Shared/src/jmatch.git
    Initialize jmatch/.git
    Initialized empty Git repository in /private/tmp/jmatch/.git/
    Password:
    remote: Counting objects: 1690, done.
    remote: Compressing objremote: ects: 100% (1239/1239), done.
    remote: Total 1690 (delta 424), reused 1683 (delta 422)
    Receiving objects: 100% (1690/1690), 3.62 MiB | 2332 KiB/s, done.
    Resolving deltas: 100% (424/424), done.

Clone using /opt/local/bin/git-shell:

    tmp[81] > git clone ssh://cameron@churn/Users/Shared/src/jmatch.git
    Initialize jmatch/.git
    Initialized empty Git repository in /private/tmp/jmatch/.git/
    Password:
    fatal: The remote end hung up unexpectedly

Laptop (Tiger OS X 10.4.11):

    git version 1.5.6.1

Central (Leopard OS X 10.5):

    git version 1.5.6.1

Configuration of repository:

[core]
        repositoryformatversion = 0
        filemode = true
        bare = true
        ignorecase = true
        sharedrepository = 1
[receive]
        denyNonFastforwards = true



I couldn't find this issue discussed anywhere, so, I post in hope that
someone has run into it before.

-- 
                              Denis
