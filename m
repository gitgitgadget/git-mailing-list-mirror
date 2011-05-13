From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/8] Sequencer Foundations
Date: Fri, 13 May 2011 05:37:56 -0500
Message-ID: <20110513103756.GC30618@elie>
References: <1305100822-20470-1-git-send-email-artagnon@gmail.com>
 <20110511131356.GI2676@elie>
 <BANLkTi=zXWojMOfe9sECUu-X9euCjr4i3w@mail.gmail.com>
 <20110512084136.GD28872@elie>
 <20110512114415.GA14724@elie>
 <BANLkTi=8BrFXfoDwL_fXG2bXarP7d0xioA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 13 12:38:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKplI-0006k3-ED
	for gcvg-git-2@lo.gmane.org; Fri, 13 May 2011 12:38:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758492Ab1EMKiG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2011 06:38:06 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:53532 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751978Ab1EMKiE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2011 06:38:04 -0400
Received: by iyb14 with SMTP id 14so1970310iyb.19
        for <git@vger.kernel.org>; Fri, 13 May 2011 03:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=H7gbMnl0fZqddUd96yAEsUssNKKfHJuFBWlssykEDRI=;
        b=RXwsek4uhjFjjDWd1eRM56oFQlv5lF0/YwqejbmVlQGXTFosyvjBhTUJt1R/FygoEy
         aEUtBy8GD8NystqydN+QTcaZLT8kekvVfSyusZYTHFJyEpSWdoIRrYTLe5tCmMWwHuj+
         jOHgdCfXbePY21jXc90/XdaMpn5xA8XgxS8v0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=gv7kfFiWQSBt1ZIB2MM6Z1wu5cFpZs8EVjWuqPVj5DNZvgcRF2tTC35EIQaw4uOo1j
         DU6elpOogA59ja3fZA1mdJ9K0QtwUA7T2nqQsmhw/7oJIJ1/CCNM9bPXf6OYtOAphven
         mUKtr8KuS8jozavZKWiTgAsdokP9+EjG7R0rc=
Received: by 10.43.59.142 with SMTP id wo14mr1623143icb.373.1305283083554;
        Fri, 13 May 2011 03:38:03 -0700 (PDT)
Received: from elie (adsl-69-209-56-134.dsl.chcgil.sbcglobal.net [69.209.56.134])
        by mx.google.com with ESMTPS id xe15sm834249icb.20.2011.05.13.03.38.01
        (version=SSLv3 cipher=OTHER);
        Fri, 13 May 2011 03:38:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTi=8BrFXfoDwL_fXG2bXarP7d0xioA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173526>

Christian Couder wrote:

> About writing files before each cherry-pick, I am not against it, if
> it is really needed to be safe. I even suggested it in my patch series
> back in November
> (http://article.gmane.org/gmane.comp.version-control.git/162183).
> But it will make cherry-pick less efficient, so it is a kind of
> performance regression that we can perhaps avoid by changing some
> die() into error().

Yes, that's a good point.  Maybe in the long term the extra safety
could become optional.  And I am happy about the die() elimination;
the only part I was not as thrilled about is relying on it.

Some die() calls, like the one in xmalloc, would be very difficult to
eliminate.
