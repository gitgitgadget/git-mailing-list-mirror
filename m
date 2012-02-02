From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jan 2012, #08; Tue, 31)
Date: Wed, 01 Feb 2012 20:21:14 -0800
Message-ID: <7vehudzwzp.fsf@alter.siamese.dyndns.org>
References: <7vlion3tr5.fsf@alter.siamese.dyndns.org>
 <m3fweudaf6.fsf@localhost.localdomain>
 <7v39au47dt.fsf@alter.siamese.dyndns.org>
 <7vty3a2sf7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>,
	"Bernhard R. Link" <brl+git@mail.brlink.eu>
X-From: git-owner@vger.kernel.org Thu Feb 02 05:21:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsoB6-0006ND-7p
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 05:21:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755143Ab2BBEVR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Feb 2012 23:21:17 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37083 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753959Ab2BBEVQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2012 23:21:16 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 53FC16142;
	Wed,  1 Feb 2012 23:21:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=O0cSgqOizPaJ0tektDshg0x6Ooo=; b=i2vw1L
	qS7DVdyz/LRvhxXYfJnkj3lKtu3INC3DK5xg7/EDAdGWFIX5qa0v4uDTtDax4EPs
	NPyoEAZkh5hprKrgHUAeEo2vCX+HvUMN4RNJ1N09MUx14gH0bQjLH/eiF7QsypX1
	XpgIMtghN0T/Zk6RSQTh8Sp1sOL3eemD3vuDo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hzuw63Ygc+RwxJ9F5ppp2WQsEmZXYzee
	phEBjpAbz2aA4EdR5nvR2YUx1+kdYTKAliNjWMqXqox+bTZzrr/BfMrz4PfZ6ORL
	Wwwj0yR8hwZlSYtONe5hkIo0Q/uEl2aGqpBDujiDx9Z3xCGj4zgG86WziXfzrkjl
	d19PyNud4Jg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B2186141;
	Wed,  1 Feb 2012 23:21:16 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B9BC1613F; Wed,  1 Feb 2012
 23:21:15 -0500 (EST)
In-Reply-To: <7vty3a2sf7.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 01 Feb 2012 12:46:20 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 58F329D2-4D55-11E1-85F8-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189582>

Junio C Hamano <gitster@pobox.com> writes:

> And of course the culprit turns out to be that "cute" expression.
>
> -- >8 --
> Subject: gitweb: do not use assignment with regexp replace in parameter
>
> A recent patch made the code to generate a parameter to git_get_projects_list
> a bit too cute, by introducing a new variable, assigning a value to it, and
> then munging that value with s/// replacement, all in the parameter list.
>
> The whole expression returns the number of replacements, not the resulting
> value in the variable after s/// operation.
>
> Split them into separate expressions, which also would make the resulting
> lines shorter and less taxing on the brain. 
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

I've squashed this in to the offending commit and merged the result to the
'next' branch.

Thanks.
