X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: [PATCH] Install git-sh-setup.sh into $(prefix)/share/git-core.
  Call with explicit path.
Date: Sat, 09 Dec 2006 14:08:27 +0100
Message-ID: <457AB54B.8070107@xs4all.nl>
References: <elc6g3$v1m$1@sea.gmane.org> <20061208193718.GA11906@soma> <7v3b7qi0b4.fsf@assigned-by-dhcp.cox.net>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 9 Dec 2006 13:08:44 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
Original-Newsgroups: gmane.comp.version-control.git
In-Reply-To: <7v3b7qi0b4.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by XS4ALL Virus Scanner
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33813>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gt1wT-0006C8-UR for gcvg-git@gmane.org; Sat, 09 Dec
 2006 14:08:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759217AbWLINIX (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 9 Dec 2006
 08:08:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759246AbWLINIX
 (ORCPT <rfc822;git-outgoing>); Sat, 9 Dec 2006 08:08:23 -0500
Received: from smtp-vbr7.xs4all.nl ([194.109.24.27]:2767 "EHLO
 smtp-vbr7.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1759217AbWLINIV (ORCPT <rfc822;git@vger.kernel.org>); Sat, 9 Dec 2006
 08:08:21 -0500
Received: from [192.168.123.187] (muurbloem.xs4all.nl [213.84.26.127])
 (authenticated bits=0) by smtp-vbr7.xs4all.nl (8.13.8/8.13.8) with ESMTP id
 kB9D8H5d083586 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256
 verify=NO); Sat, 9 Dec 2006 14:08:17 +0100 (CET) (envelope-from
 hanwen@xs4all.nl)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano escreveu:
> Eric Wong <normalperson@yhbt.net> writes:
> 
>> Han-Wen Nienhuys <hanwen@xs4all.nl> wrote:
>>> git-sh-setup isn't a 'normal' binary, in that it should be called by
>>> bash only and not run in a subshell. Therefore, it should not be installed
>>> in a executable directory, but rather in $prefix/share/git-core/
>> This seems to break existing hooks, or at least old repositories can
>> be stuck using an old version of git-sh-setup in those hooks.
> 
> Honestly speaking, I do not think this patch is worth it.
> People who care deeply enough should just use gitexecdir that is
> separate from bindir.

And how about coding the path of git-sh-setup (in <prefix>/bin/git-sh-setup) 
in the shell scripts? This will ensure that the sh-setup is the one
from the right package, but still retain backward compatibility for 
scripts.

-- 
