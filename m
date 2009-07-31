From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: suppress 'Use of uninitialized value' error
Date: Fri, 31 Jul 2009 08:24:41 +0200
Message-ID: <200907310824.42953.jnareb@gmail.com>
References: <1248988540-8971-1-git-send-email-giuseppe.bilotta@gmail.com> <200907310100.42786.jnareb@gmail.com> <cb7bb73a0907302306k691b1d4fy85d7b460077bc639@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@suse.cz>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 31 08:18:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWlS5-00065B-J9
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 08:18:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbZGaGST convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 31 Jul 2009 02:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751160AbZGaGSS
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Jul 2009 02:18:18 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:40086 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751024AbZGaGSS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2009 02:18:18 -0400
Received: by ey-out-2122.google.com with SMTP id 9so513010eyd.37
        for <git@vger.kernel.org>; Thu, 30 Jul 2009 23:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=9iPuMpFiNEQGBlX3TOtqUsxiT9nGDThHbjTVDRhZgkI=;
        b=elrcGjxGpxglUlmXq75b1qxGYgFPoxQZOUY1EAUsSQWPLZMw2sOG2VdZ7EsejpW6ZN
         LofLHQYby2YvBvXnHmUzS03Hh4lCn2guNW4ADKu83VgzgAHrXs8Vrx4g9wOXgb4rleVl
         wILVxlwoSQcAkh1gfOVOcleZGFXVh8XJQFyrs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=daAT9TqiTBORqgghpKnvYqqJJWNdc9+O9z+LWCxeabsmUjivR8Jhhkf9whMEp34o2d
         hLLdoRqgcPsCTNL86a5R8Be3Pw0Nrhf6CiXIEkL15wOUCIu89bNd0o2M5Rymkuss7A7R
         73F1qmatpowBGoHK34zhE7x12Bm6H1kNeyqZY=
Received: by 10.210.66.13 with SMTP id o13mr2527024eba.52.1249021097235;
        Thu, 30 Jul 2009 23:18:17 -0700 (PDT)
Received: from ?192.168.1.13? (abvk103.neoplus.adsl.tpnet.pl [83.8.208.103])
        by mx.google.com with ESMTPS id 24sm1727883eyx.53.2009.07.30.23.18.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 30 Jul 2009 23:18:16 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <cb7bb73a0907302306k691b1d4fy85d7b460077bc639@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124506>

Giuseppe Bilotta wrote:
> 2009/7/31 Jakub Narebski <jnareb@gmail.com>:

> >=A0I don't think gitweb generates such
> > broken links (with 'hash_parent_base' but not 'file_parent') normal=
ly,
> > but I might be mistaken.
>=20
> Do you think it would be worth to protect against this case?

Yes, of course it is worth protecting against this case (better checkin=
g
if both sides of 'eq' comparison are defined).  We want to return error
message from gitweb if URL is borked, not have Perl error in logs.

--=20
Jakub Narebski
Poland
