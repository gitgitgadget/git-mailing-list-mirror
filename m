From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/9] Makefile: Do not install a copy of 'git' in
 $(gitexecdir)
Date: Sun, 27 Jul 2008 23:24:59 -0700
Message-ID: <7vabg2v83o.fsf@gitster.siamese.dyndns.org>
References: <1216667998-8879-1-git-send-email-johannes.sixt@telecom.at>
 <1216667998-8879-2-git-send-email-johannes.sixt@telecom.at>
 <488D104F.8080005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: gitzilla@gmail.com
X-From: git-owner@vger.kernel.org Mon Jul 28 08:26:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNMBU-0000f7-Ul
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 08:26:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751485AbYG1GZI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 02:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751003AbYG1GZH
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 02:25:07 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56933 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750726AbYG1GZG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 02:25:06 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D2A0046A3E;
	Mon, 28 Jul 2008 02:25:04 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 3D15446A3D; Mon, 28 Jul 2008 02:25:01 -0400 (EDT)
In-Reply-To: <488D104F.8080005@gmail.com> (A. Large Angry's message of "Sun,
 27 Jul 2008 20:18:23 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: EA9F938E-5C6D-11DD-8F4F-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90417>

A Large Angry SCM <gitzilla@gmail.com> writes:

> Johannes Sixt wrote:
> [...]
>>
>> diff --git a/Makefile b/Makefile
>> index 551bde9..cbab4f9 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -1335,6 +1335,7 @@ endif
>>  			'$(DESTDIR_SQ)$(gitexecdir_SQ)/git$X'; \
>>  	fi
>>  	$(foreach p,$(BUILT_INS), $(RM) '$(DESTDIR_SQ)$(gitexecdir_SQ)/$p' && ln '$(DESTDIR_SQ)$(gitexecdir_SQ)/git$X' '$(DESTDIR_SQ)$(gitexecdir_SQ)/$p' ;)
>> +	$(RM) '$(DESTDIR_SQ)$(gitexecdir_SQ)/git$X'
>>  ifneq (,$X)
>>  	$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_PROGRAMS) $(BUILT_INS) git$X)), $(RM) '$(DESTDIR_SQ)$(gitexecdir_SQ)/$p';)
>>  endif
>
> This new action needs to be in a conditional to keep it from removing
> the ONLY git executable when bindir and execdir are the same dir.

Heh, I love bug reports that come immediately after I tag the tip of
'master' as -rc1.
