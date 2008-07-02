From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: git push requires a subsequent git reset --hard ?
Date: Wed, 2 Jul 2008 17:36:06 +0400
Message-ID: <20080702133606.GP5737@dpotapov.dyndns.org>
References: <912ec82a0807010951j9e970f2k9624682b33c8af7d@mail.gmail.com> <m3vdzpfr16.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Neshama Parhoti <pneshama@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 02 15:42:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KE2ar-0002u7-C7
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 15:41:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752185AbYGBNk6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 09:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752568AbYGBNk6
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 09:40:58 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:41755 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751734AbYGBNk5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 09:40:57 -0400
Received: by py-out-1112.google.com with SMTP id p76so173193pyb.10
        for <git@vger.kernel.org>; Wed, 02 Jul 2008 06:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=jf8cXEoXQ86rMH6J0YfvYg9B0mu2KlJsJUKWZw+3NPo=;
        b=UUqAAACC7qGR79ogk9qWXIOYiJ8LIpwhe4Tw0++3Kgn41PYNntteCNMZaNhgo6Zi6t
         3mjsaXoxhpVCV0U5Nzi0y3p38wF6O8h0o82IplqzB0H8PFh7iz8v5IwPp6u7+vdjoX8h
         rH+UPA8qVeSzHpXcUVwSCeV4/nu06n0Eja7DU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=CaEzfJRDPjwwSEuTENMKpsp3XdtNMNJV1lyzc98Gv2RpHSPfk+9mtjxfoPH3QR7RPS
         0l1Iv7LHQYJVgNAtB83XP0S/WFshxZ4LRI+enIxRICk8wK086Mlq82w0L2DMyZy3CGc2
         EhpF8S6UDEjEIFAMvt1YKcgOK7Bji+rXfSdDQ=
Received: by 10.114.110.1 with SMTP id i1mr7001898wac.112.1215005800161;
        Wed, 02 Jul 2008 06:36:40 -0700 (PDT)
Received: from localhost ( [83.237.184.117])
        by mx.google.com with ESMTPS id e8sm350550muf.0.2008.07.02.06.36.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 02 Jul 2008 06:36:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <m3vdzpfr16.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87136>

On Tue, Jul 01, 2008 at 10:29:38AM -0700, Jakub Narebski wrote:
> 
> This is considered normal.  Push would never touch index nor working
> area (although if you are the only user, and you know what you are
> doing, you can add "git reset --hard HEAD" to post-receive hook).

Doing "reset --hard" makes all your uncommit changes to be lost.
OTOH, if you push on the local branch assotiated with HEAD then
recovering all uncommit changes later will not be easy either. So,
I wonder, if git push should require --force if you want to push
to the HEAD branch of a non-bare repo. It will be at least some
warning (especially for novices) to not to do that, and those who
really want to understand what they are doing can use --force.

Dmitry
