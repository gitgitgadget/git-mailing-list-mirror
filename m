From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] t/test-lib.sh: support Korn shell by converting 
 GIT_EXIT_OK to GIT_EXIT_CODE
Date: Fri, 09 Oct 2009 17:57:31 -0700
Message-ID: <7vocogdq10.fsf@alter.siamese.dyndns.org>
References: <1eweIwf5YoFwmLPWwEFN69a2f-EUnj_kgiagVJoVQYfNQeLjlpm12U84RKxhzjh0NJv36SqO12lAX2c_x0WSgA@cipher.nrlssc.navy.mil> <7vhbu8s151.fsf@alter.siamese.dyndns.org> <ee63ef30910091537i40a8cc68y2513f07c91fb35b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <casey@nrlssc.navy.mil>, git@vger.kernel.org,
	drizzd@aon.at, peff@peff.net
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 10 03:02:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwQLg-0005GI-EB
	for gcvg-git-2@lo.gmane.org; Sat, 10 Oct 2009 03:02:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964814AbZJJA61 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 20:58:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934741AbZJJA60
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 20:58:26 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:62164 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934740AbZJJA60 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 20:58:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0F00C71E5C;
	Fri,  9 Oct 2009 20:57:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=gxrT6pbRacR2f1Cv9tYY759GtH8=; b=I7Z5H8RdS846UAdfuT+hdTh
	p9rfGOVsi5pkqZc25fo8IgVPLDo1JAYfD77D1ZnhHIXCnPhdsFIxY7dkwtyxkgux
	ClyBinzDqd7rHilsJup5V178MDnQEsh1YmGHif5IS9thwVX18gNOJCrHBZwHIZEV
	CoDRc2hwzYO6vTk0dJFc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=W8seN7uaOxL/qjVkgh4Hni2o3ev1IyHGHPzrOUWNBUDOGSEdQ
	dc+krYn+/+T4HFtw1oFxzj3dRi++7o6zc/VSPZRfmufrhlqu4YAQprXYDhHTbhnb
	z6RHe/lzkqLal6wDC7mGcauB0Yy3AjxhD1+r3cp8mknus/XETPOH28yIdc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BE24871E56;
	Fri,  9 Oct 2009 20:57:39 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id DF33C71E4F; Fri,  9 Oct 2009
 20:57:32 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E8915022-B537-11DE-B17D-1000076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129866>

Brandon Casey <drafnel@gmail.com> writes:

> I'm away from a computer right now. Junio, if gmail is showing me the
> entirety of your workaround, then no, I don't think that will work.
> Your code will always exit non-zero, but there are cases where 'exit
> 0' is called and a '0' exit status is desired. e.g. when test_done is
> called.

Ah, of course you are right.
