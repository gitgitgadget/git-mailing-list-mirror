X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Vilz <niv@iaglans.de>
Subject: Re: git-PS1 bash prompt setting
Date: Fri, 17 Nov 2006 09:38:02 +0100
Message-ID: <20061117083801.GB11468@fry.bender.fht>
References: <20061116130111.921396df.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 17 Nov 2006 08:41:29 +0000 (UTC)
Cc: git@vger.kernel.org, Theodore Tso <tytso@mit.edu>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061116130111.921396df.seanlkml@sympatico.ca>
X-message-flag: Please send plain text messages only. Thank you.
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at hs-esslingen.de
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31674>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkzHZ-0005mM-46 for gcvg-git@gmane.org; Fri, 17 Nov
 2006 09:41:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753270AbWKQIk4 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 17 Nov 2006
 03:40:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755509AbWKQIk4
 (ORCPT <rfc822;git-outgoing>); Fri, 17 Nov 2006 03:40:56 -0500
Received: from mail.hs-esslingen.de ([134.108.32.78]:16577 "EHLO
 mail.hs-esslingen.de") by vger.kernel.org with ESMTP id S1753270AbWKQIk4
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 17 Nov 2006 03:40:56 -0500
Received: from localhost (mail.hs-esslingen.de [134.108.32.78]) by
 mail.hs-esslingen.de (Postfix) with ESMTP id F038713EB9; Fri, 17 Nov 2006
 09:40:54 +0100 (CET)
Received: from mail.hs-esslingen.de ([134.108.32.78]) by localhost (rslx211
 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id 30977-08; Fri, 17 Nov
 2006 09:38:03 +0100 (CET)
Received: from localhost (ovpngp1162.hs-esslingen.de [134.108.121.162])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by mail.hs-esslingen.de (Postfix) with ESMTP id
 555C913EB4; Fri, 17 Nov 2006 09:38:03 +0100 (CET)
To: Sean <seanlkml@sympatico.ca>
Sender: git-owner@vger.kernel.org

On Thu, Nov 16, 2006 at 01:01:11PM -0500, Sean wrote:

> [branch!repo/relative/path]$ 
> 
> Where "repo" is the basename of the path to the root of your repo.
> An example would look like this:
> 
> [master!linus-2.6/Documentation/vm]$ 
> 
> Cheers,
> Sean
> 
> 
> #!/bin/bash
> BR=$(git symbolic-ref HEAD 2>/dev/null) || { echo "$@" ; exit ; }
> BR=${BR#refs/heads/}
> REL=$(git rev-parse --show-prefix) 
> REL="${REL//%\/}"
> LOC="${PWD%/$REL}"
> echo "[$BR!${LOC/*\/}${REL:+/$REL}]$ "

Just a note:

this doesn't work with bash 3.2. I think they altered the way of
trimming variables in this version.

on systems with bash 3.2 installed, i get
[master!linus-2.6/vm/vm]$ 
with the example above.

on systems with bash 3.1, it works properly.

unfortunatelly, i am not so good in bash scripting, so it will take some
time for me to fix it.

Sincerly
