From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] diffcore-rename: favour identical basenames
Date: Fri, 22 Jun 2007 16:19:26 +0100
Message-ID: <200706221619.30521.andyparkins@gmail.com>
References: <20070621030622.GD8477@spearce.org> <20070621131915.GD4487@coredump.intra.peff.net> <alpine.LFD.0.98.0706210910390.3593@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	govindsalinas <govindsalinas@yahoo.com>, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 22 17:19:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1kvB-0008Ia-TE
	for gcvg-git@gmane.org; Fri, 22 Jun 2007 17:19:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756967AbXFVPTf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jun 2007 11:19:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756783AbXFVPTf
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jun 2007 11:19:35 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:8561 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756703AbXFVPTe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2007 11:19:34 -0400
Received: by ug-out-1314.google.com with SMTP id j3so831364ugf
        for <git@vger.kernel.org>; Fri, 22 Jun 2007 08:19:33 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=acKo5mBWJSKu+j1iU7GiV/tEomesbjod3trfX2G8GgIleiyKsaIUIG6zK5ONaZJ279lWDwNsuLcKiLmDk7uIaQbjUeslo7XcpLAgs3Wl/SKFeeRKaOMfbxMKDSx39XYeofQxNP5b4fJw24UOlC627JwlpvX0UMI9v7pTJAq72T8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=pn7qvtjrrOtqYpplhXWC3rCgfOOf5E3KPAwDwkhGLkwbIc+fxEgQfCWGjNCEYhi12n0pqCvL5eALOIIH536Ypvf86zFZ5gWXIheAC9jJ5amWEfscgKCYV7BSEko0Sumf19RDr9m0z7M/pqdSB+NvX0bb7bL8yjATdyTVifa/cq8=
Received: by 10.82.186.5 with SMTP id j5mr6552960buf.1182525572658;
        Fri, 22 Jun 2007 08:19:32 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id y34sm6607298iky.2007.06.22.08.19.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 22 Jun 2007 08:19:31 -0700 (PDT)
User-Agent: KMail/1.9.7
In-Reply-To: <alpine.LFD.0.98.0706210910390.3593@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50702>

On Thursday 2007 June 21, Linus Torvalds wrote:

> The files are *identical* for christ sake! Following their history, it
> doesn't matter *which* base you follow, since regardless, they've come to
> the same point!
>
> So in that sense, the current git behaviour is actually perfectly fine.

Perhaps not.  (Please don't read this as meaning I disagree with your 
favour-the-identical-filename patch at all - in fact I think that would 
address the case I give below).

What if two files with different filenames and content converge at some point 
in history, then diverge again?  If git is tracking renames merely by content 
and picks the wrong one, then the history of fileA suddenly becomes the 
history of fileB.


Andy

-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
