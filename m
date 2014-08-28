From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 5/6] Change copy_fd() to not close input fd
Date: Thu, 28 Aug 2014 10:15:21 -0700
Message-ID: <xmqqegw0bknq.fsf@gitster.dls.corp.google.com>
References: <1409066605-4851-1-git-send-email-prohaska@zib.de>
	<1409066605-4851-6-git-send-email-prohaska@zib.de>
	<20140826182905.GD17546@peff.net>
	<3947B7A7-98D0-4313-B7D7-D5EB35427E56@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>,
	John Keeping <john@keeping.me.uk>,
	Scott Chacon <schacon@gmail.com>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Thu Aug 28 19:15:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XN3IP-00079m-JN
	for gcvg-git-2@plane.gmane.org; Thu, 28 Aug 2014 19:15:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbaH1RPd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2014 13:15:33 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60040 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751087AbaH1RPd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2014 13:15:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0893535E20;
	Thu, 28 Aug 2014 13:15:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=LuEckh6EohqT4JIRMBIHnem0ABk=; b=m5ZGxi
	/ho3HQQa0W3ywFgNGt9j5Or1HxSbjWjOHQ3tEQsrBYhgLeWdbeKUPGoDjJaDoEUN
	fHCJTkT+1Q3J6HxmOlGlxQp48aeVf0xS+YPjH3r4v+E5xGeUFO1xvmb7Ks2iBYYL
	D3Wf+/jRX0PC0o7RM/nBVVVuQtrLXbxYR/psI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Y799rFG8HXSaeQJ7z4zJyFq7vfmPq7ph
	ME01kcPG7REk89+/eeejD6FC8uEdbGykfCAEIaIXRtW9s5cRYKiSCppItabcIuiW
	kC64s//NxymQDVfmKgy+GHx1NDUryfmUc73rrnsOulwrK+Qw5JY/GgBRgn5pj5y4
	K8WeZDThDRw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CA52235E1E;
	Thu, 28 Aug 2014 13:15:31 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id AC78135E0C;
	Thu, 28 Aug 2014 13:15:22 -0400 (EDT)
In-Reply-To: <3947B7A7-98D0-4313-B7D7-D5EB35427E56@zib.de> (Steffen Prohaska's
	message of "Thu, 28 Aug 2014 17:37:41 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E500FE1C-2ED6-11E4-8183-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256105>

Steffen Prohaska <prohaska@zib.de> writes:

> On Aug 26, 2014, at 8:29 PM, Jeff King <peff@peff.net> wrote:
> ...
> Makes all sense, and seems sane to me, too.
>
> Junio, I saw that you have the changes on pu with 'SQUASH???...'.  Will you
> squash it, or shall I send another complete update of the patch series?

If I let you reroll, I will risk that you will forget to propagate
the log message fixes I did here while queuing the v6 iteration in
it, so let me try doing the squashing and push out the result first.

Thanks.
