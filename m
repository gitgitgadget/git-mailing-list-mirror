From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 2/4] diff.c: associate a flag with each pattern and use
 it for compiling regex
Date: Thu, 18 Sep 2008 08:41:16 +0200
Message-ID: <48D1F80C.5030502@op5.se>
References: <7v3ak06jzj.fsf@gitster.siamese.dyndns.org> <GZAEBf1BcP9-dznrIesxaE4Rb8bim6DpwDWCb9yWl99UVoQC9Dog0A@cipher.nrlssc.navy.mil> <7vod2m1464.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Arjen Laarhoven <arjen@yaph.org>,
	Mike Ralphson <mike.ralphson@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jeff King <peff@peff.net>,
	Boyd Lynn Gerber <gerberb@zenez.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 18 08:42:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgDDm-000138-Cb
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 08:42:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449AbYIRGlX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2008 02:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbYIRGlX
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 02:41:23 -0400
Received: from mail.op5.se ([193.201.96.20]:58293 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751146AbYIRGlX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 02:41:23 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 5B5491B80078;
	Thu, 18 Sep 2008 08:31:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -3.449
X-Spam-Level: 
X-Spam-Status: No, score=-3.449 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, AWL=0.950, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uJG5t9vGzcB3; Thu, 18 Sep 2008 08:31:16 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.171])
	by mail.op5.se (Postfix) with ESMTP id CA6DF1B80081;
	Thu, 18 Sep 2008 08:31:15 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <7vod2m1464.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96167>

Junio C Hamano wrote:
> Brandon Casey <casey@nrlssc.navy.mil> writes:
> 
>> This is in preparation for allowing extended regular expression patterns.
>> ...
>> @@ -100,10 +100,11 @@ static int parse_lldiff_command(const char *var, const char *ep, const char *val
>>  static struct funcname_pattern {
>>  	char *name;
>>  	char *pattern;
>> +	int cflags;
> 
> What does "C" stand for?


"compile". It's the same name as regcomp(3) uses for the flags being
used to compile the regular expression. The full mnemonic name would
be regex_compile_flag, which is a bit unwieldy. Perhaps regcomp_flags
would be a good compromise?

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
