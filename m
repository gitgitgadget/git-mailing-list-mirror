From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Huge win, compressing a window of delta runs as a unit
Date: Thu, 17 Aug 2006 14:06:25 -0400
Message-ID: <9e4733910608171106l74ee4d39x6e34900877c24bb0@mail.gmail.com>
References: <9e4733910608161020s6855140bs68aaab6e1bbd3bad@mail.gmail.com>
	 <20060817040719.GC18500@spearce.org>
	 <Pine.LNX.4.63.0608170943470.28360@wbgn013.biozentrum.uni-wuerzburg.de>
	 <Pine.LNX.4.63.0608171003020.28360@wbgn013.biozentrum.uni-wuerzburg.de>
	 <9e4733910608170736y4863e0ebr55c6c822ae548cca@mail.gmail.com>
	 <Pine.LNX.4.63.0608171738490.28360@wbgn013.biozentrum.uni-wuerzburg.de>
	 <9e4733910608171017k628ef754s4fcd075d60aaf062@mail.gmail.com>
	 <Pine.LNX.4.64.0608171323330.11359@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Shawn Pearce" <spearce@spearce.org>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 17 20:07:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDmGE-0007ph-4J
	for gcvg-git@gmane.org; Thu, 17 Aug 2006 20:06:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932562AbWHQSG1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Aug 2006 14:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932566AbWHQSG1
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Aug 2006 14:06:27 -0400
Received: from nz-out-0102.google.com ([64.233.162.201]:38864 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932562AbWHQSG0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Aug 2006 14:06:26 -0400
Received: by nz-out-0102.google.com with SMTP id n1so401086nzf
        for <git@vger.kernel.org>; Thu, 17 Aug 2006 11:06:25 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=B/sFJ5nn61i0xRRsgVAVG/2ZUFKEbMrxH4UENOiDJrU+C3TApWd0jQSYt/uBzjAWccDWUH9xekujFx+Sh3enXgUNGezi7GAQ89H1xBHCNyb35ETMIJBEYNSGns4wiUxSYgOtDDa1PAFXHQg5NAjkze9TsSSoHFzpyeqqkhlDzcE=
Received: by 10.65.121.9 with SMTP id y9mr2566776qbm;
        Thu, 17 Aug 2006 11:06:25 -0700 (PDT)
Received: by 10.65.133.17 with HTTP; Thu, 17 Aug 2006 11:06:25 -0700 (PDT)
To: "Nicolas Pitre" <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0608171323330.11359@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25600>

On 8/17/06, Nicolas Pitre <nico@cam.org> wrote:
> On Thu, 17 Aug 2006, Jon Smirl wrote:
>
> > Is there a pack format version number built into the server procotol?
> > If not there needs to be one. When there is a mismatch with the server
> > pack version the client should simply display an error requesting an
> > upgrade of the client software.
>
> There is a pack version number.  Reception of an unknown pack already
> produces an error:
>
>         if (!pack_version_ok(hdr->hdr_version))
>                 die("unknown pack file version %d", ntohl(hdr->hdr_version));
>
> That will occur really early in a pull or clone when using the native
> protocol.

Can this be fixed so that if the pack protocol coming from the server
is greater than the one handled by the client. they client gets a nice
hint about upgrading?

-- 
Jon Smirl
jonsmirl@gmail.com
