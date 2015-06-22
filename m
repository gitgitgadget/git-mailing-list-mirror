From: Jamie Archibald <jamie3@gmail.com>
Subject: Submodule and proxy server.
Date: Mon, 22 Jun 2015 08:46:53 -0600
Message-ID: <CACnwYoPvcyERhtmqGeF4MJBuwCYX=sabUA5D=XVtT33vXe4HFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 22 16:47:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z72zz-0002rt-7h
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 16:46:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750951AbbFVOqy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Jun 2015 10:46:54 -0400
Received: from mail-wi0-f182.google.com ([209.85.212.182]:38126 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750880AbbFVOqy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Jun 2015 10:46:54 -0400
Received: by wibdq8 with SMTP id dq8so77713981wib.1
        for <git@vger.kernel.org>; Mon, 22 Jun 2015 07:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=Lt/6UibTLucHcYHmVRQuouT9EdZk3ex5JI+tkoxSzr8=;
        b=zMJe7LiJjzkmzJaI5NfsEe7EyWhkFCHrF6PapLFd73Mx2+mDd/cTm5ix7A4hSaxzFC
         rA9MMj36oiN4+BPDZmoyQtMzxIjmFB3MQAWqK68I8NWMj5hw2xWrmYiB8v5F3zvkswKU
         u6XEFqn5VQ097Y8aMdHb1+kioOH6DWZlLvJRAen3bY2irCxxyu96faepQZg/7F598Nxl
         wZ0cu5nbDCPjmlCF9Zh/l3XGHJDvNRA9NMt1zV38B5VnqV/pveTce4dTmep8TT0xmgbt
         oOHyMafAdKFAQWdpmmeVFLkEhyD9Ss4Pqr1kSW6Td67fMo43/jrkejp1dImncN9ZvAb9
         gWMA==
X-Received: by 10.180.84.170 with SMTP id a10mr33477713wiz.52.1434984413094;
 Mon, 22 Jun 2015 07:46:53 -0700 (PDT)
Received: by 10.27.219.11 with HTTP; Mon, 22 Jun 2015 07:46:53 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272366>

I am behind a proxy at work and I've setup a git repo with a submodule.


Here are the commands I'm executing.


$ mkdir MyProject
$ cd MyProject
$ git init
$ git remote add origin http://path/to/repo/MyProject.git
$ git config =E2=80=94add remote.origin.proxy ""
$ git pull origin master


MyProject has a submodule called MySubmodule

The above commands work and have no problem pulling down the files to
local. The issue occurs when I attempt to update the submodule

$ git submodule init

Submodule 'MySubmodule' (http://path/to/submodule/MySubmodule.git)
registered for path 'MySubmodule'

$ git submodule update

Cloning into 'MySubmodule'...

fatal: unable to access
'http://http://path/to/submodule/MySubmodule.git/': The requested URL
returned error: 502

Clone of 'http://path/to/submodule/MySubmodule' into sub module path
'MySubmodule' failed

It seems I am getting a 502. I have a funny feeling that perhaps the
submodule command is not inheriting the proxy settings I've configured
above.

Any help would be appreciated.

GIT rocks!


--=20
Jamie
