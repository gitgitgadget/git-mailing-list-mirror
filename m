From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [BUG] svn-fe: incorrect handling of files with newlines in them
Date: Fri, 13 Apr 2012 17:22:01 -0500
Message-ID: <20120413222201.GA20197@burratino>
References: <4F88A502.9080207@pileofstuff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	David Barr <davidbarr@google.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Andrew Sayers <andrew-git@pileofstuff.org>
X-From: git-owner@vger.kernel.org Sat Apr 14 00:22:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIosh-0004Yf-G6
	for gcvg-git-2@plane.gmane.org; Sat, 14 Apr 2012 00:22:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753199Ab2DMWWK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Apr 2012 18:22:10 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:56527 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752334Ab2DMWWI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2012 18:22:08 -0400
Received: by iagz16 with SMTP id z16so4825727iag.19
        for <git@vger.kernel.org>; Fri, 13 Apr 2012 15:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=jpgbtXTuuTIGWU2vx6pvYsv1A78Z9VnHL1ME0UuEd0w=;
        b=B51TJZ9pBB2jKy6kVUUDn8NonnVIo6e0O/+lwZAYl49bZ/4rEpIUXtVx2A84StTF5b
         ACmp1lupDQmCvEltM+3rLRgahV8Wpz10QVJxAaRrMfHUBOtsygVaLyciarOkivVxDN9R
         cIDoKptFM+7EExAAw8eHIyDydK+Af5J/tZkGS/JXZCe8u/1drn6/m1ebVl/tX/dFVdAp
         4dN9gunFPXJFdLhKPSWWPclYy+j53TIUzRphQ5SVGja5Fv0H8vb685VI4i4wmmrvclEV
         71Spi4qYe+ou3/v5cs7pI3+jF79eRi8xn/lHUNUUyc/R1TzyX5KpG+MFCE64PC68C2j3
         5zOw==
Received: by 10.50.45.138 with SMTP id n10mr2917087igm.70.1334355728255;
        Fri, 13 Apr 2012 15:22:08 -0700 (PDT)
Received: from burratino (adsl-99-24-202-99.dsl.chcgil.sbcglobal.net. [99.24.202.99])
        by mx.google.com with ESMTPS id kn3sm4824889igc.15.2012.04.13.15.22.07
        (version=SSLv3 cipher=OTHER);
        Fri, 13 Apr 2012 15:22:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4F88A502.9080207@pileofstuff.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195450>

(+cc: Ram)
Hey,

Andrew Sayers wrote:

> Note that I've used the intentionally provocative filename
> $'readme.txt\nNode-kind: dir', but svn-fe doesn't fall for the trick.
> The dump format doesn't escape the filename at all, so it would probably
> fall for something cleverer like a 'copyfrom' line.  To be honest I'm
> not sure how you'd even detect such a filename.

Yep, sounds like a dump-load-format design bug.

> If the consensus is that this bug isn't fixable, I'd recommend putting a
> note to that effect in "contrib/svn-fe/svn-fe.txt".

Makes sense.  Please make it so.

Thanks much,
Jonathan
