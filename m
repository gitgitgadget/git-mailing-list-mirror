From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] teach git-archive to auto detect the output
 format
Date: Sun, 13 Sep 2009 14:27:52 -0700
Message-ID: <7v4or6o7qf.fsf@alter.siamese.dyndns.org>
References: <7v3a6r5znq.fsf@alter.siamese.dyndns.org>
 <1252863407-2598-1-git-send-email-dpotapov@gmail.com>
 <1252863407-2598-2-git-send-email-dpotapov@gmail.com>
 <7vzl8yr81j.fsf@alter.siamese.dyndns.org>
 <20090913201701.GH30385@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, John Tapsell <johnflux@gmail.com>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 13 23:28:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmwcC-0000kl-JV
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 23:28:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755167AbZIMV2A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 17:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755119AbZIMV17
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 17:27:59 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38967 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754972AbZIMV16 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2009 17:27:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AB9684FA06;
	Sun, 13 Sep 2009 17:28:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=HJygUOLxGEQHkbyXG+g1S2mxNqs=; b=HbrxQoEwBn3jcsvZGLzGdv6
	2/7y7d9NkY9+KU8JkOv2doCL6oqfMT8+WCoCaszIJPYG95vrlMA6syZRGMaKjLDf
	fwL9gpY6h3M1M/8elgV0sM2flAr2vA3mM11OCwuiu1AJv4iXYYgnPlILKABHe2dF
	FpeX/NG8MpYstHEeoAsA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=Oo3B3w0m7tisGm24KBjlzAt52l8xFKfwFW6hZB3VvosCSG7z4
	cCK1PiLzRtB6aD/oUPYyah1M8sM+hlGFZ6n1wtsWRFoshIJpT0l4I65rdoi50/Nr
	j0Tzv9fbgmANIp6tAuid6nruwrhJKCcmcT1Av1uspywu6lQOoQSee32tqk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8350D4FA05;
	Sun, 13 Sep 2009 17:27:58 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3C6ED4F9FD; Sun, 13 Sep 2009
 17:27:53 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4ED249EA-A0AC-11DE-B7DE-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128418>

Dmitry Potapov <dpotapov@gmail.com> writes:

> On Sun, Sep 13, 2009 at 11:52:56AM -0700, Junio C Hamano wrote:
>> > +		sprintf(fmt_opt, "--format=%s", format);
>> > +		argv[argc++] = fmt_opt;
>> > +		argv[argc] = NULL;
>> 
> Either --output or --format option was used before, and this option is
> extracted from argv[] by parse_options(). So it should be space for at
> least one argument in argv.

To my taste, that is a unwarranted (on the borderline) assumption of what
parse_options() does, but I'll let it pass with some additional comment to
warn readers of the code.

Applied.
