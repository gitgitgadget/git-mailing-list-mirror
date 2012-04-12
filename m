From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 8/9 v12] difftool: teach difftool to handle directory
 diffs
Date: Thu, 12 Apr 2012 12:31:30 -0700
Message-ID: <7v62d4692l.fsf@alter.siamese.dyndns.org>
References: <1334236726-18393-1-git-send-email-tim.henigan@gmail.com>
 <7viph46c1t.fsf@alter.siamese.dyndns.org>
 <CAFouetg6Ot8sKiNi45A0QRv6YYdL3Mwrb3tkVkajQQuZukSp3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, davvid@gmail.com, ramsay@ramsay1.demon.co.uk
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 12 21:31:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIPk1-0001gX-OK
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 21:31:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934614Ab2DLTbd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Apr 2012 15:31:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48021 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934514Ab2DLTbc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Apr 2012 15:31:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 323D56088;
	Thu, 12 Apr 2012 15:31:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=M7ImPiJAKTWC
	/qXj70TueP+LJn0=; b=AsG4Q6cybbL0t+lv4jC61TOomKAF+v00EBojVW8N4VgP
	M39Jbu/wQ9sa17/AJ7oqtbHyyF23BLa8CLMqj8CAXP//CL2/hEUcI18lRWLeXN5M
	F7pVQsX4cNJJ8SrwLfP9/fYLh7Jtnk2pyC+UNe00hyi/YUgPz638NHQO9fOd8Po=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Qj76yu
	vibBo+wAznRo3UfUmRaiAHtjnPnZvAFPSdKYA77PAxf2vEzxpxuYyN409Nat5sjE
	0UqmSLU4j4lmINCadgw6gZocVhut6d1BN1BK/RMCzwB+WrKAPCUMlECTlcOj1U4o
	TnRSzS86BgMmRX9dBsskQIWzFY3yfG1lpdXBc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 283436087;
	Thu, 12 Apr 2012 15:31:32 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9DAC76086; Thu, 12 Apr 2012
 15:31:31 -0400 (EDT)
In-Reply-To: <CAFouetg6Ot8sKiNi45A0QRv6YYdL3Mwrb3tkVkajQQuZukSp3g@mail.gmail.com> (Tim
 Henigan's message of "Thu, 12 Apr 2012 15:10:45 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1B787252-84D6-11E1-92BD-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195359>

Tim Henigan <tim.henigan@gmail.com> writes:

> Would the following change be better?
>
> - =C2=A0 =C2=A0 my $cmd =3D "git diff --raw --no-abbrev -z " . join("=
 ", @ARGV);
> + =C2=A0 =C2=A0 my $cmd =3D "git diff --raw --no-abbrev -z @ARGV";

They look exactly the same to me.
