From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [BUG] git checkout - breakage with rebase
Date: Sat, 11 May 2013 01:46:14 +0530
Message-ID: <CALkWK0=Gtp2cANFtSAxYyjJNoAa=uajrsq7ZnVgSjvapm9MRmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 10 22:17:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UatkR-00069q-8u
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 22:16:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754194Ab3EJUQz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 16:16:55 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:52578 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753380Ab3EJUQy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 16:16:54 -0400
Received: by mail-ie0-f172.google.com with SMTP id 16so8942030iea.31
        for <git@vger.kernel.org>; Fri, 10 May 2013 13:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=UBrXXgHJGhTaXP6nJRkdy0/z55zA9ZQiaX1MoCHOpkw=;
        b=lhUupmFQn5oHLYbaRAH+DaBxLtNNTDesCWuYE5bPhZvnPZm084SUlozoW09ErBLJKQ
         +HEHY1EHp5PN5M2DXrvWuTqhZDg+kiIga+OFWpo1ODKuwnYUgXUefO8V51JuuUUdMKuG
         8slQ5mIJt3eXzmlwmOt6a2cqqJhAlibyC6tdsO+QDJB2JfjgR4HZE7ySJdiGzf5TqrrA
         p4wQlUuAOLEj8Gy73fsDtiSNjTT2FpPSSlMZFVqdY/HDkBD7/fwl7Jm/CxXfIdULBrce
         JPf+26i4odHSuXSiVGpeTv37N5Osju95/Wl3kqt39ddHhxCEvGKRMIxVXUIPUp80leGk
         j0dg==
X-Received: by 10.50.66.197 with SMTP id h5mr3151483igt.63.1368217014561; Fri,
 10 May 2013 13:16:54 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Fri, 10 May 2013 13:16:14 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223902>

Hi,

I often do:

    $ git checkout t-rebase-cleanup
    $ git push
    $ git checkout -
    $ git merge @{u}
    $ git checkout rebase.autostash
    $ git rebase master
    $ git checkout -
    # noop
    # Aargh!
    $ git checkout -
    # noop again

Isn't this highly annoying?

Ram
