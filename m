From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Fix buffer overflow in config parser
Date: Tue, 14 Apr 2009 15:38:14 -0700
Message-ID: <7v3aca3lpl.fsf@gitster.siamese.dyndns.org>
References: <49E50003.2040907@intra2net.com>
 <alpine.DEB.1.00.0904142340350.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Jarosch <thomas.jarosch@intra2net.com>, gitster@pobox.com,
	git@vger.kernel.org, markus.heidelberg@web.de
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 15 00:40:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtrIQ-0000Xo-03
	for gcvg-git-2@gmane.org; Wed, 15 Apr 2009 00:40:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752425AbZDNWiZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2009 18:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752013AbZDNWiZ
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Apr 2009 18:38:25 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55661 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751912AbZDNWiY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2009 18:38:24 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id AC585E35D;
	Tue, 14 Apr 2009 18:38:21 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B304AE35B; Tue,
 14 Apr 2009 18:38:15 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0904142340350.10279@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Tue, 14 Apr 2009 23:41:14 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F542288E-2944-11DE-9EEC-DC76898A30C1-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116583>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Tue, 14 Apr 2009, Thomas Jarosch wrote:
>
>>  t/t1303-wacky-config.sh |    9 ++++++++-
>
> I like the name!
>
>> +LONG_VALUE=`perl -e 'print "x" x 1023," a"'`
>
> But should it not be guarded against NO_PERL?

The right question to ask is a rhetorical "do we need perl to do this?"
