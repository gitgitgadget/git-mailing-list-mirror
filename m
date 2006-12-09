X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: [PATCH] Install git-sh-setup.sh into $(prefix)/share/git-core.
 Call with explicit path.
Date: Sun, 10 Dec 2006 00:40:49 +0100
Message-ID: <457B4981.2030408@xs4all.nl>
References: <elc6g3$v1m$1@sea.gmane.org> <20061208193718.GA11906@soma>	<7v3b7qi0b4.fsf@assigned-by-dhcp.cox.net> <457AB54B.8070107@xs4all.nl> <7v1wn8ah2k.fsf@assigned-by-dhcp.cox.net>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 9 Dec 2006 23:40:58 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
Original-Newsgroups: gmane.comp.version-control.git
In-Reply-To: <7v1wn8ah2k.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by XS4ALL Virus Scanner
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33849>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtBoM-0008Rb-DF for gcvg-git@gmane.org; Sun, 10 Dec
 2006 00:40:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759827AbWLIXkq (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 9 Dec 2006
 18:40:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759846AbWLIXkq
 (ORCPT <rfc822;git-outgoing>); Sat, 9 Dec 2006 18:40:46 -0500
Received: from smtp-vbr10.xs4all.nl ([194.109.24.30]:3819 "EHLO
 smtp-vbr10.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1759821AbWLIXkp (ORCPT <rfc822;git@vger.kernel.org>); Sat, 9 Dec 2006
 18:40:45 -0500
Received: from [192.168.1.35] (cu-c-36d6f.adsl.wanadoo.nl [83.118.11.111])
 (authenticated bits=0) by smtp-vbr10.xs4all.nl (8.13.8/8.13.8) with ESMTP id
 kB9NeeW2012714 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256
 verify=NO); Sun, 10 Dec 2006 00:40:40 +0100 (CET) (envelope-from
 hanwen@xs4all.nl)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano escreveu:
> Han-Wen Nienhuys <hanwen@xs4all.nl> writes:
> 
>> And how about coding the path of git-sh-setup (in <prefix>/bin/git-sh-setup) 
>> in the shell scripts? This will ensure that the sh-setup is the one
>> from the right package, but still retain backward compatibility for 
>> scripts.
> 
> Hardcoding $(bin)/git-sh-setup is a non-starter; it breaks
> GIT_EXEC_PATH convention to allow users to override it.

> In other words, I do not know what real problem you are trying
> to solve.

The real problem is that git is nonstandard to wrap around:
scripts like git-sh-setup need special attention, because they don't work 
with

  exec /some/where/else/git-sh-setup "$@"

I admit is a small problem, but IMO that's not an argument not to solve it.

-- 
