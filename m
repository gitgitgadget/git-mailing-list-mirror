From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 5/7] i18n: am: mark more strings for translation
Date: Tue, 24 Jul 2012 13:43:25 -0700
Message-ID: <7vwr1sevpu.fsf@alter.siamese.dyndns.org>
References: <cover.1343112786.git.worldhello.net@gmail.com>
 <d3711733085d683d9a63cff6f615ef3114f2d3c0.1343112786.git.worldhello.net@gmail.com> <20120724181600.GH2939@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Git List <git@vger.kernel.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 22:43:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StlxI-0005C6-Vg
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jul 2012 22:43:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125Ab2GXUne (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 16:43:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65170 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932106Ab2GXUn1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 16:43:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4260C6F61;
	Tue, 24 Jul 2012 16:43:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=T3/pjzAVBQoiWJb4es99wDvAOcI=; b=FKzwY4
	vUoiG5BXNP9N6WQV1Pq1iDJsVojLJpNixCnRGqKXlQIM+aF1wWfwzGTvSbOiCGiJ
	Fs35wmNcw/93fPD+NzUF4ujJnXnSH980uioF6387TOzKLtwgqrvGn7WeM2ybwKHe
	3vTILYZSSEpaQ4hzLjvipvcfgfd/JO9LvV5+o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bQZ3k30WeEIuHR8czEgOMoGRKcVAPC9x
	rEuXQbr7LEVPMMhb8FJoD6t9HufuGkY6bQ/ZrLvzgnI5Kp+yBcsYnJwLI+aHm49o
	+CDID9NoRup9Hl8kCHU9zCb6dTW7pbT7CwVM2ZE1KLgMBkY9PPgyHDd+K1Nl9p5e
	gEwUasciyJc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 302C76F60;
	Tue, 24 Jul 2012 16:43:27 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8C7586F5F; Tue, 24 Jul 2012
 16:43:26 -0400 (EDT)
In-Reply-To: <20120724181600.GH2939@burratino> (Jonathan Nieder's message of
 "Tue, 24 Jul 2012 13:16:00 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 37EA2854-D5D0-11E1-97E4-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202070>

Jonathan Nieder <jrnieder@gmail.com> writes:

>>  	-b|--binary)
>> -		echo >&2 "The $1 option has been a no-op for long time, and"
>> -		echo >&2 "it will be removed. Please do not use it anymore."
>> +		echo >&2 $(gettext "The -b option has been a no-op for long time, and
>> +it will be removed. Please do not use it anymore.")
>
> ... that this changes the message when the --binary option is passed.
> Before this patch, it says
>
> 	The --binary option has been a no-op for a long time, and ...
>
> After the patch, it says
>
> 	The -b option has been a no-op for a long time, and ...
>
> Intentional?  That may be a good change or a bad one (I haven't
> thought clearly about it), but it seems at least worth mentioning.
> Cc-ing Thomas in case he has advice.

If we really care we could printf $1, but I think we usually do

	The -b/--binary option has been...

in a case like this, especially in codepaths that no longer has an
easy access to $1 after parsing the command line but knows that
either one of them is given from the parse result, and that would be
an appropriate solution for this particular one as well.
