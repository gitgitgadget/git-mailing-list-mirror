From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git ls-files --error-unmatch weirdness
Date: Fri, 12 Aug 2011 10:56:30 -0700
Message-ID: <7vaabeo6nl.fsf@alter.siamese.dyndns.org>
References: <20110812132436.GA12147@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri Aug 12 19:56:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrvyI-0005ee-ML
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 19:56:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752919Ab1HLR4e convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Aug 2011 13:56:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46079 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752812Ab1HLR4d convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Aug 2011 13:56:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D4634DBF;
	Fri, 12 Aug 2011 13:56:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=vljmL1/8O3NB
	LL3MA5qHP4bp02k=; b=kcW/M3Hv2ciHhpFRr1CBvnayEf3k0Qu4VvjFFCKPMgWv
	MTyQks5q7oGr0kPoiF0PTqncIGkj5moyg4sJMisWwQJgROj+QUi4mEojodT1h647
	7kjk6w0tsKbExNgEPJnDwy2BW9vxBmGPgQp+DtWTm+1S42sB46jHSOa5uV5HnNQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=OtI8nS
	QjCk0EkV2xRwpUP+jm2ScX7iX2VgQRI8wjawwa4IY2rrLWMqhoN69eeUEVpUYE11
	WZGXvnF27Z9cwF+HSkFdtwjLSUbVu24NG+9ZQfk9gzRb1vpsRuHYOw/HywpSkopH
	XWTjp6mq5EoPJIwZewnB6+0w/hMP7C1UT2Q54=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 350594DBE;
	Fri, 12 Aug 2011 13:56:32 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BDAA44DBD; Fri, 12 Aug 2011
 13:56:31 -0400 (EDT)
In-Reply-To: <20110812132436.GA12147@goldbirke> ("SZEDER =?utf-8?Q?G=C3=A1?=
 =?utf-8?Q?bor=22's?= message of "Fri, 12 Aug 2011 15:24:36 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 694A46D4-C50C-11E0-A2E1-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179240>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> repo (master)$ git ls-files --others --error-unmatch

The "--error-unmatch" is about reporting errors in pathspecs you gave f=
rom
the command line. The behaviour is undefined if you do not give any, li=
ke
the above command line.

Having said that, I wouldn't be surprised if it triggered when run from=
 an
empty subdirectory.
