From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] revision.c: add --format option for 'git log'
Date: Sun, 22 Feb 2009 10:06:12 -0800
Message-ID: <7vy6vyxs6j.fsf@gitster.siamese.dyndns.org>
References: <1235230015-17641-1-git-send-email-felipe.contreras@gmail.com>
 <7vtz6m1knv.fsf@gitster.siamese.dyndns.org>
 <94a0d4530902220918oc6f8ab9vc1fd0b55cad014a2@mail.gmail.com>
 <7v63j2z7bh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 22 19:07:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbIk0-0003ho-83
	for gcvg-git-2@gmane.org; Sun, 22 Feb 2009 19:07:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751779AbZBVSGT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Feb 2009 13:06:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751739AbZBVSGT
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Feb 2009 13:06:19 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38666 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751521AbZBVSGT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Feb 2009 13:06:19 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 711D99CED5;
	Sun, 22 Feb 2009 13:06:17 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 755279CED4; Sun,
 22 Feb 2009 13:06:14 -0500 (EST)
In-Reply-To: <7v63j2z7bh.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 22 Feb 2009 09:53:54 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 802D224E-010B-11DE-A86D-B26E209B64D9-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111031>

Junio C Hamano <gitster@pobox.com> writes:

> Felipe Contreras <felipe.contreras@gmail.com> writes:
> ...
>> Well, my hope was to replace --pretty=short with --format=short, but
>> you said that would break other scripts.
>
> It is not just scripts you break.  You also break people's trained
> fingers.
> ...
> The only reason why new --format=<fmt> could be an useful addition is
> because --pretty=format:<fmt> may be too long to type interactively.

An obvious alternative with lessor impact than your patch would be not to
introduce an additional option --format, but just make ":" as a synonym to
"tformat:".  Then you can say "--pretty=:%h %s".  You would need to type
one colon more but that might conceptually be less confusing, when
somebody is starting to learn git *after* this change, without knowing
that we did not have --format in earlier versions, from the documentation
and existing pages on various web sites.
