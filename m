From: Andreas Gruenbacher <agruen@suse.de>
Subject: Re: [Quilt-dev] Re: being nice to patch(1)
Date: Tue, 3 Jul 2007 15:34:46 +0200
Organization: SUSE Labs, Novell
Message-ID: <200707031534.47004.agruen@suse.de>
References: <20070702125450.28228edd.akpm@linux-foundation.org> <20070702145601.a0dcef0f.akpm@linux-foundation.org> <alpine.LFD.0.98.0707021713200.9434@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>, git@vger.kernel.org
To: quilt-dev@nongnu.org
X-From: git-owner@vger.kernel.org Tue Jul 03 15:35:28 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5iXP-0001je-Jg
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 15:35:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753861AbXGCNfZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 09:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754184AbXGCNfY
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 09:35:24 -0400
Received: from ns2.suse.de ([195.135.220.15]:58581 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754153AbXGCNfY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2007 09:35:24 -0400
Received: from Relay2.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id EB8E1215E1;
	Tue,  3 Jul 2007 15:35:22 +0200 (CEST)
User-Agent: KMail/1.9.5
In-Reply-To: <alpine.LFD.0.98.0707021713200.9434@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51490>

On Tuesday 03 July 2007 02:28, Linus Torvalds wrote:
> So I would suggest that in quilt and other systems, you either:
>
>  - strip all headers manually
>
>  - forget about "patch", and use "git-apply" instead that does things
>    right and doesn't screw up like this (and can do rename diffs etc too).
>
> I guess the second choice generally isn't an option, but dammit,
> "git-apply" really is the better program here.

I'm in bit of a conflict with choice one: when applying patches in an 
automated build process or similar, the likely way to do so is a simple loop 
over the series file. So the less magic when applying patches with quilt, the 
better.

Turning off the insane heuristic with patch -u will do well enough I hope. 
Quilt does not use that option by default because it also supports context 
diffs (some people / projects prefer them), but that can easily be customized 
in .quiltrc:

    QUILT_PATCH_OPTS=-u

Andreas
