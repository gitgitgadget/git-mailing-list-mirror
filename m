From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/8] Introduce vcs-svn lib
Date: Thu, 15 Jul 2010 12:46:29 -0500
Message-ID: <20100715174629.GA32323@burratino>
References: <1279210984-31604-1-git-send-email-artagnon@gmail.com>
 <1279210984-31604-3-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 15 19:47:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZSWt-0008Fm-CM
	for gcvg-git-2@lo.gmane.org; Thu, 15 Jul 2010 19:47:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933925Ab0GORrW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jul 2010 13:47:22 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:56292 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933810Ab0GORrV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jul 2010 13:47:21 -0400
Received: by yxn35 with SMTP id 35so162160yxn.19
        for <git@vger.kernel.org>; Thu, 15 Jul 2010 10:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=x3XGbUNUkzwMscEa84FPbZ9aMa4JhIIzUh06UuxxRzY=;
        b=qdxgqsCSdPJ3MF0EX9jE/ZcnSYqEc+wGsopu4p3KE3Re2iL4Xp4LBcg7ZPG3JxLXxA
         wXPmhKNT7w9C951DhPqU+ffS2hvp6JLJjorBzPDVfCspBX04T+AfzYmOaO6+JcXu01Uk
         gtDxHWqybwHEyrYwZ6FenFdQPzRJ9/ST21hwE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=rc1g84ZJ6ajGsAZsyD3gxgYOb660NeFTSpWQgjsIzl+wymu7EJFsi39MMMxtVhrYoz
         aEI2hri1b19V2UK8YR9aqrUeaWEEiUsiU56aKggnt/t48eu97s+WT6N8Eh5n94W2KzQM
         Bp/q+qTklcyYKkr/MaFP3OPrx35PasBByQ2GE=
Received: by 10.224.73.106 with SMTP id p42mr2285276qaj.176.1279216040656;
        Thu, 15 Jul 2010 10:47:20 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id js14sm5713145qcb.6.2010.07.15.10.47.19
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 15 Jul 2010 10:47:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1279210984-31604-3-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151100>

Ramkumar Ramachandra wrote:

> @@ -1908,6 +1912,8 @@ $(LIB_FILE): $(LIB_OBJS)
>  $(XDIFF_LIB): $(XDIFF_OBJS)
>  	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(XDIFF_OBJS)
>  
> +$(VCSSVN_LIB): $(VCSSVN_OBJS)
> +	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(VCSSVN_OBJS)

 $ make vcs-svn/lib.a V=1
 rm -f vcs-svn/lib.a && ar rcs vcs-svn/lib.a 
 ar: vcs-svn/lib.a: No such file or directory
 make: *** [vcs-svn/lib.a] Error 1

That is because the vcs-svn directory does not exist.  So
probably the LICENSE should be added with the same patch
(and git should learn to track empty directories).

Jonathan
