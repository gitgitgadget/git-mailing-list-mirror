From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Forcing rewrite of files in working tree
Date: Fri, 3 Aug 2007 14:39:28 +0100
Message-ID: <200708031439.29721.andyparkins@gmail.com>
References: <200708031345.47127.andyparkins@gmail.com> <46B3268C.7060707@dawes.za.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Rogan Dawes <lists@dawes.za.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 03 15:39:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGxNS-0007ZJ-Sw
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 15:39:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760955AbXHCNjg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 09:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760936AbXHCNjg
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 09:39:36 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:10177 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759884AbXHCNjf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2007 09:39:35 -0400
Received: by ug-out-1314.google.com with SMTP id j3so462474ugf
        for <git@vger.kernel.org>; Fri, 03 Aug 2007 06:39:34 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=gybDnjgL1h7MUbtihrrm8i6KRM2TrbpXC6LdnZ/IdUXX2fMQ/ek3G4ygQaXOd41DaaV2S/wvtD+Ijul3lfjqeZGUcxMb7sN6aadLMO0y6rC0iC/x4vZGGg0Odz4piMKFPo8oqmRsm28UXcbmsdvVepYRQaW+uFucPkIIwWfGpu8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=cwhc+qQiEq2CzkDA3htyVxW1Rl10UujaI6we56uEBLzL5yifg7fuGEBv/o6UHr3cx/l26x9oSsHMXGLii+6tmaR5vrv/Hj8cXf13owO6MmaOQ4ZOOxx82z2ebFMdyGDK8azY4xcUfHPsv8H+vO4b2Q411EsiO0Ovu9R8NWI1fOI=
Received: by 10.67.28.9 with SMTP id f9mr2933474ugj.1186148374008;
        Fri, 03 Aug 2007 06:39:34 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTPS id y34sm6369746iky.2007.08.03.06.39.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 03 Aug 2007 06:39:32 -0700 (PDT)
User-Agent: KMail/1.9.7
In-Reply-To: <46B3268C.7060707@dawes.za.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54727>

On Friday 2007 August 03, Rogan Dawes wrote:

> > The only method I've found is to delete the file in the work tree then do
> > git-checkout again.  Even with -f, if the file is not changed git doesn't
> > perform a checkout again, so git-checkout -f is not sufficient.  I assume
> > I can do what I want with some clever plumbing, but I don't know any
> > plumbing. :-)
>
> $ git reset --hard

I think that that suffers the same as "git-checkout -f"; if it doesn't see 
changes then it doesn't reread.  Also, it's not possible to do per-file:

$ git reset --hard HEAD somefile.txt
Cannot do partial --hard reset.

Which is a necessity really; I don't want to accidentally overwrite work 
that's not yet checked in in the rest of the tree.

Is git-checkout-index the thing I'm looking for?  I'm wondering if the "-n" 
switch is the trick?


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
