From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH 7/7] make "git fetch" update all fetch repositories
Date: Tue, 29 Apr 2008 08:55:58 +0200
Message-ID: <4816C67E.8010600@gnu.org>
References: <cover.1209391614.git.bonzini@gnu.org> <55a4068681841e6c3579f4183b469fc7aa4de266.1209391615.git.bonzini@gnu.org> <20080428181012.GB6710@steel.home> <48161544.90500@gnu.org> <20080428213339.GC10600@steel.home> <4816A989.2010204@gnu.org> <20080429053814.GA3332@steel.home> <4816BAB1.7080601@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	spearce@spearce.org, gitster@pobox.com, peff@peff.net,
	johannes.schindelin@gmx.de, srb@cuci.nl
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Apr 29 08:56:51 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jqjlh-00031R-31
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 08:56:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755161AbYD2G4A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 02:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754564AbYD2G4A
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 02:56:00 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:33892 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755161AbYD2Gz7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 02:55:59 -0400
Received: by fg-out-1718.google.com with SMTP id l27so5109902fgb.17
        for <git@vger.kernel.org>; Mon, 28 Apr 2008 23:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=kkFNTGeWBRIvJCm4Zr7H3rR7QdpwN1LUyfLQfjBIFes=;
        b=G4wMnvZ1zcXm2dVHAbZX1vOWC8yc08Y1STjILo5Hmty4Jj/e4MqfvH1YTvob2VifwWnDnUU2xcpTF/3gxqu783Jb8Z/Jhs5d5lo69L4Uv3IFFt034Ybf0PNrRZqb0DFFZI1yYVddC86w/ToovFe7yz3FdKCWnSlWDmOnJVA5vrg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:sender;
        b=v0CkXUgDRiT19RVdCe1BS8u0MHGdp06F+p7G+/8V0kYJKn0prd3sNAjbV1SkK65Te/ib6xs9gNeP41+Dc/Qzzswo8LXwZxZUsVR41VFMP8zyn1zzUVAaBASSI6fts3CeFfpSoV7yPB/oQ6Ev7iwkIyb5KOuEtJ+/1Iz97MRK+RA=
Received: by 10.86.68.1 with SMTP id q1mr45001fga.27.1209452158515;
        Mon, 28 Apr 2008 23:55:58 -0700 (PDT)
Received: from scientist-2.local ( [195.176.178.209])
        by mx.google.com with ESMTPS id j9sm28151822mue.6.2008.04.28.23.55.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 28 Apr 2008 23:55:56 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.12 (Macintosh/20080213)
In-Reply-To: <4816BAB1.7080601@op5.se>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80655>

> Some of them point to my colleagues laptops, where temporary
> git-daemons sometimes serve content, and sometimes it doesn't.

Again, you should probably have skipDefaultUpdate set on those remotes 
even now!  A patch that makes a "wrong" (or incomplete) configuration 
more apparent, is not necessarily wrong in itself.  (I was sort of 
expecting these objections -- the patches are designed to make the 
common use cases easier, and of course on this list you will find 
experts with less common scenarios).

In case it was not clear: it's not like the fetch command will *always* 
update all repositories.  Only the zero-argument variation will.

> How about renaming "skipDefaultUpdate" to "fetch.fetchAllRemotes" and
> let it default to false?

Renaming can be done (as a followup preferably, the patch series touches 
enough places like this).  But not setting the default, as that would 
destroy the "base case" where "git fetch" just fetches from origin.

Paolo
