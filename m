From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: [PATCH 2/3] git-daemon: use getnameinfo to resolve hostname
Date: Wed, 14 Jan 2009 09:22:45 -0500
Message-ID: <76718490901140622i1c29cd96u1b30042ad9ecb5d9@mail.gmail.com>
References: <alpine.LSU.2.00.0901141147120.16109@fbirervta.pbzchgretzou.qr>
	 <alpine.LSU.2.00.0901141148130.16109@fbirervta.pbzchgretzou.qr>
	 <20090114122536.GA5939@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Jan Engelhardt" <jengelh@medozas.de>, git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 14 15:24:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LN6fR-0007gS-5E
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 15:24:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755010AbZANOWt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 09:22:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754960AbZANOWr
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 09:22:47 -0500
Received: from rv-out-0506.google.com ([209.85.198.238]:37051 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754849AbZANOWq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 09:22:46 -0500
Received: by rv-out-0506.google.com with SMTP id k40so547882rvb.1
        for <git@vger.kernel.org>; Wed, 14 Jan 2009 06:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=weWxHIBawyIv0e2DShswjXF9hKHmVsR1LO8aehpCdcQ=;
        b=NjvsoDPAVIBTUnV5bX14xZdSAvT8MIMRNR/9649QdAm5ITTJkll3+hRDcdZexfmlMm
         37mWHqH2/PjgJeXZ4Gyz/ykAlcWoAr6LSFkJYpv2lYrpYnj9guZ6gBu54jYrJ1Sye2aN
         XzzHrE22nLuC/A8JDu15T69D1sgprQf241sE8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Ru0VCLaldIFZA+qsHIJfgIengHQNIxlsZnksCdSKOb4cpy3mwzinMM9ascleZPgIKD
         ZPsV8wxPeabh54Gq3T4UuRL1reSn1lhk7FCX+vE3Di9HBxwEGRK/zifROceQtV3FsFIe
         IxrWDYXrOGwCDyTG/LSomh6AismJFYGYQF/Fw=
Received: by 10.141.107.13 with SMTP id j13mr48018rvm.141.1231942965864;
        Wed, 14 Jan 2009 06:22:45 -0800 (PST)
Received: by 10.140.204.11 with HTTP; Wed, 14 Jan 2009 06:22:45 -0800 (PST)
In-Reply-To: <20090114122536.GA5939@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105632>

On Wed, Jan 14, 2009 at 7:25 AM, Jeff King <peff@peff.net> wrote:
> So at the very least, you should be adding REMOTE_HOST in _addition_ to
> REMOTE_ADDR, not instead of. But that still leaves one final concern,
> which is that some git-daemon admins might not want to pay the cost for
> a reverse lookup for every request. It's extra network traffic, and adds
> extra latency to the process (but I don't personally run git-daemon, and
> I don't know whether big sites like kernel.org actually care about
> this).

Speaking for large sites everywhere, yes they do care. Enabling DNS
lookups must be configurable.

j.
