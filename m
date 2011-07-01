From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] branch: honor core.abbrev
Date: Fri, 01 Jul 2011 11:21:52 -0700
Message-ID: <7voc1doo8v.fsf@alter.siamese.dyndns.org>
References: <20110630181020.GA1128@elie>
 <1309500368-3729-1-git-send-email-namhyung@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Namhyung Kim <namhyung@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 01 20:22:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QciLp-00018S-2g
	for gcvg-git-2@lo.gmane.org; Fri, 01 Jul 2011 20:22:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753900Ab1GASV4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Jul 2011 14:21:56 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57574 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751874Ab1GASVz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2011 14:21:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 163C95455;
	Fri,  1 Jul 2011 14:24:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wtrfthOe6yps2pSJwPNJL6SCEe0=; b=na1LRg
	1l+6DfPNfiR8udHkeq01eDrDxTvFQMqpyMZto6Q8I/ksXRE8R/rFAZcLXJncr8jE
	CG0/3SyRKFvPtgZhG8nmmWs2iKUbDlZjIJiDxVY2QDylh+K/bvF18EGJ2+gXgvKI
	AY7TXv3+Rtci7mSnS4sIyBOdm9Sq7NMkVJwrc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nJkg52NtpL2YBCTbjSpVMVgoQe795XnD
	rtKuI+iXlsXy8cEfUHAtv5jKhS0VcAcKsoHECUzS3PPSyGgm+JVThiRVp1yE429L
	mbVgPUmHS/n2r479p0QMZiqf3uUY8QXVDIDFz5ArklnPONq6arMk83WWHsGnmdNu
	hqJDl26NMGU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0F61A5453;
	Fri,  1 Jul 2011 14:24:09 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6E94D5452; Fri,  1 Jul 2011
 14:24:08 -0400 (EDT)
In-Reply-To: <1309500368-3729-1-git-send-email-namhyung@gmail.com> (Namhyung
 Kim's message of "Fri, 1 Jul 2011 15:06:08 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4F6556DC-A40F-11E0-BE37-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176529>

Namhyung Kim <namhyung@gmail.com> writes:

> Honor 'core.abbrev' configuration unless user specifies the
> length on command line. In order to do that, we need to set

It is not clear from this description when "git branch" needs to even show
abbreviated object name.  I'll retitle it and/or reword the description to
hint that you are talking about "branch -v", but do you know of anything
in "git branch" that may be affected by this change other than "-v" output?
