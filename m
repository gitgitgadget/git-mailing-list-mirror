From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: BUG? in --dirstat when rearranging lines in a file
Date: Fri, 8 Apr 2011 08:04:52 -0700
Message-ID: <BANLkTinv3SSYWn==F=ans4uHuHJhTrfjDQ@mail.gmail.com>
References: <201104071549.37187.johan@herland.net> <BANLkTinEipewx2+Cx7Us0BSoSbjjU9uE6A@mail.gmail.com>
 <201104081646.35750.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Apr 08 17:05:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8DFS-0000Nq-Qp
	for gcvg-git-2@lo.gmane.org; Fri, 08 Apr 2011 17:05:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757369Ab1DHPFP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2011 11:05:15 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:42625 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757204Ab1DHPFO (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Apr 2011 11:05:14 -0400
Received: from mail-iy0-f174.google.com (mail-iy0-f174.google.com [209.85.210.174])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p38F5Dj2006839
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Fri, 8 Apr 2011 08:05:13 -0700
Received: by iyb14 with SMTP id 14so3547920iyb.19
        for <git@vger.kernel.org>; Fri, 08 Apr 2011 08:05:12 -0700 (PDT)
Received: by 10.231.25.137 with SMTP id z9mr2241065ibb.53.1302275112064; Fri,
 08 Apr 2011 08:05:12 -0700 (PDT)
Received: by 10.231.11.4 with HTTP; Fri, 8 Apr 2011 08:04:52 -0700 (PDT)
In-Reply-To: <201104081646.35750.johan@herland.net>
X-Spam-Status: No, hits=-102.985 required=5 tests=AWL,BAYES_00,USER_IN_WHITELIST
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171129>

On Fri, Apr 8, 2011 at 7:46 AM, Johan Herland <johan@herland.net> wrote:
>
> #2: Improve --dirstat-by-file. It doesn't really care about the per-file
> analysis done by --dirstat, but only whether or not a file has changed
> at all. Since the diff queue does not contain unchanged files (<- this
> is an assumption that I hope someone with more diffcore knowledge can
> verify),

Hmm.

I think that with renames, the diff queue _can_ contain unchanged
files (ie pure renames).

Also, I think -CC (aka --find-copies-harder), _every_ file ends up in
the diff queue because that's how it does the detection.

But I didn't actually check, and I may be full of sh*t.

                              Linus
