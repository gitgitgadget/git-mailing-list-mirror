X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Vilz <niv@iaglans.de>
Subject: Re: git-PS1 bash prompt setting
Date: Fri, 17 Nov 2006 10:52:37 +0100
Message-ID: <20061117095237.GD11468@fry.bender.fht>
References: <20061116130111.921396df.seanlkml@sympatico.ca> <20061117083801.GB11468@fry.bender.fht> <20061117042051.d2fbddb6.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 17 Nov 2006 09:52:58 +0000 (UTC)
Cc: git@vger.kernel.org, Theodore Tso <tytso@mit.edu>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061117042051.d2fbddb6.seanlkml@sympatico.ca>
X-message-flag: Please send plain text messages only. Thank you.
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at hs-esslingen.de
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31683>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gl0Op-0000OJ-OV for gcvg-git@gmane.org; Fri, 17 Nov
 2006 10:52:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755632AbWKQJwk (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 17 Nov 2006
 04:52:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755633AbWKQJwk
 (ORCPT <rfc822;git-outgoing>); Fri, 17 Nov 2006 04:52:40 -0500
Received: from mail.hs-esslingen.de ([134.108.32.78]:43473 "EHLO
 mail.hs-esslingen.de") by vger.kernel.org with ESMTP id S1755631AbWKQJwj
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 17 Nov 2006 04:52:39 -0500
Received: from localhost (mail.hs-esslingen.de [134.108.32.78]) by
 mail.hs-esslingen.de (Postfix) with ESMTP id E749813EB0; Fri, 17 Nov 2006
 10:52:38 +0100 (CET)
Received: from mail.hs-esslingen.de ([134.108.32.78]) by localhost (rslx211
 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id 16490-01; Fri, 17 Nov
 2006 10:52:38 +0100 (CET)
Received: from localhost (ovpngp1162.hs-esslingen.de [134.108.121.162])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by mail.hs-esslingen.de (Postfix) with ESMTP id
 272D213E5E; Fri, 17 Nov 2006 10:52:38 +0100 (CET)
To: Sean <seanlkml@sympatico.ca>
Sender: git-owner@vger.kernel.org

On Fri, Nov 17, 2006 at 04:20:51AM -0500, Sean wrote:
> On Fri, 17 Nov 2006 09:38:02 +0100
> Nicolas Vilz <niv@iaglans.de> wrote:
> 
> > Just a note:
> > 
> > this doesn't work with bash 3.2. I think they altered the way of
> > trimming variables in this version.
> > 
> > on systems with bash 3.2 installed, i get
> > [master!linus-2.6/vm/vm]$ 
> > with the example above.
> > 
> > on systems with bash 3.1, it works properly.
> 
> Sorry bout that, I knew it was a bit fragile.  Was rather
> comical reading Junio's recent message about all the things not
> to do if you want portable shell code and noticing my 6 line script
> did 90% of them ;o)  Strange though, I downloaded Bash 3.2
> and gave it a try and didn't see the problem here..
> 
> Wanna try this small change, to see if it helps? :
> 
> #!/bin/bash
> BR=$(git symbolic-ref HEAD 2>/dev/null) || { echo "$@" ; exit ; }
> BR=${BR#refs/heads/}
> REL=$(git rev-parse --show-prefix)
> REL="${REL%\/}"
> LOC="${PWD%/$REL}"
> echo "[$BR!${LOC/*\/}${REL:+/$REL}]$ "
> 

That one did the job... funny, removing these two // did the job, for
both versions, 
GNU bash, version 3.1.17(1)-release (powerpc-unknown-linux-gnu) and
GNU bash, version 3.2.5(1)-release (x86_64-pc-linux-gnu).

Thx for fixing that script. It really helps me.

Sincerly
Nicolas
