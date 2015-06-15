From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH (resend)] git-gui: make gc warning threshold match 'git
 gc --auto'
Date: Mon, 15 Jun 2015 18:41:40 +0200
Message-ID: <20150615164140.GA8990@book.hvoigt.net>
References: <557C90F9.8000200@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Pat Thoyts <patthoyts@gmail.com>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 15 18:41:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4XSM-0006I1-1d
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jun 2015 18:41:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754130AbbFOQlu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2015 12:41:50 -0400
Received: from smtprelay04.ispgateway.de ([80.67.31.32]:58734 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752139AbbFOQls (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2015 12:41:48 -0400
Received: from [178.11.201.3] (helo=book.hvoigt.net)
	by smtprelay04.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.84)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1Z4XSD-00033u-FY; Mon, 15 Jun 2015 18:41:45 +0200
Content-Disposition: inline
In-Reply-To: <557C90F9.8000200@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271689>

On Sat, Jun 13, 2015 at 10:22:17PM +0200, Karsten Blees wrote:
> Date: Wed, 6 Aug 2014 20:43:46 +0200
> 
> The number of loose objects at which git-gui shows a gc warning has
> historically been hardcoded to ~2000, or ~200 on Windows. The warning can
> only be disabled completely via gui.gcwarning=false.
> 
> Especially on Windows, the hardcoded threshold is so ridiculously low that
> git-gui often complains even immediately after gc (due to loose objects
> only referenced by the reflog).
> 
> 'git gc --auto' uses a much bigger threshold to check if gc is necessary.
> Additionally, the value can be configured via gc.auto (default 6700).
> There's no special case for Windows.
> 
> Change git-gui so that it only warns if 'git gc --auto' would also do an
> automatic gc, i.e.:
>  - calculate the threshold from the gc.auto setting (default 6700,
>    disabled if <= 0)
>  - check directory .git/objects/17
> 
> We still check four directories (14-17) if gc.auto is very small, to get a
> better estimate.
> 
> Signed-off-by: Karsten Blees <blees@dcon.de>

Thanks, I like this!

Cheers Heiko
