From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: linux-next: unneeded merge in the security tree
Date: Tue, 12 Mar 2013 14:28:39 -0700
Message-ID: <CA+55aFwHJtOU4Qzt3XZsER165kTc5P0ATQP2wPHvuUiVic8bnA@mail.gmail.com>
References: <20130312100950.e45ef0e721492ff0d5fd7c8d@canb.auug.org.au>
	<alpine.LRH.2.02.1303121510270.25612@tundra.namei.org>
	<20130312041641.GE18595@thunk.org>
	<CA+55aFzFLDcN-1GKae6Xqrns59K1xOD_HPzuv2Lv1__fZpqFMw@mail.gmail.com>
	<20130312212027.GE14792@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: "Theodore Ts'o" <tytso@mit.edu>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	James Morris <jmorris@namei.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-next@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: linux-next-owner@vger.kernel.org Tue Mar 12 22:29:08 2013
Return-path: <linux-next-owner@vger.kernel.org>
Envelope-to: glkn-linux-next@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-next-owner@vger.kernel.org>)
	id 1UFWks-0006OD-9M
	for glkn-linux-next@plane.gmane.org; Tue, 12 Mar 2013 22:29:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932732Ab3CLV2m (ORCPT <rfc822;glkn-linux-next@m.gmane.org>);
	Tue, 12 Mar 2013 17:28:42 -0400
Received: from mail-ve0-f179.google.com ([209.85.128.179]:63551 "EHLO
	mail-ve0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932723Ab3CLV2m (ORCPT
	<rfc822;linux-next@vger.kernel.org>); Tue, 12 Mar 2013 17:28:42 -0400
Received: by mail-ve0-f179.google.com with SMTP id da11so268519veb.10
        for <multiple recipients>; Tue, 12 Mar 2013 14:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:content-type;
        bh=U6Cry5kEdLlDoaHd4XP+v5YExNKB5LLPRCRMBeskOeM=;
        b=e6qSqUxmVN6zE8YvnydrhhYHDRUsXv13j6RCoqxyYkiIL3lllRLJ9EvPb9ptAslfYq
         bPBNnKjlGsyeFawFA0dw9SKC2nhHOBbzS/sGYydrlGFLJLjBsoUSToNmFhFaAgK4Q3xJ
         zM1rxDDKWcmuc65PuAqspYzz9BmkGoeA43NdZQ0X/FivZJrhPqHHUkZEBysyCaiGxUoy
         d6IE9d7oVEHMuvDm6jNfxWd3D9cp036OmHUciSAUjEQtlBKbOFqw0M9MrQ0Shanb5lLq
         jA0BlrUNKWK2kke51hHsHiIzS7DVdb7ObIk80V7w0qdnXXp0uaI+flUSZPGqJPARDXEX
         oZKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:content-type;
        bh=U6Cry5kEdLlDoaHd4XP+v5YExNKB5LLPRCRMBeskOeM=;
        b=H6+jTGqKPY7Quo/rqOXSikTRK4yPLjIWtsjOKmEOQQzQ4aaBJrEntg45YrGDhWjfmo
         yh6u1xyEZDhjskIZmXD3eSLNizBZvUWE9ygaWz5L1kIM/bbPlIe+RoGLMrO7GdPrhiPc
         ea0e/YcILC/gJrQlGjyDIqzpdrorC/+uQquSk=
X-Received: by 10.52.37.109 with SMTP id x13mr6343252vdj.10.1363123719109;
 Tue, 12 Mar 2013 14:28:39 -0700 (PDT)
Received: by 10.220.145.131 with HTTP; Tue, 12 Mar 2013 14:28:39 -0700 (PDT)
In-Reply-To: <20130312212027.GE14792@thunk.org>
X-Google-Sender-Auth: wt9-laVn-m2NEtyUhsvL673BBgA
Sender: linux-next-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-next.vger.kernel.org>
X-Mailing-List: linux-next@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217997>

On Tue, Mar 12, 2013 at 2:20 PM, Theodore Ts'o <tytso@mit.edu> wrote:
> What if we added the ability to do something like this:
>
> [remote "origin"]
>         url = git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
>         fetch = +refs/heads/master:refs/heads/master
>         mergeoptions = --ff-only

Hmm. Something like this could be interesting for other things:

 - use "--rebase" when pulling (this is common for people who maintain
a set of patches and do *not* export their git tree - I use it for
projects like git and subsurface where there is an upstream maintainer
and I usually send patches by email rather than git)

 - "--no-summary". As a maintainer, you people probably do want to
enable summaries for people they pull from, but *not* from upstream.
So this might even make sense to do by default when you clone a new
repository.

 - I do think that we might want a "--no-signatures" for the specific
case of merging signed tags without actually taking the signature
(because it's a "upstream" repo). The "--ff-only" thing is *too*
strict. Sometimes you really do want to merge in new code, disallowing
it entirely is tough.

Of course, I'm not really sure if we want to list the flags. Maybe
it's better to just introduce the notion of "upstream" directly, and
make that a flag, and make "origin" default to that when you clone.
And then have git use different heurstics for pulling upstream (like
warning by default when doing a back-merge, perhaps?)

                   Linus
