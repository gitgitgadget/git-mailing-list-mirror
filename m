From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 2/2] INSTALL: Describe a few knobs from the Makefile
Date: Tue, 08 Sep 2009 13:26:11 -0700
Message-ID: <7vy6opxjx8.fsf@alter.siamese.dyndns.org>
References: <1252425313-69793-1-git-send-email-brian@gernhardtsoftware.com>
 <1252425313-69793-2-git-send-email-brian@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Tue Sep 08 22:26:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ml7Gt-0002K5-Um
	for gcvg-git-2@lo.gmane.org; Tue, 08 Sep 2009 22:26:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752193AbZIHU0U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2009 16:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752168AbZIHU0T
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Sep 2009 16:26:19 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:62256 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751922AbZIHU0S (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2009 16:26:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3F91449831;
	Tue,  8 Sep 2009 16:26:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=n6RDidVjNdnKxixc2NC5YjhE+LE=; b=Y0xZtbf50pSFRrn63G1yiVR
	RylVTFNA2tONFddVQPPiRtxWhub6syxwsLwaLYLfxLewOM7sGUpg9hViht4SDPHJ
	JALxlWcefI7bFtDQoOeUX+PKJo2RJHDJ3GDOmrx6cugJq3l13ERvD205qHFpXu0I
	33JZYAb8HDf851sEm2YI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=kYfIvawlm+buH2BR9yHjXM4Uex+EnbshlgNO117SxgRGHY7Vt
	mCLyfkTZeKl+nhsAlPKGzJj4iYLrgJ6D6O+e5g4zQBC/Wc8NA27g++kfwq4P/DIB
	fzq4D+6jA2jq370X1byvfZo4elPNwOPx3Z/5lfD4JaSRMYTtptY/HmlTWA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2147749830;
	Tue,  8 Sep 2009 16:26:18 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D164A4982F; Tue,  8 Sep 2009
 16:26:12 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DD251BF0-9CB5-11DE-A68F-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128031>

Brian Gernhardt <brian@gernhardtsoftware.com> writes:

> We said that some of our dependencies were optional, but didn't say
> how to turn them off.  Add information for that and mention where to
> save the options close to the top of the file.
>
> Also, reorder the list so the absolutely required ones are at the top.
>
> Signed-off-by: Brian Gernhardt <brian@gernhardtsoftware.com>
> ---
>
>  I don't know if anyone wants this level of detail in the INSTALL file, or
>  if we'd prefer people actually RTFMakefile.  It didn't take long to write
>  though, so I thought I'd throw it out and see if people liked it.

Thanks.

Sprinkling these Makefile variable names in this document does not add too
much detail.  If anything, they serve as good keyphrases to jump to when
you have Makefile in your pager and editing your own config.mak.

I like your patch especially because it makes it clear what the reader
will be missing if s/he chooses to omit some dependencies.

> +	- "ssh" is used to push and pull over the net
> +

Please add a full-stop at the end (original was missing one, too).

> +	- A POSIX-compliant shell is needed to use most of the bare-bones
> +	  Porcelainish scripts.

Let's stop talking about Porcelain/plumbing in this document.

It is very likely that the reader of this file has not read the main
documentation that talks about the two-tier structure.

The self pejorative reference "bare-bones" dates back to the days when git
Porcelains were supposed to be merely simpler reference implementations,
as opposed to something more end-user friendly like what Cogito aimed to
be.  But that is an old history, and there is nothing "bare-bones" about
them anymore.

So please reword it along this line:

	- A POSIX-compilant shell is needed to use many of the features
          (e.g. "bisect", "pull") in everyday use.

> +	- "openssl".  Unless you specify otherwise (with NO_OPENSSL),
> +	  you'll get the SHA1 library from here.

It is not very clear what will be affected by disabling this.

 - SHA-1 is not used from OpenSSL, as stated;
 - imap-send won't be able to talk over SSL;

Do we still able to walk https:// URLs?  If your cURL library is linked
with gnutls I think we can, but I never tried the combination.

> @@ -62,18 +73,20 @@ Issues of note:
>  	- libcurl library; git-http-fetch and git-fetch use them.  You
>  	  might also want the "curl" executable for debugging purposes.
>  	  If you do not use http transfer, you are probably OK if you
> +	  do not have them (use NO_CURL).

Probably reads more easily if it were:

	If you do not interact with http:// repositories, you do not have
	to have them (say NO_CURL).

> +	- "perl" is used for several scripts that are useful, but not
> +	  required for git (e.g. "git add -i" and "git difftool").  If you
> +	  don't need the *.perl scripts or the library contained in perl/,
> +	  then use NO_PERL.

I do not think moving "Perl" this low in the requirement level is such a
good idea, at least for now.  I'd suggest movign it back immediately after
POSIX-compliant shell, and would say something like this:

	- "Perl" is needed to use some of the features (e.g. preparing a
          partial commit using "git add -i/-p", interacting with svn
          repositories with "git svn").  If you can live without these,
          say NO_PERL.

Maybe they are Ruby, github, and general acceptance by many open source
projects these days, but it used to be that the initial entry points to
git were "git cvsimport" and "git svn" for a surprisingly large number of
people.
