From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [Administrivia] On ruby and contrib/
Date: Thu, 6 Jun 2013 10:17:25 -0500
Message-ID: <CAMP44s07p0vpS_2cjAjB=QWoZjjPSuAm09xwk4BjAAD+hsJrSw@mail.gmail.com>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org>
	<7va9n52zjc.fsf@alter.siamese.dyndns.org>
	<rmivc5rp9w2.fsf@fnord.ir.bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Greg Troxel <gdt@ir.bbn.com>
X-From: git-owner@vger.kernel.org Thu Jun 06 17:17:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkbwR-0006nJ-Hv
	for gcvg-git-2@plane.gmane.org; Thu, 06 Jun 2013 17:17:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750899Ab3FFPR1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jun 2013 11:17:27 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:35034 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750752Ab3FFPR0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jun 2013 11:17:26 -0400
Received: by mail-la0-f50.google.com with SMTP id dy20so472205lab.9
        for <git@vger.kernel.org>; Thu, 06 Jun 2013 08:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=E0lCiq5KAocHpc8BnuXaiVjeuoj3oHXyKnHZkJhmURA=;
        b=ZNl+zHNesqySsxkqMQtv9dZ2DAEIaAqdtbgzu6hJqpdbhDLpgKoh/CZwKUNL89LYGi
         7Xb7IaDvCmluEcWI1IMwhSbl/gaUBpQsDA/Gbhkz882DZGgu0rUHiqT55Cx5hl+2s4qI
         6EMtb5zdDju86Zt22WpbRPGdeLuzTWS4KLTLARNICqCtGgN+lfrtCyNDDapJSQVHqy9C
         n1z59d//TY9kgy9pbFogjP4K/dLsISStj/AdbXuU1fOapvvuiDAx9AlDHhG4+lsMXSYS
         WSXfR02BVF8qwZQ9FrtoRJmPs9mA33ybwzZsdFoqZMinvWN1IEWlv30jGQTWNlH3zGCJ
         K/6w==
X-Received: by 10.152.1.104 with SMTP id 8mr11565532lal.33.1370531845202; Thu,
 06 Jun 2013 08:17:25 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Thu, 6 Jun 2013 08:17:25 -0700 (PDT)
In-Reply-To: <rmivc5rp9w2.fsf@fnord.ir.bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226510>

On Thu, Jun 6, 2013 at 9:54 AM, Greg Troxel <gdt@ir.bbn.com> wrote:
>
> As one of the people who helps maintain git packages in pkgsrc, my
> initial reaction is negative to adding a ruby dependency.  There are
> several not-entirely-related reasons:
>
> git is a core tool that people use on almost the smallest of boxes,
> perhaps even replacing rcs for managing local config files.  On such
> machines, even perl may be large, but a second scripting language seems
> excessive.

You can compile Git without any of them.

> On a NetBSD 6 i386 system, the size of the ruby193-base
> binary package (as installed) is 25 MB (vs 15 MB for the git base
> package, which lacks gitk and docs).  (Presently, the git base package
> defaults to requiring python and installing the git_remote_helpers, but
> I think that's a bug.)  perl is 54 MB.

That's only the default, if the default doesn't suit you, don't use the default.

Besides, that doesn't carry any weight if Perl code is replaced with
Ruby code, or Python.

It is quite possible to slowly rewrite the Perl scripts, preferably
move as much code as possible to C, but the rest to shell, or Ruby.
For Ruby, we could maintain both versions at the same time until the
new versions are ready, and then the Perl dependency gets deprecated.
In this interim time, people that don't want Ruby could use the Perl
versions. But I think this is overkill. Yes, ideally we wouldn't want
to depend on both Ruby and Perl, but I think it's OK to do that for a
while, until the Perl scripts are rewritten.

In the end my point remains unchanged; Perl is declining, so it would
be wise for the future to use another scripting language instead.

-- 
Felipe Contreras
