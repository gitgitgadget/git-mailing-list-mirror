From: "James Sadler" <freshtonic@gmail.com>
Subject: Re: git filter-branch --subdirectory-filter
Date: Sat, 10 May 2008 21:38:59 +1000
Message-ID: <e5e204700805100438v6984593oada51daa4d456fd3@mail.gmail.com>
References: <e5e204700805081801x314b02bek5d53a086b02dac83@mail.gmail.com>
	 <20080509013300.GA7836@sigill.intra.peff.net>
	 <e5e204700805090038k373bbabcyfb10d8c93ec5b3a7@mail.gmail.com>
	 <20080509080039.GA15393@sigill.intra.peff.net>
	 <e5e204700805092031m14c3d6c2kb85b51af5a1ee8f7@mail.gmail.com>
	 <20080510055332.GB11556@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 10 13:40:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JunR2-00050b-CC
	for gcvg-git-2@gmane.org; Sat, 10 May 2008 13:40:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752765AbYEJLjE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 May 2008 07:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752766AbYEJLjD
	(ORCPT <rfc822;git-outgoing>); Sat, 10 May 2008 07:39:03 -0400
Received: from wx-out-0506.google.com ([66.249.82.225]:43110 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752745AbYEJLjA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 May 2008 07:39:00 -0400
Received: by wx-out-0506.google.com with SMTP id h29so1507059wxd.4
        for <git@vger.kernel.org>; Sat, 10 May 2008 04:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=gT3mLdFO7xfxA10ZRwh9Q29Y8o0u5sihjTrCwscWUVM=;
        b=Z2B6VRYUDj+YJAtclCbsj/QzVAOlEbsoR7EC3i0Tj3Yfl1y3saYgSwCqUacOP34jqgs3oLT9+85peo7y4pO9cjdVdG4EECY/Owp4aVOdbbrETGpob4JtEz36SwXBqqZaVVxzDjCcZeWEhXDkBdSLHsjGZgQaEJlpvmSGCT2BBDE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KA/BvLF06HSP4JiY+H/6EUw3WBBxmpwKmLR83ogOxiyyMOHlLyOFKfMiaICudb7Wiu4RqNAfbIsVBQ+5Cmdm+KI1Ea00vjCf8qBtxic5/5P1mvrr5Q9WFzZ8gSNZ3qvlhy71HNLAMyAcCjxO5I0Vn3haw+L1VKYVM1wi/qk8qPk=
Received: by 10.90.80.18 with SMTP id d18mr309817agb.27.1210419539660;
        Sat, 10 May 2008 04:38:59 -0700 (PDT)
Received: by 10.90.114.9 with HTTP; Sat, 10 May 2008 04:38:59 -0700 (PDT)
In-Reply-To: <20080510055332.GB11556@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81662>

2008/5/10 Jeff King <peff@peff.net>:
> On Sat, May 10, 2008 at 01:31:37PM +1000, James Sadler wrote:
>
>> Does anybody have a script that can take an existing repo, and create
>> a new one with garbled-but-equivalent commits?  i.e.  file and
>> directory structure is same with names changed, and there is a one-one
>> relationship between lines of text in new repo and old one except the
>> lines have been scrambled?  It would be a useful tool for distributing
>> private repositories for debugging reasons.
>
> This is only lightly tested, but the script below should do the trick.
> It works as an index filter which munges all content in such a way that
> a particular line is always given the same replacement text. That means
> that diffs will look approximately the same, but will add and remove
> lines that say "Fake line XXX" instead of the actual content.
>
> You can munge the commit messages themselves by just replacing them with
> some unique text; in the example below, we just replace them with the
> md5sum of the content.
>
> This will leave the original author, committer, and date, which is
> presumably non-proprietary.
>

> <snip>

Jeff,

I have run your script on my repo and now have an obfuscated version.
When I run 'git filter-branch -subdirectory filter $DIR' on this repo, the same
problem occurs, i.e. there are fewer commits remaining than I would expect.

If I place this repo somewhere you can download it, would you be kind enough
to take a look?  I'll detail the steps required to reproduce in another post.

Thanks,

James
