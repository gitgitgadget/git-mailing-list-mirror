From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-tag bug? confusing git fast-export with double tag objects
Date: Sat, 16 May 2009 09:56:24 +0200
Message-ID: <200905160956.27417.jnareb@gmail.com>
References: <op.utv93sdo1e62zd@merlin.emma.line.org> <7v3ab6uuw4.fsf@alter.siamese.dyndns.org> <4A0E67E9.3020208@op5.se>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Alex Riesen <raa.lkml@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Matthias Andree <matthias.andree@gmx.de>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Sat May 16 10:00:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5Ep8-0000GV-TJ
	for gcvg-git-2@gmane.org; Sat, 16 May 2009 10:00:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753439AbZEPH4h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 May 2009 03:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752822AbZEPH4h
	(ORCPT <rfc822;git-outgoing>); Sat, 16 May 2009 03:56:37 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:48300 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752734AbZEPH4g (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 May 2009 03:56:36 -0400
Received: by fxm2 with SMTP id 2so2307665fxm.37
        for <git@vger.kernel.org>; Sat, 16 May 2009 00:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=icbvnuJ9MF5BRDJCcYu1C38WM6HZTRcNqQa7xy5gLdw=;
        b=Bl+wgeC2hlkJ4nYai8cPmHZgo0eOttDlDS3R/dBH4V2EZUvA3+WtfY7Wvp77ZKm79J
         Dw4LE/BOL8a/QjCtkjK4OwJ+zLb5O74KIBBk6kKC4wpUOt76cnN6GWOuz5bk3C/4TOmS
         p8fA2kjTqaJMc1RgTy4W4UKolLhDDoLzY5GBI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=aKCuh7v6DbyneS+yOsgn5U+KSB7b11Tkn3E+GJhXzUHb29tB92Cp8s9u+s3IKo8rYy
         C6KqEKwh6cTqJG1lZI0YY7SA1AOueuiqHSLpcRm1zCfZMZu77qOIyYGTdADexuUY75/9
         8Ne9BbwMPfAmv+/rLSyOnGt8hbV5d/K2mKtxc=
Received: by 10.86.70.20 with SMTP id s20mr4569482fga.1.1242460596570;
        Sat, 16 May 2009 00:56:36 -0700 (PDT)
Received: from ?192.168.1.13? (abvj81.neoplus.adsl.tpnet.pl [83.8.207.81])
        by mx.google.com with ESMTPS id 12sm3790397fgg.25.2009.05.16.00.56.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 16 May 2009 00:56:36 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4A0E67E9.3020208@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119342>

On Sat, 16 May 2009, Andreas Ericsson wrote:

> Add a tag with a new name, pointing to the original tag. Try doing what
> Matthias did and then run "git show $tagname". It won't show the original
> tag at all, so people have to resort to low-level commands in order to
> see it, but it will still exist as an object.

Not true. Did you check that?

"git show <tag>" shows the whole chain of objects down to non-tag object.

  tag tag1
  Tagger: Jakub Narebski <jnareb@gmail.com>
  Date:   Sat May 16 09:55:13 2009 +0200


  tag1 (retagged)
  tag tag1
  Tagger: Jakub Narebski <jnareb@gmail.com>
  Date:   Sat May 16 09:54:58 2009 +0200
  
  
  tag1
  commit 6d3eee4f5e9fde51f3213320b98bda5f325000e4
  [...]

True, the separation between objects could have been made more explicit...

-- 
Jakub Narebski
Poland
