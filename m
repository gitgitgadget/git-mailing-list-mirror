From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] git-gui: change the termination checks to avoid
 potential hang.
Date: Tue, 17 Aug 2010 23:21:07 -0500
Message-ID: <20100818042107.GC21185@burratino>
References: <20100704203342.6064.32250.reportbug@balanced-tree>
 <20100704212125.GA1613@burratino>
 <20100704212439.GA1765@burratino>
 <87iq3bh1op.fsf_-_@fox.patthoyts.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Anders Kaseorg <andersk@MIT.EDU>, git@vger.kernel.org
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Wed Aug 18 06:22:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlaAt-0006ZZ-Aw
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 06:22:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104Ab0HREWq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Aug 2010 00:22:46 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:37762 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750798Ab0HREWp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Aug 2010 00:22:45 -0400
Received: by gwj17 with SMTP id 17so35186gwj.19
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 21:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=8xzH5DbUUc+XL9iqYM8i7Ng9mdC+mu8KSC6mxI0zSpc=;
        b=MgKL+y1exYYP1qBRFpuPjHdpd+GdDzSOEWfRXmgJX74DFuL4NU1myL2tVeNnolf2uW
         th+ORbMAjByL+x3a34pJtrVCxom91D2ldkx2pQcWYsBS9QYf69uExVkdXHmK3gNSHoHq
         2oAuA1Y9R6QfTokvu23S+aWtDFZ4XZMVpZTG8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=oss0+6rSoXj5lwJCRgQngWmKu8laahQjjSuZUrc0J3m30VB0tpkF54jJfZkXSLTql3
         05cN1QfMAjAKm/IYz4V+PMQkm+Xv6vxm0YZi5eqdgbEf9IUCd05f/i6Norfd5ITPFaro
         /RYdqjq/zc0jpd66BzXOuV8ecWxqhrjj+EAlE=
Received: by 10.150.2.8 with SMTP id 8mr8143186ybb.394.1282105364487;
        Tue, 17 Aug 2010 21:22:44 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id q21sm1654507ybk.15.2010.08.17.21.22.43
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 17 Aug 2010 21:22:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87iq3bh1op.fsf_-_@fox.patthoyts.tk>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153810>

Pat Thoyts wrote:

> Supposedly

And consistently.

 $ wish
 % puts $tcl_version
 8.5
 % puts $tk_version
 8.5
 $ dpkg -l tcl8.5 tk8.5 | tail -2
 ii  tcl8.5         8.5.8-2       Tcl (the Tool Command Language) v8.5 - ru
 ii  tk8.5          8.5.8-1       Tk toolkit for Tcl and X11, v8.5 - run-ti
 $ ./git-gui--askpass
 <types passphrase>

The window would stay open and hang.

> Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
> ---
>  git-gui--askpass |   17 +++++++++++------
>  1 files changed, 11 insertions(+), 6 deletions(-)

Tested-by: Jonathan Nieder <jrnieder@gmail.com>

> +++ b/git-gui--askpass
[...]
> +vwait rc
> +exit $rc

I like it.

Thanks for keeping git gui in good shape.
