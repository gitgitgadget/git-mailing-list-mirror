From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] Remove function stubs in shell.c
Date: Fri, 18 Jul 2008 10:06:34 +0400
Message-ID: <20080718060634.GK2925@dpotapov.dyndns.org>
References: <20080718005814.GA4155@spearce.org> <1216343197-20290-1-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Fri Jul 18 08:07:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJj7z-0006RL-EU
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 08:07:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329AbYGRGGl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 02:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751285AbYGRGGl
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 02:06:41 -0400
Received: from mu-out-0910.google.com ([209.85.134.188]:53245 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751202AbYGRGGk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 02:06:40 -0400
Received: by mu-out-0910.google.com with SMTP id w8so293615mue.1
        for <git@vger.kernel.org>; Thu, 17 Jul 2008 23:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Ir6V93dk+i2hZkTDF5ycIWmwseYEW8a3eTROuFg3MKQ=;
        b=tTZ1DA2XQowSg/OJs5QXRh82L7FFviEO3Qc9JSonTzZ9Ru6AeZis9nk+rty2dK//gE
         E3Wa0b8qA/XLmCxUGAchfElhTXFAZppnCFvX3yuMjI26y7Uc8GuV+2bcEw79x47BU4MF
         koi06zwMgv336aawwGm+qi9zBo/R2Mos6W/S4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=gcTIJe8nonHxjckoczu0NC9S9nLxjUGyT9NGuf2DDnV+K66lQZsY5vbcxElHJhSiLb
         IIHRmh6TsZtaytYRyT7GLQBP3hyG62zl4SGaw/hVPrSY25OXpsj0oSpn3J9+L8XAEie0
         EJM8c7fFKUlmW0k+jZRUZErZ5H+mjxvhdoahw=
Received: by 10.103.214.8 with SMTP id r8mr2629127muq.64.1216361198722;
        Thu, 17 Jul 2008 23:06:38 -0700 (PDT)
Received: from localhost ( [85.140.168.212])
        by mx.google.com with ESMTPS id t10sm7662712muh.17.2008.07.17.23.06.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 17 Jul 2008 23:06:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1216343197-20290-1-git-send-email-s-beyer@gmx.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88993>

On Fri, Jul 18, 2008 at 03:06:37AM +0200, Stephan Beyer wrote:
> These function stubs may be useful, but because they redefine
> functions, they provoke a linker error.
> 
> Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
> ---
> Or would you rather like this one? ;)

Unfortunately, this one will increase the size of git-shell
considerably:

   text    data     bss     dec     hex filename
  18182     824    8232   27238    6a66 git-shell
===
   text    data     bss     dec     hex filename
 146738    1376   93164  241278   3ae7e git-shell

So, personally, I don't like it.

Dmitry
