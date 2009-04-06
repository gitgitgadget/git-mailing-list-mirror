From: Klas Lindberg <klas.lindberg@gmail.com>
Subject: Re: Submodules can't work recursively because Git implements policy?
Date: Mon, 6 Apr 2009 18:29:30 +0200
Message-ID: <33f4f4d70904060929r31aa5870s3d9880c8ec9afc67@mail.gmail.com>
References: <33f4f4d70904060642m25b2cff8nafed433eeabfb6c4@mail.gmail.com>
	 <20090406135618.GA17793@pvv.org>
	 <33f4f4d70904060747h72019846gca18255bd71adc22@mail.gmail.com>
	 <20090406145140.GG23604@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Finn Arne Gangstad <finnag@pvv.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Users List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Apr 06 18:31:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lqrj1-00056a-79
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 18:31:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751655AbZDFQ3e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 12:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751235AbZDFQ3e
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 12:29:34 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:42038 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750804AbZDFQ3d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 12:29:33 -0400
Received: by fxm2 with SMTP id 2so1966641fxm.37
        for <git@vger.kernel.org>; Mon, 06 Apr 2009 09:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ykU1XWXXmPfx9hC12c4RwTt6KHlc4eeaz9+f3BYvR2A=;
        b=iBYIi71BgZG5oy6fuOu8SnREO62elBrJ6cvFk2oAqvXR/Pf7mNheQH2G/iHEH4eX6J
         +XVER64hKekpc+OR6zcAqhDPYPWEdXhp0v2G00r+TThSIkoDMBVrYMGRRJVPUHto/JNa
         VZmjQNK7+HLEAxUQ4uE+XgfHufOxmgc81Xe+Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=QGBZE8cZTdMAoyJt2rpopy4f6Kk7yvzL35KvgRj3s9J1+8AuOshrMEbTrz1WpWdjIm
         HBgQ73DPwwgM1ELOJ1tzyQFV6rnE3K9id4KA6+79D8NVBqvG5E6DQJsYXJ/qQLiuPrH5
         Lg5yLTJSl5F0/jq3Xj77/gvhyEWqvuuwjmMiM=
Received: by 10.223.116.72 with SMTP id l8mr3887347faq.33.1239035370150; Mon, 
	06 Apr 2009 09:29:30 -0700 (PDT)
In-Reply-To: <20090406145140.GG23604@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115851>

On Mon, Apr 6, 2009 at 4:51 PM, Shawn O. Pearce <spearce@spearce.org> wrote:

> What, like a secret shadow repository that you move the objects into?
>
> That could be very expensive in terms of disk IO if those objects
> are in large packs.  You'd need to break the pack apart into the
> "ok" and "sekret" parts.  Ick.

Well, ok. Just popping then?
Or adding the wrong publication to a forbidden fetch list?

>> But anyway: If I implement support for fetching SHA keys and full
>> recursive behaviour in the presence of submodules; would my patches
>> automatically be rejected because of the rationale for the current
>> behaviour?
>
> See my recent email (like ~10-15 minutes ago).  It will be rejected
> due to the issue that unreachable objects are subjected to GC and
> you'd easily see your repository delete that data on the next "git
> gc" invocation.  Automatic data destruction is not something that
> users come to git for.

Indeed not. But I don't want to suggest that named references
shouldn't be necessary. Just that it should be possible to fetch based
on the SHA key if that commit is (still) available on the remote end.

BR / Klas
