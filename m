From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Help! My ISP blocks repo.or.cz. How to push changes?
Date: Mon, 12 Jan 2009 12:13:44 +0100
Message-ID: <200901121213.45858.jnareb@gmail.com>
References: <200901120246.28364.jnareb@gmail.com> <81b0412b0901120117mf010317m79874a235e29a439@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 12 12:15:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMKlK-00029V-7d
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 12:15:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751786AbZALLNx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 06:13:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751776AbZALLNx
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 06:13:53 -0500
Received: from mail-ew0-f17.google.com ([209.85.219.17]:41921 "EHLO
	mail-ew0-f17.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750856AbZALLNw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 06:13:52 -0500
Received: by ewy10 with SMTP id 10so11435997ewy.13
        for <git@vger.kernel.org>; Mon, 12 Jan 2009 03:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=ePdFOcztu5bzxDBaFzycHx0O52gNK506ZgAUF0oNp2c=;
        b=pahVQcvEnj4+W4m8Q2sFIcCLrT9O/I7q1Z3wgVJ+g8DAgNq0OkagNpWGC/Mdr47hOO
         qy0AJ1PKYcAbhvVJGavwKp/T+RtteLNrCMJwGX1ZCmfdWEmiZnDApAkUi4kKiip92f1s
         Ge7ylN1Md8onkVRh4Rrn9QpDf24d+ppxGghLM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=EML3UaOyHLoEB43cN15vFNLaeroG630zlYMGlWLURyTS64QiPecTiZLqrUnLMHZF8j
         3l4KQtQS7bOG09302QCmFPb49udH4PidJ8J6kw2vC/D1TzUR+dnXbrDbHAbRV4knnXfZ
         Ggo8GHn9tfwfHDRjIFr4qMEs/0LK6AofVjVvk=
Received: by 10.210.19.16 with SMTP id 16mr3423901ebs.36.1231758830443;
        Mon, 12 Jan 2009 03:13:50 -0800 (PST)
Received: from ?192.168.1.11? (abvj184.neoplus.adsl.tpnet.pl [83.8.207.184])
        by mx.google.com with ESMTPS id h4sm54858262nfh.25.2009.01.12.03.13.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 12 Jan 2009 03:13:49 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <81b0412b0901120117mf010317m79874a235e29a439@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105325>

Alex Riesen wrote:
> 2009/1/12 Jakub Narebski <jnareb@gmail.com>:

> > Do you have any suggestions to bypass this block for git? I have access
> > to Linux shell account (no root access, though) which doesn't have
> > problems with repo.or.cz, so I think I could set up SSH tunnel: but
> > how? And what to do with access via git:// - move to SSH too?
> 
> See man ssh, look for -L. It works for arbitrary ports, so you can redirect
> git:// port to anywhere. Same for push over ssh, just give another port when
> connecting.

Currently I have the folowing in my ~/.ssh/config:

  # TP S.A. blocks repo.or.cz
  Host repo.or.cz
	NoHostAuthenticationForLocalhost yes
	HostName localhost
	Port 2222

and I can simply use "git push repo" without any changes.
But I have to run 

 $ ssh -f -N -L 2222:repo.or.cz:22 jnareb@host.example.com

first. Is there any way to automate this?

-- 
Jakub Narebski
Poland
