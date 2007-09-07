From: Mike Hommey <mh@glandium.org>
Subject: Re: Significant performance waste in git-svn and friends
Date: Fri, 7 Sep 2007 07:41:21 +0200
Organization: glandium.org
Message-ID: <20070907054121.GA18421@glandium.org>
References: <20070905184710.GA3632@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 07 07:42:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITWbU-0002Cd-1p
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 07:42:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752126AbXIGFl5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 01:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752117AbXIGFl4
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 01:41:56 -0400
Received: from vawad.err.no ([85.19.200.177]:49473 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752092AbXIGFl4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 01:41:56 -0400
Received: from aputeaux-153-1-67-245.w81-249.abo.wanadoo.fr ([81.249.53.245] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1ITWbJ-00086F-Pb
	for git@vger.kernel.org; Fri, 07 Sep 2007 07:41:54 +0200
Received: from mh by namakemono.glandium.org with local (Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1ITWao-00058Y-32
	for git@vger.kernel.org; Fri, 07 Sep 2007 07:41:22 +0200
Content-Disposition: inline
In-Reply-To: <20070905184710.GA3632@glandium.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Spam-Status: (score 0.0): Status=No hits=0.0 required=5.0 tests=none version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57980>

On Wed, Sep 05, 2007 at 08:47:10PM +0200, Mike Hommey <mh@glandium.org> wrote:
> Some notes about git-svn:
> - A few lines above the patched zone, the file is already read once to
>   do the MD5 sum. It should be possible to do SHA-1, MD5 sums and
>   deflate in just one pass.

FWIW, I tried, and it doesn't make it much quicker to do everything in one pass.
99% of the speedup comes from not using git-hash-object.

Mike
