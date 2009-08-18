From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 1/6 (v4)] man page and technical discussion for rev-cache
Date: Mon, 17 Aug 2009 22:34:52 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908172227040.6044@xanadu.home>
References: <op.uys3qgmitdk399@sirnot.private>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sam Vilain <sam@vilain.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Nick Edelen <sirnot@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 18 04:35:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdEXV-00005n-FY
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 04:35:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755861AbZHRCe5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 22:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755780AbZHRCe5
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 22:34:57 -0400
Received: from relais.videotron.ca ([24.201.245.36]:63708 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755712AbZHRCe4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 22:34:56 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KOJ002QRWI4B520@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 17 Aug 2009 22:34:53 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <op.uys3qgmitdk399@sirnot.private>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126341>

On Mon, 17 Aug 2009, Nick Edelen wrote:

> diff --git a/Documentation/git-rev-cache.txt b/Documentation/git-rev-cache.txt
> new file mode 100644
> index 0000000..3479499
> --- /dev/null
> +++ b/Documentation/git-rev-cache.txt
[...]
> +add
> +~~~
> +Add revisions to the cache by creating a new cache slice.  Reads a revision
> +list from the command line, formatted as: `START START ... \--not END END ...`
> +
> +Options:
> +
> +\--all::
> +	Include all refs in the new cache slice, like the \--all option in
> +	'rev-list'.
> +
> +\--fresh::
> +	Exclude everything already in the revision cache, analogous to
> +	\--incremental in 'pack-objects'.

Why not using --incremental here as wel then?

> +\--stdin::
> +	Read newline-seperated revisions from the standard input.  Use \--not
> +	to exclude commits, as on the command line.
> +
> +\--legs::
> +	Ensure newly-generated cache slice has no partial ends.  This means that
> +	no commit has partially cached parents, in that all its parents are
> +	cached or none of them are.
> ++
> +\--legs will cause 'rev-cache' to expand potential slice end-points (creating
> +"legs") until this condition is met, simplifying the cache slice structure.
> +'rev-cache' itself does not care if a slice has legs or not, but the condition
> +may reduce the required complexity of other applications that might use the
> +revision cache.

I'm not sure I understand this.  As a user, should I care?


Nicolas
