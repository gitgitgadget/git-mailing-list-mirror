From: Junio C Hamano <gitster@pobox.com>
Subject: Re: use gitignore implementation in shell bash
Date: Tue, 18 Jun 2013 09:59:53 -0700
Message-ID: <7vhagv5p86.fsf@alter.siamese.dyndns.org>
References: <CA+=RcCrAnNoFbu1VGnFLpubOkss1VyyfdumJiVcJ0G0z+tB6sQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?TMOhc3psw7M=?= Lajos =?utf-8?Q?J=C3=A1nszky?= 
	<laszlo.janszky@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 18 19:00:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UozGH-0003ep-9F
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 19:00:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933203Ab3FRQ76 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Jun 2013 12:59:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52130 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933150Ab3FRQ74 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Jun 2013 12:59:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A5F13281AA;
	Tue, 18 Jun 2013 16:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=OcJbXAjErEvb
	IMp18G+nGIZb8Tk=; b=FLN4W6JquAjgSogF3bkHgzIpK1a8bmrcQEk7rxe1pMTh
	lI3Nz2F0qoXl37f9RTdC+o/pbvryolt8B4Jc6J+S2JLwNYmd8aPtNdXIC4dYGebN
	bOaYpltURfiiNMFS62L8088ML7q5m6yCXerjJjRMTGVSAnUk/Mcod+rA4kAVlXE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=yg1LbI
	37lnQN4SdtB/XR/0XOqjtXNYnyjaV8RqRJ55h0ZCDcJTMTekwRTPMAT7HHZv3AOC
	NGvUr1/WShhwyJcEjDM4m67QyW+ElFO3M9UJKnZ2ZXkjbYVPPeU3NAEyV1c2wQCa
	4UX2kKF+yFg3lhS7fvTZYmeEPJlO0f4geT57w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B3FC281A9;
	Tue, 18 Jun 2013 16:59:55 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1FFB8281A7;
	Tue, 18 Jun 2013 16:59:55 +0000 (UTC)
In-Reply-To: <CA+=RcCrAnNoFbu1VGnFLpubOkss1VyyfdumJiVcJ0G0z+tB6sQ@mail.gmail.com>
	(=?utf-8?B?IkzDoXN6bMOz?= Lajos =?utf-8?Q?J=C3=A1nszky=22's?= message of
 "Tue, 18 Jun 2013 17:45:55
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7FF9D8D6-D838-11E2-96FB-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228275>

L=C3=A1szl=C3=B3 Lajos J=C3=A1nszky  <laszlo.janszky@gmail.com> writes:

> There is a git extension called git ftp, written by Ren=C3=A9:
> https://github.com/resmo in bash. This extension uses git to push onl=
y
> the changed files to the ftp server. Currently this extension uses
> grep to decide which file is ignored by upload.

Two possibilities that come to mind are the "git ls-files" (read the
doc and find the option to have it read .gitignore file) command,
and the "git check-ignore" command.
