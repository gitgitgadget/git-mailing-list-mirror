From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 0/2] tests: make verify_merge check that the number of
 parents is right
Date: Fri, 6 May 2011 15:54:41 -0500
Message-ID: <20110506205441.GA20182@elie>
References: <20110503090351.GA27862@elie>
 <4DC1CE16.5030808@dailyvoid.com>
 <7vsjsuc704.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Grubb <devel@dailyvoid.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 06 22:54:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIS35-0000II-D2
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 22:54:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932716Ab1EFUyu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2011 16:54:50 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:36643 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932711Ab1EFUyt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2011 16:54:49 -0400
Received: by iyb14 with SMTP id 14so2964428iyb.19
        for <git@vger.kernel.org>; Fri, 06 May 2011 13:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=YyN8Oda+qzU/cA39fbuSS+rpzLX0lhVl5ywaJp1exKw=;
        b=pn04ChMDN+6Rv2bWlw8Ejt92Wg6of+8fW9/NuxXtsBNIWYkp49Zv8ZecxwAzANJvt1
         JPKeAXPVcTgvRPcJPb4ZQxnsDkuIcU+Cvef51vUm3bpmUkDvYKzKVQXnTV7MNx6/9XEn
         PHyT9+g+wbeLimaKXCuS05uJn2fr2eAO3iiRs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Csk9oZIJhaXDVmE4mFEX5jBo3zQIWclUlwUDPV1Tdjfey2vKru4qI1ykYQU3A/H6RF
         g3YcJd9UlQ+bVIqFOSAnTQ/DibxFDVD13IaKLkJRJgNbbPMVtRJ+hQCMSXd6a3FjHy3I
         uAVeU00UneogZkZDdw76uv7HGBhn4QgFHC8uc=
Received: by 10.42.167.72 with SMTP id r8mr3323403icy.131.1304715288548;
        Fri, 06 May 2011 13:54:48 -0700 (PDT)
Received: from elie ([76.206.232.100])
        by mx.google.com with ESMTPS id ui7sm1350690icb.2.2011.05.06.13.54.47
        (version=SSLv3 cipher=OTHER);
        Fri, 06 May 2011 13:54:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vsjsuc704.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173008>

Junio C Hamano wrote:

> 	Side note: I think verify_parents is buggy. It only makes sure
> 	that the earlier parents of HEAD match the commits given, and does
> 	not care if there actually are more parents.

How about this?

Jonathan Nieder (2):
  tests: eliminate unnecessary setup test assertions
  tests: teach verify_parents to check for extra parents

 t/t6010-merge-base.sh |   62 +++++++++++-----------
 t/t7600-merge.sh      |  135 ++++++++++++++++++++++++-------------------------
 2 files changed, 98 insertions(+), 99 deletions(-)
