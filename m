From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Teach Makefile.PL to find .pm files on its own
Date: Wed, 25 Jul 2012 15:19:13 -0700
Message-ID: <7vsjcfa3ha.fsf@alter.siamese.dyndns.org>
References: <1343186471-1024-1-git-send-email-schwern@pobox.com>
 <7vhasvdbk9.fsf@alter.siamese.dyndns.org> <5010567B.1060907@pobox.com>
 <7vehnzbmyt.fsf@alter.siamese.dyndns.org> <50106136.5000404@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, robbat2@gentoo.org,
	bwalton@artsci.utoronto.ca, normalperson@yhbt.net
To: Michael G Schwern <schwern@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 00:19:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Su9vO-0005iy-RE
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 00:19:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363Ab2GYWTQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 18:19:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38678 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751066Ab2GYWTP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 18:19:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 364FD819F;
	Wed, 25 Jul 2012 18:19:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=R6Vw85LaidHUGlp/qEmIt/oGtCs=; b=qw6grE
	Onk5dWfOnmp9Tg/0IsqOOzJD9jgSb0Q04VC9rGHpc6MQz9rw66WSBqou9092ZoVr
	zCkcGLm4cI0hB4ahMo/0cBcKuioXEhpJyWuadxOPKxt8MCytrIbBUPzdbNOFO+MC
	L8b6djvchWtH9AZtl4Yi0Ng+UiVpxIuWu2xXk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=K7ZyURV5y7xSvUXFJRcqpHdpAF8Q+jct
	AKWjdE4RZmB5H19uumJ4q9NOrfY/TkE3/+hRC/M4jRzFQk6vyyIeEh1g++1UcOBQ
	3va5/rHfdR1ZgfZuZwjwi1NcvFXrSeO4Ks7jUydem+a/FhK7vW/jImFUWg4Vp04O
	mroVdiIAPpI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 239F7819E;
	Wed, 25 Jul 2012 18:19:15 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 97912819D; Wed, 25 Jul 2012
 18:19:14 -0400 (EDT)
In-Reply-To: <50106136.5000404@pobox.com> (Michael G. Schwern's message of
 "Wed, 25 Jul 2012 14:12:22 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C46E0616-D6A6-11E1-8FB4-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202210>

Michael G Schwern <schwern@pobox.com> writes:

>>> Also I just realized I've been basing my work on master.  Should I move to maint?
>> 
>> I don't think so.  It is not fixing any urgent breakage (iow, by
>> being told about .pm explicitly, it knows about them just fine
>> without being taught how to find them).
>
> How about the git-svn SVN 1.7 fix in general?  All of these patch sets I'm
> sending build on one another, is that going to be a problem?  It's going to
> come in about six parts.

Judging from the rate of the discussion this is progressing, I was
imagining that this series would be ready by 1.7.13 at the earliest,
possibly back-merged to 1.7.12.X maintenance series, and 1.7.11.X
maintenance series is no longer relevant by then.

But I certainly do not mind seeing the series based on earlier
maintenance releases, e.g. maint-1.7.9.  There however are tons of
other git-svn.perl and perl/ updates since then, so basing the
series on the current maint branch to abandon 1.7.10.X and earlier
but still leaving the door open to downmerge to 1.7.11.X may be a
good trade-off.
