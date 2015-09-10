From: Daniele Mammarella <mammarella.daniele@gmail.com>
Subject: git clone in windows after a linux push
Date: Thu, 10 Sep 2015 10:25:18 +0200
Message-ID: <55F13E6E.6080509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 10 10:28:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZxDT-0005Ay-RH
	for gcvg-git-2@plane.gmane.org; Thu, 10 Sep 2015 10:28:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752055AbbIJI2T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2015 04:28:19 -0400
Received: from mail-wi0-f180.google.com ([209.85.212.180]:38460 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751294AbbIJI2Q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2015 04:28:16 -0400
Received: by wiclk2 with SMTP id lk2so13763124wic.1
        for <git@vger.kernel.org>; Thu, 10 Sep 2015 01:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=to:from:subject:message-id:disposition-notification-to:date
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=89ivlPpFKM3lkZviAQpootgVPuVufaBtB+2DCYCF7ik=;
        b=fPDMayjcKDhYk57UkgTghpJ2bYnnwVb64vYn3YhdRfaxYMPYhyv29nPtDx5Ow4x43T
         N2/L+5zIppnNB1q52Tsrb4PuAKOHTtnhDE/BZZImUd7k2IBZ1o0PgqmwTWTtTXGFdIka
         dCiBljANNf49CocE0QOMIhtW2rd9ScgHn7BwIlglQYwx/QpauOl4VUMLON8z1pr1Q4Ey
         qiKGWoANo7cnoGUTBhjSpEo1GU0lhcabw3aesyp0tMGO0hlvzbsdvCAhEdSOmZdiYhSa
         iJXzQwgr0D1WVXKM26u+45sQg5R7rNa1AMXVSwcsquK4jEhb10akoEGSO4Lhty3T8S6w
         ipZw==
X-Received: by 10.180.182.107 with SMTP id ed11mr3969129wic.52.1441873694777;
        Thu, 10 Sep 2015 01:28:14 -0700 (PDT)
Received: from [192.168.1.72] (host91-31-static.62-79-b.business.telecomitalia.it. [79.62.31.91])
        by smtp.googlemail.com with ESMTPSA id fs9sm7940520wic.24.2015.09.10.01.28.13
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Sep 2015 01:28:14 -0700 (PDT)
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277575>

Hi to all,
This is what i have done for initialize a local git archive, and a
remote git repository.

daniele@daniele-nb /var/www/localhost/htdocs $ mkdir provagit && cd provagit
daniele@daniele-nb /var/www/localhost/htdocs/provagit $ git init
Inizializzato un repository Git in /var/www/localhost/htdocs/provagit/.git/
daniele@daniele-nb /var/www/localhost/htdocs/provagit $ echo 1 > asd.txt
daniele@daniele-nb /var/www/localhost/htdocs/provagit $ git add .
daniele@daniele-nb /var/www/localhost/htdocs/provagit $ git commit -m "il mio primo commit"
[master (root-commit) 5c2cd93] il mio primo commit
 1 file changed, 1 insertion(+)
 create mode 100644 asd.txt
daniele@daniele-nb /var/www/localhost/htdocs/provagit $ cd ..
daniele@daniele-nb /var/www/localhost/htdocs $ cp -r ./provagit /mnt/tinfor/Sviluppo/
daniele@daniele-nb /var/www/localhost/htdocs $ cd /mnt/tinfor/Sviluppo/
daniele@daniele-nb /mnt/tinfor/Sviluppo $ git clone --bare ./provagit ./provagit.git
Clone nel repository spoglio './provagit.git'...
fatto.
daniele@daniele-nb /mnt/tinfor/Sviluppo $ rm -rf provagit
daniele@daniele-nb /mnt/tinfor/Sviluppo $ cd /var/www/localhost/htdocs/
daniele@daniele-nb /var/www/localhost/htdocs $ rm -rf provagit
daniele@daniele-nb /var/www/localhost/htdocs $ git clone /mnt/tinfor/Sviluppo/provagit.git
Cloning into 'provagit'...
fatto.
daniele@daniele-nb /var/www/localhost/htdocs $


The problem i have noticed is that when i make my first "push" after
this commands from a linux machine to a remote repository,
If i try to clone that project from windows with git clone on git bash
no problem.
But if i try to clone from Git Gui on Windows it have problems because
it say to me that it can not resolve last commit SHA1.

I've tried to make also that process from windows:
inizialize a local git archive and a remote archive with git bash or
with git gui (so i dont write any commands with the gui), and i have the
same problem.
If a windows machine clone the project with the Gui from remote archive
BEFORE any push from the linux machine, its ok, i can push and fetch
from windows with the Gui and linux without any problems.
If a windows machine clone the project with the Gui from remote archive
AFTER the first push from the linux machine, bad requests (can not
resolve the last commit SHA1).

I thinks its a bug of Git Gui on Windows machine.
If it will be important, i use Windows 8 and Linux Gentoo.
I have on linux:
daniele@daniele-nb ~ $ git --version
git version 2.4.6

and on windows:
$ git --version
git version 2.5.1.windows.1

Hope to have your idea, thanks a lot!

-- 
Daniele Mammarella
