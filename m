From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] fsck: default to "git fsck --full"
Date: Tue, 20 Oct 2009 12:11:34 -0700
Message-ID: <7vy6n5namx.fsf@alter.siamese.dyndns.org>
References: <loom.20091019T094924-194@post.gmane.org>
 <4ADC2D45.3020803@viscovery.net>
 <alpine.DEB.1.00.0910191202020.4985@pacific.mpi-cbg.de>
 <7v7hur1a0h.fsf@alter.siamese.dyndns.org> <vpqy6n6shri.fsf@bauges.imag.fr>
 <7vfx9esgvt.fsf@alter.siamese.dyndns.org>
 <81b0412b0910200225g47220cc9wa2e82290a853c85d@mail.gmail.com>
 <alpine.DEB.1.00.0910201221250.4985@pacific.mpi-cbg.de>
 <vpq1vkygtx6.fsf@bauges.imag.fr> <7v3a5doqcg.fsf_-_@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.0910201457310.21460@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Alex Riesen <raa.lkml@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Sergio Callegari <sergio.callegari@gmail.com>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue Oct 20 21:12:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0K7q-0007Rf-Mf
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 21:12:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752637AbZJTTLx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 15:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752664AbZJTTLw
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 15:11:52 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:35664 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752637AbZJTTLu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 15:11:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F1890605E7;
	Tue, 20 Oct 2009 15:11:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=u/ZkXjxj43fGGgYe7Uu+HCcGe7o=; b=p9ukdM
	GoMTlKjmq2ZDnns4Ul4y3Oa2IQhlSogF1PZBhonLQZKYEiAerKcr4tssntHj+ST/
	+6eIsEJrtqanXLQyqmqA0gic6DsGtvd2GTs68iZHqIVkjXaPBctWPztde439h2Z4
	WDVrlYald9sx7xas9O+1y+jc18ImG6oJQci70=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TE60zw9J5HKNy2ZNArivOxxLi1ujS8EX
	k7G/SInYsMaKBdYEeGpsQPULuSMf2WyRaKtREZEk5zkUcm+/0c9FZXmO0/VBNw5s
	bM1gAtInDPa9alZWBFMy1rYiqVu86kJyBvYsFZtuy2oACeFPpZSXqOrGhUitPhm8
	8anWpSwAkxc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 83017605E4;
	Tue, 20 Oct 2009 15:11:45 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 49478605DE; Tue, 20 Oct
 2009 15:11:36 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.00.0910201457310.21460@xanadu.home> (Nicolas
 Pitre's message of "Tue\, 20 Oct 2009 15\:00\:31 -0400 \(EDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 68A021D6-BDAC-11DE-A2FE-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130827>

Nicolas Pitre <nico@fluxnic.net> writes:

> On Tue, 20 Oct 2009, Junio C Hamano wrote:
>
>> diff --git a/Documentation/RelNotes-1.6.6.txt b/Documentation/RelNotes-1.6.6.txt
>> index 5f1fecb..1896e05 100644
>> --- a/Documentation/RelNotes-1.6.6.txt
>> +++ b/Documentation/RelNotes-1.6.6.txt
>> @@ -1,6 +1,13 @@
>>  GIT v1.6.6 Release Notes
>>  ========================
>>  
>> +In this release, "git fsck" defaults to "git fsck --full" and checks
>> +packfiles.  If you prefer a quicker check only on loose objects (the
>              ^^
>
> Might be worth mentioning explicitly that, because of that change, plain 
> fsck is now going to take much longer to complete.

Sounds fair; thanks.

diff --git a/Documentation/RelNotes-1.6.6.txt b/Documentation/RelNotes-1.6.6.txt
index 0adf998..fa0e11a 100644
--- a/Documentation/RelNotes-1.6.6.txt
+++ b/Documentation/RelNotes-1.6.6.txt
@@ -2,7 +2,8 @@ GIT v1.6.6 Release Notes
 ========================
 
 In this release, "git fsck" defaults to "git fsck --full" and checks
-packfiles.  If you prefer a quicker check only on loose objects (the
+packfiles, and because of this it will take much longer to complete
+than before.  If you prefer a quicker check only on loose objects (the
 old default), you can say "git fsck --no-full".  This has been
 supported by 1.5.4 and newer versions of git, so it is safe to write
 it in your script even if you use slightly older git on some of your
