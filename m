From: Mike Hommey <mh@glandium.org>
Subject: Re: Question on git-filter-branch
Date: Thu, 1 Nov 2007 14:34:41 +0100
Organization: glandium.org
Message-ID: <20071101133440.GA17239@glandium.org>
References: <18217.52425.655322.52338@lisa.zopyra.com> <20071101125845.GA27567@glandium.org> <18217.53833.710503.667761@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Thu Nov 01 14:35:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InaD7-0008Sq-Hd
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 14:35:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753069AbXKANfg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 09:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753009AbXKANfg
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 09:35:36 -0400
Received: from vawad.err.no ([85.19.200.177]:35546 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752844AbXKANff (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 09:35:35 -0400
Received: from aputeaux-153-1-31-123.w82-124.abo.wanadoo.fr ([82.124.1.123] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1InaCo-0007Gn-SD; Thu, 01 Nov 2007 14:35:33 +0100
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1InaC1-0005AY-3f; Thu, 01 Nov 2007 14:34:41 +0100
Content-Disposition: inline
In-Reply-To: <18217.53833.710503.667761@lisa.zopyra.com>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Spam-Status: (score 2.0): Status=No hits=2.0 required=5.0 tests=RCVD_IN_SORBS_DUL version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62958>

On Thu, Nov 01, 2007 at 07:19:05AM -0600, Bill Lear wrote:
> >Just remove .git/refs/original/
> 
> Ok, thanks.  But, how do I remove the subdirectory?
> 
> % rm -rf .git/refs/original
> % git filter-branch --index-filter 'git update-index --remove sensitive_stuff' HEAD
> Rewrite 6711f6a50605918326f67ca0c3402eab9a4c8571 (8/8)
> WARNING: Ref 'refs/heads/master' is unchanged

git-update-index --remove will remove files, not trees, so you need to
use something like
git-ls-files ensitive_stuff | xargs -d "\n" git-update-index --remove
instead.

Mike
