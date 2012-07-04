From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v4 03/18] sha1_name.c: get rid of ugly get_sha1_with_mode_1()
Date: Wed, 04 Jul 2012 09:12:12 +0200
Message-ID: <vpqk3ykhuer.fsf@bauges.imag.fr>
References: <1341268449-27801-1-git-send-email-gitster@pobox.com>
	<1341268449-27801-4-git-send-email-gitster@pobox.com>
	<vpqsjd9nuid.fsf@bauges.imag.fr>
	<7vk3ykwynh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 04 09:12:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmJlG-0005Wu-Sx
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jul 2012 09:12:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932576Ab2GDHMV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jul 2012 03:12:21 -0400
Received: from mx2.imag.fr ([129.88.30.17]:33217 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932097Ab2GDHMU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2012 03:12:20 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q647B698015298
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 4 Jul 2012 09:11:07 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SmJkz-0002dz-Dp; Wed, 04 Jul 2012 09:12:13 +0200
In-Reply-To: <7vk3ykwynh.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 03 Jul 2012 10:19:14 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 04 Jul 2012 09:11:07 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q647B698015298
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1341990669.39832@IAnNFpX7vS+o76diY5f2DA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200988>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> +/*
>>> + * Call this function when you know "name" given by the end user must
>>> + * name an object but it doesn't; the function _may_ die with a better
>>> + * diagnostic message than "no such object 'name'", e.g. "Path 'doc' does not
>>> + * exist in 'HEAD'" when given "HEAD:doc", or it may return in which case
>>> + * you have a chance to diagnose the error further.
>>> + */
>>> +void die_on_misspelt_object_name(const char *name, const char *prefix)
>>
>> It seems unusual to have a function named die_* that is not a noreturn
>> function. I'd call it die_*_maybe, or diagnose_* instead.
>>
>> (but as the comment above documents the behavior, it's not terribly
>> important, you may ignore my comment if you whish)
>
> I was hoping "on" may imply "if not misspelled, ignore and keep
> going", but apparently that failed.  I am not good at names.

Ah, maybe I missed the "on". With your explanation, it makes sense.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
