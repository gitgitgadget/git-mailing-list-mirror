From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: Exec format error when using gitweb
Date: Sun, 22 Jun 2008 16:17:03 +0200
Message-ID: <485E5EDF.1030002@gmail.com>
References: <ce513bcc0806220651g5cf59516w3fc30a68d7f09e79@mail.gmail.com>	 <485E5BD6.6060105@gmail.com> <ce513bcc0806220711k5e8c5085qfa330b017d736142@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Erez Zilber <erezzi.list@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 22 16:18:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAQOM-0002KW-1n
	for gcvg-git-2@gmane.org; Sun, 22 Jun 2008 16:18:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751745AbYFVORK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jun 2008 10:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752091AbYFVORJ
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jun 2008 10:17:09 -0400
Received: from fk-out-0910.google.com ([209.85.128.186]:61644 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751745AbYFVORI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jun 2008 10:17:08 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1951765fkq.5
        for <git@vger.kernel.org>; Sun, 22 Jun 2008 07:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:from;
        bh=8uOAM+cAeawoNBisRlT2rQmw/wu/usFSsu0r2e+kUHM=;
        b=Y891x9UiE6V0MHL+Ls+jyRVNsfEK/6Nxw/mvgiRY6GIorFnmDYWorciuv6U86+4uSD
         73SCvK44wp/ZEN0BapN6VxNfe8G0WR1pSkOfSEcTUo+JClO1UXYzQMhivl490FBah6aI
         VX/X+MvO9WhZtcEcJ0rybF4W4WGc7Npu42jdQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding:from;
        b=F1Zq8qM732XXX7mdD01DcwXFeAKA0NdOgP/gnAsjt5N4L+RrSG+rHbeaC0oORWfjPk
         L0rHddAkmhRSaS+/10lctXG5bfSCplf7Ki//noFlKyCUlPo/Wb82rJmqQRCs15EoJAg3
         /vMwrHIZGo5pzl+Rnk9v1qP5XYUHWAfl4Pjyg=
Received: by 10.78.144.11 with SMTP id r11mr2302517hud.78.1214144227123;
        Sun, 22 Jun 2008 07:17:07 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.209.241])
        by mx.google.com with ESMTPS id 36sm6019005hub.59.2008.06.22.07.17.05
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 22 Jun 2008 07:17:06 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
In-Reply-To: <ce513bcc0806220711k5e8c5085qfa330b017d736142@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85777>

Erez Zilber wrote:
> -rw-r--r-- 1 apache root   7112 Jun 19 13:57 gitweb.css
> 
> [Sun Jun 22 17:06:08 2008] [error] [client 172.16.0.7] (13)Permission
> denied: exec of '/var/www/cgi-bin/gitweb/gitweb.css' failed, referer:

Apparently your web server is trying to execute gitweb.css even though 
its executable bit isn't set -- perhaps because it's located in the 
cgi-bin directory.  I suggest you open 
http://.../cgi-bin/gitweb/gitweb.css and try to get it to display the 
CSS file in your browser; this is a problem with your web server, not 
with gitweb.

(By the way, git-favicon.png and gitweb_config.perl shouldn't have their 
executable bits set either, since they're not CGI scripts.)

-- Lea
