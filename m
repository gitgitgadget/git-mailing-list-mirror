From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] provide advance warning of some future pack default changes
Date: Tue, 18 Dec 2007 14:47:35 +0100
Message-ID: <200712181447.36228.jnareb@gmail.com>
References: <20071215004230.GF7300@mail.oracle.com> <20071218111136.GA6266@coredump.intra.peff.net> <Pine.LNX.4.64.0712181204500.23902@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Nicolas Pitre <nico@cam.org>,
	Joel Becker <Joel.Becker@oracle.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Dec 18 14:48:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4cny-00055k-SW
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 14:48:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755206AbXLRNrn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 08:47:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754839AbXLRNrm
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 08:47:42 -0500
Received: from fk-out-0910.google.com ([209.85.128.189]:32085 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755202AbXLRNrl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 08:47:41 -0500
Received: by fk-out-0910.google.com with SMTP id z23so2065835fkz.5
        for <git@vger.kernel.org>; Tue, 18 Dec 2007 05:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=iR/IAfQX8PKgyoEA09jI8+vqSN8WpSau2cfoG86wICE=;
        b=WwaX6i6nUBMxhl68FHN19mAffC1c/x2NZ79z3ttakHhGF6RGDPWX+5dlpon/L1z5mjlpYtGkiD6IzYMHiXSCaonJpfqm0c5mzJMO/b5Acan76hZl5IB5kd3y9xKs/16aXJ0nzGWNcY4F9JJAhhxuCwDnMIQd/npM9pv7qBTQhqM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=uCVcQZ8yprfrqrEYJJTop7e411ye9QLF5ex8nDtsGnY1lPbZ/oHOvnEa6yUW66Y5D46ryIDRhs7hvT7zVN2kz6jKnYoFCXbW6fi3/Xg7Aud3/WEUBESp8em+/0uk5S6SBdu9FComiFFkFLbgkVVaodWlOHmkZKua8dGIXjF7qJw=
Received: by 10.82.177.3 with SMTP id z3mr7654823bue.35.1197985659900;
        Tue, 18 Dec 2007 05:47:39 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.255.201])
        by mx.google.com with ESMTPS id b30sm1772078ika.2007.12.18.05.47.37
        (version=SSLv3 cipher=OTHER);
        Tue, 18 Dec 2007 05:47:39 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.64.0712181204500.23902@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68746>

Johannes Schindelin wrote:
> On Tue, 18 Dec 2007, Jeff King wrote:
> 
>>   - moving dashed forms out of paths
> 
> Playing it safe, and waiting with this after announcing it more obviously, 
> is something that I appreciate.  Too many scripts can break, and I am sure 
> quite a few of mine will; I simply do not have the time right now to audit 
> them.

We could do it IMVHO in two (or two an a half :-)) steps:

1. Decide where separate exec-path area should be, following FHS. Create
   it during install. Install helper scripts there, moving it out of PATH.
   Test those tools which use helper scripts (helper commands), which
   should be _much_ easier than testing whole git for "moving dashed forms
   out of path" breakage.

2. Move dashed forms out of PATH, perhaps leaving (or with option of
   leaving) dashed forms of porcelain in PATH. Test all scripts and tests
   ;-)
   
I think that the first step can be done before 1.6.0, perhaps even
before 1.5.4
-- 
Jakub Narebski
Poland
