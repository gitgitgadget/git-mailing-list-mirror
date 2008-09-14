From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 14/16] clone: support narrow checkout with --path option
Date: Sun, 14 Sep 2008 12:01:22 -0700 (PDT)
Message-ID: <m3r67mmu0v.fsf@localhost.localdomain>
References: <1221397685-27715-1-git-send-email-pclouds@gmail.com>
	<1221397685-27715-2-git-send-email-pclouds@gmail.com>
	<1221397685-27715-3-git-send-email-pclouds@gmail.com>
	<1221397685-27715-4-git-send-email-pclouds@gmail.com>
	<1221397685-27715-5-git-send-email-pclouds@gmail.com>
	<1221397685-27715-6-git-send-email-pclouds@gmail.com>
	<1221397685-27715-7-git-send-email-pclouds@gmail.com>
	<1221397685-27715-8-git-send-email-pclouds@gmail.com>
	<1221397685-27715-9-git-send-email-pclouds@gmail.com>
	<1221397685-27715-10-git-send-email-pclouds@gmail.com>
	<1221397685-27715-11-git-send-email-pclouds@gmail.com>
	<1221397685-27715-12-git-send-email-pclouds@gmail.com>
	<1221397685-27715-13-git-send-email-pclouds@gmail.com>
	<1221397685-27715-14-git-send-email-pclouds@gmail.com>
	<1221397685-27715-15-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?b?Tmd1eeG7hW4gVGjDoWkgTmfhu40=?= =?utf-8?b?YyBEdXk=?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 14 21:02:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kewrz-0002Wq-9a
	for gcvg-git-2@gmane.org; Sun, 14 Sep 2008 21:02:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754064AbYINTB1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Sep 2008 15:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754257AbYINTB0
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Sep 2008 15:01:26 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:5874 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754243AbYINTBZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Sep 2008 15:01:25 -0400
Received: by yx-out-2324.google.com with SMTP id 8so517738yxm.1
        for <git@vger.kernel.org>; Sun, 14 Sep 2008 12:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding:date;
        bh=yV+JY/NiZWJtOZo8hz/nGCwr5sCig0IM9V4eA0tVXaI=;
        b=bSaFwZBEL645A1IGro1LH0bkJe+QIZPWWv2D/PQsuKG/pWUfbjhdhRqrG5w2p1H/3M
         8IQPXO50C3wTUNtf6eKfYacGAe2usBDJtL+/ny6npDL8AptSds4Esg3XAWvia9CypQtq
         1em2K1t8kWpi1Cm8GsfRRC0vp1RxKkVAfAOLQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding:date;
        b=cBTxGH7lwlV3s/u7QaUI0q2PadQCOOg81cll6UrABpQ0ZCrHIrYNMt61K61OqF3D/j
         xA9X4uvHyCpQ9S+3HJCds33jx6bE8v6kZ0f40UT2bkluhCi+Dm9zy7LRtWqMdDLU19qu
         1GBrjZDAGXWcFKTY92JFR63vlE8l4Aq4+dBnE=
Received: by 10.86.33.19 with SMTP id g19mr5213483fgg.13.1221418883564;
        Sun, 14 Sep 2008 12:01:23 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.251.193])
        by mx.google.com with ESMTPS id 3sm13865304fge.3.2008.09.14.12.01.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Sep 2008 12:01:22 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m8EJ1L03014170;
	Sun, 14 Sep 2008 21:01:21 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m8EJ1K7S014167;
	Sun, 14 Sep 2008 21:01:20 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1221397685-27715-15-git-send-email-pclouds@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95856>

I will comment only on the documentation...

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> +--path=3D<narrow_spec>::
> +	A narrow checkout of HEAD is performed after clone is complete
> +	with given narrow spec. Please refer to linkgit:git-checkout[1]
> +	for more detail on narrow checkout and narrow spec.

Two questions. First, can you repeat those specifiers, i.e. use
"git clone --path=3DDocumentation/ --path=3D.gitignore"?

Second, how `--path=3D<narrow_spec>` interacts with `-n' (no checkout).
Does it even have any sense? Perhaps those options should be mutually
incompatibile (and --bare and this option too)?

--=20
Jakub Narebski
Poland
ShadeHawk on #git
