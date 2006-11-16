X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGIT PATCH] StGIT bash completion
Date: Thu, 16 Nov 2006 17:29:58 +0100
Message-ID: <20061116162958.GB20729@diana.vm.bytemark.co.uk>
References: <20061112211813.19959.73406.stgit@localhost> <b0943d9e0611160621g60a0cac2r5205e37ed7d9fe9f@mail.gmail.com> <20061116154002.GA20729@diana.vm.bytemark.co.uk> <b0943d9e0611160812s6ffec19fm4bf079e08e5fce01@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Thu, 16 Nov 2006 16:30:50 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <b0943d9e0611160812s6ffec19fm4bf079e08e5fce01@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31595>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gkk7s-0004io-Sg for gcvg-git@gmane.org; Thu, 16 Nov
 2006 17:30:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424300AbWKPQaE convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006 11:30:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424314AbWKPQaE
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 11:30:04 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:59656 "EHLO
 diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP id S1424300AbWKPQ37
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006 11:29:59 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1
 (Debian)) id 1Gkk7i-0005fB-00; Thu, 16 Nov 2006 16:29:58 +0000
To: Catalin Marinas <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org

On 2006-11-16 16:12:43 +0000, Catalin Marinas wrote:

> Indeed, stg help takes over 200ms on my machine as well, with hot
> caches but this is mainly because it imports all the
> stgit.commands.* modules in order to read the short description. The
> 'stg help <command>' takes around 90ms on my machine since it only
> imports one module

Excellent. However, this suggests that an option should be added to
stg that makes it print just the subcommand names, without importing
anything, to get this kind of speed there as well. Call it
--generate-tab-completion or something, and don't print it in the help
output.

> (I actually reduced it to 85ms by minimizing the imports even
> further).

Goodie. For reference, I think git was able to list its subcommands in
about 20 ms. Just so you know what to aim for. :-)

> I could actually hard-code the commands only in the script. At the
> moment I removed the _stg_* functions and added some common
> _stg_all_patches() to avoid duplicating the code (see attached).

Seems reasonable.

Next time I do some StGIT hacking (not this weekend, unfortunately), I
was planning to build more tab-completion stuff. On top of my list are
fixing basic completion for all subcommands, and fixing some kind of
filename completion. But do feel free to do it first if you like. :-)

--=20
Karl Hasselstr=F6m, kha@treskal.com
