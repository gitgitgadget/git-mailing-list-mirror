From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/7 v2] git_extract_argv0_path(): Move check for valid
 argv0 from caller to callee
Date: Sun, 18 Jan 2009 13:28:09 -0800
Message-ID: <7vzlhotic6.fsf@gitster.siamese.dyndns.org>
References: <1232280015-8144-1-git-send-email-prohaska@zib.de>
 <1232280015-8144-4-git-send-email-prohaska@zib.de>
 <200901182016.56395.j6t@kdbg.org> <200901182028.11345.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Jan 18 22:29:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOfDH-00082V-Dv
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 22:29:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755348AbZARV2T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 16:28:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754964AbZARV2S
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 16:28:18 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:42057 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755428AbZARV2S (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 16:28:18 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id CB64D1CCD9;
	Sun, 18 Jan 2009 16:28:17 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 129721B56B; Sun,
 18 Jan 2009 16:28:11 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: EC073DC2-E5A6-11DD-B7B3-2E3B113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106287>

Johannes Sixt <j6t@kdbg.org> writes:

> On Sonntag, 18. Januar 2009, Johannes Sixt wrote:
>> On Sonntag, 18. Januar 2009, Steffen Prohaska wrote:
>> > This simplifies the calling code.
>>
>> But it could really be squashed into the previous patch, after fixing...
>>
>> > @@ -23,6 +23,9 @@ const char *system_path(const char *path)
>> >
>> >  const char *git_extract_argv0_path(const char *argv0)
>> >  {
>> > +	if (!argv0 || !*argv0)
>> > +		return 0;
>> > +
>> >  	const char *slash = argv0 + strlen(argv0);
>>
>> ... this declaration after statement.
>
> And we prefer NULL over 0 for the null pointer.
>
> The series is nicely done, thank you! I am using it (the previous round) 
> without problems so far. I hope we can get this in RSN.

Thanks, both.  I take that as your Ack to the whole series.

I've rebased the series to master, squashed in fixes like the above (there
were others) so that each step can compile.  Will queue the result.
