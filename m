From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] test results for v1.7.12-rc0 on cygwin
Date: Sun, 29 Jul 2012 13:33:44 -0700
Message-ID: <7va9yiwbmf.fsf@alter.siamese.dyndns.org>
References: <50143379.8050500@ramsay1.demon.co.uk>
 <5014FAE6.7080009@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	GIT Mailing-list <git@vger.kernel.org>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Jul 29 22:33:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvaBV-00019S-P2
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jul 2012 22:33:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753475Ab2G2Uds convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Jul 2012 16:33:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55712 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753454Ab2G2Uds convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Jul 2012 16:33:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 357679E6E;
	Sun, 29 Jul 2012 16:33:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=5o94y+N0AS+x
	scM0ktOQXsF1IIU=; b=KY/1kGwTkqcmdJcYfCsoISm9fnAhdam2wkwT6ASd7Zqy
	bf5YCOv5JdVF0xVi8UFrVTezLIeVXCIGGJzm1oxMKHzuuSo4UCN5v9pkVdkBROff
	MiLh89aX0gxW7ppjm2O30HZZWYOeACfyxHF129hWye0jcYlyDTy0MKxWTFn4CFE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=WU6l2V
	Mh77yK2lsvwTN5238j/BmY4vkmPgaHISIIuAP7TaL8Y2K8D3kfGQnaOPCeoE6vrD
	ZDm5f6ea0JOCdDb480h1f5kua4bxezf81GC5yNpItsdORc0S9dky6JlXKQq7HHMw
	vKWRd2iqp7KrnI33H31H1oGc4vfB/cMVdJH2Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 222479E6D;
	Sun, 29 Jul 2012 16:33:47 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 864C39E6C; Sun, 29 Jul 2012
 16:33:46 -0400 (EDT)
In-Reply-To: <5014FAE6.7080009@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Sun, 29 Jul 2012 10:57:10 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B2421734-D9BC-11E1-A40B-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202493>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Am 28.07.2012 20:46, schrieb Ramsay Jones:
>> Unfortunately, I was unable to reproduce the final failure in t7810-=
grep.sh.
>> I tried, among other things, to provoke a failure thus:
>>
>>      $ for i in $(seq 100); do
>>      > if ! ./t7810-grep.sh -i -v; then
>>      >     break;
>>      > fi
>>      > done
>>      $
>>
>> but, apart from chewing on the cpu for about 50 minutes, it didn't r=
esult
>> in a failure. :(
>>
>> However, after looking at test 59, it seems to me to be a stale (red=
undant)
>> test. So, patch #2 removes that test! :-D [I wish I could reproduce =
the
>> failure because I don't like not knowing why it failed, but ...]
>
> Removing the test makes sense, since it was needed for --ext-grep
> only, is relatively expensive and a bit fragile (by depending on
> MAXARGS).
>
> I'm slightly worried about the non-reproducible failure,
> though. Perhaps a timing issue is involved and chances are higher if
> you leave out the option -v?

Thanks for a comment.  I agree that removing the test makes sense,
and I also agree that the non reproducibleness is worrying (the
latter is more important).
