From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH 1/2] Change "refs/" references to symbolic constants
Date: Wed, 3 Oct 2007 08:40:30 +0100
Message-ID: <200710030840.31405.andyparkins@gmail.com>
References: <200709291359.59147.andyparkins@gmail.com> <200710020941.05288.andyparkins@gmail.com> <7v1wcdmm7p.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 03 09:41:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Icyqy-0002l6-An
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 09:41:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752869AbXJCHkh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 03:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753029AbXJCHkh
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 03:40:37 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:65023 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752428AbXJCHkg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 03:40:36 -0400
Received: by ug-out-1314.google.com with SMTP id z38so71765ugc
        for <git@vger.kernel.org>; Wed, 03 Oct 2007 00:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=mdaakN82b6uY8EecDMDOE+9hLIdvl4/RzZ+mqfGVR6o=;
        b=E2lo46jCJNnvNpNlhPVfBwjq30IcLLnWY+fmRbtCJVkE/xfGTsAJ6VJmuZhfbpiR8ZcCX3VVV/x7slUcrIbPhY88B3USXIAN3MNI19mWmfMd+pDCrclZiBlya42ffJzgMuNEUAVEDNIC4r2ZAnIq8AwtdHBWqDZX8+rC6/mSTGE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=tSRlbjzEr5p4+6ON9smsiEvrcL2NWUcUurYakifKGxL7F0PJmS9ivX3zpDfiBfJFZQMgsbRHbjdm28yx146OL0Hpl9GXdVCMqgwUmHMfvBUn+awFTTuHtGuL/lTgdMwVqPbAnDmbCOWrykIz5qHNJ2lRwHGef5PLgggNB9atGTY=
Received: by 10.66.219.16 with SMTP id r16mr142993ugg.1191397234709;
        Wed, 03 Oct 2007 00:40:34 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTPS id b33sm108664ika.2007.10.03.00.40.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 03 Oct 2007 00:40:33 -0700 (PDT)
User-Agent: KMail/1.9.7
In-Reply-To: <7v1wcdmm7p.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59803>

On Tuesday 2007 October 02, Junio C Hamano wrote:
> Andy Parkins <andyparkins@gmail.com> writes:
> > I noticed a couple of places where memcmp() has been used where
> > prefixcmp() would work fine.  I'm tempted to change them too - what do
> > you think? Perhaps a separate patch?
>
> In general, probably it is preferable to have a separate
> "preliminary patch" to normalize the existing code without using
> the new infrastructure (i.e. REF_* macros), and then to have the
> main patch.  That way would make the main patch more about
> mechanical conversion, which would be easier to verify
> independently.

I only noticed them memcmp() use while I was reviewing the PATH_REFS patch :-)  
So making it preliminary would have meant travelling backwards in time.

I imagine I can do a bit of rebase-interactive to rearrange should that be the 
route you'd like me to go.  Your call.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
