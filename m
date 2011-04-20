From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [RFC 0/5] Date Mode: Add --time-zone; deprecate --date=local
Date: Wed, 20 Apr 2011 14:22:45 +0000
Message-ID: <0e899fff-5833-4686-aa81-4bd77f2bd633-mfwitten@gmail.com>
References: <0f30e048-7dd2-4aff-8c1f-00bf0dfa3d34-mfwitten@gmail.com>
            <20110420064318.GF28597@sigill.intra.peff.net>
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 20 16:25:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCYLe-0000oU-42
	for gcvg-git-2@lo.gmane.org; Wed, 20 Apr 2011 16:25:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753921Ab1DTOZh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2011 10:25:37 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:49140 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753110Ab1DTOZh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2011 10:25:37 -0400
Received: by pvg12 with SMTP id 12so398781pvg.19
        for <git@vger.kernel.org>; Wed, 20 Apr 2011 07:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:date:from:to:cc:message-id:in-reply-to
         :references;
        bh=Jd786H9N2QuiGC9ua2dyi43Ng+MSCdpPJtk5It0q1sw=;
        b=KpKD8H+2QgEWrPlQBCuvg+vyf2Oy/vluG1np4joXxdA2cbDcfgB6nBpS1T7a/t171/
         ERIdLYP35hmiEIS20QZYCpvppqlC4VEnmfdLXKmfPKS2tisfsVjOApakudM7t0C/FSW7
         mvsXhfyLKEeZt29pDCJQneZG7iuEPGE9dUCSg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:date:from:to:cc:message-id:in-reply-to:references;
        b=cDOzTJ12jC+dNT5QUOzn1MICJvtTESprmpYP177H46WP+JZgSaStTPxGIjgPRk+rXI
         M7Kbj7EMbtlzGYdGbkC26r3lph+1wKZzDjHNCOwgxK/YJw2mrVciEkRJa6oYKsyVajL/
         Eb88gBHOSvn84SGhgnU3MoZM6rwpp0IVUMoSs=
Received: by 10.68.37.72 with SMTP id w8mr66932pbj.263.1303309536953;
        Wed, 20 Apr 2011 07:25:36 -0700 (PDT)
Received: from gmail.com (tor-exit-router45-readme.formlessnetworking.net [199.48.147.45])
        by mx.google.com with ESMTPS id u3sm663903pbh.8.2011.04.20.07.25.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 20 Apr 2011 07:25:36 -0700 (PDT)
In-Reply-To: <20110420064318.GF28597@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171864>

On Wed, 20 Apr 2011 02:43:18 -0400, Jeff King wrote:

> On Wed, Apr 20, 2011 at 02:53:36AM +0000, Michael Witten wrote:
>
>> The date format `local' has thus been deprecated, though it is still
>> supported (with a warning on stderr).
>
> I don't know if we need to go that far. We can leave it forever as a
> historical compatibility feature. Its existence is not really hurting
> anyone as long as the documentation marks it as deprecated (or doesn't
> even mention it).

The references to a `local' *format* have indeed been removed from
the documentation, and the warning is just an indication that the
code that supports it will also be removed at some point too.

However, the warning mechanism (in general) could be improved by
producing the message only when exiting the program (after the
pager has been destroyed); currently, the message can be quite
easy to miss otherwise (depending on the way the terminal handles
the buffer history).

I don't see the point of leaving crufty code in place forever; it's
ridiculous that my modern CPU starts up like a 35 year old chip
when the very few people who need that functionality (if anybody)
can emulate it if necessary.

As an aside, I've always found it amusing that most programmers
are adamant about justifying an existing use case for a new
feature before even considering an implementation for it, but yet
they will gladly keep around dead code until the next Big Bang.
