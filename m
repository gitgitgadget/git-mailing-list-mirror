From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCHv3 7/8] fast-import: Add support for importing commit
	notes
Date: Wed, 29 Jul 2009 07:21:21 -0700
Message-ID: <20090729142121.GB1033@spearce.org>
References: <1248834326-31488-1-git-send-email-johan@herland.net> <1248834326-31488-8-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org, johannes.schindelin@gmx.de,
	trast@student.ethz.ch, tavestbo@trolltech.com,
	git@drmicha.warpmail.net, chriscool@tuxfamily.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Jul 29 16:21:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWA2P-0004ED-Br
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 16:21:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752676AbZG2OVW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2009 10:21:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752125AbZG2OVV
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 10:21:21 -0400
Received: from george.spearce.org ([209.20.77.23]:44479 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751448AbZG2OVV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2009 10:21:21 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 83E7C381FD; Wed, 29 Jul 2009 14:21:21 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1248834326-31488-8-git-send-email-johan@herland.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124353>

Johan Herland <johan@herland.net> wrote:
> Introduce a 'notemodify' subcommand of the 'commit' command. This subcommand
> is similar to 'filemodify', except that no mode is supplied (all notes have
> mode 0644), and the path is set to the hex SHA1 of the given "comittish".
> 
> This enables fast import of note objects along with their associated commits,
> since the notes can now be named using the mark references of their
> corresponding commits.
> 
> The patch also includes a test case of the added functionality.

Seems sane to me.

Acked-by: Shawn O. Pearce <spearce@spearce.org>
 
> +static void note_change_n(struct branch *b)
> +{
...
> +	tree_content_set(&b->branch_tree, sha1_to_hex(commit_sha1), sha1,
> +		S_IFREG | 0644, NULL);

I thought you wanted to use the note code to handle the name
formatting here?

-- 
Shawn.
