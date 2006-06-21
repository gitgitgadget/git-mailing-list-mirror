From: Timo Hirvonen <tihirvon@gmail.com>
Subject: Re: [PATCH 3/3] gitweb: Use --git-dir parameter instead of setting
 $ENV{'GIT_DIR'}
Date: Wed, 21 Jun 2006 16:33:02 +0300
Message-ID: <20060621163302.47271f89.tihirvon@gmail.com>
References: <e79921$u0e$1@sea.gmane.org>
	<46a038f90606201233p6283febbn9a46e36c3a666903@mail.gmail.com>
	<20060621130535.G2b34d382@leonov.stosberg.net>
	<20060621130930.G421234bb@leonov.stosberg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: martin.langhoff@gmail.com, jnareb@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 21 15:33:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ft2pd-00064Z-PM
	for gcvg-git@gmane.org; Wed, 21 Jun 2006 15:33:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932134AbWFUNdP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Jun 2006 09:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932143AbWFUNdP
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jun 2006 09:33:15 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:20089 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932134AbWFUNdO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jun 2006 09:33:14 -0400
Received: by nf-out-0910.google.com with SMTP id o60so97161nfa
        for <git@vger.kernel.org>; Wed, 21 Jun 2006 06:33:13 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=aep81DMHJSxS2st7rdf9sR5k6KmMlFLR7ltFc4ik3nK9nwPyg3Rxa2YdjkhMbi4zSenTY/UXG0MEj68n/WoyxcfbeTQsmTvwZ9H92xHFhOMlL45QUGiG4tY58lmsQwl+IbPH0s4pQSXyy2Sxi2Y8jOXmAtuSr3odWoE5ouMj8Sw=
Received: by 10.49.92.10 with SMTP id u10mr580379nfl;
        Wed, 21 Jun 2006 06:33:12 -0700 (PDT)
Received: from garlic.home.net ( [82.128.229.197])
        by mx.gmail.com with ESMTP id d2sm714103nfe.2006.06.21.06.33.11;
        Wed, 21 Jun 2006 06:33:12 -0700 (PDT)
To: Dennis Stosberg <dennis@stosberg.net>
In-Reply-To: <20060621130930.G421234bb@leonov.stosberg.net>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.18; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22272>

Dennis Stosberg <dennis@stosberg.net> wrote:

> -	open my $fd, "-|", "$gitbin/git-cat-file -t $hash" or return;
> +	open my $fd, "-|", "$gitbin/git --git-dir=$git_dir cat-file -t $hash" or return;

How about adding a function to simplify calling the git commands?

Something like git("cat-file -t $hash") which would return
"$gitbin/git --git-dir=$git_dir cat-file -t $hash" string.

I'm not Perl programmer so I don't know what would be the best way to
do this.

-- 
http://onion.dynserv.net/~timo/
