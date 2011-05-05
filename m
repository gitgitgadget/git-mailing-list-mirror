From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] Honor $(prefix) set in config.mak* when defining
 ETC_GIT* and sysconfdir
Date: Thu, 05 May 2011 08:46:03 -0700
Message-ID: <7vd3jxb16s.fsf@alter.siamese.dyndns.org>
References: <20110428192751.GE4833@camk.edu.pl>
 <4DBFA3C6.8060209@viscovery.net> <7vzkn3itb5.fsf@alter.siamese.dyndns.org>
 <4DC0E99E.6090402@viscovery.net> <20110504135827.GC18585@camk.edu.pl>
 <4DC1653A.7000000@viscovery.net> <7v4o5afht7.fsf@alter.siamese.dyndns.org>
 <7vwri5c27e.fsf@alter.siamese.dyndns.org>
 <20110505142910.GA31229@camk.edu.pl> <4DC2B814.5070507@viscovery.net>
 <20110505150036.GB31229@camk.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Kacper Kornet <kornet@camk.edu.pl>
X-From: git-owner@vger.kernel.org Thu May 05 17:46:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI0ku-0006Tk-6Z
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 17:46:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753402Ab1EEPqP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 11:46:15 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55816 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751028Ab1EEPqO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 11:46:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 287C04EA0;
	Thu,  5 May 2011 11:48:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GUsm/VxV23UdhhPddxFpevfY8wA=; b=o65sut
	jLPc0yKkumRLJnrWsZk/VH7rEHGqBYDEruz96qiCM84uAksiNzsAL2cG3UngaDhK
	DlwNLZJK2cfZnP8GYytqVGqTevC24HwH74q4zZFXKDw/9eaFZ8j6MwNiq7MStb9A
	26rOD98Tcu0wFaNdxrwjLlMhbgLkeDuXZyj74=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YbPbWrK1SJm+a6X/PHys0rUh9LxGB3D7
	OuLyASnRBqI9rtorofGiGH4M4gUN2TIW27xQqcE/ZLILe+Qlmb/NKXzr4A6tVjth
	3uw5aUjb3+FIlAZOWhJNTD1wg1OU+Qp9s0Yvmx1BZISSkbpSd/+GqYENAb0ljdHo
	GuneJn2jOaY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E51D24E97;
	Thu,  5 May 2011 11:48:13 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id CC2694E89; Thu,  5 May 2011
 11:48:09 -0400 (EDT)
In-Reply-To: <20110505150036.GB31229@camk.edu.pl> (Kacper Kornet's message of
 "Thu, 5 May 2011 17:00:36 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 160FF2E6-772F-11E0-8FCE-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172840>

Kacper Kornet <kornet@camk.edu.pl> writes:

> Should the patch be based on main or on the previous patch that was
> merged to next?

After having this much discussion, it is preferrable to have a patch
relative to what you have in 'next' (2910bf5) as a fix-up, explaining "The
initial version does not cover these cases / has these problems" to
summarize the discussion so far, followed by explanation of the
incremental change "Fix this and that by doing ...".

We could revert what is in 'next' and start from scratch, but then it is
likely that the thought process will be lost when you write the log
message.
