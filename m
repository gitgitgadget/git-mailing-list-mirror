From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] "git diff <tree>{3,}": do not reverse order of arguments
Date: Sat, 11 Oct 2008 14:36:55 -0700
Message-ID: <7vtzbiizk8.fsf@gitster.siamese.dyndns.org>
References: <1223690175.2828.26.camel@mattlaptop2.local>
 <7vwsgfjrp6.fsf@gitster.siamese.dyndns.org>
 <237967ef0810110553r662df370ud1ec34de402bfe1c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Matt McCutchen" <matt@mattmccutchen.net>, git@vger.kernel.org
To: "Mikael Magnusson" <mikachu@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 11 23:38:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KomAM-0008H7-MH
	for gcvg-git-2@gmane.org; Sat, 11 Oct 2008 23:38:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755191AbYJKVhQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Oct 2008 17:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755101AbYJKVhP
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Oct 2008 17:37:15 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:50673 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754883AbYJKVhO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Oct 2008 17:37:14 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id E9300899E7;
	Sat, 11 Oct 2008 17:37:13 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id EA1AD899E6; Sat, 11 Oct 2008 17:36:57 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C4AEB65A-97DC-11DD-AB14-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97992>

"Mikael Magnusson" <mikachu@gmail.com> writes:

> 2008/10/11 Junio C Hamano <gitster@pobox.com>:
>> Perhaps the thinko was caused by discrepancy between the way internal
>> revision parser handles A..B and the way git-rev-parse parses it.  While
>> the internal revision parser parses it into "A ^B", rev-parse gives them
>> in reverse order, i.e. "B ^A" (which is not going to change).  In any
>> case, thanks for spotting this.
>
> Ehm, do you mean the internal parses it into "A ^B" and rev-parse gives "^B A"?

Sorry; a typo is in my description on the result from the internal parser.

For A..B, rev-parse gives B^ then A, and internal gives ^A in ent[0] and B
in ent[1].
