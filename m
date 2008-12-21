From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 1/2] fast-import: add special mode; copy from parent.
Date: Sun, 21 Dec 2008 14:07:57 -0800
Message-ID: <20081221220757.GA17355@spearce.org>
References: <1229825502-963-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 21 23:09:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEWU8-0004OJ-R9
	for gcvg-git-2@gmane.org; Sun, 21 Dec 2008 23:09:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439AbYLUWH7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Dec 2008 17:07:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbYLUWH7
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Dec 2008 17:07:59 -0500
Received: from george.spearce.org ([209.20.77.23]:52499 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751378AbYLUWH6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Dec 2008 17:07:58 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id BE2CB38200; Sun, 21 Dec 2008 22:07:57 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1229825502-963-1-git-send-email-felipe.contreras@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103717>

Felipe Contreras <felipe.contreras@gmail.com> wrote:
> +	if (!prefixcmp(p, "- ")) {
> +		mode = 0;
> +		p += 2;

This part made me wonder, why are we always doing "S_IFREG | mode"
further down?

> +	} else {
> +		p = get_mode(p, &mode);
> +		if (!p)
> +			die("Corrupt mode: %s", command_buf.buf);
> +		switch (mode) {
> +		case S_IFREG | 0644:
> +		case S_IFREG | 0755:
> +		case S_IFLNK:
> +		case S_IFGITLINK:
> +		case 0644:
> +		case 0755:
> +			/* ok */
> +			break;
> +		default:
> +			die("Corrupt mode: %s", command_buf.buf);
> +		}

-- 
Shawn.
