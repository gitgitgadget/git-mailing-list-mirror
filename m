From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH] Add multiple workdir support to branch/checkout
Date: Wed, 5 Oct 2011 16:57:42 -0500
Message-ID: <20111005215742.GB12747@elie>
References: <CACsJy8AqYq+YF+rvUp=BBeFUAtUz783iF2jbUp3fO58yLp9ptQ@mail.gmail.com>
 <CAG+J_DygQTD5ibco=-NOiKg0BLgBGFJnvV8zPyhngC2iZv_H8g@mail.gmail.com>
 <7vpqib8jzk.fsf@alter.siamese.dyndns.org>
 <CAG+J_Dz-GXvRbYUXSoyfyHfOO-_BszcOza9x=ysHhmL5YBW-Jw@mail.gmail.com>
 <7vzkhf713u.fsf@alter.siamese.dyndns.org>
 <CAG+J_Dzg2D+vmFRfLX01S2k98YZQBE0FFv76VAyPnXdetyWADQ@mail.gmail.com>
 <20111005200043.GA32732@inner.h.iocl.org>
 <CAG+J_DynQ8U6T9YMsWstKF_Cf6CSCr8b8E4T=p5uyGPh28G=kA@mail.gmail.com>
 <20111005213002.GA12667@elie>
 <CAG+J_Dz=9jAFBQ5fpY=d6M5Zc-BhNFi6foKJx69v3n3Km-U0rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Krey <a.krey@gmx.de>, Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 05 23:57:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBZTN-0008Uc-Qd
	for gcvg-git-2@lo.gmane.org; Wed, 05 Oct 2011 23:57:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935414Ab1JEV5t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Oct 2011 17:57:49 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:62263 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934884Ab1JEV5t (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2011 17:57:49 -0400
Received: by gyg10 with SMTP id 10so2012624gyg.19
        for <git@vger.kernel.org>; Wed, 05 Oct 2011 14:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=bUtota347LVRkatiE7Ha/oAn3Mn1lol8W278NOLdCoI=;
        b=Mz0OuR18DUAEdwr8vI62+vycOFlgkYFEe+mPialmAiSGH5Na7x1xwh4zojy+Wodc6G
         JxrADPccLEmekRtCz+vREjdLgRlgHEtpM9Mx+8nmu9yz4mNWujgzXta6bJ0qu+05Vx9K
         7SBUFJLWgnrDt6MRJQaz69YCLKUzJOTScKMqU=
Received: by 10.236.168.41 with SMTP id j29mr16673302yhl.32.1317851868507;
        Wed, 05 Oct 2011 14:57:48 -0700 (PDT)
Received: from elie (99-120-124-35.lightspeed.cicril.sbcglobal.net. [99.120.124.35])
        by mx.google.com with ESMTPS id w70sm4371787yhk.6.2011.10.05.14.57.46
        (version=SSLv3 cipher=OTHER);
        Wed, 05 Oct 2011 14:57:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAG+J_Dz=9jAFBQ5fpY=d6M5Zc-BhNFi6foKJx69v3n3Km-U0rg@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182894>

Jay Soffian wrote:

> I don't understand this. Is it about not gc'ing commits that other
> workdirs are detached on, or something more?
>
> I like that each of my workdirs have their own HEAD reflog.

Yes, sorry for the lack of clarity.  I only meant that "git gc" needs
to be aware of the HEAD reflog for other workdirs (e.g., as described
in the thread following madcoder's proposal), not that it would be a
good idea for the reflogs to actually be symlinked.
