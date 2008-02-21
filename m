From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: [PATCH 2/2] Add support for url aliases in config files
Date: Wed, 20 Feb 2008 21:19:31 -0500
Message-ID: <76718490802201819g6e2662afjdcbbacadb2521106@mail.gmail.com>
References: <200802202203.m1KM37aR012221@mi1.bluebottle.com>
	 <alpine.LSU.1.00.0802202221130.17164@racer.site>
	 <7v4pc316gq.fsf@gitster.siamese.dyndns.org>
	 <76718490802201726t677b1498ma3bdb3dbf25dd781@mail.gmail.com>
	 <alpine.LFD.1.00.0802201735030.7833@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"=?UTF-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?=" <nanako3@bluebottle.com>,
	git@vger.kernel.org, "Daniel Barkalow" <barkalow@iabervon.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Feb 21 03:20:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JS12f-0000xA-Sd
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 03:20:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750850AbYBUCTe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2008 21:19:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbYBUCTe
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Feb 2008 21:19:34 -0500
Received: from wx-out-0506.google.com ([66.249.82.233]:27450 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750727AbYBUCTd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2008 21:19:33 -0500
Received: by wx-out-0506.google.com with SMTP id h31so2388917wxd.4
        for <git@vger.kernel.org>; Wed, 20 Feb 2008 18:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=hrSVBedVWgA0Cbt181/zxcVfskoHXrDe+1TwklqQihw=;
        b=vpbmIrHi9ai85wD02ud9Slf/Qi84ipzVpQYRAJ3tXjZA4Xs6cwIV9fgQF6wneLL1/MRcW/CyaEDCG4jiolxw1R7UgKkrCART5pAbpGVMqH0rtWE/BtC8tiXQ0gzdOnFlqgUJ18GJRQEU5jujF8I6zDUwHh+YqA0MZPbmTauCK+o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=x+eBpm1SYIz6L5PfIve8t5ZPaYvGtJpMpE9ifXA78oE8dpFKTGTQUm4DKqT5eBUNpUnVEbhohDMkykgz2myrJsduC3WypoPqntIKJfQba9gwQnYUhmdTPLA9p/TdGibNQP413KWyAZZMU0+L4Ef+qv+4V4dcLMf5Swphkf0WQvc=
Received: by 10.114.149.2 with SMTP id w2mr7530097wad.5.1203560371414;
        Wed, 20 Feb 2008 18:19:31 -0800 (PST)
Received: by 10.114.145.13 with HTTP; Wed, 20 Feb 2008 18:19:31 -0800 (PST)
In-Reply-To: <alpine.LFD.1.00.0802201735030.7833@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74587>

On Wed, Feb 20, 2008 at 8:47 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:

>  So I think it really boils down to the fact that you want to "rewrite" the
>  thing. Not aliases, not "also known as", but you're logically really
>  looking for something like
>
>         [access "git://git.kernel.org/*"]
>                 proxy = proxy-program
>                 url = "ssh://master.kernel.org/*"
>
>  which admittedly looks rather strange too, but at the same time it does
>  make sense from a "what do we really want to do?" standpoint.
>
>  Of course, in this case Daniel didn't actually do that "proxy" part, but I
>  think the argument that we should try to make the config file syntax
>  describe what the user wants to do is still very true. So skip that
>  "proxy" part (maybe somebody wants to do that too some day), and leave the
>
>         [access "original"]
>                 url = "rewritten"
>
>  kind of syntax.
>
>  (And no, I'm not at all married to the "access" and "url" parts - I don't
>  care. I'm just saying that syntax should be tied to what people want to
>  do, not anything else.

Shrug:

[core]
  rewriterule = <from> <to>
  ; ...

If <from> or <to> contain whitespace then you have to use %20 or quotes.

(There is already proxy support elsewhere in the config.)

I think I'm done suggesting paint colors. :-)

j.
