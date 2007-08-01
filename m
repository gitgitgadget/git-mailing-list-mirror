From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git benchmark - comparison with Bazaar, Darcs, Git and Mercurial
Date: Thu, 2 Aug 2007 01:51:16 +0200
Message-ID: <200708020151.17301.jnareb@gmail.com>
References: <200708010216.59750.jnareb@gmail.com> <200708011033.00873.jnareb@gmail.com> <7vzm1b7i8v.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 02 01:51:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGNyN-00035c-7k
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 01:51:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753574AbXHAXvU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 19:51:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753558AbXHAXvU
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 19:51:20 -0400
Received: from mu-out-0910.google.com ([209.85.134.184]:43468 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753432AbXHAXvT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2007 19:51:19 -0400
Received: by mu-out-0910.google.com with SMTP id i10so444596mue
        for <git@vger.kernel.org>; Wed, 01 Aug 2007 16:51:17 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=i6z29rZl0kNrD7Bs7kt+TdzlbYFmLKYwi4C53NNFRGt9gNtfPrBDlC5q6okUc2otKMVLcO8pBc55LC07rrPz8r7VneDqrHdLHuJsyP6H6jpJAjAu5MtFMXyjnIxUctdfCyUJVAtxRjxltUnPx5NJsx9faII7yQxnB4pxnvXSyoA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=IJqwZ22MbbAV6x1I52BKi56QYa20E3VTpTrdayFYWspbf5CtLG37C+FbEuNHX13G42t0SO+Mc94QatKki4snkqXIH5h9lAGYvjIaALr3ycekCCz+EO91AI/SS++Ktc2N8GVNqDZ2lsRhv9/vXOCuPH7of0AvZFklnyDkBbphmHI=
Received: by 10.86.3.2 with SMTP id 2mr945232fgc.1186012277425;
        Wed, 01 Aug 2007 16:51:17 -0700 (PDT)
Received: from host-89-229-8-65.torun.mm.pl ( [89.229.8.65])
        by mx.google.com with ESMTPS id 22sm2619294fkr.2007.08.01.16.51.15
        (version=SSLv3 cipher=OTHER);
        Wed, 01 Aug 2007 16:51:15 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vzm1b7i8v.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54500>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > About clone: there was "pack loose, copy existing packs" idea.
> 
> Can you give more details --- I do not recall such an "idea"
> discussed.

The idea was to avoid repacking, and just pack loose, unpacked objects 
(and save this pack if possible), then concatenate all packs and send 
this concatenated pack as the result. This saves a bit (quite a bit) of 
CPU at the cost of additional bandwidth usage if packfiles are not 
optimized.

The only result of the discussion was that it would be fairly easy to 
send multiple packs concatenated into one pack, without need to add 
some multi-pack extension, as there would be required minor changes to 
split "concatenated" packfiles.

-- 
Jakub Narebski
Poland
