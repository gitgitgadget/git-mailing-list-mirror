From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: Re: Git bug. "make [all]" does not use USE_LIBPCRE when "configure
 --with-libpcre" was previously run
Date: Thu, 15 Aug 2013 10:51:23 +0400
Message-ID: <20130815065123.GA23414@ashu.dyn1.rarus.ru>
References: <20130814124849.GA8234@ashu.dyn1.rarus.ru>
 <7v38qcuudi.fsf@alter.siamese.dyndns.org>
 <7vtxistefl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Cc: Stefano Lattarini <stefano.lattarini@gmail.com>,
	Git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 15 08:51:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9rPB-0005U3-Ba
	for gcvg-git-2@plane.gmane.org; Thu, 15 Aug 2013 08:51:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753891Ab3HOGv3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Aug 2013 02:51:29 -0400
Received: from mail-lb0-f171.google.com ([209.85.217.171]:48317 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753442Ab3HOGv3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Aug 2013 02:51:29 -0400
Received: by mail-lb0-f171.google.com with SMTP id t13so361052lbd.2
        for <git@vger.kernel.org>; Wed, 14 Aug 2013 23:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=3UOvdftbiDeCuvxxg/sQMkfAZKmZx0BPwzPjhw4ix1I=;
        b=UKiRBWYDEgQpH70p73c5zDoFyvPPob783ALuDEscp2//svZAW4sxyLdO0ldvT+Yk7F
         N769If+EjXyc+25QFOxVjUwvjrm+YhyqBZmqpYzHp+6uEy+B4XsdHy79IOxSISvIHYsa
         3VG2ZTzkpwfreISUohlMi5cQMS+ULj2qkaOMoTG6W33qq8X9qeYFOP7SgsC7tvENMVLo
         c0vPIr8oWM/nyD2pgmTkAHLTNonZgQ/ifGTjhcHqzvVerw4Da1ceZ1kxXKlr8zCXp1j4
         sRnEY57mOHiQ7u4bXO2qYLIF1G0Xq7ikGZMfRhwHOP/gE/4jbcZfBtjnoQEdq4sbuJwS
         p5Og==
X-Received: by 10.152.2.74 with SMTP id 10mr176290las.36.1376549487755;
        Wed, 14 Aug 2013 23:51:27 -0700 (PDT)
Received: from localhost ([85.21.218.130])
        by mx.google.com with ESMTPSA id ay4sm2169270lbb.2.2013.08.14.23.51.25
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 14 Aug 2013 23:51:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vtxistefl.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232333>

On Wed, Aug 14, 2013 at 09:39:10AM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > This does not have anything to do with C, but is a breakage in our
> > autoconf script.
I've meant C-programmers does understand autoconf, too. But I do not :(.

> > It appears that anything that is meant to be
> > appended at end via $config_appended_defs mechanism is missing from
> > the end result.
> >
> > In fact, symbols whose explicit substitution the above patch
> > removes, e.g. CC_LD_DYNPATH, TCLTK_PATH, NEEDS_SSL_WITH_CRYPTO,
> > etc. are all missing.
> 
> Wait, I spoke too soon.
> 
>     $ rm -f configure config.status &&
>       make configure &&
>       ./configure --with-libpcre &&
>       grep USE_LIBPCRE config.mak.autogen
>     USE_LIBPCRE=YesPlease
> 
> no longer reproduces for me (even though I _thought_ I tried and saw
> the breakage).  Hmmmmmm.....
Oh! That have worked for me, too. No more error occured.
Thank you! 

-- 
Alexey Shumkin
