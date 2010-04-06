From: Alexander Gladysh <agladysh@gmail.com>
Subject: gitk pays too much attention to file timestamps
Date: Wed, 7 Apr 2010 02:57:00 +0400
Message-ID: <l2hc6c947f61004061557x8085600fif5e973077d9eb4f3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 07 00:57:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzHhm-0003kd-8n
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 00:57:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757618Ab0DFW5F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Apr 2010 18:57:05 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:40940 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757603Ab0DFW5D (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Apr 2010 18:57:03 -0400
Received: by vws13 with SMTP id 13so207340vws.19
        for <git@vger.kernel.org>; Tue, 06 Apr 2010 15:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:received:message-id
         :subject:from:to:content-type;
        bh=F+WoTuZXO/uDtAaVKVRdbY1/8frhsf4Hw2l76aA7ZKc=;
        b=vOM2exc19o5sanhItSZjy577Cc4ApyuOJAH8KzfsxRqafBrgys5Iu2SBOBqevEFZXt
         dDCWg3flCYoIH3P+IlKxx13VRy45Elr9mo5PffJgCLYN+Q+y07pde6elISHZg6b7Xo4U
         OcYg+9ChxGcJ8zoMjKVifS29eK/oKu0qz2xzM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=Ycy0vJk6GVDiM8cxbBGZD3nefhR+bBhAZuKIloEZaH8/xbHJCPUOeHzNG52J+ZScDH
         QLZzXPSKKYD3DDmoGDjt7gkW6NJyJqGHUlGp5qOOgHFwcmgIQGj8dnKIsmhw11kIpaIh
         avTgPYZTnUsJpP3oxC36oVbigXl60Q/lGScYU=
Received: by 10.220.93.2 with HTTP; Tue, 6 Apr 2010 15:57:00 -0700 (PDT)
Received: by 10.220.48.22 with SMTP id p22mr3926162vcf.93.1270594620413; Tue, 
	06 Apr 2010 15:57:00 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144176>

Hi, list!

OS X 10.6.3
Git 1.7.0.4

When I "touch" a file, gitk lists it in "local uncommitted changes,
not checked in to index" (without a difference, just a name). I
believe that it should not.

Git status, and git commit do ignore such files.

After git reset --hard, gitk stops seeing changes as expected.

See steps to reproduce below.

HTH,
Alexander.

$ mkdir touch
$ cd touch
$ git init
$ echo "A" > alpha
$ git add alpha
$ git commit -m "alpha"
$ touch alpha
$ git status
# On branch master
nothing to commit (working directory clean)
$ gitk --all

Observe "local uncommitted changes, not checked in to index"
