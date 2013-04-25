From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t5801: properly test the test shell
Date: Thu, 25 Apr 2013 09:25:49 -0700
Message-ID: <7vhaiu60he.fsf@alter.siamese.dyndns.org>
References: <ff7ccf22012f069ceca054d90aa0f72666cc11c2.1366884583.git.git@drmicha.warpmail.net>
	<51792A48.60603@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Apr 25 18:25:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVOzd-0001UF-O9
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 18:25:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757892Ab3DYQZx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Apr 2013 12:25:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32920 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755921Ab3DYQZw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Apr 2013 12:25:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5152D17BDE;
	Thu, 25 Apr 2013 16:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=cxFW8+bhzDL/
	ewMZWs8pbdcfUh0=; b=BbxWkD4AQ/94zSM/yYdbmTj6O62K+1EBuQIWGuk3BP39
	Bai/+5mnQTJ1rUsnMB8apNOuCUfrXSA2cZrJg0l/ZSUy21ypm8dJE627uV2w7uSF
	pY3d1OHjzXV+FlSr9pxMg7L9lF7eNPfEQi7FXLhFtRG3ZSUECGhpzLzE2Vl4Xgo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=QL0z5b
	IysbnCTtvuerNAMSqtodALnVFFVU3oti9INvsmmRJ/Gy0abopdWhfSd4u/TwTxaz
	R/4mnM2gb08muD+nodpqiCoPmbI21qbuNwAWHHGX3Re0ighTQHtiRGt/nGrOwH6X
	CtwII4z/2GmdBwZN+B0NHfjBJ3FcFaSBhK04Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4432C17BDD;
	Thu, 25 Apr 2013 16:25:52 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A4E1117BD7;
	Thu, 25 Apr 2013 16:25:51 +0000 (UTC)
In-Reply-To: <51792A48.60603@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershausen?=
 =?utf-8?Q?=22's?= message of
	"Thu, 25 Apr 2013 15:06:16 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CBAD70EC-ADC4-11E2-83A8-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222391>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> Could we use the same logic as in t9903:
> ...
> . ./lib-bash.sh

Please no.  The test itself is not about something that checks how
we behave under bash (which is what 9903 wants to see).  The use of
construct that is portable in t5801 is a pure and simple bug, and it
should not be hard to fix it.

If there still is such an unportable construct left, that is.
