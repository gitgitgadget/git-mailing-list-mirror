From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/6 (v2)] upload-pack: send the HEAD information
Date: Mon, 01 Dec 2008 17:31:16 -0800
Message-ID: <7vk5ajqs63.fsf@gitster.siamese.dyndns.org>
References: <1228140775-29212-1-git-send-email-gitster@pobox.com>
 <1228140775-29212-2-git-send-email-gitster@pobox.com>
 <1228140775-29212-3-git-send-email-gitster@pobox.com>
 <1228140775-29212-4-git-send-email-gitster@pobox.com>
 <1228140775-29212-5-git-send-email-gitster@pobox.com>
 <1228140775-29212-6-git-send-email-gitster@pobox.com>
 <20081201174414.GA22185@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 02 02:33:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7K8a-0008Up-AZ
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 02:33:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752788AbYLBBbs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 20:31:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752766AbYLBBbr
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 20:31:47 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55422 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752146AbYLBBbr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 20:31:47 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 99EC317E71;
	Mon,  1 Dec 2008 20:31:45 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E5FD617E6D; Mon, 
 1 Dec 2008 20:31:18 -0500 (EST)
In-Reply-To: <20081201174414.GA22185@coredump.intra.peff.net> (Jeff King's
 message of "Mon, 1 Dec 2008 12:44:15 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FB201740-C010-11DD-96EC-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102089>

Jeff King <peff@peff.net> writes:

> On Mon, Dec 01, 2008 at 06:12:54AM -0800, Junio C Hamano wrote:
>
>> +			packet_write(1, "%s %s%c%s%c%s\n", sha1_to_hex(sha1), refname,
>> +				     0, capabilities, 0, target);
>
> Yuck. My two complaints are:
>
>   (1) this implicitly handles only the HEAD symref.

But this information *is* on the "40-hex name" line that describes the
HEAD ;-)

You can trivially extend it to add this to other symbolic refs if you are
interested.  I wasn't.
