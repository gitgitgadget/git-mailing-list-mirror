From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] teach --edit to git rebase
Date: Tue, 11 Oct 2011 21:44:34 -0700
Message-ID: <7vvcrubyz1.fsf@alter.siamese.dyndns.org>
References: <CAMQw0oOBEjW3yS2+wcktXDuEuUiHKjfbK2qDzKvBOiwxo7Zkow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jean Privat <jean.privat@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 12 06:44:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDqgL-0006wK-N5
	for gcvg-git-2@lo.gmane.org; Wed, 12 Oct 2011 06:44:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752113Ab1JLEoh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Oct 2011 00:44:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50877 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751957Ab1JLEoh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2011 00:44:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A1FB62C8F;
	Wed, 12 Oct 2011 00:44:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=EjOYWfYwMQkj0BgR0ftt3KcFgfs=; b=nFGTlXUs7vNJbx3r0sov
	mSZEaRgbzP6VGVdOgG9XoZO2X5fpkaTeoGbFHIgH57jAw1qx1faIgCoYFdDrpczb
	tY3piFQi8l86itaETjqwzX9qWQphuB/U83uEnav6+AFFkCCxT8ojvyeLCmILuVCV
	MeeFIdcFwunj/mK1cqcI/zs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=NLZ5+4IQ2vde1fB81yG3R8mund1ZKHwj0MqZZqMkfm7o0P
	kNaSkkdk1ZsoTRnRYXPSTqJZZJiY6ArXD7D33u5Bw2oF8YJNw3CQ53ZZTzZY//92
	+empyY/Q9d05E9Ju2ghe9CUFh3fDhSqROYYS55+fGkB3OMaVi8QJ6yYXRIWpE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A7B52C8E;
	Wed, 12 Oct 2011 00:44:36 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2E7FB2C8D; Wed, 12 Oct 2011
 00:44:36 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E2FDF6BA-F48C-11E0-A762-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183353>

Jean Privat <jean.privat@gmail.com> writes:

> Yes I know "show me the code" but because I am lazy I prefer ask 1-if
> the proposal makes sense, and 2-if the following way of doing it makes
> sense.

No, no, and no we do not necessarily hate talking to lazy people but only
as long as what they propose makes some sense.

The only thing you can do with this new option is "update one commit
buried in the history, and rebase everything that build on top of it", as
far as I can tell. It feels a shame to waste the generic word "--edit" for
such a narrow option.

At the UI level, "git commit --amend HEAD~4" might be a more natural way
to invoke such an operation, I would think.
