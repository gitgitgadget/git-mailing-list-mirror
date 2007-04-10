From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH 6/6] Teach core object handling functions about gitlinks
Date: Tue, 10 Apr 2007 13:31:40 +0200
Message-ID: <81b0412b0704100431i1e58c74tbe19ea490e470b8b@mail.gmail.com>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org>
	 <Pine.LNX.4.64.0704092115350.6730@woody.linux-foundation.org>
	 <20070410084022.GB2813@planck.djpig.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Apr 10 18:06:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbEZg-000361-RZ
	for gcvg-git@gmane.org; Tue, 10 Apr 2007 13:31:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752346AbXDJLbn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 07:31:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752350AbXDJLbn
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 07:31:43 -0400
Received: from an-out-0708.google.com ([209.85.132.249]:54633 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752346AbXDJLbm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 07:31:42 -0400
Received: by an-out-0708.google.com with SMTP id b33so1908286ana
        for <git@vger.kernel.org>; Tue, 10 Apr 2007 04:31:41 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GKTicgn/eP4xyB+MNp38+vlmmZ3jCuVXT88Q/2IveoHCnR8ur9mDwqVtpsxfk2mwOBtNGVVJr33oI76G+iQcf7OljX5czKSScU3PnYhqpKcPYM4z7ytIZ3Vfvdcf9ucd0O8e5VvU+j1n7KtavRWv2LpRH9u8AjIWNiwTxsUBQtw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Sru2/YBnFJe33MYAJq8mufkfY6AEoP2tiyVecKuWKYIfHuLnfKHCnVFXhw+MJfXh7KVdTeBEZ3/BVK1JUN0I4dEyCuv/XpHQtlAuQcwdeXrT/ubVGTOHFUPGPoOZBuG7VCWwOTyS6XqYRidbFJbvZDdd7dz+HiUsALrNdYIq77M=
Received: by 10.100.196.3 with SMTP id t3mr4754524anf.1176204700791;
        Tue, 10 Apr 2007 04:31:40 -0700 (PDT)
Received: by 10.100.86.14 with HTTP; Tue, 10 Apr 2007 04:31:40 -0700 (PDT)
In-Reply-To: <20070410084022.GB2813@planck.djpig.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44129>

On 4/10/07, Frank Lichtenheld <frank@lichtenheld.de> wrote:
> On Mon, Apr 09, 2007 at 09:20:29PM -0700, Linus Torvalds wrote:
> > +     case S_IFDIR:
> > +             return resolve_gitlink_ref(path, "HEAD", sha1);
> >       default:
> >               return error("%s: unsupported file type", path);
> >       }
>
> Not that I have time right now to look up the exact context (only read
> the patch), but I would've expected a "case S_IFDIRLNK:" here?
>

No, the st_mode comes directly from file system. It knows nothing about
dirlinks.
