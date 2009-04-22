From: Allan Caffee <allan.caffee@gmail.com>
Subject: Re: [PATCH] graph API: fix extra space during pre_commit_line state
Date: Wed, 22 Apr 2009 15:38:38 -0400
Message-ID: <20090422193838.GA1841@linux.vnet>
References: <87zlea9lit.fsf_-_@iki.fi> <20090421183412.GA8499@linux.vnet> <87y6tt2wuq.fsf@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Teemu Likonen <tlikonen@iki.fi>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 22 21:40:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwiJ2-0004sh-Gu
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 21:40:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753477AbZDVTiw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 15:38:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752876AbZDVTiw
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 15:38:52 -0400
Received: from wf-out-1314.google.com ([209.85.200.172]:34685 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752698AbZDVTiv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 15:38:51 -0400
Received: by wf-out-1314.google.com with SMTP id 26so126858wfd.4
        for <git@vger.kernel.org>; Wed, 22 Apr 2009 12:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mail-followup-to:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=nss8nuADqNMVPewPwNg76LiGMBtMTpHCtmn/ItFsdk0=;
        b=jPmU79K1G0wZphgVU2bmMkukK9WAytngLOhDB5MjxN2wPcfiYGOBJBZQKcfe0aFJ0O
         nEG+s9XZd6q+QTvZggCjVKabbh5INGvxR9X2rRsCaD+0vM3hGjB16lKgTvHsWvhxxesU
         AJjpMANf4Yt6kdWV/M/gI5t1Lz2SiRd5E/9tY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=nGuWR9bGHJGIEuMcy5TJZDzMDgqR9EdYvzRVjpzTFrGC4layFmpP1RkiP01AqAtP7m
         BXgdebUDyKh1TFKyLaAHsJ/UPlHXy6U4kB+lywKKM2vh4FSEKZih++nm2+lkHM3gOTR0
         GH/2UsGBlKeUfSUmBHOo6UALpN0y9I882/Qj0=
Received: by 10.142.132.2 with SMTP id f2mr27592wfd.309.1240429129668;
        Wed, 22 Apr 2009 12:38:49 -0700 (PDT)
Received: from linux.vnet (n2-53-87.dhcp.drexel.edu [144.118.53.87])
        by mx.google.com with ESMTPS id 32sm736314wfc.26.2009.04.22.12.38.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 22 Apr 2009 12:38:48 -0700 (PDT)
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Teemu Likonen <tlikonen@iki.fi>
Content-Disposition: inline
In-Reply-To: <87y6tt2wuq.fsf@iki.fi>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117239>

On Wed, 22 Apr 2009, Teemu Likonen wrote:

> On 2009-04-21 14:34 (-0400), Allan Caffee wrote:
> 
> > An extra space is being inserted between the "commit" column and all of
> > the successive edges.  Remove this space.  This regression was
> > introduced by 427fc5b.
> >
> > Signed-off-by: Allan Caffee <allan.caffee@gmail.com>
> 
> Looks like it's working now, thanks. Let's Cc to Junio so that he
> doesn't miss the fix.

Actually, Junio, please disregard this patch for the moment.  I'll
resend it in a series along with another minor fix related to octopus
merges.

> > This issue exposes a gap in the existing test coverage, which doesn't
> > exercise the pre_commit_line code.  Maybe another patch is in order to
> > extend t4202-log to cover pre-commit lines and octopus merges.
> 
> I think that's a good idea. I like "log --graph" very much and when
> someone alters that part of the code I run my own visual "test suites"
> to notice if my pet feature has been broken. :-) Automatic tests would
> be helpful.

I'll include a test patch in that series as well.
