From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Set TAR in t/Makefile and in t4116-apply-reverse.sh
Date: Fri, 25 Jul 2008 11:54:29 -0700
Message-ID: <7vmyk5sska.fsf@gitster.siamese.dyndns.org>
References: <TE3N1FoSy-vEEv0qsAyvBwBMMq2RuJCWYw7DNLBC7mEh6PxM1LCsOw@cipher.nrlssc.navy.mil> <1217003860-10609-1-git-send-email-s-beyer@gmx.net> <7vvdytsu7n.fsf@gitster.siamese.dyndns.org> <20080725182416.GG27172@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <casey@nrlssc.navy.mil>, git@vger.kernel.org
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Fri Jul 25 20:55:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMSSE-0002BN-GI
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 20:55:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751897AbYGYSyi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 14:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751895AbYGYSyh
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 14:54:37 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:65086 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751191AbYGYSyh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 14:54:37 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 260643BDA1;
	Fri, 25 Jul 2008 14:54:36 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 3332B3BDA0; Fri, 25 Jul 2008 14:54:31 -0400 (EDT)
In-Reply-To: <20080725182416.GG27172@leksak.fem-net> (Stephan Beyer's message
 of "Fri, 25 Jul 2008 20:24:16 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 205D7E54-5A7B-11DD-8369-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90088>

Stephan Beyer <s-beyer@gmx.net> writes:

> Hi,
>
>> diff --git a/Makefile b/Makefile
>> index b003e3e..1d14209 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -1212,6 +1212,7 @@ GIT-CFLAGS: .FORCE-GIT-CFLAGS
>>  
>>  GIT-BUILD-OPTIONS: .FORCE-GIT-BUILD-OPTIONS
>>  	@echo SHELL_PATH=\''$(SHELL_PATH_SQ)'\' >$@
>> +	@echo TAR=\''$(subst ','\'',$(TAR))'\' >>$@
>>  
>>  ### Detect Tck/Tk interpreter path changes
>>  ifndef NO_TCLTK
>
> But then TAR has to be set in test-lib.sh also, to be able to
> invoke t5000 and t4116 directly, hasn't it?

Dosen't test-lib source GIT-BUILD-OPTIONS?
