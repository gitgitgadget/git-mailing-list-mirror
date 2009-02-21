From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git merge --abort
Date: Sat, 21 Feb 2009 11:18:30 +0100
Message-ID: <200902211118.32185.jnareb@gmail.com>
References: <43d8ce650902190205yc2274c5gb8e658c8608267ff@mail.gmail.com> <m3ocwwrxtg.fsf@localhost.localdomain> <7v3ae8rvvd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Bryan Donlan <bdonlan@gmail.com>,
	John Tapsell <johnflux@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 21 11:19:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaoxV-0002k1-GH
	for gcvg-git-2@gmane.org; Sat, 21 Feb 2009 11:19:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752523AbZBUKRF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Feb 2009 05:17:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752128AbZBUKRD
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Feb 2009 05:17:03 -0500
Received: from fg-out-1718.google.com ([72.14.220.158]:49558 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751350AbZBUKRB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Feb 2009 05:17:01 -0500
Received: by fg-out-1718.google.com with SMTP id 16so2187509fgg.17
        for <git@vger.kernel.org>; Sat, 21 Feb 2009 02:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=ANmldFxhIE3CUDbMfAn0wi5kQvTCw4jBr8XTgJKpz4g=;
        b=ibNxQtE/LCTIKQP95RMZy7ElxVON8a2mr+jMVu8Q11Vq0E6mv617Ulb1bvozpVm7WT
         NZg4ABDYqgWZnO0SQu10nbaCkSiqYH59DgQv9LNFruC1PSweJsAoHKZihU3d7BAmiTZc
         NDZI3oAUo2P8Kk1LZu+xNM9pFpAFgMPZosZO0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=dBJgFjf7L4gzVsCrY7oCkiDCjYw8m8CxJM0+ZcQnPus4V0DYZoEho4O/ZYZ8ETjVtH
         D6tJuE3uP6/6BUMJy21MeGNzSPb3hvQ5cIzVb95LQa021lXgI8qdGuyVfpQdzt8TFgUt
         ODqHsUghRlMh8HFG+DGo58PfQWMDTbrXCMVgg=
Received: by 10.86.98.18 with SMTP id v18mr1606959fgb.46.1235211419272;
        Sat, 21 Feb 2009 02:16:59 -0800 (PST)
Received: from ?192.168.1.13? (abwx73.neoplus.adsl.tpnet.pl [83.8.247.73])
        by mx.google.com with ESMTPS id e11sm1472781fga.50.2009.02.21.02.16.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 21 Feb 2009 02:16:58 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7v3ae8rvvd.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110936>

On Sat, 21 Feb 2009, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > Perhaps this is the case fo "feature that waits for a user", namely
> > 'git stash --no-reset', which would save a state just in case, perhaps
> > in a separate area and not refs/stash (ORIG_STASH perhaps?).
> 
> Isn't that Nana's "git stash --keep" patch posted a few weeks ago sitting
> in "pu"?

Almost exactly.

When using it as a safety measure (perhaps enabled via configuration
variable, similarly to core.safecrlf or diff.autoRefreshIndex) we would
probably want to not save it in 'refs/stash' stack, but in single-use
ORIG_STATE (similar to HEAD reflog vs. ORIG_HEAD). And of course have
"git merge --abort" (or even "git pull --abort") as a porcelain.

-- 
Jakub Narebski
Poland
