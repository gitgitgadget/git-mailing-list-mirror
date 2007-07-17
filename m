From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] Add --show-size to git log to print message size
Date: Tue, 17 Jul 2007 08:49:33 +0100
Message-ID: <200707170849.35842.andyparkins@gmail.com>
References: <e5bfff550707140952hb60735bi95a4f03636c4aa99@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "Marco Costalba" <mcostalba@gmail.com>,
	"Junio C Hamano" <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 17 09:49:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAhoY-0007Qj-9p
	for gcvg-git@gmane.org; Tue, 17 Jul 2007 09:49:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761795AbXGQHtm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jul 2007 03:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761077AbXGQHtm
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jul 2007 03:49:42 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:56270 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756121AbXGQHtk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2007 03:49:40 -0400
Received: by ug-out-1314.google.com with SMTP id j3so102418ugf
        for <git@vger.kernel.org>; Tue, 17 Jul 2007 00:49:39 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Wfl6RXuMtt6IGJfEesEapevfVWbb97IS3Uz7YVL620x+HSBMCDHkQUGtUq23d/oqGf85fp4yYwhgVUVvCI/XSdXxfgntEdUjHLyyXdyT4SODgZjtu9MMa6LRBbPXja754kYvKxfcvf+9kLwI8yaRJtzMkrRt1PbeKP5BbUmnbIU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=JPN5+lp6rd8i2kOYjpb8M89NloL/aPbElInnqXLPgWjRYs6lgMfKDMaRS2RA46K/YZWryMHZ372FInPDmJzzPYZMWKrFhr9h0e/r+s0SDKDriCzA3eMOz4LjaU9d8/Zp4SZb3NcLN5FeUi0ikp5hHSKIC4ez+4Lsb5lbndh+KOI=
Received: by 10.66.221.17 with SMTP id t17mr130248ugg.1184658579739;
        Tue, 17 Jul 2007 00:49:39 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id b30sm47408972ika.2007.07.17.00.49.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 17 Jul 2007 00:49:38 -0700 (PDT)
User-Agent: KMail/1.9.7
In-Reply-To: <e5bfff550707140952hb60735bi95a4f03636c4aa99@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52747>

On Saturday 2007 July 14, Marco Costalba wrote:
> Print message size just before the corresponding message
> to speedup the parsing by scripts/porcelains tools.

Does this really give a speedup?

I'd be surprised, as long as the parse is being done during the output from 
git using the QProcess::readyRead() signal once and only once, then git is 
the bottle neck.  Parsing the stream is almost trivial in comparison to the 
work that git is doing.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
