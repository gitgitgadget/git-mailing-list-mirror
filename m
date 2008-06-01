From: "Steven Walter" <stevenrwalter@gmail.com>
Subject: Re: [PATCH review] Build: make PERL_PATH = /usr/bin/env perl
Date: Sun, 1 Jun 2008 14:11:08 -0400
Message-ID: <e06498070806011111w792399dfi9dad780ee00faa8a@mail.gmail.com>
References: <1212258886-87484-1-git-send-email-mfwitten@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Michael Witten" <mfwitten@mit.edu>
X-From: git-owner@vger.kernel.org Sun Jun 01 20:12:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2s2d-00011z-W5
	for gcvg-git-2@gmane.org; Sun, 01 Jun 2008 20:12:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbYFASLM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Jun 2008 14:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751160AbYFASLM
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jun 2008 14:11:12 -0400
Received: from an-out-0708.google.com ([209.85.132.247]:26964 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750726AbYFASLL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jun 2008 14:11:11 -0400
Received: by an-out-0708.google.com with SMTP id d40so215703and.103
        for <git@vger.kernel.org>; Sun, 01 Jun 2008 11:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=wFok0fGI7eEefAA8YK9LDwf0bhotoxuzj4P9XjSt0IE=;
        b=q8e1p4BbPr6dqbcgsyUq/Xu9NffqtvB7TjYewqkeOskGsJnqABhCaTenQPg8DrNaipy0//OsURTcqaTuafAEmSgPgwhFnPx7XYAGYLB6EVoPp2TkdohLWP0OchmesjPiVneEvn4CTk2J1VQmbHuzadYTDZXCLiz2T/eOM+rYoV4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QCNiEWsiZX4kvFhTdkeOk4NpP9Vvrk17TXKoVC6H0kwoyL9czinfGqJykwfegXg6tcd6jw+8bbDIYvL1N0a6s2YbgSScz4qH7b0kifHFHbmTtW+dKAxYuw+6USg15ESmxqmSGJwWvDmAWB+b4GqCB3aMuEuJhhdL3jtjlramERU=
Received: by 10.100.251.18 with SMTP id y18mr13322378anh.36.1212343868261;
        Sun, 01 Jun 2008 11:11:08 -0700 (PDT)
Received: by 10.100.92.6 with HTTP; Sun, 1 Jun 2008 11:11:08 -0700 (PDT)
In-Reply-To: <1212258886-87484-1-git-send-email-mfwitten@mit.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83454>

On Sat, May 31, 2008 at 2:34 PM, Michael Witten <mfwitten@mit.edu> wrote:
> This should make PERL_PATH more robust, as some
> systems may have multiple version of perl installed.
>
> Signed-off-by: Michael Witten <mfwitten@mit.edu>
> ---
>  Makefile |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 865e2bf..5828745 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -323,7 +323,7 @@ ifndef SHELL_PATH
>        SHELL_PATH = /bin/sh
>  endif
>  ifndef PERL_PATH
> -       PERL_PATH = /usr/bin/perl
> +       PERL_PATH = /usr/bin/env perl
>  endif
>
>  export PERL_PATH
> --
> 1.5.5.GIT

If you do this, you will have to modify the perl scripts to remove the
-w flag from their hash-bang line.  "/usr/bin/env perl -w" does not
seem to do the expected thing.
-- 
-Steven Walter <stevenrwalter@gmail.com>
"A human being should be able to change a diaper, plan an invasion,
butcher a hog, conn a ship, design a building, write a sonnet, balance
accounts, build a wall, set a bone, comfort the dying, take orders,
give orders, cooperate, act alone, solve equations, analyze a new
problem, pitch manure, program a computer, cook a tasty meal, fight
efficiently, die gallantly. Specialization is for insects."
 -Robert Heinlein
