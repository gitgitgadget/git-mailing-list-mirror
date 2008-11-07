From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH v2 3/3] pack-objects: honor '.keep' files
Date: Fri, 7 Nov 2008 11:25:06 -0800
Message-ID: <20081107192506.GB2932@spearce.org>
References: <-RiFxYEd9Wiq2fWX74zYGUiEwrzLeoFDb1KuG3-Xo-s@cipher.nrlssc.navy.mil> <LSyxMgVV7zAWRvSezvxyUc6-kz2gK6MRVKonKSf1pAmdqO-jeuMFIw@cipher.nrlssc.navy.mil> <GV8cY3fn8l5UV5cNoPN8bHchWt9u2tbZ8j_ypkiY-ZLfO1tx9d7ebA@cipher.nrlssc.navy.mil> <HBFmgmcvgPzZ0xq-fRUt98ZOBXGCvwxHGyEwF9bNcgpDgS-t-D3viw@cipher.nrlssc.navy.mil> <7v8wrwidi3.fsf@gitster.siamese.dyndns.org> <BgEXN35P6wpio928OZi_34hs22vqUQxIAIGxR5hR8LqmfPIyw565Mg@cipher.nrlssc.navy.mil> <4913F859.8070500@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@cam.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Fri Nov 07 20:26:34 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyWyT-0001Ik-AX
	for gcvg-git-2@gmane.org; Fri, 07 Nov 2008 20:26:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751557AbYKGTZJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2008 14:25:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbYKGTZJ
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Nov 2008 14:25:09 -0500
Received: from george.spearce.org ([209.20.77.23]:53044 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953AbYKGTZH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2008 14:25:07 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id C369838194; Fri,  7 Nov 2008 19:25:06 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4913F859.8070500@op5.se>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100325>

Andreas Ericsson <ae@op5.se> wrote:
>
> Only -d should honor .keep, imo. .keep-files is nothing about "don't copy
> objects from this file" and all about "never delete this file".
>
> The only muddying comes from you, who decided that .keep-files should
> have impact on anything else than deleting the protected pack. Before that,
> .keep files had a clear semantic, and repack's documentation was correct.
>
> How do you explain .keep-files now? "protects pack-files that will forever
> be used"? Then why the hell is it called ".keep" instead of "eternal"?

The _intent_ behind .keep files has always been to avoid copying
the objects into a new pack during git-repack, because the objects
are held in a pack that cannot be deleted.

Sadly the implementation has never quite worked right, which is
what led to this patch series I think.

-- 
Shawn.
