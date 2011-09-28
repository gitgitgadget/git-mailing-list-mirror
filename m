From: Cord Seele <cowose@googlemail.com>
Subject: Re: [PATCH] git-send-email.perl: expand filename of aliasesfile
Date: Wed, 28 Sep 2011 16:40:57 +0200
Message-ID: <20110928144057.GC12586@laptop>
References: <20110928131307.GB12586@laptop>
 <vpqwrcspyvq.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Sep 28 16:41:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8vK0-0004PZ-34
	for gcvg-git-2@lo.gmane.org; Wed, 28 Sep 2011 16:41:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753251Ab1I1OlA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Sep 2011 10:41:00 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:49505 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751346Ab1I1OlA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Sep 2011 10:41:00 -0400
Received: by fxe4 with SMTP id 4so623970fxe.19
        for <git@vger.kernel.org>; Wed, 28 Sep 2011 07:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=rQ8dj405TP9xXfYBkad9BwpUrxvSE0ygG59OT1QinHc=;
        b=BJQWd/eAdffDzFVOWqC4m8qNcshWotyBKK6xrsES+UVK4r1Qo28fwksQ1WqJlcsF6o
         j07PMkzVRMSc6sc9ked2eiirzuxUf3TRj0bSVefZyQ+JKcsnel+kUVZSuXpirmZsLphS
         nSihA0uVwjW45b3EBzc/lrtr9CBRGbPEodbHg=
Received: by 10.223.42.202 with SMTP id t10mr156387fae.71.1317220858860;
        Wed, 28 Sep 2011 07:40:58 -0700 (PDT)
Received: from laptop (p4FF1B1D8.dip.t-dialin.net. [79.241.177.216])
        by mx.google.com with ESMTPS id h16sm27544363fab.19.2011.09.28.07.40.57
        (version=SSLv3 cipher=OTHER);
        Wed, 28 Sep 2011 07:40:58 -0700 (PDT)
Mail-Followup-To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>
Content-Disposition: inline
In-Reply-To: <vpqwrcspyvq.fsf@bauges.imag.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182326>

On Wed 28 Sep 2011 15:42:01 +0200, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:

> Cord Seele <cowose@googlemail.com> writes:
> 
> > -		open my $fh, '<', $file or die "opening $file: $!\n";
> > +		open my $fh, '<', glob($file) or die "opening $file: $!\n";
> 
> That'd be cleaner to use
> 
> git config --path sendemail.aliasesfile
> 
> to let Git do the right expansion, in a way consistant with other places
> of Git.

This means to expand it at 'git config' time? Wouldn't it be nicer to
have it expanded when you run 'git send-email'? Then you could move your
~/.gitconfig (that's where I have my aliasesfile configured) between different
accounts and it could still work.

-- Cord
