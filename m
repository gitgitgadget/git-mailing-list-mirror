From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: How can I tell if anything was fetched?
Date: Thu, 11 Oct 2012 18:45:09 +0200
Message-ID: <m28vbdkley.fsf@igel.home>
References: <CAFRB3XkueafikCvwzBb+WOAG_1mEkVg1Yt6=teOuVwYd2zWVOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: Phil Lawrence <prlawrence@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 11 18:45:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMLsx-0003Dn-RW
	for gcvg-git-2@plane.gmane.org; Thu, 11 Oct 2012 18:45:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758891Ab2JKQpN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2012 12:45:13 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:39635 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758266Ab2JKQpM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2012 12:45:12 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3Xcyhj6pNRz4KK2J;
	Thu, 11 Oct 2012 18:45:09 +0200 (CEST)
X-Auth-Info: n5R+vQrUBqiM7+soRPnxQW6nBltlCr9MQF2KAqEO/Mw=
Received: from igel.home (ppp-88-217-111-196.dynamic.mnet-online.de [88.217.111.196])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3Xcyhj6RK5zbbcM;
	Thu, 11 Oct 2012 18:45:09 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 7254ACA2A4; Thu, 11 Oct 2012 18:45:09 +0200 (CEST)
X-Yow: I'm RELIGIOUS!!  I love a man with a HAIRPIECE!!
 Equip me with MISSILES!!
In-Reply-To: <CAFRB3XkueafikCvwzBb+WOAG_1mEkVg1Yt6=teOuVwYd2zWVOw@mail.gmail.com>
	(Phil Lawrence's message of "Thu, 11 Oct 2012 09:25:23 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207486>

Phil Lawrence <prlawrence@gmail.com> writes:

> One approach might be to first generate a state-of-the-repo SHA1:
>     # http://stackoverflow.com/a/7350019/834039
>     # http://git-scm.com/book/ch9-2.html
>     {
>         git rev-list --objects --all
>         git rev-list --objects -g --no-walk --all
>         git rev-list --objects --no-walk \
>             $(git fsck --unreachable |
>               grep '^unreachable commit' |
>               cut -d' ' -f3)
>     } | sort | uniq | git hash-object -w --stdin

I think you'd only need to record the state of all refs (eg. the output
of `git for-each-ref') to reliably detect any changes.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
