From: Junio C Hamano <gitster@pobox.com>
Subject: Re: BUG: git pull --rebase on detatched head prints a lot of usage
 warnings
Date: Fri, 03 Dec 2010 14:31:57 -0800
Message-ID: <7vy686lc82.fsf@alter.siamese.dyndns.org>
References: <AANLkTimyCG6zVhc4znWPWwipd0bn-YT2FrOT=T0AgHNW@mail.gmail.com>
 <20101203190050.GB14049@burratino>
 <AANLkTin-9pb7cxsAvDqWj3So47_zq5co9TZRWux9ezxz@mail.gmail.com>
 <AANLkTikwdqQpmyxZu-kp7UHjYnKuVxs8urxM=9c=66H0@mail.gmail.com>
 <7vbp52o9c6.fsf@alter.siamese.dyndns.org>
 <AANLkTimgk-jqyKD+ab=bHZLVH3F52WqCjr4v3chMY_Fv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Santi =?utf-8?Q?B=C3=A9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Fri Dec 03 23:32:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POeAr-0006Ud-Aw
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 23:32:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754020Ab0LCWcM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Dec 2010 17:32:12 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:48587 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753580Ab0LCWcM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Dec 2010 17:32:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 92E4E201E;
	Fri,  3 Dec 2010 17:32:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=85mssSQT1A5N
	gs52YDjdhOkdjCE=; b=B5aMPzzy6a3ds43zQdlKgsPGrrcqhvOD3Dm+8QuhGbQl
	OFvfQkdjzR0zTwP+k/IxvzWYRSvLLv12GWrMPdh6PbAITbmPGeL4HS9qX+cNcFZA
	u6f8fSY/UvVwFaf8hDyvIUqEFoB7Xht+L48sxldvzTZFC1UAuUubbjLcJjr5584=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=C6hZgK
	ygd2wLBQY1Wh/0PMnLfHqm5BID13gRtzmkHW6+6pX0eUf8fRNbBTukkTIF/artMm
	3LjxfziBYjo3zHrTvTfo8AgcTGHZqBAIwVvvonPSoix7NovRxi/Sa0nouF0SCA1j
	4jlgdRQNTCRvSGmM6yT04VINM3yXTcniet/Ao=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3FCE4201D;
	Fri,  3 Dec 2010 17:32:26 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2B6052018; Fri,  3 Dec 2010
 17:32:18 -0500 (EST)
In-Reply-To: <AANLkTimgk-jqyKD+ab=bHZLVH3F52WqCjr4v3chMY_Fv@mail.gmail.com>
 ("Santi =?utf-8?Q?B=C3=A9jar=22's?= message of "Fri\, 3 Dec 2010 23\:16\:11
 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 34679188-FF2D-11DF-B4AC-CDEAE6EC64FC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162872>

Santi B=C3=A9jar <santi@agolina.net> writes:

> No, I'm not sure. In fact the documentation explicit says that they
> are different. But I fail to see when it matters, and more
> specifically (now that I've reread the docs), what is the point of
> "merge-base A B C".

See c5dc9a2 (git-merge-octopus: use (merge-base A (merge B C D E...)) f=
or
stepwise merge, 2008-07-27), not the patch but the explanation.

> Just a data point, show-branch --merge-base is only used once in the
> code, in git-pull.sh, but "git merge-base A B C" is not used (at leas=
t
> using my grep).

Your grep skill needs honing ;-)  The variable MRC in git-merge-octopus=
 is
a space separated list of commit object names, split at $IFS when
merge-base is called.
