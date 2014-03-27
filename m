From: Siggi <siggin@gmail.com>
Subject: Bug report: Git 1.8 on Ubuntu 13.10 refs not valid
Date: Thu, 27 Mar 2014 15:45:34 +0100
Message-ID: <5334398E.8090402@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 27 15:45:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTBYt-0004Qr-Le
	for gcvg-git-2@plane.gmane.org; Thu, 27 Mar 2014 15:45:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755128AbaC0Opj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2014 10:45:39 -0400
Received: from mail-bk0-f48.google.com ([209.85.214.48]:61559 "EHLO
	mail-bk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754638AbaC0Opi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2014 10:45:38 -0400
Received: by mail-bk0-f48.google.com with SMTP id mx12so770068bkb.21
        for <git@vger.kernel.org>; Thu, 27 Mar 2014 07:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=Qq0bG5aqwBiP840Cd/osqk2Gyi0g0oM8XluDYJVLkrU=;
        b=PuG7PCy5vtX0dyUx2K8xClFaTqX1aaywKS5Ntxam80rijXwpXJTbSlvsS/jwDLHXQj
         0sUXnDWfCVGMPEQYARxIMJdngBQg4wfdd/Raf6CBLnBhvd0vAZOd9dhtsQTbOUc+blQP
         TPoFJ3CJT761PIQN5rU1+4VVYkoqyU0lU5go3s9rxe/Pq4u2BZ3/lgABYkaoH6g67cMz
         VwNgXc3FcdBc7pzziyK/OneC186DGDpxrJmS+vP0wTppMDTM6JY5r6Ot0Y9rSs/jzwrG
         40Bv21nj6AFaezdYYu7Dsy2YL4VoYsRoHP+R9zc+eY3kR0/2fmpXF4kvzahXoUHjImaa
         1bMQ==
X-Received: by 10.204.180.67 with SMTP id bt3mr3070419bkb.16.1395931537274;
        Thu, 27 Mar 2014 07:45:37 -0700 (PDT)
Received: from [10.18.250.137] (era126.goemobile.de. [134.76.0.126])
        by mx.google.com with ESMTPSA id zl9sm2322540bkb.11.2014.03.27.07.45.35
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 27 Mar 2014 07:45:36 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245285>

Hi,
I'm running:

Ubuntu 13.10 64 bit

and git version
git:amd64/saucy 1:1.8.3.2-1 uptodate

my remote repository is on a Chiliprojekt server (a fork of Redmine).

cloning the repo over http results in following error:

sneher@sneher-XPS:~/Dokumente/test$ git clone 
http://sneher@git.projects.gwdg.de/xrd-csd.git
Klone nach 'xrd-csd'...
Password for 'http://sneher@git.projects.gwdg.de':
fatal: http://sneher@git.projects.gwdg.de/xrd-csd.git/info/refs not 
valid: is this a git repository?

the content of ../info/refs looks like this

e49ae34096fd6fff3d1e7b8e7b6e78ae29bad913	refs/heads/0.2.2
3d375b2f7eeeb7bc12b24cc8181aa085f471ba10	refs/heads/master
f7a69735c1e2cb8363be849afa9e9bfdf2db61c6	refs/heads/new_lab
879ccace941ea6dc83876b1dcfcc099e5c7e5b42	refs/heads/testing
2f9504da3febcdafb9cb92806e7e178144fec0c9	refs/remotes/origin/HEAD
2f9504da3febcdafb9cb92806e7e178144fec0c9	refs/remotes/origin/master
f7a69735c1e2cb8363be849afa9e9bfdf2db61c6	refs/remotes/origin/new_lab
58fe57f5a2a0c8e8096c62f8ab8be2077c592e53	refs/remotes/origin/testing
4b64a990dc1534abcccfb7f8c22f0cc5388e9db8	refs/tags/0.1.0
a90ce817ca3bde41ce6c88cf22a9993bd7560f55	refs/tags/0.1.1
9a25635e866979b044b83f914cfd993a7031a9ca	refs/tags/0.1.2
5a94e698b1042b34a25c87ced98f5f42d40e2578	refs/tags/0.2.0
7cb00e325c1fb9a4112700744237f873bd5bae16	refs/tags/0.2.1



I use to have the same problem on a different Ubuntu version (12.10). There the problem occurede with the git 1.8 update. I just switcht back to the older version.

Problem is, there is no older version for saucy.

Thanks for your help! and, in case this do to my inability, sorry for bugging you!

Siggi
