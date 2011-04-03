From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Background processes in post-receive hook
Date: Sun, 3 Apr 2011 00:06:19 -0500
Message-ID: <20110403050619.GA32750@elie>
References: <AANLkTinrEt6DkwhknpDZ0iV9PR+7bBd3DAaPRJOgNFTG@mail.gmail.com>
 <BANLkTin4-fMhi_5H1oZ+gPB99stj5GRjVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: James Pickens <jepicken@gmail.com>, Git ML <git@vger.kernel.org>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 03 07:08:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6FXi-00054d-GU
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 07:08:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395Ab1DCFH4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Apr 2011 01:07:56 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:56769 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751250Ab1DCFH4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 01:07:56 -0400
Received: by iyb14 with SMTP id 14so4879386iyb.19
        for <git@vger.kernel.org>; Sat, 02 Apr 2011 22:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=tJtAf7bAftSaOFtR24AbGxi8SWdmkjJWBwfz023Y3tY=;
        b=GPiPOMMV4NHMXJHRuV44DF6X8kE0yPiBR1ZHhg7xHkhd/sNw4gi3B2zSBgUk7Bk3RS
         2ortU9LBvPa5erCBK2rsKCjKrrO36lhaOGVpIEReLGc8fMy2TkSfh8oLzmI6d2uiKwgP
         wRq2bnqayznZLVJKiM/Gfbpb8v7I0O1NqRm+E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=FZaDJMzY47qnQ5VnSpZ2cAdlEpM2j+T2MF1paeXpKSHIkS9yM6Zah1Sc9GMok2XT/9
         15nyePtRupXSMknxT0m+XxMrCIRtfW5Py6Wd4qWlThNVxZZvFOgoWrQf1gBaVuMfkJai
         QYfOz8QsknledYu95JcaLeJABOQeBVDSRo0Vs=
Received: by 10.231.65.209 with SMTP id k17mr4160978ibi.127.1301807275478;
        Sat, 02 Apr 2011 22:07:55 -0700 (PDT)
Received: from elie (adsl-68-255-107-98.dsl.chcgil.ameritech.net [68.255.107.98])
        by mx.google.com with ESMTPS id o3sm2717584ibd.10.2011.04.02.22.07.53
        (version=SSLv3 cipher=OTHER);
        Sat, 02 Apr 2011 22:07:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTin4-fMhi_5H1oZ+gPB99stj5GRjVA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170677>

Sitaram Chamarty wrote:

> interestingly, the double fork trick doesn't work either...
>
>   ( ( long-running-command & ) )

Hopefully closing the output pipe does the trick.

	exec long-running-command >&- 2>&- &

Thanks for an interesting example.
Jonathan
