From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] ls-files: Add eol diagnostics
Date: Sun, 01 Nov 2015 10:22:33 -0800
Message-ID: <xmqqtwp5h95i.fsf@gitster.mtv.corp.google.com>
References: <52B3B0AC-037A-4872-9E0E-CDF6BE7A9695@web.de>
	<vpqbnbfpc6p.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Nov 01 19:22:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsxH7-00081O-Fh
	for gcvg-git-2@plane.gmane.org; Sun, 01 Nov 2015 19:22:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752575AbbKASWg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Nov 2015 13:22:36 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56697 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752408AbbKASWf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Nov 2015 13:22:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C0971271BC;
	Sun,  1 Nov 2015 13:22:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=xDtse8sAXr7O
	Xc3KJJ6PMp/miNY=; b=nCV2NMeVcmTViVh2I0TyXhInFgn8JI8quA0+0gq/Qd+J
	9JbVXgOh8bPS68Y+pA9P16+hplESqJ8JPHgaNTWPFMRRQccb0YL/ksJOVkUn6WvT
	BAkMs3MRBNyzkp25OMUWkQiGLlUjj0kWhngIVUxl8wA/oK8Du/zuln8pgBhPN0s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=SDPQ01
	H164HcCapsJVPoLpyJNp3KSj74s483OVSi8iDnkCLgnaHo+Ye+wtOldmNAKukOTm
	8qcbofD4fVQLanRMFLkMIWR/+kjM6gienYDtu5ZuDm0fyEgVOEFwbDhDzl9aGhWt
	VL94chk1bi4SLY8+LM0BFvxL2DHbfV+aaFVUU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B8D72271BB;
	Sun,  1 Nov 2015 13:22:34 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3D99D271B9;
	Sun,  1 Nov 2015 13:22:34 -0500 (EST)
In-Reply-To: <vpqbnbfpc6p.fsf@anie.imag.fr> (Matthieu Moy's message of "Sat,
	31 Oct 2015 11:25:18 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8593DDE0-80C5-11E5-9727-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280647>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>
>> ca:text-no-eol   wt:text-no-eol   t/t5100/empty
>> ca:binary        wt:binary        t/test-binary-2.png
>> ca:text-lf       wt:text-lf       t/t5100/rfc2047-info-0007
>> ca:text-lf       wt:text-crlf     doit.bat
>> ca:text-crlf-lf  wt:text-crlf-lf  locale/XX.po
>
> I would spell the first "in" or "idx" (for "index"), not "ca" (for
> "cache"). I think we avoid talking about "the cache" these days even
> though the doc sometimes says "cached in the index" (i.e. use "cache"=
 as
> a verb, not a noun).

i/ and w/ have been used to denote the "i"ndex and "w"orktree
versions for the past 7 years with diff.mnemonicprefix option,
which you may want to match.
