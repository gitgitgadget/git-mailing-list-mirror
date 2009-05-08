From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: I want "fast forward my workdir to upstream if it's safe"
Date: Fri, 08 May 2009 09:15:31 -0700 (PDT)
Message-ID: <m3prejmv2f.fsf@localhost.localdomain>
References: <86prekfv7z.fsf@blue.stonehenge.com>
	<20090508023028.GA1218@coredump.intra.peff.net>
	<F871F2A1-DFCF-4642-BB53-7BE483A93271@orakel.ntnu.no>
	<7vk54rvb8x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no>,
	Jeff King <peff@peff.net>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org,
	Yuval Kogman <nothingmuch@woobling.org>,
	Sverre Hvammen Johansen <hvammen@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 08 18:16:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2SkL-0008J5-JY
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 18:16:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753126AbZEHQPf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2009 12:15:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753016AbZEHQPe
	(ORCPT <rfc822;git-outgoing>); Fri, 8 May 2009 12:15:34 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:41437 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751653AbZEHQPd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2009 12:15:33 -0400
Received: by ey-out-2122.google.com with SMTP id 9so512091eyd.37
        for <git@vger.kernel.org>; Fri, 08 May 2009 09:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=kE3dKqeNf53Ah52shhbUN+b3D5gapJ+wfd81ZfNbYBU=;
        b=MRJA+Rq8r5Gy2vWzvhyCgb8DmpyJaIHInuIAnY5XzeL9Gg4VBJ6A0qzes3JYl3RODD
         cxmlyc/NcM94DYZxozv/TVjZIh7U73kAbP+EdK2STNswmTSQ2JDD+LqyrJEwPs0HkuBT
         FzhJvFo0hY/pu0sjmrDTD0siD2kLCb4hlqFKk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=qCZp+eGMcG4jIdn6bOcjfDd6cUkGLLrHbnxykXDwpyCe8gI4i/9MEbzXsdD+/TKizN
         K+wp/YI0XlWke3fuoEyM8Xpp9scQds2z8k/f1+SxzfqsS++J7m4AERmTM3N+busg3jE/
         4Mk78OzmeU0KPSTCdPEDHl4rmQ76hxW3XK01g=
Received: by 10.216.10.72 with SMTP id 50mr1662747weu.127.1241799332894;
        Fri, 08 May 2009 09:15:32 -0700 (PDT)
Received: from localhost.localdomain (abwe61.neoplus.adsl.tpnet.pl [83.8.228.61])
        by mx.google.com with ESMTPS id j8sm2781259gvb.11.2009.05.08.09.15.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 08 May 2009 09:15:31 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n48GENbU014844;
	Fri, 8 May 2009 18:14:34 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n48GDjJ1014829;
	Fri, 8 May 2009 18:13:45 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vk54rvb8x.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118614>

Junio C Hamano <gitster@pobox.com> writes:
> Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no> writes:
> 
> > I read it as a request for pull/merge --ff-only (based on "abort if
> > the workdir is dirty or is not a fast-forward update").  This feature
> > has been implemented twice, but never included:
> 
> Interesting.  Do you mean twice they were both found lacking, substandard,
> useless, uninteresting, buggy, incorrect, or all of the above?  Or was it
> just somebody simply forgot to apply a perfect patchset twice?

I think (if I remember correctly) that they were once to be split into
just --ff-only and --ff=<strategy>, and once there were almost ready,
and either feature freeze happened, or the author didn't have time to
resend corrected patches, or both.

I cc-ed authors of both versions (longer by Sverre, only --ff-only by
Yuval)
-- 
Jakub Narebski
Poland
ShadeHawk on #git
