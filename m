From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [[PATCH v3] 1/2] [submodule] handle multibyte characters in name
Date: Fri, 14 Jun 2013 11:33:49 -0700
Message-ID: <7vfvwko836.fsf@alter.siamese.dyndns.org>
References: <1371225365-4219-1-git-send-email-iveqy@iveqy.com>
	<1371225365-4219-2-git-send-email-iveqy@iveqy.com>
	<7va9msppw7.fsf@alter.siamese.dyndns.org>
	<20130614182741.GA5812@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jens.lehmann@web.de
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Fri Jun 14 20:33:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnYov-0005bw-41
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 20:33:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753651Ab3FNSdx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 14:33:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37790 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753652Ab3FNSdw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 14:33:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0C40427A39;
	Fri, 14 Jun 2013 18:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Q2QX+8PjHAhLqq8hvX08v2xXIKU=; b=GTrkOY
	fC8lG/BSo3Ay1TqQdIKNofIL6nRVEfTGLepQRDkqkjCEQVlkoRIDT8f3eZVNIOj6
	pyrAbx9b2z9dEjDfMyVSpXWCZq2n520Q37cXxvvc04pgq+IJKOn27FyzOz6dd2Bv
	7kvh+c+yADzz3+EoK/YIOcHm2LZfPN3blLj/M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=T8ukWyxeBPWFlk+DyGJzEydgyGPRnGAr
	AhtnK5MR8UvaFh98zt8Z8zRbwx/oHAlDvUMGeGZ0lf8rOdf57JrWZ5fVTcdEAVcT
	adPNphQFPJZPfB48HKxi4cMUEX2ud6u3ylVpX90FG7aT2aFifzO4MIIRU6QDWbJi
	3Fbu/Uxsv4E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D5ECB27A38;
	Fri, 14 Jun 2013 18:33:51 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3F94C27A32;
	Fri, 14 Jun 2013 18:33:51 +0000 (UTC)
In-Reply-To: <20130614182741.GA5812@paksenarrion.iveqy.com> (Fredrik
	Gustafsson's message of "Fri, 14 Jun 2013 20:27:41 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F5B86378-D520-11E2-95B9-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227910>

Fredrik Gustafsson <iveqy@iveqy.com> writes:

> On Fri, Jun 14, 2013 at 10:23:52AM -0700, Junio C Hamano wrote:
>> Fredrik Gustafsson <iveqy@iveqy.com> writes:
>> 
>> > ... The
>> > correct approach to solve the problem for all pathnames may be to use
>> > "ls-files -z" and tell the Perl script that reads its output to read NUL
>> > separated records by using $/ = "\0".
>> 
>> I've tentatively queued the attached without 2/2; the scriptlet is
>> small enough not to matter in an eventual rewrite, so it shouldn't
>> make a difference either way.
>
> Sorry, I didn't knew enough perl to understand that that was a
> suggestion rather than a hint to a future developer.

Heh, no need to be sorry.  It was a hint, and I just made you a
future developer ;-)
