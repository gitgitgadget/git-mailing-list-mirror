From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] status: display "doing what" information in git
 status
Date: Thu, 05 May 2011 16:49:50 -0700
Message-ID: <7vr58c4sip.fsf@alter.siamese.dyndns.org>
References: <1304632126-16733-1-git-send-email-madcoder@debian.org>
 <7vbozg67oj.fsf@alter.siamese.dyndns.org> <20110505233925.GE636@madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git ML <git@vger.kernel.org>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Fri May 06 01:50:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI8J6-0003J5-7w
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 01:50:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754237Ab1EEXuB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 19:50:01 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46183 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754064Ab1EEXuA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 19:50:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DBE24436F;
	Thu,  5 May 2011 19:52:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=m/gwSBlpnGbPV/m9hptdLzku+Yg=; b=Mfjerd
	uMjyImjGybz/qO47HeKz+B86Kmbci/UDbvB/xWkwYpoArrZZXDZ8e9kZU4uYnGcD
	yDq5ZIMidE4wojf6oNW9r/bG3Kep8R5ZxIIIQ563rcphuN/vi83oNPXElY7yGnv0
	yOKe2PZkxWFuqR4+KoYBI2u3TII0QPoMzm5Uk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VT12HHhNigF4zggWt4Zc8hlp1iN9D9oW
	2TAiyz12RQKd83EPx6e3F7JoUOWGuJ+IGGu6gAjaLHVPPja79nvQtUicbpzaHcn8
	+jBWsnv5Aa4tK3AAg62Wjk3Wg0X3xpE55j3Xn6WkYC0S4BKPv8uxUrCabQK2l87O
	REMlxGEbT78=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AFFEC436C;
	Thu,  5 May 2011 19:51:59 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9CBD84368; Thu,  5 May 2011
 19:51:55 -0400 (EDT)
In-Reply-To: <20110505233925.GE636@madism.org> (Pierre Habouzit's message of
 "Fri, 6 May 2011 01:39:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AAC793F6-7772-11E0-82E1-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172928>

Pierre Habouzit <madcoder@debian.org> writes:

>> As the "You are in middle of" information is useful mostly when you are on
>> detached head, I would have expected that the call would be inside the
>> if/elif chain near the top of wt_status_print() where we say "On branch"
>> vs "Not currently on...", to replace that information that comes from that
>> on_what variable.
>
> It's also useful when you're in the middle of a rebase or during a merge
> conflict who aren't on a detached head.

What I would expect in such a case would be like:

	# On branch master (resolving merge with ph/status)

instead of wasting an extra line like:

	# Resolving a merge conflict
        # On branch master

That is what I meant "to replace".
