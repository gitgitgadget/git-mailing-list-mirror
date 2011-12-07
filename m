From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH, v4] git-tag: introduce --cleanup option
Date: Wed, 7 Dec 2011 04:58:46 +0200
Message-ID: <20111207025837.GA31369@shutemov.name>
References: <1322972426-7591-1-git-send-email-kirill@shutemov.name>
 <20111205215148.GA22663@sigill.intra.peff.net>
 <7vvcpuk5ex.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 07 03:58:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RY7if-0002vv-AE
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 03:58:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754939Ab1LGC6s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Dec 2011 21:58:48 -0500
Received: from shutemov.name ([188.40.19.243]:52245 "EHLO shutemov.name"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751550Ab1LGC6s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2011 21:58:48 -0500
Received: by shutemov.name (Postfix, from userid 500)
	id 1D32A114001; Wed,  7 Dec 2011 04:58:46 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <7vvcpuk5ex.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186417>

On Mon, Dec 05, 2011 at 02:41:26PM -0800, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > More importantly, though, this seems to break t6300 badly. I haven't
> > looked into why yet, though.
> 
> Probably two issues.
> 
>  - opt.message (and the original 'message') was misnamed and confused the
>    patch author what "if (!message && !buf->len)" meant.
> 
>  - "opt" is a structure meant to be extensible, but is not initialized as
>    a whole, inviting future errors.

Sorry for that and thanks for the investigation.

> It still seems to be broken with respect to the primary thing the patch
> wanted to do (t7400 "git tag -F commentsfile comments-annotated-tag" does
> not seem to produce an expected result), so I'll kick it back to the
> Kirill to look at.

CLEANUP_ALL should always be default regardless of opt.message_given.

I'll send new version.

-- 
 Kirill A. Shutemov
