From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: git-checkout changes the index but not the checked out files?
Date: Mon, 23 Apr 2007 11:25:01 +1200
Message-ID: <46a038f90704221625k216864cdwb2b35bc035fac7e9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 23 01:25:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HflQw-0006wW-Mv
	for gcvg-git@gmane.org; Mon, 23 Apr 2007 01:25:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030964AbXDVXZF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Apr 2007 19:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030959AbXDVXZE
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Apr 2007 19:25:04 -0400
Received: from wx-out-0506.google.com ([66.249.82.231]:47531 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030964AbXDVXZB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Apr 2007 19:25:01 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1591838wxd
        for <git@vger.kernel.org>; Sun, 22 Apr 2007 16:25:01 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Qi/QNxjB5US1ZlmTHa6x1xEIOQ8OquoE40I2XK452Q2p2hpY/KP75p4aMv+F3HhdsyZc14AAPEuOp0AxcaqKs5yNgk1ERyeOW7Mfsg2K84xy7oNM+es/Me7Nl7wz5x2tysf3EHzyC1+wv7+uDa9ho5zx6Yt7OZdlMbgD9wYFEBY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=DkV5b6RiTnjGNvPyKT5FPqrotVumHdQhGtuDxblOdoxfBUQSMXysqf2YQ5x71OFH2XmA+Y9rqghxuy/BxznLdpwTJHPQCByqhzYcjHBGld86J1IlRdS2kKlnZRqhxVDhfHM+a6mZgSbdiAyY6HujXqGktXoPbNIYVpXerIa7Vr4=
Received: by 10.90.87.5 with SMTP id k5mr4266758agb.1177284301165;
        Sun, 22 Apr 2007 16:25:01 -0700 (PDT)
Received: by 10.90.52.17 with HTTP; Sun, 22 Apr 2007 16:25:01 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45287>

I am a bit confused by git-checkout behaviour in the following scenario.

$ git version
git version 1.5.1.gf8ce1

$ git-branch
  mdl17-polhn
* mdl18-local
  mdl18-topnz

$ git-status
<shows a clean status>

# checkout an upstream branch to test that it has a bug
$ git-checkout origin/MOODLE_18_STABLE
$ git-status
<shows a clean status>

# switch back to our local branch to test that the bug is gone
$ git-checkout mdl18-local
$ git-status
<shows a very dirty status - the index has changed but the files
weren't updated to the contents of mdl18-local>
$ git-reset --hard # this fixes things back to normal

Is the bug in git-checkout or in my understanding? ;-) Perhaps I am
modelling my use of git-checkout on how I used cg-switch and that's
wrong. But reading the man page, it says:

When <paths> are not given, this command switches branches by
updating the index and working tree to reflect the specified
branch, <branch>, and updating HEAD to be <branch>

cheers,


martin
