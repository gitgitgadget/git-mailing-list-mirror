From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/4] Allow detached form (e.g. "-S foo" instead of "-Sfoo") for diff options
Date: Wed, 28 Jul 2010 09:38:45 +0200
Message-ID: <vpqr5ioukca.fsf@bauges.imag.fr>
References: <1280265719-30968-1-git-send-email-Matthieu.Moy@imag.fr>
	<1280265719-30968-2-git-send-email-Matthieu.Moy@imag.fr>
	<20100727213750.GB11768@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 28 09:44:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oe1JN-0001Jk-Rq
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 09:44:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754234Ab0G1Hn6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jul 2010 03:43:58 -0400
Received: from imag.imag.fr ([129.88.30.1]:51021 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754141Ab0G1Hn5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jul 2010 03:43:57 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o6S7cjhc004389
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 28 Jul 2010 09:38:45 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Oe1Dx-0006fb-H6; Wed, 28 Jul 2010 09:38:45 +0200
In-Reply-To: <20100727213750.GB11768@burratino> (Jonathan Nieder's message of "Tue\, 27 Jul 2010 16\:37\:50 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 28 Jul 2010 09:38:46 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152051>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Matthieu Moy wrote:
>
>> +++ b/diff.c
>> @@ -2990,9 +2990,23 @@ static int opt_arg(const char *arg, int arg_short, const char *arg_long, int *va
> [...]
>> +#define IF_SHORT_OPT(optname)			\
>> +	((!strcmp(arg, "-" #optname)		\
>> +	  && (argv[1] || (die("Option `" #optname "' requires a value"), 1),	\
>> +	      optarg   = argv[1],	       		\
>> +	      argcount = 2,			\
>> +	      1)) ||				\
>> +	 (!prefixcmp(arg, "-" #optname)		\
>> +	  && (optarg = arg + strlen("-" #optname),	\
>> +	      argcount = 1,			\
>> +	       1)))
>> +
>
> Why not something like this?
>
> 	static inline int short_opt(char opt, const char *arg,
> 					const char *argv, const char **optarg)

Sounds nice too. I'll do that in the next round.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
