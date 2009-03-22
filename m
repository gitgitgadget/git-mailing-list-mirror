From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote: improve sorting of "configure for git push" list
Date: Sun, 22 Mar 2009 14:58:26 -0700
Message-ID: <7vk56hdxtp.fsf@gitster.siamese.dyndns.org>
References: <20090319200308.GB17028@coredump.intra.peff.net>
 <20090322085920.GA5201@coredump.intra.peff.net>
 <76718490903220747p74cf3704vbbbc085c28a105b2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 22 23:00:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlViD-00024D-Hh
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 23:00:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755241AbZCVV6i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 17:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753876AbZCVV6i
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 17:58:38 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39614 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753183AbZCVV6h (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 17:58:37 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id ADB64A4625;
	Sun, 22 Mar 2009 17:58:35 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id A079FA4624; Sun,
 22 Mar 2009 17:58:28 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 97885648-172C-11DE-AFF2-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114177>

Jay Soffian <jaysoffian@gmail.com> writes:

> On Sun, Mar 22, 2009 at 4:59 AM, Jeff King <peff@peff.net> wrote:
>> The data structure used to store this list is a string_list
>> of sources with the destination in the util member. The
>> current code just sorts on the source; if a single source is
>> pushed to two different destination refs at a remote, then
>> the order in which they are printed is non-deterministic.
>> ...
> Ack. There is one thing I wonder though. Is this even a sane config?

I do not think of a workflow that this feature is absolutely necessary in
the sense that it cannot be worked around if you removed it, but that is
not what you asked.

I wouldn't be surprised if there are some kernel subsystem maintainers who
usually push to their master but when they push their finished goods to
their for-linus branch make sure they update their master at the same time.
Configuring their local for-linus to push to master and for-linus may be
one way to do so.

In a one-branch project with two people, it is not entirely inconceivable
to arrange for me to push to master and junio while you to push to master
and jay, in order to keep track.
