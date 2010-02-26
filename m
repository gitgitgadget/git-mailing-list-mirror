From: Andreas Gruenbacher <agruen@suse.de>
Subject: Re: [PATCH 2/3] Different views on a repository
Date: Fri, 26 Feb 2010 22:35:43 +0100
Organization: SUSE Labs
Message-ID: <201002262235.43929.agruen@suse.de>
References: <cover.1267029680.git.agruen@suse.de> <7vljeh9qcx.fsf@alter.siamese.dyndns.org> <201002260145.33960.agruen@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 22:35:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nl7qi-00029j-Lu
	for gcvg-git-2@lo.gmane.org; Fri, 26 Feb 2010 22:35:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966188Ab0BZVfr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2010 16:35:47 -0500
Received: from cantor2.suse.de ([195.135.220.15]:55202 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966162Ab0BZVfq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2010 16:35:46 -0500
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	by mx2.suse.de (Postfix) with ESMTP id 520A8867E2;
	Fri, 26 Feb 2010 22:35:45 +0100 (CET)
User-Agent: KMail/1.12.2 (Linux/2.6.31.12-0.1-desktop; KDE/4.3.1; x86_64; ; )
In-Reply-To: <201002260145.33960.agruen@suse.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141152>

On Friday 26 February 2010 01:45:33 Andreas Gruenbacher wrote:
> A combination of the two approaches would be to "link forward" instead of
> "linking back", so that the consolidated view would maintain itself, with a
> server repo setup like this:
> 
> 	/repos/ABC:
> 		objects
> 		refs/tags/A/
> 		refs/tags/B/
> 		refs/heads/A/
> 		refs/heads/B/
> 
> 	/repos/A:
> 		refs/tags -> /repos/ABC/refs/tags/A/
> 		refs/heads -> /repos/ABC/refs/heads/A/
> 		objects -> /repos/ABC/objects/
> 
> 	/repos/B:
> 		refs/tags -> /repos/ABC/refs/tags/B/
> 		refs/heads -> /repos/ABC/refs/heads/B/
> 		objects -> /repos/ABC/objects/
> 
> This could be made safe by not doing garbage collection if objects is a
> symlink instead of a directory.  (The ABC repo could be garbage collected
>  as usual.)  Am I overlooking anything why this can't work?

Self reply: reference packing breaks this kind of setup.  Crap.

Andreas
