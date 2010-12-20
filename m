From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: cvsimport still not working with cvsnt
Date: Mon, 20 Dec 2010 15:36:54 -0600
Message-ID: <20101220213654.GA24628@burratino>
References: <4D0ED5EC.9020402@burntmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Emil Medve <Emilian.Medve@Freescale.com>,
	Pascal Obry <pascal@obry.net>,
	Clemens Buchacher <drizzd@aon.at>,
	Martin Langhoff <martin@laptop.org>
To: Guy Rouillier <guyr@burntmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 20 22:37:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PUnQ3-0003uz-6j
	for gcvg-git-2@lo.gmane.org; Mon, 20 Dec 2010 22:37:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755559Ab0LTVhP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Dec 2010 16:37:15 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:38541 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754573Ab0LTVhO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Dec 2010 16:37:14 -0500
Received: by wwa36 with SMTP id 36so3458193wwa.1
        for <git@vger.kernel.org>; Mon, 20 Dec 2010 13:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=i8yDXuF2rUYQn7tGy64FE6PMaczqfO53WJH0whDsNFA=;
        b=Bv0f/xknARhhzBRj5HkUllq6F5XVQZUsKiyMf72FFbxp2jOWrho+VkZ4epEJgORuX0
         aeOYyL6YZSBR1hEB5uMlAdSsnjAzChzMuwrauoy6Kcj7xx3cDl4w4igeDS0mssMG46xA
         2LCSV4ksM4deIFBYplhgy17mZFr6JlNL+c5dg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=C9NgOn/ZqvBdKRikXTZhdyLfJnHNXXVOqxKge8jdvFVCg/PsRDtaRsgGnomxEwkW+V
         mfOsfrY+57xRq83wDhb5IHqgkMUtBjptamP2sYdk+30yzoKdZ/Tj5F3iYZZ9JbLcIrSx
         EjkA2+TnaJIQxDqHjQh26AkwgtLU0iSnYXps0=
Received: by 10.216.156.6 with SMTP id l6mr8136282wek.55.1292881032848;
        Mon, 20 Dec 2010 13:37:12 -0800 (PST)
Received: from burratino (c-76-126-174-171.hsd1.ca.comcast.net [76.126.174.171])
        by mx.google.com with ESMTPS id n78sm2130913weq.27.2010.12.20.13.37.08
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 20 Dec 2010 13:37:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D0ED5EC.9020402@burntmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164013>

(+cc: Emil, some cvsimport people)

Guy Rouillier wrote:

> I'm going to try sending this blind, as the mailing list has sent me
> the promised authorization key after 24 hrs.

No problem.  Actually a subscription is not required --- the
convention on this list is to always reply-to-all.

> I finally found the problems, both of which were reported in 2008
> here:
>
> http://kerneltrap.org/mailarchive/git/2008/3/13/1157364

Seems to have received no replies[1].

> I do see one possible issue with the supplied modifications.  At
> work, we upgraded from CVS to CVSNT.  So, my home directory has both
> .cvspass (from the original CVS) and .cvs/cvspass (after the
> conversion to CVSNT.)  Sloppy housekeeping on my part, I admit, but
> probably not uncommon.  The supplied patch would pick up the
> original CVS file and would fail.  (BTW, this is true only of the
> git-cvsimport.perl script itself; cvsps must shell out to the
> installed CVS client (in my case, cvsnt), because when I invoked
> that manually, it worked.)
> 
> So, I would advise checking to see if both files exist, and if so
> exit with an error.  Unless cvsimport wants to get real fancy and
> shell out to the installed cvs client to try to figure out what is
> installed, there is no way to tell which cvspass file is actively
> being used.  I don't recommend trying to figure this out, as the
> user's intent is unclear.

Thanks, sounds sane to me.  Care to write a patch?

Regards,
Jonathan

[1] http://thread.gmane.org/gmane.comp.version-control.git/77109
