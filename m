From: Junio C Hamano <gitster@pobox.com>
Subject: Re: linux-next: unneeded merge in the security tree
Date: Tue, 12 Mar 2013 20:17:27 -0700
Message-ID: <7v38w056pk.fsf@alter.siamese.dyndns.org>
References: <7vtxog5msj.fsf@alter.siamese.dyndns.org>
 <20130313023026.GD16919@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	James Morris <jmorris@namei.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-next@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
X-From: linux-kernel-owner@vger.kernel.org Wed Mar 13 04:18:04 2013
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1UFcCa-0006ao-2S
	for glk-linux-kernel-3@plane.gmane.org; Wed, 13 Mar 2013 04:18:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932796Ab3CMDRb (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 12 Mar 2013 23:17:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39557 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755896Ab3CMDRa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Mar 2013 23:17:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 49D3ACD05;
	Tue, 12 Mar 2013 23:17:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SI859CWL3HK5JxS2HfVdoHLH9IE=; b=fOQitI
	fFH6ub4SJG2ZJJ7rMYjn6CQrmCRUKyJ/3B4Zv/yC/+N2SPmyF2dx+12H6H0BpLQ/
	beXwnBeIr6/mGDiqK63TNc/889XWLv1BJ8xEg+WZiwn6LNTqcKfUPZGln4jCtN5U
	X21jHtvZIjJeWOo0keoX6aRS86F9cpQbwWHXk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lVDbKMmWS3x4oohb3dH78V0txoyfUcM9
	PWiUGmyhPmeG0Bc3wkYw7ndTTmj8glknR2Pwfa2+ei99tpgpbnwUJmlSUumXwGHZ
	SnvJmWExEHjoEta73ac/Fk+1/2P5CFFZC8vjaO5z8l1j0VWqPo/9d9YGq+79azDX
	JmtWBPQyjIg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3DFBECD04;
	Tue, 12 Mar 2013 23:17:29 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B5B00CD03; Tue, 12 Mar 2013
 23:17:28 -0400 (EDT)
In-Reply-To: <20130313023026.GD16919@thunk.org> (Theodore Ts'o's message of
 "Tue, 12 Mar 2013 22:30:26 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 892E8DF0-8B8C-11E2-94E0-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218027>

Theodore Ts'o <tytso@mit.edu> writes:

> On Tue, Mar 12, 2013 at 02:30:04PM -0700, Junio C Hamano wrote:
>> Theodore Ts'o <tytso@mit.edu> writes:
>> 
>> > [remote "origin"]
>> > 	url = git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
>> > 	fetch = +refs/heads/master:refs/heads/master
>> > 	mergeoptions = --ff-only
>> >
>> 
>> Is there an escape hatch for that rare case?  IOW, how does a
>> submaintainer who configured the above to override --ff-only?
>
> Hmm, maybe we would need to add a --no-ff-only?  Or they could just
> do:
>
> 	git fetch origin
> 	git merge FETCH_HEAD

Hmm, neither feel quite nice.

I haven't heard any comments on my alternative proposal, by the
way.  Did the message get lost?
