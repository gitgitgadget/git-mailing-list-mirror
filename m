From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] cherry-pick: Add an option to prepend a string to the
 commit message
Date: Fri, 11 Jun 2010 23:18:53 -0700
Message-ID: <7vsk4sg4du.fsf@alter.siamese.dyndns.org>
References: <1276319237-12010-1-git-send-email-bobbypowers@gmail.com>
 <20100612055831.GA2426@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bobby Powers <bobbypowers@gmail.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 12 08:19:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONK3r-0001qZ-W1
	for gcvg-git-2@lo.gmane.org; Sat, 12 Jun 2010 08:19:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752482Ab0FLGTJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jun 2010 02:19:09 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:55170 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751166Ab0FLGTI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jun 2010 02:19:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B002BB7B6;
	Sat, 12 Jun 2010 02:19:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JgumSbckrsHemFLcuo4gngs+gw4=; b=KY1UvM
	OtGvPP0HJgdXmpCpBUof7Kv5nFjgUTK7SqzolF7InRKuxEf5jZo3HfQVEP5x6YWI
	tYdmYtqIq7GcEV/sV29CY4kCQWpbJTe4t41+3Exazudsdy98D5ey698BudZ76tEA
	M0T7ntA+CRh3SB/Mad46EjMO78oNf9MPT/ydg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UBgXgBxql9H/mqa+om8AMakWLYs4VAPA
	do08Y4t759sigvn6MSPpwLoY5yaOv74zwCNDA/yxi+snjzqVFFZk7oa7Ga9EBHFY
	sbDDk3a+PL76K8yyUjaIjGnk9nHnHGW9BI+OwRMGsWan7fLz7SnY5GGnXu3NvM5I
	n63V2nfEXho=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5626FBB7B4;
	Sat, 12 Jun 2010 02:19:01 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 95EEABB7B3; Sat, 12 Jun
 2010 02:18:55 -0400 (EDT)
In-Reply-To: <20100612055831.GA2426@burratino> (Jonathan Nieder's message of
 "Sat\, 12 Jun 2010 00\:58\:32 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 647EB0E4-75EA-11DF-A2F0-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148989>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Bobby Powers wrote:
>
>> This can be useful situations where you have a batch of commits to
>> cherry-pick and need to prefix each new commit message with similar
>> information
>
> Sounds reasonable.

It might be "usable in some limited context", but does not sound
"reasonable" at all, sorry.

Especially since we will be getting "replay more than one commits in
sequence", I would say it would make more sense to allow this kind of
per-invocation (iow, command line option) commit transmonger a bit more
flexibility, e.g. being a filter, or even a script that takes the original
commit object name (so that it can consult git-vs-svn mapping in it if it
wants to, for example).
