From: Junio C Hamano <gitster@pobox.com>
Subject: Re: GIT_DIR=. for hooks?
Date: Wed, 06 Jan 2010 09:13:39 -0800
Message-ID: <7v7hrvyx4s.fsf@alter.siamese.dyndns.org>
References: <4B44965F.8040803@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Jan 06 18:13:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSZSB-0003iw-34
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jan 2010 18:13:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932301Ab0AFRNr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2010 12:13:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932262Ab0AFRNr
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jan 2010 12:13:47 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52941 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932259Ab0AFRNq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2010 12:13:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D23778EA4D;
	Wed,  6 Jan 2010 12:13:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=AMA4bLtdfrw7xdIR16WlIjpjtnc=; b=p5a7Bw/gbeFg5Zh/BJq2W4+
	b0uU3jGCqdpcaQaCptsIRzDI5omXDqiats2q3v/EhW6qmOPmrOeqMUbAeuth+MaH
	R6SS+fPphRsLHcH62wQdwYP6uNuCs2Khz1a61cOqdbmTOlFF0HMctDAbl4JPTQ3Y
	XAzH4lWOLPbaEVTomyos=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=iuYdvACWpBud4nlYwftYfdT2q+0u8AnB1bwZNbmsrgOqNymBB
	GWd2qAXX7d1n/DFnyKRVrBufGPKlmZgwmPgMOFraNW6daCWF5hF8w/ncN1sLQAz2
	eeQ0OzJGp8YjKXfx63HLEKtUdE3BSVQFdFynG6z03hkzRftuTJl2hIIr2g=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AC93C8EA4A;
	Wed,  6 Jan 2010 12:13:43 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1D0F58EA3E; Wed,  6 Jan
 2010 12:13:40 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D7BEC744-FAE6-11DE-B1A8-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136276>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> I can unset GIT_DIR or set WORK_TREE, of course,

That is not just an acceptable but _the_ right way to write hooks that
touch the files in the work tree.  In earlier versions of git, a git-dir
in $PWD was not found without GIT_DIR=. and hooks are supposed to work
across versions of git, so this behaviour got stuck.
