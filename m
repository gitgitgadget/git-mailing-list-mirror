From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String Library.
Date: Fri, 11 Jun 2010 05:23:55 -0700 (PDT)
Message-ID: <m3mxv1pxli.fsf@localhost.localdomain>
References: <46DDC500.5000606@etek.chalmers.se>
	<1189004090.20311.12.camel@hinata.boston.redhat.com>
	<vpq642pkoln.fsf@bauges.imag.fr>
	<4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com>
	<loom.20100610T204637-685@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Dmitry Kakurin <dmitry.kakurin@gmail.com>
To: Ian Molton <ian.molton@collabora.co.uk>
X-From: git-owner@vger.kernel.org Fri Jun 11 14:24:10 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ON3HN-00022y-8Z
	for gcvg-git-2@lo.gmane.org; Fri, 11 Jun 2010 14:24:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760194Ab0FKMYB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jun 2010 08:24:01 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:36756 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759976Ab0FKMYA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jun 2010 08:24:00 -0400
Received: by fxm8 with SMTP id 8so601772fxm.19
        for <git@vger.kernel.org>; Fri, 11 Jun 2010 05:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=etZTyUeIKHjTyWdJd1EnDgeGOCsZIoOjKx2dvbWXG0U=;
        b=cJJwLV5Ykdq33jgugtPfVBwxyUjFbFQCpbcGOkWjbmsD9kIhx3SaCzeobnCm+IduRs
         /mAoBCKo2UYOMgY2TO8WXUi78vvi7tuxxa6OPHyWlktgH2wvP29+91hV9L3TvI1MoP3R
         ixLSgy24kV4B03paAP++FajMJ7xpTBHSLKuhA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=vkvrv3jqSc7Xhp+jRz2GdjQap4Ct9QvIEAtbQJn1xvxvlnMTBxj++IqG1G0zFEV+wm
         uJnigWO1oLepq2khgq/Wf6w6DIBn4mmj4sGii5BTgKtLCT/30ySGtYblipE3TaXUlpvJ
         1UxilPHkmbPOeCci/d8SSd5uBfLs2vQKioaAc=
Received: by 10.102.246.2 with SMTP id t2mr485293muh.103.1276259035958;
        Fri, 11 Jun 2010 05:23:55 -0700 (PDT)
Received: from localhost.localdomain (abuz71.neoplus.adsl.tpnet.pl [83.8.197.71])
        by mx.google.com with ESMTPS id y37sm1585558mug.22.2010.06.11.05.23.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 11 Jun 2010 05:23:55 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o5BCNLKk009548;
	Fri, 11 Jun 2010 14:23:32 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o5BCN5aA009543;
	Fri, 11 Jun 2010 14:23:05 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <loom.20100610T204637-685@post.gmane.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148939>

Ian Molton <ian.molton@collabora.co.uk> writes:
> Dmitry Kakurin <dmitry.kakurin <at> gmail.com> writes:
>
> > [ snip ]
> > 
> > When I first looked at Git source code two things struck me as odd:
> > 1. Pure C as opposed to C++. No idea why. Please don't talk about 
> > portability, it's BS.

No gain from C++.

Also, I don't know when Dmitri written his post, but git uses its own
string manipulation mini-library, named strbuf, at least since end of 2007
(Documentation/technical/api-strbuf.txt was added as stub on 2007-11-24).
 
> > in the *real world* rewriting Git in assembly would be like  
> > painting a house using a single horse hair instead of a paint brush  
> > or roller. Your SHA-1 example is a perfect example of where you  
> > benefit from doing a tiny embellished detail using the single hair  
> > (assembly) and leave all the rest in C.

Sidenote: block-sha1 implementation is C plus smidgeon of assembly via
'asm'.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
