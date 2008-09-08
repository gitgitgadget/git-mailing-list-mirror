From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: pack operation is thrashing my server
Date: Mon, 8 Sep 2008 12:01:58 -0400
Message-ID: <9e4733910809080901g5f9c9c11ia7c291125bf52776@mail.gmail.com>
References: <a6b6acf60808101247r4fea978ft6d2cdc53e1f99c0e@mail.gmail.com>
	 <9e4733910809061950g6d9d2cf1g708f8faf0c06108@mail.gmail.com>
	 <alpine.LFD.1.10.0809061957320.3117@nehalem.linux-foundation.org>
	 <9e4733910809062043y661d2d54rcb034d4c70296727@mail.gmail.com>
	 <alpine.LFD.1.10.0809062148110.3117@nehalem.linux-foundation.org>
	 <9e4733910809070658k66e0481fx758e9a365229cf18@mail.gmail.com>
	 <alpine.LFD.1.10.0809071304130.23787@xanadu.home>
	 <9e4733910809071333t57d03257m34fd6a752e40177e@mail.gmail.com>
	 <alpine.LFD.1.10.0809081008330.23787@xanadu.home>
	 <9e4733910809080812g4a7e5916l82bd3bf496f16324@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Sep 08 18:03:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcjCn-0001aW-EO
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 18:03:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752225AbYIHQCA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 12:02:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752220AbYIHQCA
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 12:02:00 -0400
Received: from wa-out-1112.google.com ([209.85.146.180]:17683 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751646AbYIHQB7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 12:01:59 -0400
Received: by wa-out-1112.google.com with SMTP id j37so1191944waf.23
        for <git@vger.kernel.org>; Mon, 08 Sep 2008 09:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=jwmQaZ/am7pFYZJWISrWDakVwmXvh4XTgIQ1YQlW2Go=;
        b=lvvBSnflFuhHMvg+9p0gYoL6jhL947xroPXUPfERDZKxCsyr4+CcIQdWG21OS2ctaB
         qNofC5xsj7YzTK4PCp34tfET7QmEL0tP/nw77WfReW6MlKNOKUOQtzSUPmdhqAcKsaNJ
         /Bvs5TldeUtgaIw/n/reDNr09GrAl5jtOmmuQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=vgftVMQcGkC589kLP6bdaQOhv2NwWxY3LjaancBTdMTib3elTLdctnwmtq/94eIMby
         AusnIm2qAC9T2TPY22DQQ1ADOLQc1PwLdfi3QREJNY1ErYZwTZap7xTbACVPrz4nZsxW
         fxNdlB7+tZQV3ZF2nTaEG4iM1nbHu1Hc2ZLtM=
Received: by 10.114.159.6 with SMTP id h6mr12603703wae.65.1220889718948;
        Mon, 08 Sep 2008 09:01:58 -0700 (PDT)
Received: by 10.70.55.6 with HTTP; Mon, 8 Sep 2008 09:01:58 -0700 (PDT)
In-Reply-To: <9e4733910809080812g4a7e5916l82bd3bf496f16324@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95269>

On 9/8/08, Jon Smirl <jonsmirl@gmail.com> wrote:
> On 9/8/08, Nicolas Pitre <nico@cam.org> wrote:
>  > On Sun, 7 Sep 2008, Jon Smirl wrote:
>  >
>  >  > On 9/7/08, Nicolas Pitre <nico@cam.org> wrote:
>  >
>  > > > Please have a look at commit eac12e2d4d7f.  This fix improved things for
>  >  > >  my gcc repack tests.
>  >  >
>  >  > Do you have any test numbers for something like a 2000 delta chain
>  >  > before and after?
>  >
>  >
>  > What kind of number do you want?
>
>
> See if repacking a 2000 chain delta still takes 30 minutes. It can be
>  any 2000 chain delta.

Time for repacking a 2000 chain delta would be a good thing to monitor
as part of the testing process.  It amplifies any small performance
problems and makes them obvious.

-- 
Jon Smirl
jonsmirl@gmail.com
