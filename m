From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 4/8] git-repack --max-pack-size: add fixup_header_footer()
Date: Sun, 08 Apr 2007 17:04:04 -0700
Message-ID: <7vwt0m76rv.fsf@assigned-by-dhcp.cox.net>
References: <46197950.3080804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 09 02:05:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HahMh-0008A8-V0
	for gcvg-git@gmane.org; Mon, 09 Apr 2007 02:04:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752140AbXDIAEJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Apr 2007 20:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752141AbXDIAEI
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Apr 2007 20:04:08 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:35411 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752140AbXDIAEH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Apr 2007 20:04:07 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070409000405.HYLN24385.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Sun, 8 Apr 2007 20:04:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id ko451W00A1kojtg0000000; Sun, 08 Apr 2007 20:04:05 -0400
cc: Shawn Pearce <spearce@spearce.org>, Nicolas Pitre <nico@cam.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44020>

Dana How <danahow@gmail.com> writes:

> +/*
> + * Move this, the version in fast-import.c,
> + * and index_pack.c:readjust_pack_header_and_sha1 into sha1_file.c ?
> + */
> +static void fixup_header_footer(int pack_fd, unsigned char *pack_file_sha1,
> +				char *pack_name, uint32_t object_count)
> +{

Indeed that is a very good point.

I admit I did not notice we already had the duplication between
fast-import.c and index-pack.c

Shawn, Nico, what do you think?  Wouldn't it be better to
refactor them first, independent of Dana's series?
