From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH] gitweb: Make linking to actions requiring JavaScript a feature
Date: Thu, 26 Nov 2009 22:24:35 +0100
Message-ID: <200911262224.36371.jnareb@gmail.com>
References: <1258659887-5244-1-git-send-email-bebarino@gmail.com> <200911262112.16280.jnareb@gmail.com> <7vws1d3tzk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stephen Boyd <bebarino@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 26 22:24:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDlpb-00084O-4I
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 22:24:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751662AbZKZVYk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Nov 2009 16:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751445AbZKZVYk
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 16:24:40 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:62040 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751032AbZKZVYj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Nov 2009 16:24:39 -0500
Received: by bwz27 with SMTP id 27so821027bwz.21
        for <git@vger.kernel.org>; Thu, 26 Nov 2009 13:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=N/VF9ai9/293TpYFCLExPDH68rPTSFxfRJoNwbqNBqQ=;
        b=P3rHh9qtY3vT00dai5IGhQDbND57yvPaqlBXZxm11Iulp2ZpWxbGbiXUJs2XmSIPOG
         9+d/bV3GKA6CEntP/7R0ahdbcl19P2iboSldhFeqIyGntxjR5u03zFIp/mKFoEVc3Jrc
         sU4qbT3AMnXqIu7h+CFCN/bTDncF52AIYgg2s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=TStM/UNQWFTzj/fPrz2FbDwR/aM9+I/LY46usRWgY2uQ69tjAiBhSdiIykCLaeLA4w
         gtFCPMmzQJ//3f4IZUKDx8tKuVR8pbx68fjInqiwSWrfDM+4ZfvooP7mWv8sJTjTtqG0
         UFYhbvl6H05jUDDIox/Wz21orh0iQiM4yiYQQ=
Received: by 10.204.155.65 with SMTP id r1mr235046bkw.143.1259270684782;
        Thu, 26 Nov 2009 13:24:44 -0800 (PST)
Received: from ?192.168.1.13? (abvg159.neoplus.adsl.tpnet.pl [83.8.204.159])
        by mx.google.com with ESMTPS id 1sm1408416fkt.33.2009.11.26.13.24.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 26 Nov 2009 13:24:43 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vws1d3tzk.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133835>

Dnia czwartek 26. listopada 2009 21:34, Junio C Hamano napisa=B3:
> Jakub Narebski <jnareb@gmail.com> writes:
>=20
> > Let gitweb turn some links (like 'blame' links) into linking to
> > actions which require JavaScript (like 'blame_incremental' action)
> > only if 'javascript-actions' feature is enabled.
>=20
> Hmm, instead of "fixLinks" that actually munges existing links to wor=
king
> action with some other action, can that be "addLinks" that _adds_ new
> links to features available only when JS can be used?

I am not sure if this would make sense.

Both 'blame' (running "git blame --porcelain") and 'blame_incremental'
(running "git blame --incremental") actions generate *the same* view,
modulo some very minor differences.  The idea behind 'blame_incremental=
'
is that it provides incremental updates to long-running action, and
hopefully also reduce server load, at least a bit.


It might be however good *interim* solution, so people would be able
to test 'blame_incremental' view without having to edit gitweb links.
Hmmm....

--=20
Jakub Narebski
Poland
