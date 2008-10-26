From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [VOTE] git versus mercurial (for DragonflyBSD)
Date: Sun, 26 Oct 2008 21:07:29 +0200
Message-ID: <200810262007.30148.jnareb@gmail.com>
References: <ge0rla$mce$1@ger.gmane.org> <m3r663h276.fsf@localhost.localdomain> <94a0d4530810260857u7c0cb122g8147b9484108f539@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mercurial@selenic.com
To: "Felipe Contreras" <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 26 20:08:55 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuAyo-0008Sj-5f
	for gcvg-git-2@gmane.org; Sun, 26 Oct 2008 20:08:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752846AbYJZTHg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Oct 2008 15:07:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752751AbYJZTHg
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Oct 2008 15:07:36 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:11663 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752628AbYJZTHf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Oct 2008 15:07:35 -0400
Received: by ug-out-1314.google.com with SMTP id 39so83485ugf.37
        for <git@vger.kernel.org>; Sun, 26 Oct 2008 12:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=zGebT8Ps/rx+YCVkWQelUM8vE3E7ixlNOGhA9ncz4OM=;
        b=uxePLRRgPTHhWsfFuhcHIgv0RQ7GMOhT5kroKagrK6V5l/47NfLbtJVX2JRfiZJN6o
         BWUJosPmfjzjEyLL37TqeAeZRFWTLECBcHxAPj84FtCcsxfP2C4iuWWDduIseJ3qgynn
         rrywTN8CZNxDp5pHLeNAXHrUe/lK5mfjiOtb0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Ph3mC0CK8BOcXnqozDOWcITIzhriIn7BK7PLPFMlHEnyqJwYdX5TG/s4A/Xzre9Onr
         Xd+u+0LH24sUAChruOGS6amoSsS2YHwf95MlOkHeHqFjIL7FL3HxU36mzc4wOZIyxCvV
         zJXGpEsJk1p9hbzN2yz/q8Fqh8sUsY0L/P7GI=
Received: by 10.66.240.18 with SMTP id n18mr1573256ugh.60.1225048053838;
        Sun, 26 Oct 2008 12:07:33 -0700 (PDT)
Received: from ?192.168.1.11? (abxb216.neoplus.adsl.tpnet.pl [83.8.251.216])
        by mx.google.com with ESMTPS id u6sm3254540uge.4.2008.10.26.12.07.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 26 Oct 2008 12:07:32 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <94a0d4530810260857u7c0cb122g8147b9484108f539@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99179>

I'm not sure if Mercurial mailing list is not subscribe only. Git isn't.

On Sun, 26 Sep 2008, Felipe Contreras wrote:
> On Sun, Oct 26, 2008 at 4:15 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> > [Cc: gmane.comp.version-control.git,
> >     gmane.comp.version-control.mercurial.general]

> > 3. Repository design and performance.

> >   Git and Mercurial have similar performance, although it is thought
> >   that due to design Mercurial has faster patch applying and is
> >   optimized for cold cache case, while Git has faster merging and is
> >   optimized for warm cache case.
> >
> >   Mercurial may have (or had) problems with larger binary files, from
> >   what I have heard.
> 
> The fact that hg is changeset based means that certain operations are
> slower, like checkout a specific commit. In hg my bet is you would
> need to gather a bunch of changesets while in git the operation is
> done in a single step.

Actually from what I have read Mercurial stores current version
(snapshot) from time to time, so time to resolve specific commit is
limited.  Also if you have packed your Git repository (good idea not
only to limit size, but also for performance (I/O performance)), then
resolving specific commit also might require some delta resolution
(by default delta chain length is limited to 50, see pack.depth).
 
> It also means that bare clones are not possible in hg, or at least
> very complicated.

I think it is things like .hgtags which make bare clones (without
working directory) to be hard or even impossible in Mercurial.

> Note: I'm not sure if what I'm claiming is correct.

Hmmm...
-- 
Jakub Narebski
Poland
