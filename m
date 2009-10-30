From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC PATCH v4 14/26] Add stateless RPC options to upload-pack,
	receive-pack
Date: Fri, 30 Oct 2009 16:59:36 -0700
Message-ID: <20091030235936.GH10505@spearce.org>
References: <1256774448-7625-1-git-send-email-spearce@spearce.org> <1256774448-7625-15-git-send-email-spearce@spearce.org> <7vd446dfx4.fsf@alter.siamese.dyndns.org> <20091029152629.GY10505@spearce.org> <7vtyxi53sh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 31 00:59:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N41Nd-0004kk-UW
	for gcvg-git-2@lo.gmane.org; Sat, 31 Oct 2009 00:59:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933105AbZJ3X7c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 19:59:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933077AbZJ3X7c
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 19:59:32 -0400
Received: from george.spearce.org ([209.20.77.23]:38681 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933060AbZJ3X7b (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 19:59:31 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id A0F67381D3; Fri, 30 Oct 2009 23:59:36 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vtyxi53sh.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131779>

Junio C Hamano <gitster@pobox.com> wrote:
> I think that is probably too much complexity for too little gain.  I think
> detecting stale request and having requestor retry would be sufficient,
> and validating the want lines as we already do would give the same level
> of assurance as "check against the hash of first phase response" I
> outlined above, and would be much simpler thus more robust.

Ack.

I think what we want here is to just add an "ERR invalid want"
message just before disconnecting when the client gives us a SHA-1
which we don't point to directly.  Client implementations can choose
how to handle this error.  They could retry from the beginning,
or they could abort.

-- 
Shawn.
