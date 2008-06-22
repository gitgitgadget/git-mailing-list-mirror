From: "Erez Zilber" <erezzi.list@gmail.com>
Subject: Re: Exec format error when using gitweb
Date: Sun, 22 Jun 2008 17:11:47 +0300
Message-ID: <ce513bcc0806220711k5e8c5085qfa330b017d736142@mail.gmail.com>
References: <ce513bcc0806220651g5cf59516w3fc30a68d7f09e79@mail.gmail.com>
	 <485E5BD6.6060105@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Lea Wiemann" <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 22 16:12:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAQJA-00011X-Ju
	for gcvg-git-2@gmane.org; Sun, 22 Jun 2008 16:12:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752657AbYFVOLt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jun 2008 10:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752646AbYFVOLt
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jun 2008 10:11:49 -0400
Received: from rv-out-0506.google.com ([209.85.198.239]:34165 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752636AbYFVOLs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jun 2008 10:11:48 -0400
Received: by rv-out-0506.google.com with SMTP id k40so6527884rvb.1
        for <git@vger.kernel.org>; Sun, 22 Jun 2008 07:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=dB4dBZvqtOi3cNGKolBd5CvzXr881ksxaS9bDyBcTDk=;
        b=laEdgSSgiqxW9EM5JJLpbSBD8n6kkNQ5Hqf1yjcRPzBdduXSwFEovLeY82F10A22tA
         pRF7nnrifQS1IM1jRJEh7KHC3BIgReyR91XIDmt8RwPXNhjc/7C+uKO6Up1canaiL+LS
         KYhrH8A1pArOf68RwGO/o+EWodg1UVusDa9eQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=X31OVsvCt6m0pnajbqpEi1Zo72zd5rsyGDAGFq8AddYIML01SLwA9dTpipuRH2JoWd
         CLUZP1nqeapAufjWPWPoq92kLpRdHKvtCaaHNlmDnsRG2n5kCOF+pcRgLop9TtGrGgiB
         7MSEFH4LzIKZD65Mrz45ttx14uZ8dJ5s/Q3PM=
Received: by 10.140.148.3 with SMTP id v3mr10939586rvd.71.1214143907981;
        Sun, 22 Jun 2008 07:11:47 -0700 (PDT)
Received: by 10.141.195.7 with HTTP; Sun, 22 Jun 2008 07:11:47 -0700 (PDT)
In-Reply-To: <485E5BD6.6060105@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85776>

On Sun, Jun 22, 2008 at 5:04 PM, Lea Wiemann <lewiemann@gmail.com> wrote:
> Erez Zilber wrote:
>>
>> [Sun Jun 22 16:33:53 2008] [error] [client 172.16.0.7] (8)Exec format
>> error: exec of '/var/www/cgi-bin/gitweb/gitweb.css' failed, referer:
>
> Random guess: Did you make the data files (.css, .png) executable by
> accident, so your server is trying to execute them?
>

Thanks for the quick response. Yeah, I did that after I got
"Permission denied" errors. Now, I chnaged it and it looks like this:

[admin@kites ~]$ sudo ls -l /var/www/cgi-bin/gitweb
total 192
-rwxr-xr-x 1 apache root    164 Jun 19 13:57 git-favicon.png
-rw-r--r-- 1 apache root    208 Jun 19 13:57 git-logo.png
-rwxr-xr-x 1 apache root 170562 Jun 19 13:57 gitweb.cgi
-rwxr-xr-x 1 apache root     79 Jun 22 16:29 gitweb_config.perl
-rw-r--r-- 1 apache root   7112 Jun 19 13:57 gitweb.css

and I get the following errors:

[Sun Jun 22 17:06:08 2008] [error] [client 172.16.0.7] (13)Permission
denied: exec of '/var/www/cgi-bin/gitweb/gitweb.css' failed, referer:
http://kites/cgi-bin/gitweb/gitweb.cgi
[Sun Jun 22 17:06:08 2008] [error] [client 172.16.0.7] Premature end
of script headers: gitweb.css, referer:
http://kites/cgi-bin/gitweb/gitweb.cgi
[Sun Jun 22 17:06:08 2008] [error] [client 172.16.0.7] (13)Permission
denied: exec of '/var/www/cgi-bin/gitweb/git-logo.png' failed,
referer: http://kites/cgi-bin/gitweb/gitweb.cgi
[Sun Jun 22 17:06:08 2008] [error] [client 172.16.0.7] Premature end
of script headers: git-logo.png, referer:
http://kites/cgi-bin/gitweb/gitweb.cgi

Erez
