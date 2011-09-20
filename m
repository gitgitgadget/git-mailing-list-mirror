From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Worktree vs. working copy
Date: Tue, 20 Sep 2011 12:10:02 -0700
Message-ID: <7vhb476ned.fsf@alter.siamese.dyndns.org>
References: <1316505022.13996.12.camel@bee.lab.cmartin.tk>
 <CALkWK0mHQZEPKk3Dy3RSp70thcsw3x6RSvUxTuPVzzRjgsM8-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 20 21:10:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R65hw-0000cm-Pr
	for gcvg-git-2@lo.gmane.org; Tue, 20 Sep 2011 21:10:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751037Ab1ITTKI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Sep 2011 15:10:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61232 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750874Ab1ITTKH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Sep 2011 15:10:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 31A865697;
	Tue, 20 Sep 2011 15:10:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=cXF4ny88IIjk
	59uZyUCEI25gceA=; b=COlMVNgmjAfeX9/lcmoq0evoHPhUvXu+Dy1mxDYwY98E
	lE5NyhWENrmRDe1MrntnBDe0Yj1gy687G3NhI7CdLJhBkJPCq0VROCD6QiHt4PW6
	f7OhsL5z++32/pP8cFYGQKW1LrHbZocPtp13DwnBruONnn5Hk/ex6/rgkbiQa3U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=htzNK/
	CD/oMcUegAyOGZyW1GYnjVCwGqpJ2ncFS2i4O3PwmxpouNNDZDBTWmUu2KtUkzKe
	lLUA3ROdpkVAglN/Ff48wEggbVFelAeF5ac1nGyPoI6BrvD0LM7ibZhGbObnOPL+
	yGjBn6O9sWj++bWDiYjjTDPMp/jtI0PVd4BMI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 239B25696;
	Tue, 20 Sep 2011 15:10:06 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 969FB5690; Tue, 20 Sep 2011
 15:10:04 -0400 (EDT)
In-Reply-To: <CALkWK0mHQZEPKk3Dy3RSp70thcsw3x6RSvUxTuPVzzRjgsM8-A@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Tue, 20 Sep 2011 16:26:08 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 25A8F294-E3BC-11E0-BD72-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181778>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Hi Carlos,
>
> Carlos Mart=C3=ADn Nieto writes:
>> [...]
>> =C2=A0 =C2=A0$ git grep 'worktree' | wc -l
>> =C2=A0 =C2=A0412
>> =C2=A0 =C2=A0$ git grep 'working copy' | grep -v ^git-cvsserver | =C2=
=A0wc -l
>> =C2=A0 =C2=A032
>> [...]
>
> You might like to refer to a related discussion [1].
>
> [1]: http://thread.gmane.org/gmane.comp.version-control.git/159287/fo=
cus=3D160083

Sorry, I do not see "working tree" discussion there. The discussion on
that quoted thread was about remote-tracking branches, no?

Historically, we used to say "working tree" and "worktree" more or less
interchangeably, and over time we tried to update the documentation to =
use
"working tree" consistently, even though the latter is still seen in
places like "GIT_WORK_TREE" environment variable (which will _not_
change).

But as far as I recall, we have never referred to the working tree
controlled by a git repository as "working copy".
