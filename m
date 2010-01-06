From: Junio C Hamano <gitster@pobox.com>
Subject: Re: submodules' shortcomings, was Re: RFC: display dirty submodule
 working directory in git gui and gitk
Date: Wed, 06 Jan 2010 09:01:46 -0800
Message-ID: <7vbph7181x.fsf@alter.siamese.dyndns.org>
References: <4B3F6742.6060402@web.de>
 <alpine.DEB.1.00.1001041038520.4985@pacific.mpi-cbg.de>
 <4B421F90.4090402@web.de>
 <alpine.DEB.1.00.1001042217370.4985@pacific.mpi-cbg.de>
 <4B42F425.4010901@web.de> <7v1vi428w0.fsf@alter.siamese.dyndns.org>
 <4B43292C.5060106@web.de> <7vd41oz9mp.fsf@alter.siamese.dyndns.org>
 <4B439A86.3020500@web.de> <7vbph8oxg0.fsf@alter.siamese.dyndns.org>
 <4B4498BC.5040400@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Paul Mackerras <paulus@samba.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Lars Hjemli <hjemli@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Jan 06 18:02:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSZH1-0006tn-MG
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jan 2010 18:02:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755930Ab0AFRCN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2010 12:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754880Ab0AFRCM
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jan 2010 12:02:12 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42315 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754681Ab0AFRCI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2010 12:02:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 70D5F8E81B;
	Wed,  6 Jan 2010 12:02:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=kWKNDJBQClNrEDrUzbC29s5glWI=; b=q4cXzTcOAvOhjXOXMviY33T
	RIF8OmYWddReiu1jaBcGdhpLYAmNhXDLD5ADNJhkt862gac/os8o4I5IFGRe5E2G
	v0xdKWYzFtUOQHmkhFDgPs0z3MjC85m0WgXAEaejTcEClvhs5bh+xita0/s6mxc9
	tyIpXIVgrigaUSsFbWIc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=KQhye6+t1JC/g/tiX/Oz91zOWAuAsrPX8QVbJqQRFjoztjV8U
	n0TJpkoepcL70SWJ/TOtglI/kPXpvdvM/CI/R1rfCtr02u/9ajqkt9F3Wa9OAB7+
	/j5QxwMmsv4yQPGGindtu12PqU/cmaOOMPy0kbyvyS2trW6vI0JaiwE2iE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 976168E817;
	Wed,  6 Jan 2010 12:01:57 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F1FCB8E80C; Wed,  6 Jan
 2010 12:01:47 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 32E21D1C-FAE5-11DE-B25A-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136270>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Am 06.01.2010 02:04, schrieb Junio C Hamano:
>> After all we _were_ in agreement.  We both think the user should be told
>> about untracked files in submodule directory when inspecting the status to
>> make a commit in the superproject.
>
> Thanks. So i'll take a closer look at the diff core (but i suspect i'll
> need some time until i can come up with some patches because i don't know
> this part of git very well).

I don't see a direct connection between "the user should be told about
untracked in the submodule before committing" and diffcore.  It is just
the matter of "git status" and "git commit" running another instance of
"git status" via run_command() interface in the submodule directory, no?
