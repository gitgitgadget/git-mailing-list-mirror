From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: Re: [PATCHv3 GSoC] git-instaweb: Configure it to work with new gitweb 
	structure
Date: Sun, 23 May 2010 15:48:15 +0530
Message-ID: <AANLkTim5M4Bv0T93GxvCLMR5kGmhaGjdGW9zqMp_isZQ@mail.gmail.com>
References: <1274599968-3749-1-git-send-email-pavan.sss1991@gmail.com>
	 <20100523095645.GD3426@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jnareb@gmail.com, chriscool@tuxfamily.org,
	pasky@ucw.cz
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun May 23 12:19:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OG8H7-0002bE-K1
	for gcvg-git-2@lo.gmane.org; Sun, 23 May 2010 12:19:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753103Ab0EWKSR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 May 2010 06:18:17 -0400
Received: from mail-gx0-f227.google.com ([209.85.217.227]:35688 "EHLO
	mail-gx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752904Ab0EWKSQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 May 2010 06:18:16 -0400
Received: by gxk27 with SMTP id 27so106916gxk.1
        for <git@vger.kernel.org>; Sun, 23 May 2010 03:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=69Y6zGH57wOOa4Yr2wDRXXQsJghSNx1C+NLtEwn+Yoc=;
        b=UqoANlOIxOc4+kAaFRY6wX5XzJtIVV2dDH8DBzoL84eXY5KPljWncNqo2uVbalD35u
         NDwjdO2OZKRZP2+B2vZ7/5RMdx5x+5aGggY6Q7Oh0H+0ci0IFE4fK3o43VLoWXdwFPNn
         Y/4qK/urq19r7cVa3lbN/ipOr3zuKhs6seMF4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=x3zgRHNugCfKQ27ig4A7QhOGPk1dqdGxgCuORe7//NDqeAeicJYABH12LvboGY9jZS
         j3SxyScY+/EGKcapWJHyhOd0DbFOGpLmCnxEk7MeiN3RK9WQzQhbO7jY9R8bQvEbWiIb
         G6WqPtWwWyTIGLpZlExk9+M35YP0OYyrHq0bU=
Received: by 10.90.203.8 with SMTP id a8mr2191986agg.138.1274609895166; Sun, 
	23 May 2010 03:18:15 -0700 (PDT)
Received: by 10.90.84.5 with HTTP; Sun, 23 May 2010 03:18:15 -0700 (PDT)
In-Reply-To: <20100523095645.GD3426@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147570>

On Sun, May 23, 2010 at 3:26 PM, Eric Wong <normalperson@yhbt.net> wrot=
e:
> Pavan Kumar Sunkara <pavan.sss1991@gmail.com> wrote:
>> While at it, change apache2 configuration to use the same access log
>> and error log files as the rest of web servers supported by
>> git-instaweb.
>
> Hi Pavan, I'm late to this thread, but I'm leaning against forcing
> access logs onto people. =A0I don't believe access logs are necessary=
 for
> instaweb. =A0Error logs are important for debugging breakage, yes, bu=
t
> access logs aren't worth the trouble IMHO.
>
> Also, using the same error log paths might make it confusing to peopl=
e
> switching between web servers. =A0In fact, it may be the most confusi=
ng
> for those folks if they're trying different web servers and forgettin=
g
> to shut down the previous server before starting the next. =A0They co=
uld
> end up seeing confusing log messages from the wrong server if they
> look in the error log to debug the problem.
>
> I'm not sure why Mongoose has access logs enabled by default, but I k=
now
> I conciously left it out by default for lighttpd/apache/webrick.
>
> --
> Eric Wong

Well, Until before this patch, lighttpd and mongoose have been using
the same error log and access log.
So, I enabled it for apache2 too in the process of debugging
git-instaweb while using apache2.

IMVHO If there is no problem using the same logs for lighttpd and
mongoose until now, I don't think it will be a problem when apache2 is
included into that group.

- Pavan
>
