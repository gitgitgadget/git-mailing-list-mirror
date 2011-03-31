From: Jakob Pfender <jpfender@elegosoft.com>
Subject: Re: [PATCH] Documentation/git-update-index.txt: Remove obsolete note
Date: Thu, 31 Mar 2011 17:18:43 +0200
Organization: elego Software Solutions GmbH
Message-ID: <4D949B53.80801@elegosoft.com>
References: <4D9329C5.3060809@elegosoft.com> <AANLkTik3nEE2mtpRVwuQxfoNZd8Ejpgc=T=GS_jEpXsB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, torvalds@osdl.org,
	spearce@spearce.org, johannes.schindelin@gmx.de, peff@peff.net,
	nico@fluxnic.net, barkalow@iabervon.org, chriscool@tuxfamily.org,
	jrnieder@gmail.com, raa.lkml@gmail.com,
	Matthieu.Moy@grenoble-inp.fr, Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 31 17:18:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5JeE-0004JF-1m
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 17:18:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757842Ab1CaPSv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2011 11:18:51 -0400
Received: from mx0.elegosoft.com ([88.198.54.133]:53753 "EHLO
	mx0.elegosoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752637Ab1CaPSv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2011 11:18:51 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id 26C6F1B4CC0;
	Thu, 31 Mar 2011 17:18:50 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mx0.elegosoft.com
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sqc+FJLZ8862; Thu, 31 Mar 2011 17:18:44 +0200 (CEST)
Received: from [10.10.10.30] (i59F7870A.versanet.de [89.247.135.10])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id 5EEB51B4CAE;
	Thu, 31 Mar 2011 17:18:44 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.14) Gecko/20110223 Thunderbird/3.1.8
In-Reply-To: <AANLkTik3nEE2mtpRVwuQxfoNZd8Ejpgc=T=GS_jEpXsB@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170500>

On 03/31/2011 02:15 PM, Nguyen Thai Ngoc Duy wrote:
 > On Wed, Mar 30, 2011 at 8:01 PM, Jakob 
Pfender<jpfender@elegosoft.com>  wrote:
 >> 8dcf39 (Prevent bogus paths from being added to the index) introduced a
 >> check for files beginning with '.', preventing path names such as
 >> `./file`, `dir/./file` or `dir/../file` from being added. This was
 >> reflected in the man page.
 >>
 >> d089eba (setup: sanitize absolute and funny paths in get_pathspec())
 >> removed this check without reflecting the change in the man page.
 >
 > Sounds good.
 >
 >>   <file>::
 >>         Files to act on.
 >> -       Note that files beginning with '.' are discarded. This includes
 >> -       `./file` and `dir/./file`. If you don't want this, then use
 >> -       cleaner names.
 >> -       The same applies to directories ending '/' and paths with '//'
 >> +       Note that directories ending in '/' and paths with '//' are
 >> +       discarded.
 >
 > Do you mean the slashes or the directories are discarded? Directories
 > are not, I believe.

Since we're talking about update-index, yes, directories are actually
discarded, as update-index only accepts files. Directories can be added
via git-add as git-add just passes the single files in the directory to
update-index.
