From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] gitweb.perl t9500 t9501
Date: Sat, 22 Aug 2009 19:09:57 -0700
Message-ID: <7v3a7j2scq.fsf@alter.siamese.dyndns.org>
References: <7veir5naq3.fsf@alter.siamese.dyndns.org>
 <F4C7A2F3-B030-449A-87AC-B54CA2B647B4@mailservices.uwaterloo.ca>
 <200908212006.16333.jnareb@gmail.com>
 <7vfxbldj31.fsf@alter.siamese.dyndns.org>
 <4C812C4E-815B-478D-AEB1-3F1DEC5D3641@mailservices.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Mark A Rada <marada@uwaterloo.ca>
X-From: git-owner@vger.kernel.org Sun Aug 23 04:11:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mf2Yn-0003Ry-BS
	for gcvg-git-2@lo.gmane.org; Sun, 23 Aug 2009 04:11:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933432AbZHWCKL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Aug 2009 22:10:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933430AbZHWCKK
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Aug 2009 22:10:10 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59034 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933429AbZHWCKJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Aug 2009 22:10:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1A5063315B;
	Sat, 22 Aug 2009 22:10:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=otOEnF9eM8jheDbp+VBvb5JUpWw=; b=kCb+gw
	SBgDIhQKolUnXge3rcbq33UM1G3lEj0OZ+R2j1tRpWty8hiorKGBEMH3tOJv7IXf
	/RflqaLsaE2h1OVnqhOIW/S/PANYJwN1TpQbdJVw3Wy8UULdpi10PHHHgZiIWKo/
	/WHucbSfzGBqYkGiDGYVQcinhxkSu5b9VwLgc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gfzQ78ciLMcW1Eva2lE2uxB+6LEifM8x
	YlGcDr1x/KMhs2qOqvJWOl4gj4XYCg/QjsOnRLeh2VdRqHhqUsGW8Hq0oiqOEYr9
	njANvz+XXoeudLMDryJNFR61XYg0DxaSRjF+dJZxIAZs4MsyJNeL98cpX+IMoVDo
	jrESnOfT7do=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E6B9E3315A;
	Sat, 22 Aug 2009 22:10:06 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 94DFF33159; Sat, 22 Aug 2009
 22:10:02 -0400 (EDT)
In-Reply-To: <4C812C4E-815B-478D-AEB1-3F1DEC5D3641@mailservices.uwaterloo.ca>
 (Mark A. Rada's message of "Sat\, 22 Aug 2009 18\:42\:56 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 13D9FFD2-8F8A-11DE-8B04-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126830>

Mark A Rada <marada@uwaterloo.ca> writes:

> I have not been telling git-format-patch to use a specific width for
> the diffstat, is the standard width supposed to be 70?

Perhaps there is some misconception here.

We try to keep our _code_ to fit in standard 80-column terminal.  We also
keep lines in the _log message_ shorter than 70-something so that after
indentation by various programs (e.g. shortlog) and a few levels of
quoting in the e-mail are added, the lines will still stay below
80-columns.  These are standard practices.

And you may need to find a good place to break lines in your _code_, and
your _log message_, to stay below that limit.

But that all happens inside your editor, before you touch format-patch nor
your MUA.

The patch contents may contain long lines, such as

    diff --git a/filename-that-is-long b/filename-that-is-long

or

    @@ -old,lines +new,lines @@ original contents that is long

that is neither _code_ nor _log message_.  They could easily go beyond
80-column, but that is normal, and they do not have any 70-column limit
for you to worry about.  They follow a different rule, namely, if
format-patch (or "diff" in general) outputs something on a single line,
that has to stay on a single line.  "patch" expects each of these on a
single line.  Do not break them.

So make sure that you do not let your MUA perform any line-wrapping at
random place in the message after you formatted your commits via
format-patch, and you will be Ok.
