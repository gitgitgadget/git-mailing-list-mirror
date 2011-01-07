From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-cvs*: Make building (and testing) of CVS interface
 scripts optionally selectable
Date: Fri, 07 Jan 2011 15:50:41 -0800
Message-ID: <7vei8o46jy.fsf@alter.siamese.dyndns.org>
References: <1294433290-9262-1-git-send-email-robbat2@gentoo.org>
 <20110107220147.GB9194@burratino>
 <robbat2-20110107T225413-429815896Z@orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: "Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Sat Jan 08 00:50:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbM5B-0008QK-Dk
	for gcvg-git-2@lo.gmane.org; Sat, 08 Jan 2011 00:50:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752466Ab1AGXuw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jan 2011 18:50:52 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41397 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752286Ab1AGXuw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 18:50:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 60827350C;
	Fri,  7 Jan 2011 18:51:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=en+lXzid/S25qXbPGk8dJ5H/nIY=; b=fS66Hn
	Ng+Ww6Z++SCTdyzXoYVDFlO0D3lAqyYPxxBiVET9db0K6odKPuYoAO1Y47Ej0Fxf
	xiSEBwVFrwgPMNx5I4qEyn9n7VrbSlFA8mq2DV98btwl16vo79kiXEJxx5oV3ueE
	NBhEbx6CMkKLmjTP2mrfAf3kxAO0cZ+3daaqo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Gv3O2zpRdTbWbDKUT/cHB6WaQ/X9tlS3
	+r9YOAoXQ9ZOmo1Pt29wsf+nEEQTMG2pcAZPZl6vM0mOCswjVvXG1L/8Y5vxo4PW
	UioK1jo8jCw0MSV3BnxieyRFcIvxGXTJ8llM/L9Pm5qeqkHINE447bM0dz7EKIBs
	2Nq+8JZmZgs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2EB743504;
	Fri,  7 Jan 2011 18:51:26 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 147073503; Fri,  7 Jan 2011
 18:51:21 -0500 (EST)
In-Reply-To: <robbat2-20110107T225413-429815896Z@orbis-terrarum.net> (Robin
 H. Johnson's message of "Fri\, 7 Jan 2011 22\:55\:54 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0A14F036-1AB9-11E0-A29E-CBB45B885003-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164791>

"Robin H. Johnson" <robbat2@gentoo.org> writes:

> On Fri, Jan 07, 2011 at 04:01:48PM -0600, Jonathan Nieder wrote:
>> This explanation seems quite odd to me.  Are you saying we can't rely
>> on the 'cvs' name being "taken" and should live in fear that someone
>> will implement an incompatible utility with the same name?  Did that
>> actually happen?
> Not in the linked bug report, but it does explain a previous bug I had
> seen, where a user had a little script in /usr/local/bin that complained
> at him whenever he ran 'cvs', so he would learn to migrate away faster.

I suspect that NO_CVS is not the best way to help a person who is trying
to wean herself off of cvs by having a phony cvs in a directory that is
early on the $PATH (be it $HOME/bin/cvs or /usr/local/bin/cvs).  Before
ceasing to actively build more histories in cvs, it would help to have an
access to git-cvsimport and friends to salvage what's already there, no?

A change that models after PERL_PATH, not after NO_PERL, would be a more
appropriate thing to do for that particular purpose.

I still think the patch itself is a worthy thing to have, so everything
above is a tangent that is orthogonal to what your patch tries to do,
though.
