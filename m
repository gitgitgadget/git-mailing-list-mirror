From: Derek Fawcus <dfawcus@cisco.com>
Subject: Re: [PATCH v2] git-am: fix maildir support regression for unordered headers in emails
Date: Wed, 15 Jul 2009 13:54:19 +0100
Message-ID: <20090715125419.GA21811@gpk-lds-007.cisco.com>
References: <20090714122354.GA13806@vidovic> <2433101adeafddeab78815083446552ff3ea9f49.1247636959.git.nicolas.s.dev@gmx.fr> <7vljmqflti.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>, git@vger.kernel.org,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 15 15:04:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MR49m-0005ow-Nf
	for gcvg-git-2@gmane.org; Wed, 15 Jul 2009 15:04:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752004AbZGONEO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jul 2009 09:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751888AbZGONEO
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Jul 2009 09:04:14 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:17740 "EHLO
	ams-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750885AbZGONEN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jul 2009 09:04:13 -0400
X-Greylist: delayed 587 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Jul 2009 09:04:13 EDT
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AmAAAEduXUqQ/uCKe2dsb2JhbACZOAEBFiQGnQ6II5EJBYQJgUI
X-IronPort-AV: E=Sophos;i="4.42,404,1243814400"; 
   d="scan'208";a="45147124"
Received: from ams-dkim-1.cisco.com ([144.254.224.138])
  by ams-iport-1.cisco.com with ESMTP; 15 Jul 2009 12:54:25 +0000
Received: from ams-core-1.cisco.com (ams-core-1.cisco.com [144.254.224.150])
	by ams-dkim-1.cisco.com (8.12.11/8.12.11) with ESMTP id n6FCsO4S028567;
	Wed, 15 Jul 2009 14:54:24 +0200
Received: from gpk-lds-007.cisco.com (gpk-lds-007.cisco.com [64.103.78.12])
	by ams-core-1.cisco.com (8.13.8/8.14.3) with ESMTP id n6FCsOR2001251;
	Wed, 15 Jul 2009 12:54:24 GMT
Received: from gpk-lds-007.cisco.com (localhost [127.0.0.1])
	by gpk-lds-007.cisco.com (8.13.1/8.13.1) with ESMTP id n6FCsMOs020490;
	Wed, 15 Jul 2009 13:54:22 +0100
Received: (from dfawcus@localhost)
	by gpk-lds-007.cisco.com (8.13.1/8.13.1/Submit) id n6FCsKqi020373;
	Wed, 15 Jul 2009 13:54:20 +0100
Content-Disposition: inline
In-Reply-To: <7vljmqflti.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.4.1i
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; l=1045; t=1247662464; x=1248526464;
	c=relaxed/simple; s=amsdkim1002;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=dfawcus@cisco.com;
	z=From:=20Derek=20Fawcus=20<dfawcus@cisco.com>
	|Subject:=20Re=3A=20[PATCH=20v2]=20git-am=3A=20fix=20maildi
	r=20support=20regression=20for=20unordered=20headers=20in=20
	emails
	|Sender:=20;
	bh=bDi8AaZFlQSbFwD+Q6UMLmdcibYnNv8gV9s3eGvwsjI=;
	b=Ob6kXTYjHnFQpV69aTf72o038Rd0uJvXceqEzIV1HBV/pVcLhJw+Vbc+9l
	Xjcjgxd4sVFdxSiFAChZIFaWGT+PbnymMn/iXCiucEfWzLyZvQEUg629KyXW
	nRDoeTLx3g;
Authentication-Results: ams-dkim-1; header.From=dfawcus@cisco.com; dkim=pass (
	sig from cisco.com/amsdkim1002 verified; ); 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123306>

On Wed, Jul 15, 2009 at 12:27:05AM -0700, Junio C Hamano wrote:
> Nicolas Sebrecht <nicolas.s.dev@gmx.fr> writes:
> 
> > Patch format detection introduced by a5a6755a1d4707bf2fab7752e5c974ebf63d086a
> > may refuse valid patches from verbatim emails.
> 
> It is unclear what you meant by "verbatim email".  A verbatim e-mail
> in mbox begins with "From " header that is already covered in the existing
> code long before support for stgit/hg was added.

I believe he is referring to the claimed support for maildir format boxes.

> But I am not convinced that I understand what _problem_ you are trying to
> solve in the first place.

Assuming it is maildir support,  then there is no 'header' as such in the
file which can be detected.  One could try and detect that the contents
are structured as an RFC822 message (but with local line ends),  or one
could try and detect that the file is within a maildir folder.

It seems this patch is taking the former approach and trying to ensure
the file consists of header fields.
