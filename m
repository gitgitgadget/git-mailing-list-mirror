From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [PATCH 2/3] Add gitmodules(5)
Date: Sun, 10 Jun 2007 02:28:02 +0200
Message-ID: <20070610002802.GD31707@planck.djpig.de>
References: <1181425132239-git-send-email-hjemli@gmail.com> <11814251322779-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sven Verdoolaege <skimo@kotnet.org>, git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 10 02:28:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxBHx-0005iQ-Nt
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 02:28:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759204AbXFJA2M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jun 2007 20:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759098AbXFJA2M
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jun 2007 20:28:12 -0400
Received: from planck.djpig.de ([85.10.192.180]:4155 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759181AbXFJA2M (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2007 20:28:12 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id B26608803E;
	Sun, 10 Jun 2007 02:28:09 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ynIER1GCB+v5; Sun, 10 Jun 2007 02:28:03 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id 03C5888105; Sun, 10 Jun 2007 02:28:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <11814251322779-git-send-email-hjemli@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49644>

The unofficial git documentation nitpicker at work ;)

On Sat, Jun 09, 2007 at 11:38:51PM +0200, Lars Hjemli wrote:
> +The `.gitmodules` file, located in the top-level directory of a
> +gitlink:git[7] working tree, is a text file with a layout matching the

That link seems superfluous to me.
I would have used "syntax" instead of "layout".

> +requirements of gitlink:git-config[1].
> +
> +The file consists of sections named `module`, divided into one subsection
> +per submodule. The subsections are named with the logical name of the
> +submodule it describes.

"sections named module" sounds confusing to me. Why are there multiple
sections named module? (for the record: I know what you mean, I just
don't know if it couldn't be said simpler)
Maybe better "subsections of section `module`, one per submodule"?
Hmm, sounds ugly too.

> +Each submodule can contain the following keys.
> +
> +module.$name.path::
> +	Define a path, relative to the top-level directory of the git
> +	working tree, where the submodule is expected to be checked out.
> +
> +module.$name.url::
> +	Define a url from where the submodule repository can be cloned.

For .path a "Defaults to name of submodule" probably wouldn't hurt.

For the sake of documentation consistency I would suggest
module.<name>.path. You can compare the output of
$ grep "\.<[a-z]" Documentation/*.txt
with
$ grep "\.\$[a-z]" Documentation/*.txt
to see what I mean.

> +	[module 'libfoo']
> +		path = include/foo
> +		url = git://example1.com/git/libfoo.git
> +
> +	[module 'libbar']
> +		url = git://example2.com/pub/git/libbar.git

This would actually be a syntax error in a git config file
(subsection names can be enclosed in "" but not '').

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
