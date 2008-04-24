From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: Git on Windows, CRLF issues
Date: Thu, 24 Apr 2008 12:56:40 -0400
Message-ID: <32541b130804240956u2ec5817ey7b9652447489bc86@mail.gmail.com>
References: <alpine.DEB.1.00.0804212145570.21181@perkele.intern.softwolves.pp.se>
	 <32541b130804220951p224c9be7ya4e8de5056481fd1@mail.gmail.com>
	 <20080423080826.GA11935@sigill.intra.peff.net>
	 <480F1671.2060602@viscovery.net>
	 <20080423110402.GA27437@sigill.intra.peff.net>
	 <480F218C.3060703@viscovery.net>
	 <20080423214745.GA30057@sigill.intra.peff.net>
	 <7vprsgqiq1.fsf@gitster.siamese.dyndns.org>
	 <32541b130804231604r4c439fa5va5c01bfd53a22cc7@mail.gmail.com>
	 <alpine.DEB.1.00.0804240909220.26553@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>,
	"Johannes Sixt" <j.sixt@viscovery.net>,
	"Peter Karlsson" <peter@softwolves.pp.se>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Apr 24 18:58:28 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jp4lH-0000O1-Cf
	for gcvg-git-2@gmane.org; Thu, 24 Apr 2008 18:57:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751503AbYDXQ4o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2008 12:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752415AbYDXQ4o
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Apr 2008 12:56:44 -0400
Received: from fk-out-0910.google.com ([209.85.128.190]:17005 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751503AbYDXQ4m (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2008 12:56:42 -0400
Received: by fk-out-0910.google.com with SMTP id 19so4481971fkr.5
        for <git@vger.kernel.org>; Thu, 24 Apr 2008 09:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=MLZ2hiUckS0J++i3GPD7tPTkQ8t+CUyICuUpHOOEZIQ=;
        b=WWfUKVcdWi1qT2VIQHo29cfP/nXMHuvyOl17BnPzImUpt/1561IxHySOSfIXj35I6IOnXbmboCe7bIKLpFCNsZwoBB2GTap65GQCzNFCgHAtRsZNv9QJaFfQHLCsigWGtMIANqxdOw/GZIgkxW4gdeQQLAxdu2KTf6AnR8BgGCU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SswH+3CgqCEAtP3F1s3Tefk0+xW54bwjb7jF7uKZnTIgN5JO+GwWe8I2+/0LuNxan0VGbKUNLhdSVlQWKtqXNu0tFwwFNuHiRclkeRncIrA3R2Jfb76jqynYOuuH/ZluAT2mkG/LrB56kgDqb8FeZwe5rW6ecTMjp85I36imywA=
Received: by 10.82.125.8 with SMTP id x8mr2651554buc.33.1209056200665;
        Thu, 24 Apr 2008 09:56:40 -0700 (PDT)
Received: by 10.82.166.12 with HTTP; Thu, 24 Apr 2008 09:56:40 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0804240909220.26553@eeepc-johanness>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80309>

On 4/24/08, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>  On Wed, 23 Apr 2008, Avery Pennarun wrote:
>  > What I really want is the equivalent of "dos2unix --recursive *.c *.txt
>  > etc" for all commits.
>
> I start to wonder if "git fast-export --all | my-intelligent-perl-script |
>  git fast-import" would not be a better solution here.
>
>  All you would have to do is to detect when a blob begins, and how long it
>  is, and work with that.  If your trees do not contain any binary files, it
>  should be trivial.

Err, yes... as long as there are no binary files.  I'm not so lucky,
and life is a little more complex in that case.  It also gives no easy
way of selectively applying the blob filter based on filename, which
is pretty important when you do have some binary files and you're
trying to decide whether to run dos2unix.

(In contrast, the *other* objection, which is that the same blob might
have multiple filenames, doesn't bother me at all, since I'm sure I
don't have any .txt files that were accidentally named .jpg at some
point.)

I agree that a working solution based on
git-fast-export/git-fast-import should run faster than any of the
other proposed solutions, but my version of Jeff's patch is quite fast
and it's easy to compose simple command lines that "make simple things
simple and hard things possible":

  git-filter-branch --blob-filter dos2unix HEAD
  git-filter-branch --blob-filter 'case "$path" in *.c) expand -8;; *)
cat;; esac' HEAD

It sure beats writing a perl script every time you want to do something.

Jeff wrote:
> But I think the problem then is
> that the blob filter isn't terribly useful. IOW, it is not really a
> separate filter, but rather an optimizing pattern for an index filter,
> so maybe calling it a blob filter is the wrong approach

The problem is that doing an optimization on an index filter is kind
of hard for a user to express, and each user will have to implement
the caching logic by hand every time.  Using --index-filter at all
requires extremely high levels of shell and git knowledge.

The fact that the blob transformation might "slightly depend on" the
path is not actually very important; fundamentally we're still
transforming blobs, not paths.  We're just using the filename as a
*hint* about what kind of transformation we need to do on that
particular blob.

I think the measure of a good idea here is how straightforward it is
to express what you want on the command line, and --blob-filter makes
it easy to express a certain class of filters.

Have fun,

Avery
