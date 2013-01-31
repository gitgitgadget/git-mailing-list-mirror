From: TJ <git@iam.tj>
Subject: Re: [PATCH 1/1] Introduce new build variables INSTALL_MODE_EXECUTABLE
 and INSTALL_MODE_DATA.
Date: Thu, 31 Jan 2013 16:55:03 +0000
Message-ID: <510AA1E7.9070704@iam.tj>
References: <5109D230.2030101@iam.tj> <7vtxpxic5l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 31 17:55:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0xQ9-0003ri-Bn
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 17:55:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755231Ab3AaQzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 11:55:08 -0500
Received: from yes.iam.tj ([109.74.197.121]:51981 "EHLO iam.tj"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752485Ab3AaQzG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 11:55:06 -0500
Received: from [10.254.251.193] (jeeves.iam.tj [82.71.24.87])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by iam.tj (Postfix) with ESMTPSA id B28D418118
	for <git@vger.kernel.org>; Thu, 31 Jan 2013 16:55:04 +0000 (GMT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
In-Reply-To: <7vtxpxic5l.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215125>

On 31/01/13 15:51, Junio C Hamano wrote:
> TJ <git@iam.tj> writes:
> 
>> +	$(INSTALL) -d -m $(INSTALL_MODE_EXECUTABLE) $(DESTDIR)$(man1dir)
>> +	$(INSTALL) -d -m $(INSTALL_MODE_EXECUTABLE) $(DESTDIR)$(man5dir)
>> +	$(INSTALL) -d -m $(INSTALL_MODE_EXECUTABLE) $(DESTDIR)$(man7dir)
>> +	$(INSTALL) -m $(INSTALL_MODE_DATA) $(DOC_MAN1) $(DESTDIR)$(man1dir)
>> +	$(INSTALL) -m $(INSTALL_MODE_DATA) $(DOC_MAN5) $(DESTDIR)$(man5dir)
>> +	$(INSTALL) -m $(INSTALL_MODE_DATA) $(DOC_MAN7) $(DESTDIR)$(man7dir)
> 
> I'm tempted to suggest
> 
>     INSTALL_DIR = $(INSTALL) -d -m 755
>     INSTALL_DATA = $(INSTALL) -m 644
>     INSTALL_PROGRAM = $(INSTALL) -m 755
> 
> The number of lines the patch needs to touch will be the same, but
> the resulting lines will not have many $(INSTALL_MODE_BLAH) shouting
> at us.

I did contemplate that but was concerned it might be seen as interfering unduly with
the tool name/path settings, as opposed to their options.

> Besides, you would want to differentiate the two kinds of 755 anyway
> (I'd prefer INSTALL_PROGRAM to use -m 555 personally, for example).

Yes, I think I lost that one in the mists of sed-land when making the changes :)

I'll revise the patch based on received comments and post the revision tomorrow.
