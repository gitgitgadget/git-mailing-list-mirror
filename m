From: "Richard Quirk" <richard.quirk@gmail.com>
Subject: Re: [PATCH] git-bisect.sh: don't accidentally override existing branch "bisect"
Date: Thu, 1 May 2008 14:15:12 +0200
Message-ID: <cac9e4380805010515h783dcf74h39fcc522c78885d3@mail.gmail.com>
References: <20080430164613.28314.qmail@b31db398e1accc.315fe32.mid.smarden.org>
	 <200804302330.18354.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Gerrit Pape" <pape@smarden.org>, git@vger.kernel.org,
	"Junio C Hamano" <gitster@pobox.com>
To: "Christian Couder" <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Thu May 01 14:16:03 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrXhi-0006kH-HR
	for gcvg-git-2@gmane.org; Thu, 01 May 2008 14:16:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756424AbYEAMPP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2008 08:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752774AbYEAMPO
	(ORCPT <rfc822;git-outgoing>); Thu, 1 May 2008 08:15:14 -0400
Received: from wx-out-0506.google.com ([66.249.82.227]:50356 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756055AbYEAMPN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2008 08:15:13 -0400
Received: by wx-out-0506.google.com with SMTP id h31so917959wxd.4
        for <git@vger.kernel.org>; Thu, 01 May 2008 05:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=iwRRzEl+iTFnA2mRFAFcrALoM2wDaj39oSJ2ef+YM5g=;
        b=qPNDPH3UFDH1E0cBIEcM4VlIhcgqmvPhRyF6v7Gab0q34u5SNRmk22f8DrRnXsDSMpXKbPqzl4cYRpqF5d9zMZ+txy7rKON75LdIeyVs7tTlr5GPXfMt8QofvgtHmfMCTHevnj6pT1exBedMan/a9lfnwMlVR3+vahAkCzjGuNw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tO++4smstrgnJLJrQXliZqa27qqDrEZDyTHdxt3yuy40IMH+G7DtREBHYT258j3Ag4b0/6U7yb/P+aioLimcvtmh0l1nivQXZeaD/ar1l9nYsLObFVy9IthFVSZEk63vxQixzq1C/BgUVLq0QjGkZsp7WSuAxaRwGhcAEuiSUYg=
Received: by 10.70.118.4 with SMTP id q4mr524730wxc.9.1209644112223;
        Thu, 01 May 2008 05:15:12 -0700 (PDT)
Received: by 10.70.23.17 with HTTP; Thu, 1 May 2008 05:15:12 -0700 (PDT)
In-Reply-To: <200804302330.18354.chriscool@tuxfamily.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80905>

On Wed, Apr 30, 2008 at 11:30 PM, Christian Couder
<chriscool@tuxfamily.org> wrote:

>  Minor nitpick: you may use:
>
>  git show-ref -q {new-,}bisect
>
>  instead of:
>
>
>  git show-ref bisect > /dev/null ||
>         git show-ref new-bisect > /dev/null

Careful with that - it's a bashism and would fail if /bin/sh is dash.
ie it would say that a branch called literally "{new-,}bisect" does
not exist, even if new-bisect and bisect do.

(this time reply-all instead of just to Christian!)
