From: Junio C Hamano <gitster@pobox.com>
Subject: Re: CIA hook for contrib/
Date: Sun, 28 Mar 2010 23:14:33 -0700
Message-ID: <7veij3bqnq.fsf@alter.siamese.dyndns.org>
References: <20100327102632.GA5043@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: esr@thyrsus.com
X-From: git-owner@vger.kernel.org Mon Mar 29 08:15:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nw8Ff-0006bR-8P
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 08:15:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754152Ab0C2GOn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Mar 2010 02:14:43 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57698 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753935Ab0C2GOl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Mar 2010 02:14:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A27AA68B9;
	Mon, 29 Mar 2010 02:14:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=n7kjpAFB3zfUQGmQF7vUYVURHno=; b=rwGmzD
	DTUUjOngNouqTgoOiGpOC4UAFXoX+esgByUXCjFinSikFkF1+s3ozfkMBRPw4HxO
	B/I/SyW1g2mGIUCU0cYekRmH9n0rV5x2Vyr77y30nAKNCXWuFSKcDpG0zY4HSsGf
	YFR1I5/Kgy0sYxU8ukBgb4b12a8ZqryUmS+WI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L4Esu9BjrwVzGAEZYeEBQc5MkphCDTiz
	bbgCLus+LA43p1FTsQN1xreGCSpk8IDAPRr981W79I8l9rGyOhTv+HK6UcmD8rHP
	W2m7d1sKxBKdnOnrt0oy1qjJiTwOMKuXPdxltQa6jdzHultarfL6dHqrXsOK4Fxe
	c6tKmzkPG8I=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E74A7A68B7;
	Mon, 29 Mar 2010 02:14:37 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5629EA68B5; Mon, 29 Mar
 2010 02:14:35 -0400 (EDT)
In-Reply-To: <20100327102632.GA5043@thyrsus.com> (Eric Raymond's message of
 "Sat\, 27 Mar 2010 06\:26\:32 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5A833AB8-3AFA-11DF-B543-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143440>

Eric Raymond <esr@thyrsus.com> writes:

> Summary:
> * The CIA hooks for git are presently dusty and somewhat broken.

Thanks; but I don't ship any ancient hooks, so this probably wants to be
sent to whoever still have them displayed on their sites.

> * I am requesting that they be given a home in git contrib/.

I gave a quick read to the shell one, and I found it reasonable.  Thanks
for sharing.

One tiny nit is the "git --exec-path" bit, though.  You don't seem to use
any ancient "git-frotz" form, so it is not just unnecessary but is
misleading.  I'd recommend to just drop it.

Another tiny nit is that you _might_ want to make it fail loudly if
somebody copies this out of contrib/ without changing $project properly,
instead of spamming cia with bogus messages claiming that they pertain to
the GPSD project.

> I am also enclosing a rewrite in Python. This has a serious functional
> advantage over either Perl or sh; the batteries-included effect of the
> Python libraries means it's not dependent on things like the path
> location of sendmail or whether the hosting site will allow it to
> run wget.
> ...
> Code is enclosed.

Thanks.  Could you send a signed-off patch that creates contrib/ciabot/
directory, and places these two files in there, with a README describing
that you are the maintainer of these tools?
