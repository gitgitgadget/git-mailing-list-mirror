From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Is there a way to add a default `--squash` flag for all merges
 into a head?
Date: Tue, 08 Mar 2011 11:28:23 -0800
Message-ID: <7vr5ahe7jc.fsf@alter.siamese.dyndns.org>
References: <9f02bed0-fa18-46b1-a3d3-346e1cc7dc01@k15g2000prk.googlegroups.com>
 <m2r5aibpsl.fsf@igel.home>
 <b98e837f-a0ae-4061-aa09-b4d30e3b0522@b13g2000prf.googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dun Peal <dunpealer@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 08 20:28:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Px2aN-00059W-6b
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 20:28:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755651Ab1CHT2c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2011 14:28:32 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:62739 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755618Ab1CHT2b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2011 14:28:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1C2893153;
	Tue,  8 Mar 2011 14:29:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GJPY9gT137TgLlNpoDohbh8BSx0=; b=fVAqIs
	1MQUZWdh2DVODhn9h6WmiRXJPh0eUE2GO6dExCS1uhkNSQBS9A7lxIHdJPVqaZck
	WQu//DsCL74RKzoSYJJWrZZgtCIbfKsnSzEr4eu57YJZizgInCpM2+wsBwsk3C3g
	oAKuh3Zmylad6afDB7hiRfvOf5TGoI30GF4IQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HmbGK6oJIcxa/N5WpCBniVe13RjUr3gS
	W36YIOFoZaTAa4Vv7CsrXzm5vf1Wn86mBbYadAPXP6kXHZWpDdnhSQhX64HijDMh
	85CRa/3YY9rBpvfF6jJ9UbwuG06vJ88X8tGLxcyeq6YzZ6RxyeT3mwYYN9SOCYTX
	qS6nconsW2c=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EE9AD314E;
	Tue,  8 Mar 2011 14:29:54 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1F5E2314D; Tue,  8 Mar 2011
 14:29:51 -0500 (EST)
In-Reply-To: <b98e837f-a0ae-4061-aa09-b4d30e3b0522@b13g2000prf.googlegroups.com> (Dun
 Peal's message of "Mon, 7 Mar 2011 13:48:46 -0800 (PST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 722627DC-49BA-11E0-9EB7-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168680>

Dun Peal <dunpealer@gmail.com> writes:

> Sigh. You're right, what a silly man I am!!!
>
> I assume there's no way to do what I want, except maybe encourage
> everyone to use an alias for `git merge` that includes the flag.

I have a strong suspicion that it is not really what you want to always
use --squash merge, and everybody forced (or "encouraged") by you to do so
would hate you in the end.

The solution to whatever problem you are trying to solve should not be to
discard one of the most valuable information git keeps track of to avoid
the CVS/(old)SVN mess when performing repeated merges with a branch.

I also suspect that you might be delighted by "log --first-parent -m".
