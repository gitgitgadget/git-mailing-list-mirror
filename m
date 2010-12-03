From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH] Re: git submodule -b ... of current HEAD fails
Date: Fri, 3 Dec 2010 01:10:37 -0600
Message-ID: <20101203071037.GA18202@burratino>
References: <20101201171814.GC6439@ikki.ethgen.de>
 <20101201185046.GB27024@burratino>
 <4CF80B71.3010309@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Klaus Ethgen <Klaus@Ethgen.de>,
	Sven Verdoolaege <skimo@kotnet.org>, mlevedahl@gmail.com,
	ben@ben.com
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Fri Dec 03 08:11:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POPnI-0008Bz-ME
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 08:11:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755769Ab0LCHKy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 02:10:54 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:64048 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755348Ab0LCHKx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 02:10:53 -0500
Received: by ywl5 with SMTP id 5so4608689ywl.19
        for <git@vger.kernel.org>; Thu, 02 Dec 2010 23:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=EGJQSIJP1FTapAWxghLWhDvLoYKJkcFTqmmpSTETEME=;
        b=aSz2lKso3AHwp8aRN7WFfSp0616PdvjNjOiPOL4twD+U4U0IxcYyX3MMQ0aWhTb53a
         bVhBrNtz9WJLtdxuMOAovkjEUTQa6E35HL9p+FhU3F4n6KLRSUQk5MSii7OTvT3dFjeF
         a7WmSyu+91+M1fl28ia/2DMdJAxo+DJHm/ZKo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Iy1/+BfnrHje+euAkpHMTBvkwmbLUJUAJ9LwFa7HRfiaSXYjKgRjwYcK6BkXnutEgb
         B+mJ5MlnSEgVEc18v3JKDxuPIZbMybuvAfHwadWKA0YqXdG/paVONxMl0f7wHyu+3DSO
         fLKA0N1AFiMMQwTFza83+EK+V9PeuuuqZeb2o=
Received: by 10.150.52.20 with SMTP id z20mr3157223ybz.193.1291360253078;
        Thu, 02 Dec 2010 23:10:53 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.sbcglobal.net [68.255.109.73])
        by mx.google.com with ESMTPS id f73sm901260yhc.4.2010.12.02.23.10.50
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 02 Dec 2010 23:10:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4CF80B71.3010309@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162763>

Jens Lehmann wrote:
> Am 01.12.2010 19:50, schrieb Jonathan Nieder:

>>                                  Jens, any idea why git submodule
>> is not using "clone --branch" directly?
>
> Nope, these lines date back to the time before I got involved in the
> submodule business ... Seems like this "git checkout" was added in
> March 2008 by Mark Levedahl (CCed), maybe he can shed some light on
> that.

Ah, so the problem is that "clone --branch" did not exist.  Sorry for
the noise.

Another question can be also be easily answered by history examination:
the series of checks in module_clone are because 70c7ac22d:git-clone.sh
did not have checks of its own for the target directory.

So there is some simplification within grasp.

'night,
Jonathan
