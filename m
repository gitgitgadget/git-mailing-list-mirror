From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Calculating tree nodes
Date: Wed, 5 Sep 2007 09:02:59 +1200
Message-ID: <46a038f90709041402k45d72dc6l59f93cd22b8c02e9@mail.gmail.com>
References: <9e4733910709031913q278cb9dbp441756afb28607c6@mail.gmail.com>
	 <20070904025153.GS18160@spearce.org>
	 <9e4733910709032026s7f94eed9h25d5165840cc38d2@mail.gmail.com>
	 <Pine.LNX.4.64.0709040439070.28586@racer.site>
	 <9e4733910709032054y4407ce62o6b21935502bfacdb@mail.gmail.com>
	 <46a038f90709032121v54454c6fi500ee15497eec85c@mail.gmail.com>
	 <9e4733910709032237y65ccafdai4889078533908fb0@mail.gmail.com>
	 <Pine.LNX.4.64.0709041131030.28586@racer.site>
	 <9e4733910709040731s2695ab14kb9750923fcac007@mail.gmail.com>
	 <46DD7660.2030109@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jon Smirl" <jonsmirl@gmail.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Andreas Ericsson" <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Sep 04 23:03:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISfYF-0001yw-Ci
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 23:03:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754705AbXIDVDF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 17:03:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754608AbXIDVDE
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 17:03:04 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:23570 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754212AbXIDVDB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 17:03:01 -0400
Received: by nf-out-0910.google.com with SMTP id f5so1544675nfh
        for <git@vger.kernel.org>; Tue, 04 Sep 2007 14:02:59 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XUSy9MKtSJAyLZyhbY73Tcard3NZWXNj5/kR6WK04cXbHMsnxpyOjOFVMWj0HnWWMFGrBfQOpRA19MKT4q645L+ZEfiHmG9MSCNUCryT4jA8e8dPnV0+wuW9p2jU3WdZKX48j/An+DMKVB6hSMW/JIx1tTOjqQz4czh96qHSCuU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Si2Khx2H9N0iAt58b/G65E51uuIYD2FEEVeM2xt/rfoc6VSUHApgWiOnZSzKWWH/KsPQ0YpRxFYucklsnsU1GhxDuyo+zcpIKpLPhPGRJT0mYavWIJGVnfkKHL6+mvAZ2WJF+HZLNzSj+LEc52yndQNGSqbSEYbhMv5rJsXWw4o=
Received: by 10.78.204.7 with SMTP id b7mr4530289hug.1188939779390;
        Tue, 04 Sep 2007 14:02:59 -0700 (PDT)
Received: by 10.67.40.9 with HTTP; Tue, 4 Sep 2007 14:02:59 -0700 (PDT)
In-Reply-To: <46DD7660.2030109@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57645>

On 9/5/07, Andreas Ericsson <ae@op5.se> wrote:
> Jon Smirl wrote:
> > The
> > essential part of the commit is the SHA1 list. The path names belong
> > to the file objects and should be stored there.
>
> Sorry, but it'll take code and benchmarks to convince me this is a
> good idea.

Same here. But I do want to note that adding the pathname to the blob
(and storing them on the combined SHA1 I assume) is broken, broken,
broken. It won't support any of the great semantics that git has
today.

Jon: I think you need to think carefully about the key operations like
diff and log on paths on projects like linux or mozilla. Even better,
craft a proof-of-concept patch that shows how that'd work, and why
it's faster/smaller.

cheers,



m
