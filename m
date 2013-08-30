From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] revision: add --except option
Date: Fri, 30 Aug 2013 09:11:29 +0200
Message-ID: <522045A1.3040409@viscovery.net>
References: <1377838805-7693-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?ISO-8859-15?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 30 09:11:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFIro-0007cR-VA
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 09:11:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754814Ab3H3HLd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 03:11:33 -0400
Received: from so.liwest.at ([212.33.55.24]:63325 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754478Ab3H3HLc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 03:11:32 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1VFIri-0001dO-E6; Fri, 30 Aug 2013 09:11:30 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 3667F1660F;
	Fri, 30 Aug 2013 09:11:30 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <1377838805-7693-1-git-send-email-felipe.contreras@gmail.com>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233427>

Am 8/30/2013 7:00, schrieb Felipe Contreras:
> So that it's possible to remove certain refs from the list without
> removing the objects that are referenced by other refs.
> 
> For example this repository:
> 
>   * 374e8dd (crap) crap
>   * 4cbbf7b (test) two
>   * d025ae0 (HEAD, master) one
> 
> When using '--branches --except crap':
> 
>   * 4cbbf7b (test) two
>   * d025ae0 (HEAD, master) one
> 
> But when using '--branches --not crap' nothing will come out.

I like the idea to be able to exclude refs from listings. My use-case is
the following:

To unclutter 'git branch' output, I rename work-in-progress branches to
begin with "wip/", ready-to-merge branches do not carry this prefix. To
inspect unmerged work of the latter kind of branches I would like to
type... what?

  gitk --branches --except --branches=wip --not master
  gitk --branches --not master --except --branches=wip

Would one of these work with your current patch?

-- Hannes
