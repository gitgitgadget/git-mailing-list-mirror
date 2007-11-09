From: "Yossi Leybovich" <sleybo@gmail.com>
Subject: Re: corrupt object on git-gc
Date: Fri, 9 Nov 2007 10:53:46 -0500
Message-ID: <4fe79b4b0711090753r52abd3e1ree64271c0fa229f6@mail.gmail.com>
References: <4fe79b4b0711090538wf483ce7j89c518962e89780e@mail.gmail.com>
	 <473464A2.7080003@op5.se>
	 <4fe79b4b0711090701g7a43cdfdi5e20e5ffb437d7bb@mail.gmail.com>
	 <47347E0E.1040205@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Andreas Ericsson" <ae@op5.se>, git@vger.kernel.org,
	"Yossi Leybovich" <sleybo@mellanox.co.il>
To: "Johannes Sixt" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Nov 09 16:54:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqWBI-0000yX-Um
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 16:54:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761383AbXKIPxu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 10:53:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760801AbXKIPxu
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 10:53:50 -0500
Received: from rn-out-0910.google.com ([64.233.170.188]:54760 "EHLO
	rn-out-0102.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760130AbXKIPxt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 10:53:49 -0500
Received: by rn-out-0102.google.com with SMTP id s46so796366rnb
        for <git@vger.kernel.org>; Fri, 09 Nov 2007 07:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=jxWgSmhjVXfeb+q3agTOqmO2S43LutSh3LcbLwDner0=;
        b=bu0H1JkUlo4J1DD7PHyUCjJba6ROTNduSkSr14zbZJtkV2X2GZhQICvGpXe1yMkrrNVZB2s4upplGeOWYKSsdaqLr0VUvr059C5ykNvoFOVhTedBEVE8XkUkLzGTcGaUZzf71H3EHSKlUWsgkCBI5hyz5mL4fsGg+7ZK6RXnzNU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PM0H/hQVYPBT00Fc+x4SQaBhwgJXW5uvJYHYX/ofHsJfkpL55C2IrZTyuSeOM7vmERoJcFXL1Kq69F30rGe4rlAaFyj6u4kPSl3J0maSSb7icR8NLCcPcv3HaaHYtfnslmK81mp+H/AEIm+flnI2oMJ229Vg/qfizAl/fu0B1Ck=
Received: by 10.142.240.9 with SMTP id n9mr527960wfh.1194623626797;
        Fri, 09 Nov 2007 07:53:46 -0800 (PST)
Received: by 10.142.217.12 with HTTP; Fri, 9 Nov 2007 07:53:46 -0800 (PST)
In-Reply-To: <47347E0E.1040205@viscovery.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64204>

On Nov 9, 2007 10:34 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Yossi Leybovich schrieb:
> > [about corrupt loose object '4b9458b3786228369c63936db65827de3cc06200']
>
> You can try to create a clone (after you have fixed up the artificial
> breakages that you made). If that goes well, then the bad object is
> referenced only from reflogs.
>


git clone ib ib-clone
Initialized empty Git repository in /home/mellanox/work/symm/ib-clone/.git/
0 blocks



[mellanox@mellanox-compile ib-clone]$  cd ib-clone/

[mellanox@mellanox-compile ib-clone]$ git branch -a
* mlx4
  origin/HEAD
  origin/master
  origin/mlx4
  origin/mlx4-work
  origin/mthca
  origin/second_port


[mellanox@mellanox-compile ib-clone]$ git-gc
Generating pack...
Done counting 3288 objects.
Deltifying 3288 objects...
error: corrupt loose object '4b9458b3786228369c63936db65827de3cc06200'
fatal: object 4b9458b3786228369c63936db65827de3cc06200 cannot be read
error: failed to run repack


So still I cant pack my repository


> -- Hannes
>
>
