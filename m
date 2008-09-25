From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] usage.c: remove unused functions
Date: Thu, 25 Sep 2008 14:53:01 +0200
Organization: At home
Message-ID: <gbg1jc$hjm$1@ger.gmane.org>
References: <20080925184104.6117@nanako3.lavabit.com> <200809251348.42789.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 25 14:54:31 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiqMY-0002cM-SK
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 14:54:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752999AbYIYMxQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2008 08:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753223AbYIYMxQ
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 08:53:16 -0400
Received: from main.gmane.org ([80.91.229.2]:60976 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752965AbYIYMxP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2008 08:53:15 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KiqLE-0005UV-Fb
	for git@vger.kernel.org; Thu, 25 Sep 2008 12:53:08 +0000
Received: from abwl56.neoplus.adsl.tpnet.pl ([83.8.235.56])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 25 Sep 2008 12:53:08 +0000
Received: from jnareb by abwl56.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 25 Sep 2008 12:53:08 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abwl56.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96759>

Thomas Rast wrote:

> Nanako Shiraishi wrote:
>> This removes three functions that are not used anywhere.
> [...]
>> -void set_usage_routine(void (*routine)(const char *err) NORETURN)
> [...]
>> -void set_error_routine(void (*routine)(const char *err, va_list params))
> [...]
>> -void set_warn_routine(void (*routine)(const char *warn, va_list params))
> 
> These blame to the following commit:
> 
>   commit 39a3f5ea7c0352a530338d30d4e618f6b4db84e4
>   Author: Petr Baudis <pasky@suse.cz>
>   Date:   Sat Jun 24 04:34:38 2006 +0200
> 
>       Customizable error handlers
>       
>       This patch makes the usage(), die() and error() handlers customizable.
>       Nothing in the git code itself uses that but many other libgit users
>       (like Git.pm) will.
>   [...]
> 
> So apparently the intent was that they would only be used from outside
> Git.  I don't know whether anyone still plans to do that, but they're
> certainly not "just" unused.

By the way, those functions could be used to implement 
"git --silent <cmd>", which is equivalent of "git <cmd> 2>/dev/null"
(which you don't always can do easily).

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
