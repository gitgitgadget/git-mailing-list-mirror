From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Moving a directory with history from one repository to another while renaming
Date: Thu, 21 Jun 2007 14:57:28 +0100
Message-ID: <200706211457.29030.andyparkins@gmail.com>
References: <200706211337.32978.andyparkins@gmail.com> <20070621130137.GB4487@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 21 15:57:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1NAC-0003cu-4d
	for gcvg-git@gmane.org; Thu, 21 Jun 2007 15:57:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755611AbXFUN5a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jun 2007 09:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755206AbXFUN5a
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jun 2007 09:57:30 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:35430 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753717AbXFUN52 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2007 09:57:28 -0400
Received: by ug-out-1314.google.com with SMTP id j3so579770ugf
        for <git@vger.kernel.org>; Thu, 21 Jun 2007 06:57:27 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=GJCJXXcjfH8Rm2mllRcpK6lBmq5tNfI/CjKuenxTlga/OL1UGbJ0gtFn1OCI3SDYCz+1KTDCbZSMIzB6Xo5JY+iYN6GT+6c4++xcpqPmy3qTOZjIod/g1+hNbKT1TqPHROzmJkdD5qfR0ujSNEWu6wJ0zSTdjKIoGJ1md+TGrqQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=QuraSl0xqKQCc+WQB/8sJfGbmEPcffvNRCvvvVaxn2x4W+M3c1ungO747FIFBAZCztcu8BxhAEa/3h0Qhtoafijr8nDHqc57n9h9UIqqk5sFBGmdbpFOREcbY9whkpD6XYE/Wqnc/Ln4/QMF2h0GU0SkcrFEse/utgxTydMpWbU=
Received: by 10.66.242.19 with SMTP id p19mr2066143ugh.1182434247522;
        Thu, 21 Jun 2007 06:57:27 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id z37sm3629061ikz.2007.06.21.06.57.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 21 Jun 2007 06:57:26 -0700 (PDT)
User-Agent: KMail/1.9.7
In-Reply-To: <20070621130137.GB4487@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50627>

On Thursday 2007 June 21, Jeff King wrote:

> You can do this much more efficiently by just operating on the index.
> Something like:
>
> git-filter-branch --index-filter \
>  'git-ls-files -s | sed -n 's/change/paths/p' | git-update-index
> --index-info' \ directorymoved

:-D  Even better.  I am definitely in the "fan of git-filter-branch" camp.

Thanks for sharing that line; I've actually found it instructive for more than 
just git-filter-branch.  I definitely hadn't appreciated the fact that the 
index can be so easily manipulated.



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
