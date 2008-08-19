From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] compat: introduce stat_to_kilobytes
Date: Tue, 19 Aug 2008 00:31:42 -0700
Message-ID: <7v7iadh34x.fsf@gitster.siamese.dyndns.org>
References: <273481A4-0BB2-4A58-83AD-604B425DE824@web.de>
 <7vy72w6kiv.fsf@gitster.siamese.dyndns.org>
 <200808182157.16392.johannes.sixt@telecom.at>
 <7vbpzqm50b.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Andreas =?utf-8?Q?F=C3=A4rber?= <andreas.faerber@web.de>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Tue Aug 19 09:33:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVLi6-0002XC-TD
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 09:32:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752273AbYHSHbz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 03:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752205AbYHSHbz
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 03:31:55 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64366 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752031AbYHSHbz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 03:31:55 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 24EF459F48;
	Tue, 19 Aug 2008 03:31:54 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 6F65559F47; Tue, 19 Aug 2008 03:31:50 -0400 (EDT)
In-Reply-To: <7vbpzqm50b.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 18 Aug 2008 13:40:04 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E56F0BD8-6DC0-11DD-83C9-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92822>

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Sixt <johannes.sixt@telecom.at> writes:
> ...
>> But notice that we now underestimated the size of loose objects more than
>> we did previously because we now round down individual sizes; previously
>> we rounded down only the total size.
>
> Ah, you are right.
>
> Perhaps we should fix this by making the helper stat_to_on_disk_bytes(),
> so that on platform with st_blocks counted in 512-byte blocks we multiply
> it by 512?

I've done this myself and will queue the result.
