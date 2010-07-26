From: Julio Lajara <ju2wheels@gmail.com>
Subject: Potential bug in gitweb 1.7.2
Date: Mon, 26 Jul 2010 00:55:06 -0400
Message-ID: <4C4D152A.7050505@gmail.com>
Reply-To: julio.lajara@alum.rpi.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 26 06:55:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdFih-0005Le-Ls
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 06:55:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752875Ab0GZEzM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jul 2010 00:55:12 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:62017 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751045Ab0GZEzK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jul 2010 00:55:10 -0400
Received: by qyk7 with SMTP id 7so1668650qyk.19
        for <git@vger.kernel.org>; Sun, 25 Jul 2010 21:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=tg9uGP5rvYLJeE4hlLrrdV/w8sEbijkYNPKQazgouUo=;
        b=GffQhQIZ0lUyS5bQX3wXUNlBuWvoQcQwe+y65gqCNP1jxYOdBpgRBhDLHSRDpSGo3h
         bIaENZbSamypk6YFmKwUvZoCa/DrBBq0RyBcAiNI1Rp/psLMKC5xVSt0GxT5xbT2Xbxb
         85SNQMKKmbfOETpRqISm23bj+swSf2ESAb0AI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=LNAlFyXa4Vnrw+U7yKIL9fEcBbQlA0rVzxnKbzDS8x5WCT1tqViN831XHPo039EP6p
         OD5Os52lQ0LWxCHfPMC7MMRAl6S5mM6+VPmwhzeZ/PSYiqx+QQHtPOpzPeInuFc/TG8e
         ifVJz2kH/o0znfjGrRHRorTpxCWiQiZBFBn/c=
Received: by 10.224.44.194 with SMTP id b2mr5322422qaf.29.1280120109239;
        Sun, 25 Jul 2010 21:55:09 -0700 (PDT)
Received: from [192.168.1.100] (c-76-28-16-43.hsd1.ct.comcast.net [76.28.16.43])
        by mx.google.com with ESMTPS id h41sm3678821qcz.37.2010.07.25.21.55.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 25 Jul 2010 21:55:08 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.10) Gecko/20100527 Thunderbird/3.0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151804>

Hi all, I recently had git/gitweb (1.7.0.4) setup on my Ubuntu 10.04 box 
and decided to add ppa:git-core/ppa to get up to 1.7.2. After I did so, 
my previously working gitweb stopped functioning and only shows a blank 
page. Im using apache/cgi and the following error is what I found in my 
apache error log:

[Sat Jul 24 23:11:41 2010] [error] [client 192.168.1.100] Can't call 
method "http" on an undefined value at /usr/share/gitweb/index.cgi line 
3401., referer: http://192.168.1.142/gitweb/


 From the latest source:
cat -n gitweb.perl | grep 3401
   3401        if (defined $cgi->http('HTTP_ACCEPT') &&

Thanks,
