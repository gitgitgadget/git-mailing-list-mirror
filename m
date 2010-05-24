From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCHv5 GSoC] gitweb: Move static files into seperate subdirectory
Date: Mon, 24 May 2010 22:05:43 +0200
Message-ID: <201005242205.43194.chriscool@tuxfamily.org>
References: <1274714564-7553-1-git-send-email-pavan.sss1991@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, jnareb@gmail.com, normalperson@yhbt.net,
	pasky@ucw.cz
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 24 22:06:01 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGduQ-0004K1-IK
	for gcvg-git-2@lo.gmane.org; Mon, 24 May 2010 22:05:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754287Ab0EXUFw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 May 2010 16:05:52 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:50880 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752909Ab0EXUFw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 May 2010 16:05:52 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 0AE03818043;
	Mon, 24 May 2010 22:05:44 +0200 (CEST)
Received: from style.localnet (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP;
	Mon, 24 May 2010 22:05:43 +0200 (CEST)
User-Agent: KMail/1.12.2 (Linux/2.6.31-20-generic; KDE/4.3.2; x86_64; ; )
In-Reply-To: <1274714564-7553-1-git-send-email-pavan.sss1991@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147645>

On Monday 24 May 2010 17:22:44 Pavan Kumar Sunkara wrote:
> 
>  gitweb/{ => static}/git-favicon.png |  Bin 115 -> 115 bytes
>  gitweb/{ => static}/git-logo.png    |  Bin 207 -> 207 bytes
>  gitweb/{ => static}/gitweb.css      |    0
>  gitweb/{ => static}/gitweb.js       |    0

The patch is supposed to move git-favicon.png and git-logo.png into 
gitweb/static but it doesn't.

>  diff --git a/gitweb/gitweb.css b/gitweb/static/gitweb.css
> similarity index 100%
> rename from gitweb/gitweb.css
> rename to gitweb/static/gitweb.css
> diff --git a/gitweb/gitweb.js b/gitweb/static/gitweb.js
> similarity index 100%
> rename from gitweb/gitweb.js
> rename to gitweb/static/gitweb.js

Only gitweb.css and gitweb.js are moved into gitweb/static and that gives some 
errors when running make install:

install -d -m 755 '/home/christian/share/gitweb'
install -m 755 gitweb.cgi '/home/christian/share/gitweb'
install -d -m 755 '/home/christian/share/gitweb/static'
install -m 644 static/gitweb.js static/gitweb.css static/git-logo.png 
static/git-favicon.png '/home/christian/share/gitweb/static'
install: cannot stat `static/git-logo.png': No such file or directory
install: cannot stat `static/git-favicon.png': No such file or directory
make[1]: *** [install] Error 1
make[1]: Leaving directory `/home/christian/work/git/gitweb'
make: *** [install] Error 2

Best regards,
Christian.
