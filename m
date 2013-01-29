From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 4/6] introduce a commit metapack
Date: Tue, 29 Jan 2013 11:24:45 +0100
Message-ID: <5107A36D.2050307@alum.mit.edu>
References: <20130129091434.GA6975@sigill.intra.peff.net> <20130129091610.GD9999@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 29 11:25:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U08NK-000214-ST
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 11:25:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752997Ab3A2KYu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2013 05:24:50 -0500
Received: from ALUM-MAILSEC-SCANNER-1.MIT.EDU ([18.7.68.12]:44150 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751464Ab3A2KYs (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Jan 2013 05:24:48 -0500
X-AuditID: 1207440c-b7fde6d00000088a-60-5107a36f1147
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id F8.89.02186.F63A7015; Tue, 29 Jan 2013 05:24:47 -0500 (EST)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r0TAOjgm002384
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 29 Jan 2013 05:24:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
In-Reply-To: <20130129091610.GD9999@sigill.intra.peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCKsWRmVeSWpSXmKPExsUixO6iqJu/mD3Q4NVCNYuuK91MFt1T3jJa
	/GjpYbaYf2giqwOLx85Zd9k9nvXuYfT4c34Pq8fnTXIBLFHcNkmJJWXBmel5+nYJ3BkLbrIX
	fGGt+DxpH0sD41OWLkZODgkBE4n+N2fYIGwxiQv31gPZXBxCApcZJdrXrmMGSQgJHGeSeNrB
	AWLzCmhLfOj5yQpiswioSpy+ewHMZhPQlVjU08wEYosKhEn0vj7HCFEvKHFy5hOwZSICshLf
	D28EizMLZEps/LcEbL4w0BEL9h5lgdiVLtE9tQOshlPASmLz73dAcQ6genWJ9fOEIFrlJba/
	ncM8gVFgFpINsxCqZiGpWsDIvIpRLjGnNFc3NzEzpzg1Wbc4OTEvL7VI11AvN7NELzWldBMj
	JJR5djB+WydziFGAg1GJh7d5AVugEGtiWXFl7iFGSQ4mJVHeWwvZA4X4kvJTKjMSizPii0pz
	UosPMUpwMCuJ8LrWAuV4UxIrq1KL8mFS0hwsSuK8qkvU/YAeSyxJzU5NLUgtgsnKcHAoSfBu
	WATUKFiUmp5akZaZU4KQZuLgBBnOJSVSnJqXklqUWFqSEQ+K0fhiYJSCpHiA9maBtPMWFyTm
	AkUhWk8x6nJs/93+nFGIJS8/L1VKnLcZpEgApCijNA9uBSxxvWIUB/pYmHcrSBUPMOnBTXoF
	tIQJaIlRG9iSkkSElFQDo6Y64/YmflO+/QuemT8/68ys81lla4b3ATYxZUf3043sBZZ8braP
	v87tKO5mOainfuevfQf//YdbPhq5TGL83Hn0gpmF+DH2zvmf3P0iknv6+hPSryeE 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214924>

On 01/29/2013 10:16 AM, Jeff King wrote:
> When we are doing a commit traversal that does not need to
> look at the commit messages themselves (e.g., rev-list,
> merge-base, etc), we spend a lot of time accessing,
> decompressing, and parsing the commit objects just to find
> the parent and timestamp information. We can make a
> space-time tradeoff by caching that information on disk in a
> compact, uncompressed format.
> 
> TODO: document on-disk format in Documentation/technical
> TODO: document API

Would this be a good place to add the commit generation number that is
so enthusiastically discussed on the mailing list from time to time?

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
