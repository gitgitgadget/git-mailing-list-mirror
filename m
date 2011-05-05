From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin/checkout.c: show usage with options on missing
 argument 'branch'
Date: Thu, 05 May 2011 12:49:08 -0700
Message-ID: <7vwri553nv.fsf@alter.siamese.dyndns.org>
References: <1304614690-12493-1-git-send-email-ralf.thielow@googlemail.com>
 <7vsjst6l5o.fsf@alter.siamese.dyndns.org>
 <BANLkTikMu3fjbALTAwaaknskBw0H7LbZ-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ralf Thielow <ralf.thielow@googlemail.com>
X-From: git-owner@vger.kernel.org Thu May 05 21:49:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI4Y5-0006PB-AI
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 21:49:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751735Ab1EETtR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 15:49:17 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34483 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751028Ab1EETtQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 15:49:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E2CC14A06;
	Thu,  5 May 2011 15:51:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YFMqpu0AkXbGIhfA1NgDAYORzCQ=; b=Mu8f1V
	u6VoRd+agyeYkDcNStcQZHObXeUx4Sd4LpeoyHGklZeuwWo6UY46QcCMpfIvBq4j
	6xVkpSrKiaCmlQ2Okocp9FIXpQHc8Z9+PZ6qMa9yFuXVGod/A2zZL3tJoWwA+oa8
	GIyoztJj0bKamC1bBSZ1Zsv9XCW4gARF7X/Ks=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VxdqvYxKjpkleFKlTqSxb/ycyx+hbfrz
	eEL9az4GZljG4JFvmVSOYeWW0H/9l6TDVGlftOqaKBAjn/mgO73zXdM1Fy0lZnaX
	Pw5sRg0Pj+0QneW3t10ouf7dvZr3I1ZqxXtTJmX7SQMn0lpy18PD9UUmhxR8+hl7
	7OWXGGF3i74=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BCA434A05;
	Thu,  5 May 2011 15:51:16 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id DB5E84A04; Thu,  5 May 2011
 15:51:13 -0400 (EDT)
In-Reply-To: <BANLkTikMu3fjbALTAwaaknskBw0H7LbZ-g@mail.gmail.com> (Ralf
 Thielow's message of "Thu, 5 May 2011 21:02:47 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0A1D94F8-7751-11E0-8785-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172892>

Ralf Thielow <ralf.thielow@googlemail.com> writes:

> Simple "git checkout" or "git checkout " don't tell me that i've done a mistake
> on usage. It does nothing.

That is a designed behaviour.  You did nothing wrong.

Besides, that is a way people who use "checkout -t -b" to create topic
branches check their branch status.  Pay attention to what the last
command does in the following transcript.

    $ git checkout master
    $ git checkout -t -b side
    Branch side set up to track local branch master.
    Switched to a new branch 'side'
    $ git checkout master
    Switched to branch 'master'
    $ edit ; git commit ;# on 'master'
    $ git checkout side
    Switched to branch 'side'
    Your branch is behind 'master' by 1 commit, ...
    ... time passes ...
    $ git checkout
    Your branch is behind 'master' by 1 commit, ...

   
