From: Disc Magnet <discmagnet@gmail.com>
Subject: Can't assign user.name to "E F" in git config
Date: Tue, 30 Mar 2010 02:02:55 +0530
Message-ID: <308d4701003291332s500cbbci68e10a784ac1aa81@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 29 22:41:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwLlw-0004iN-Ri
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 22:41:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753657Ab0C2UlO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Mar 2010 16:41:14 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:53876 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753032Ab0C2UlE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Mar 2010 16:41:04 -0400
Received: by vws20 with SMTP id 20so262022vws.19
        for <git@vger.kernel.org>; Mon, 29 Mar 2010 13:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:received:message-id
         :subject:from:to:content-type;
        bh=nUW4xz9mONPijnJ0VG+avr16pK8clliNkLcOaAdm7P0=;
        b=pKXuKN9O4hATbJs6DpkProwpYJPe+GykHC79EMw9LYG+sr9DPXlmqh7C8WegY1diJC
         LyxCMQLbt40fWbKKe3V6PnY3abB9MJmCCHyRtsknt7UAJIDI8ykhoQcCfXN8NWqJCx8U
         83n7hrtvg1QBgLgjeBAod+kPHWKoah2oael9o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=iHuFhZHr5DDyR4WCZtMhH81HTzisXD9MnHuGPoeZOr11MHPQESy05p5dqP6zAtsRNp
         VTT2/drt4nH/sJt0cD/wKqXNPkXLhbMzFUsT9YDFP0XypwwK8OIIyldbOdtNHGRAVo5n
         csiaeEB7YwX8bNWkfxzAp7kQLkYkS33sa8iQI=
Received: by 10.229.250.15 with HTTP; Mon, 29 Mar 2010 13:32:55 -0700 (PDT)
Received: by 10.229.229.70 with SMTP id jh6mr3936776qcb.107.1269894775935; 
	Mon, 29 Mar 2010 13:32:55 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143515>

I've never done a git init and I don't have any .git directory in the
current directory. I get warnings in the following example. Moreover,
I can't assign user.name to "E F".

humpty@wall:~/work$ rm ~/.gitconfig
humpty@wall:~/work$ git config --global user.name A B
humpty@wall:~/work$ git config --global user.name C D
humpty@wall:~/work$ git config --global user.name "E F"
warning: user.name has multiple values
humpty@wall:~/work$ git config -l
user.name=A
user.name=C
humpty@wall:~/work$ cat ~/.gitconfig
[user]
        name = A
        name = C

However, everything works fine here.

humpty@wall:~/work$ rm ~/.gitconfig
humpty@wall:~/work$ git config --global user.name A
humpty@wall:~/work$ git config --global user.name C
humpty@wall:~/work$ git config --global user.name "E F"
humpty@wall:~/work$ git config -l
user.name=E F
humpty@wall:~/work$ cat ~/.gitconfig
[user]
        name = E F

The same behavior can be reproduced after doing git init and by
removing the --global option.

Is this an expected behavior or is it a bug?
