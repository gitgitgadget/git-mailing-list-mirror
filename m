From: Matt Mackall <mpm@selenic.com>
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
Date: Sat, 30 Apr 2005 09:06:40 -0700
Message-ID: <20050430160640.GK21897@waste.org>
References: <200504301444.j3UEiHN05686@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: andrea@suse.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 30 18:01:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRuOo-00059x-OE
	for gcvg-git@gmane.org; Sat, 30 Apr 2005 18:00:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261271AbVD3QGs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Apr 2005 12:06:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261274AbVD3QGs
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Apr 2005 12:06:48 -0400
Received: from waste.org ([216.27.176.166]:45240 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261271AbVD3QGq (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Apr 2005 12:06:46 -0400
Received: from waste.org (localhost [127.0.0.1])
	by waste.org (8.13.4/8.13.4/Debian-1) with ESMTP id j3UG6e9G016914
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 30 Apr 2005 11:06:40 -0500
Received: (from oxymoron@localhost)
	by waste.org (8.13.4/8.13.4/Submit) id j3UG6e5J016911;
	Sat, 30 Apr 2005 11:06:40 -0500
To: "Adam J. Richter" <adam@yggdrasil.com>
Content-Disposition: inline
In-Reply-To: <200504301444.j3UEiHN05686@adam.yggdrasil.com>
User-Agent: Mutt/1.5.6+20040907i
X-Virus-Scanned: by amavisd-new
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 30, 2005 at 07:44:17AM -0700, Adam J. Richter wrote:
>
> 	I'd like to mention a couple of possible optimizations
> for both the with and without compression approaches.
> 
> 	If you remove the gzip compression, then I imagine you could
> do much of the IO of checking out files via sendfile, without
> ever copying data to program space or even changing the program's
> memory map.  There apparently exists a python sendfile module.
> 
> 	If this mercurial were written in C, much of the rest of
> the IO could be optimized with mmap (to reduce copies) and writev
> in the absense of a compression pass.  I don't know enough about
> python to know if these optimizations are available.

Python can do mmap, not sure about writev. 

But I'm currently still in the "keep it as simple as possible" stage.
There's a bunch of room for optimization still, but if I do it all
now, it'll make things hard when I run into the next design change.

And there's still some important core work that needs doing - checkout
and commit need to be a subcase of the core merge code.

-- 
Mathematics is the supreme nostalgia of our time.
