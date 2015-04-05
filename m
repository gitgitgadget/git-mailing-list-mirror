From: "Yi, EungJun" <semtlenori@gmail.com>
Subject: Feature request: Update remote url if it is redirected.
Date: Sun, 5 Apr 2015 19:44:07 +0900
Message-ID: <CAFT+Tg8PyLG_hLVoR0s40J_tY1opRBe57XXLT9cpBv5=8ZtgOQ@mail.gmail.com>
Reply-To: semtlenori@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 05 12:44:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yei2K-0000H9-DT
	for gcvg-git-2@plane.gmane.org; Sun, 05 Apr 2015 12:44:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751821AbbDEKoK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2015 06:44:10 -0400
Received: from mail-qk0-f181.google.com ([209.85.220.181]:34269 "EHLO
	mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751508AbbDEKoI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2015 06:44:08 -0400
Received: by qkgx75 with SMTP id x75so5425447qkg.1
        for <git@vger.kernel.org>; Sun, 05 Apr 2015 03:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:date:message-id:subject:from:to:content-type;
        bh=bjixjSr0C/eHXGzFM8tGjb5a1cKRpgYslscf08jDPes=;
        b=aggZiPrn2jG59XFDfFQdtM1Q5OyNJPT3yd7nwW+jue/xB624mEejOlxvQQQCuYTPlT
         CabCBv7i1dh3H68c7SC/wj9dZsPjwvQaRDdk2vz/NzjiwSQ8U4EtNUQa8s/KfyOnw3qo
         OKkBeHM/FjDjLpYP776NHomb2kERl5l2cgkXbcVmG1nTngMmzWZ72rGMSbD2+hWmiIsz
         tjPqTZ77v75NjWZbbSplICM66fv2Bxu/GaNDzm/Ia8gDaUl1jKqjsYe+ZfkD9y+maEtz
         dD8BE2dI/eNLFIM8iY2tkV5iurXfctCOwkXqETBCALvA9cMMvAdDstPi8eFnZjoiFW7n
         UGwA==
X-Received: by 10.55.49.138 with SMTP id x132mr19336484qkx.19.1428230647523;
 Sun, 05 Apr 2015 03:44:07 -0700 (PDT)
Received: by 10.140.105.161 with HTTP; Sun, 5 Apr 2015 03:44:07 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266801>

Some git hosting services, like Github, a url to a git repository can
be changed by changing the name of the repository by the owner. If
someone tries to get the repository with the old url, usually the
hosting service serves the request with the repository indiciated by
the new url. It is very helpful for the users who don't know the url
has been changed.

In such case, I think it is recommended to update the user's remote
url with the new one because the old url possibily does not work if
the hosting service does not keep the old url anymore, or worse, works
incorrectly if someone makes a repository with the old url.

To fix the potential problem, it would be nice if Git client asks the
user, while fetching objects from a remote url, to update the url if
it is changed. If the client and the server is talking in HTTP, it is
easy to know the url is changed if the server responses with 301 Moved
Permantely or 308 Permanet Redirect.
