From: Lance <lancethepants@gmail.com>
Subject: Issue with compiling git 1.8.4 under uclibc with gcc 4.6.3
Date: Mon, 26 Aug 2013 14:10:43 -0600
Message-ID: <521BB643.304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 26 22:10:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VE37p-000373-FJ
	for gcvg-git-2@plane.gmane.org; Mon, 26 Aug 2013 22:10:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751808Ab3HZUKs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Aug 2013 16:10:48 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:58136 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751489Ab3HZUKq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Aug 2013 16:10:46 -0400
Received: by mail-pa0-f46.google.com with SMTP id fa1so3876857pad.33
        for <git@vger.kernel.org>; Mon, 26 Aug 2013 13:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=Ibz2G3ShSh3jdB9yz1wfqL2tncSzg0wwABT2lg2CqLI=;
        b=TEi1p9hPc6V5GvKFsAWg+eaCH+ASKZu5SwLUPib4bZSv9wRuzwpcFBcNyan//qZX2Z
         IYgkWId7+bf0dhbxUjLML1C2LREbuVa1apQIYRT4jEA26rTWmPEXwgTw2Qv7OtlKqqBP
         R+B3XLadKZQmVnhM9iUN3hvjI6t7WQGPfO6EQrBm7Kf5iTX6mFDjmy5ETUwp0b069sCT
         m72tyBxTIqUiJcpxSCiLyOsSZOmItm+o+oKXD/gNx474cINnrc/tnF9WVyJ3XftoV+x4
         M+//HihRpOjv96w32JpBCtq+C5ZGpilbLtV1DaayA7sa+rBheyl6S18bzrt4gZj9wrD0
         aWIQ==
X-Received: by 10.68.137.1 with SMTP id qe1mr17510575pbb.25.1377547845529;
        Mon, 26 Aug 2013 13:10:45 -0700 (PDT)
Received: from [10.0.0.155] ([70.103.142.130])
        by mx.google.com with ESMTPSA id tz3sm19818330pbc.20.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 26 Aug 2013 13:10:44 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233021>

Up until the latest release, I've been able to compile git for a uclibc 
based embedded linux. The toolchain I use is from "entware", which is 
based off of the openwrt toolchain.
https://code.google.com/p/wl500g-repo/

Somewhere between git 1.8.3.4 & 1.8.4 there seems to be some changes 
that breaks compilation for my particular situation.  When cross 
compiling I receive the following error.  I also receive the same error 
when compiling natively on the uclibc based device itself.
Not sure if being uclibc based has anything to do with it, but is 
noteworthy. I am not a c programmer.
Both the cross compiler, and embedded device's version off gcc is 4.6.3.
Previous versions compile fine

     CC config.o
config.c: In function 'get_next_char':
config.c:220:14: error: expected identifier before '(' token
config.c:220:14: error: expected statement before ')' token
config.c:220:14: error: expected statement before ')' token
config.c:224:11: error: expected identifier before '(' token

Lance
