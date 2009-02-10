From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make repack less likely to corrupt repository
Date: Tue, 10 Feb 2009 07:59:16 -0800
Message-ID: <7viqninuzv.fsf@gitster.siamese.dyndns.org>
References: <1234140299-29785-1-git-send-email-robin.rosenberg@dewire.com>
 <7vwsc0uow1.fsf@gitster.siamese.dyndns.org>
 <200902100807.40417.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de,
	spearce@spearce.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Feb 10 17:01:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWv2v-0005KP-2U
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 17:01:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753938AbZBJP7Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Feb 2009 10:59:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753910AbZBJP7Y
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 10:59:24 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:52295 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753883AbZBJP7Y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Feb 2009 10:59:24 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 91A652AD5E;
	Tue, 10 Feb 2009 10:59:23 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 15BA02AD7D; Tue,
 10 Feb 2009 10:59:17 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C9014358-F78B-11DD-814F-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109263>

Robin Rosenberg <robin.rosenberg@dewire.com> writes:

> m=C3=A5ndag 09 februari 2009 07:04:46 skrev Junio C Hamano:
>> What's troubling more is that this would seem to leave the result ev=
en
>> more inconsistent if there are more than one packs that need to be
>> replaced.
>
> Why? We don't prune the old objects if we fail. The result might be a=
 lot
> of redundancy, but nothing should be lost.

I was not talking about any loss.  The result would be a funny mixture =
of
permutations of {old-,}pack-*.{pack,idx} the user needs to match up aft=
er
figuring out what corresponds with what other one, and I think an exper=
t
who is asked for help would have hard time matching them up too, even
though that is what you suggested in the message.

That troubled me and I was wondering if we can make the recovery simple=
r
for the users.
