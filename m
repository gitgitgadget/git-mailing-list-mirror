From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] http: Include locale.h when using setlocale()
Date: Fri, 06 Mar 2015 11:01:32 -0800
Message-ID: <xmqqa8zqympf.fsf@gitster.dls.corp.google.com>
References: <1405792730-13539-1-git-send-email-eungjun.yi@navercorp.com>
	<1425658438-1004-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Yi EungJun <eungjun.yi@navercorp.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 20:01:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTxVE-0003wE-EH
	for gcvg-git-2@plane.gmane.org; Fri, 06 Mar 2015 20:01:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753973AbbCFTBg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Mar 2015 14:01:36 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60061 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750933AbbCFTBf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Mar 2015 14:01:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 816F83D86C;
	Fri,  6 Mar 2015 14:01:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=QZv27yjs/1jj
	LnyE4y1ChxgZIsU=; b=ipuRhfmSYk61khV7IwX2cE5PVct4DoOFa2C9SCJAGieL
	ze58uHK7GoKrUwbFKq8nHJNW/xwqvxvBX2EqL5oJeqTlG65yzmOqW+VznOo3JuXF
	ns/h5wOzZ4GZs+DNFumqnpDWJ7QZfyHccRo7rLbdJPDPC4cc3G24K14tiR8xd1I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=UPatcv
	mCHf3ozTNyBfG6Pwx4L4w9z3H9r7ZAqZX+2kV4p3AgZJZNJOVRMmonjBD0Z/EB6u
	jOtafNygkmjIXh3ZqmfHadqi4qaGVAalKU/8htrUM14Twb9KCAbIJZKkEv3DEPkp
	OnDIX/oye52K2FH+0o7LARSRTmBPk8B+u3mWo=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 779AC3D86B;
	Fri,  6 Mar 2015 14:01:34 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F16F33D86A;
	Fri,  6 Mar 2015 14:01:33 -0500 (EST)
In-Reply-To: <1425658438-1004-1-git-send-email-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 6 Mar
 2015 16:13:58 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 35076CC4-C433-11E4-A9B4-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264952>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Since v2.3.0-rc1-37-gf18604b we've been using setlocale() here withou=
t
> importing locale.h. Oddly enough this only causes issues for me under
> -O0 on GCC & Clang.

Sorry for not making this entry in "What's cooking" report very
prominent:

    * ye/http-accept-language (2015-02-26) 1 commit
      (merged to 'next' on 2015-03-03 at 58d195e)
     + gettext.c: move get_preferred_languages() from http.c

     Compilation fix for a recent topic in 'master'.

     Will merge to 'master'.

This has cooked on 'next' for a few days, and is eligible to
graduate to 'master'.  Will be in the next update.

Thanks.
