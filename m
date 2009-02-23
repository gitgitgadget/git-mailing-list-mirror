From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Make git blame's date output format configurable,
 like git log
Date: Mon, 23 Feb 2009 08:33:47 -0800
Message-ID: <7v3ae5un84.fsf@gitster.siamese.dyndns.org>
References: <1235170271-10694-1-git-send-email-eletuchy@gmail.com>
 <20090222230358.GA19011@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: eletuchy@gmail.com, gitster@pobox.com, git@vger.kernel.org,
	Eugene Letuchy <eugene@facebook.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 23 17:35:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbdmT-0004d0-1C
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 17:35:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755153AbZBWQeB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 11:34:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756960AbZBWQeA
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 11:34:00 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36590 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755161AbZBWQd7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 11:33:59 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C4B722BC2E;
	Mon, 23 Feb 2009 11:33:55 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id DCAF82BC32; Mon,
 23 Feb 2009 11:33:48 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C381F602-01C7-11DE-91FD-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111154>

Jeff King <peff@peff.net> writes:

> On Fri, Feb 20, 2009 at 02:51:11PM -0800, eletuchy@gmail.com wrote:
>
>> @@ -1975,6 +1975,9 @@ static int git_blame_config(const char *var, const char *value, void *cb)
>>  		blank_boundary = git_config_bool(var, value);
>>  		return 0;
>>  	}
>> +	if (!strcmp(var, "blame.date") && value[0]) {
>> +		blame_date_mode = parse_date_format(value);
>> +	}
>>  	return git_default_config(var, value, cb);
>>  }
>
> When there is a config value we are expecting to have a value rather
> than a boolean, we usually print an error rather than silently
> discarding.

Oops, missed that.  Yes, this needs fixing.

Thanks.
