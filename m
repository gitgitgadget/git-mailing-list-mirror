From: Zachary Steven Young <zacharysyoung@gmail.com>
Subject: Setup Git Server Over HTTP: fatal info/refs
Date: Tue, 17 Dec 2013 12:20:59 -0800
Message-ID: <155A3C2F-E0E0-4C60-95D3-D06EFB8F1002@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Zachary Young <zacharysyoung@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 17 21:21:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vt18j-00020z-TR
	for gcvg-git-2@plane.gmane.org; Tue, 17 Dec 2013 21:21:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753119Ab3LQUVH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Dec 2013 15:21:07 -0500
Received: from mail-pb0-f43.google.com ([209.85.160.43]:62781 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752306Ab3LQUVG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Dec 2013 15:21:06 -0500
Received: by mail-pb0-f43.google.com with SMTP id rq2so7437510pbb.30
        for <git@vger.kernel.org>; Tue, 17 Dec 2013 12:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:content-type:content-transfer-encoding:subject:date:message-id
         :cc:to:mime-version;
        bh=v0SiSgahkSP04BZoWnXhDbbMIB4wGYEt5mUXaaIH7a0=;
        b=PVppzM+oRCcPIsXQNFaOFL7WokkUrtBU9U62BQtC8s0TNBfSHLARXZeWqK6nYrHQyB
         +ax0qcPcq99Frr/iL8hKICxBFmnXkIbNnprCO0r3rFbqyUr8XPCSTDWcE223za8I3wcg
         MXVicLlKmvl8jgQIORvYPqDMiQsORPiO5DjimjiwLrY2AGFGoHoDTW6XW9JTqNqiFVUt
         DfoMwqFRqyZCgw6R4zlEdZkpGno3YYQT0YDNkEK8zuYyLy7SfQCFXWAuS4tv5jrOvueC
         w6pYsR2UjtNCnRaqVojhMfqlaNtcNMorMbGAkG80caK04S3Kn0xP6UCJhkXTh70nOGjn
         P3bA==
X-Received: by 10.68.6.66 with SMTP id y2mr29492106pby.60.1387311664740;
        Tue, 17 Dec 2013 12:21:04 -0800 (PST)
Received: from zacharys-air.san.rr.com (209-234-190-105.static.twtelecom.net. [209.234.190.105])
        by mx.google.com with ESMTPSA id jk16sm35915047pbb.34.2013.12.17.12.21.03
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 17 Dec 2013 12:21:03 -0800 (PST)
X-Mailer: Apple Mail (2.1827)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239402>

Hi, all,

Thank you for that wonderful document, it worked flawlessly for CentOS =
6.4 with one exception:

> [Tue Dec 17 12:07:42 2013] [error] [client 10.2.32.197] File does not=
 exist: /var/www/html/gpu-code.git/info/refs

I did some searching and found this StackOverflow answer:

> fatal: https://github.com/username/repository-name.git/info/refs not =
found: did you run git update-server-info on the server?

only my client (git version 1.8.3.4 (Apple Git-47)) did not suggest `up=
date-server-info=92.

Running `git update-server-info=92 after `git --bare init=92 worked and=
 I can now push over HTTP.

> yum list git httpd
> ...
> Installed Packages
> git.x86_64                                            1.7.1-3.el6_4.1=
                                          @rhel-x86_64-server-6
> httpd.x86_64                                          2.2.15-28.el6_4=
                                          @rhel-x86_64-server-6

Thank you, again!

-Zachary