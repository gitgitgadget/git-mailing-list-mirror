From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Customizable error handlers
Date: Fri, 23 Jun 2006 16:14:07 -0700
Message-ID: <7vsllv8ny8.fsf@assigned-by-dhcp.cox.net>
References: <20060623133227.27854.65567.stgit@machine.or.cz>
	<20060623133847.GN21864@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 24 01:14:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ftuqs-0003S9-Sd
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 01:14:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752169AbWFWXOJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Jun 2006 19:14:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752170AbWFWXOJ
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jun 2006 19:14:09 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:39332 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1752169AbWFWXOI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jun 2006 19:14:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060623231408.VYHT6235.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 23 Jun 2006 19:14:08 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060623133847.GN21864@pasky.or.cz> (Petr Baudis's message of
	"Fri, 23 Jun 2006 15:38:47 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22452>

Petr Baudis <pasky@suse.cz> writes:

> Dear diary, on Fri, Jun 23, 2006 at 03:32:27PM CEST, I got a letter
> where Petr Baudis <pasky@suse.cz> said that...
>> diff --git a/git-compat-util.h b/git-compat-util.h
>> index 5d543d2..e954002 100644
>> --- a/git-compat-util.h
>> +++ b/git-compat-util.h
>> @@ -36,9 +36,13 @@ #endif
>>  #endif
>>  
>>  /* General helper functions */
>> -extern void usage(const char *err) NORETURN;
>> -extern void die(const char *err, ...) NORETURN __attribute__((format (printf, 1, 2)));
>> -extern int error(const char *err, ...) __attribute__((format (printf, 1, 2)));
>> +void usage(const char *err) NORETURN;
>> +void die(const char *err, ...) NORETURN __attribute__((format (printf, 1, 2)));
>> +int error(const char *err, ...) __attribute__((format (printf, 1, 2)));
>
> Wah, this kind of slipped through. Below is a patch without the
> externs removed.

Oh, I first thought you did that on purpose as a cleanup.  After
all don't they mean the same thing?
