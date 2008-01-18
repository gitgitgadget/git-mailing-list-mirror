From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: What's not in 'master' but should be
Date: Fri, 18 Jan 2008 12:54:59 +0100
Message-ID: <8c5c35580801180354w74774fe2u1d96a8d12f513811@mail.gmail.com>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com>
	 <47893E1A.5020702@gmail.com>
	 <7v4pdislrf.fsf@gitster.siamese.dyndns.org>
	 <alpine.LSU.1.00.0801132224540.8333@wbgn129.biozentrum.uni-wuerzburg.de>
	 <7vir1xmazm.fsf@gitster.siamese.dyndns.org>
	 <7v63xrh3mw.fsf_-_@gitster.siamese.dyndns.org>
	 <8c5c35580801180215s2c980b4kbc66fbb05778ff67@mail.gmail.com>
	 <7vwsq7fn2e.fsf@gitster.siamese.dyndns.org>
	 <8c5c35580801180253x9022e62qf1ec515e101fb294@mail.gmail.com>
	 <7vzlv3e6fy.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 18 12:55:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFpp3-0001vr-4h
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 12:55:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753563AbYARLzA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 06:55:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753403AbYARLzA
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 06:55:00 -0500
Received: from wa-out-1112.google.com ([209.85.146.180]:35103 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753563AbYARLy7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 06:54:59 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1691627wah.23
        for <git@vger.kernel.org>; Fri, 18 Jan 2008 03:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=rkz0bXnf0Mcl8OYVZMJm9RJ4AZ1AAzMxZfl7WY03v0E=;
        b=B8TYlXIWHcrmhmIBgYHHnSuKukWFcWVJpN5AYqybNqbYRKqutP0AzqFXgWiIaHhsd0g3YEZLlozGruBqHPhh7OEW8hGJ1Hjl7htJTJRC0z1OfQZF87EJ68Du/8Xz8vsbahZBqzx8qP0xW1q5GkcmNonE0smrPj2LZ1iNoRdyxCI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=K+XUf7nGiTddsPr12Siq0wL+APbx0KEXq8XHyLEDw/Owo5SeOR+gk6wCeiWBroNUP0vAHGg5qMBsxXzRNBClPm3FbAj/m5Gd9LSf4zHYyjfIBI7nNFa63fqHS3yHvHA0MCvKZuGKF1fhiM2qcpRZLDpTWXzpN2yAkSME3mB0MzA=
Received: by 10.114.148.1 with SMTP id v1mr3823292wad.21.1200657299265;
        Fri, 18 Jan 2008 03:54:59 -0800 (PST)
Received: by 10.114.241.8 with HTTP; Fri, 18 Jan 2008 03:54:59 -0800 (PST)
In-Reply-To: <7vzlv3e6fy.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71004>

On Jan 18, 2008 12:09 PM, Junio C Hamano <gitster@pobox.com> wrote:
> "Lars Hjemli" <hjemli@gmail.com> writes:
>
> > Hmm, isn't a nonfunctional libgit considered breakage? Without
> > something like this patch it is no longer possible to use
> > write_tar_archive()/write_zip_archive() in libgit.a.
>
> Sorry, but libgit.a is not part of what we deliver.  We do not
> support linking random stuff against libgit.a.  We never did.
> It is not a "library".

I kind of expected this reply, and I know libgit isn't supposed to be
a stable API aginst git internals, but it still feels like a
regression: cgit has been linking against libgit for over a year now
(initial snapshot support added feb 8, 2007), and git-1.5.4 looks like
the first git release which cgit cannot use.

> The code movement you did _should_ not hurt so it may be a fine
> material for post 1.5.4, but I haven't carefully compared what
> other change might have accidentally snuck in that patch, and I
> would rather not have to during the rc cycle.

Ok, I can't argue with that.

But could the patch then be part of 1.5.4.X or would I have to wait
for 1.5.5 since it's not considered to fix any breakage in 1.5.4? The
reason I'm asking is that cgit relies on offical git releases (or
rather, the tarballs published on kernel.org when a release is cut),
and it would be a shame if the 1.5.4-series becomes unusable for me
(there's always the possibility to link against a forked git, but I'd
rather not).

-- 
larsh
