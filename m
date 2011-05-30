From: Romain Geissler <romain.geissler@gmail.com>
Subject: Re: Git global usage and tests
Date: Mon, 30 May 2011 18:10:20 +0200
Message-ID: <B369AA28-DEF2-48F3-8E4E-F387E8A57D26@gmail.com>
References: <754E784F-51C6-4B8D-B15D-3FF8B7AF1321@gmail.com> <20110530153620.GA24431@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v1082.1)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 30 18:10:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QR53A-0003PI-Rf
	for gcvg-git-2@lo.gmane.org; Mon, 30 May 2011 18:10:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757445Ab1E3QKb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 May 2011 12:10:31 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:35020 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757402Ab1E3QKW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 May 2011 12:10:22 -0400
Received: by wya21 with SMTP id 21so2723713wya.19
        for <git@vger.kernel.org>; Mon, 30 May 2011 09:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:mime-version:content-type:from
         :in-reply-to:date:cc:content-transfer-encoding:message-id:references
         :to:x-mailer;
        bh=Pbh+Bc+wgmiMOIYgrWCBLybemlU1lYywvH6j4OwJ/3A=;
        b=MMx0p7Yui7R1XFp40DzFW1fKz+Ajd5v26kNfyTvc+9xSNR6gaI88MDtqYirtVPanHN
         rsUnd4uk/Q10c2zklTunispew9sdZvhqvPnFaQDUT4uP7JKw4xRW8Xftc82QZnNU+3C4
         2P50H1gSFDw3V8eZZ1cZRgBL2BYou8M0+oV/c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=JEBGoZWf8oXrLuk4SY0PdfcnoKVrF0ihxVuYv/lvBNNaaU1zZ9jfsLFnXATFHpsDy4
         Zr6lbnWn7b2NhrAZol9+X9tYo2apgxn02JejQ239g1kvuBAglXxiY1ewhombCsSjiiR5
         52JbF+GpM5A8v/WNhVa473KtayKsbXXMxz0Ds=
Received: by 10.227.11.67 with SMTP id s3mr5104864wbs.62.1306771820785;
        Mon, 30 May 2011 09:10:20 -0700 (PDT)
Received: from ensi-vpn-31.imag.fr (ensi-vpn-31.imag.fr [129.88.57.31])
        by mx.google.com with ESMTPS id ge4sm3148962wbb.47.2011.05.30.09.10.19
        (version=SSLv3 cipher=OTHER);
        Mon, 30 May 2011 09:10:20 -0700 (PDT)
In-Reply-To: <20110530153620.GA24431@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.1082.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174759>


Le 30 mai 2011 =E0 17:36, Jeff King a =E9crit :

> Your option parser needs to follow these rules to be compatible with
> git.

Sure, according to our mentor teacher (Matthieu Moy) parse-option can h=
andle both if the command is followed by a required argument, we just n=
eed to specify it.

> Have you considered pulling the parse-options parser from git into
> libgit2? It's one of the more modularized and lib-ified bits of code =
in
> git already.

Yes and No. We have already copied some code from git : parse-option, t=
he error handling functions, a part of the run-command block and a part=
 of the compatibility layer. To my mind, there is no reason to pull it =
into libgit2 as it's only a client feature that works on strings, and l=
ibgit2 does not aim at being a client, only a git library.

Romain Geissler