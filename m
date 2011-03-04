From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: [PATCH/RFC] init, clone: support --real-git-dir for .git file
Date: Fri, 4 Mar 2011 08:41:50 +0100
Message-ID: <AANLkTin8Gnbyji4sz6cnWLcAzC2RAS_wnd_o3avDvsvG@mail.gmail.com>
References: <1299156201-12149-1-git-send-email-pclouds@gmail.com>
	<4D700469.7090807@gmail.com>
	<7vhbbj93yb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 04 08:41:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PvPe9-0007qq-GT
	for gcvg-git-2@lo.gmane.org; Fri, 04 Mar 2011 08:41:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753267Ab1CDHlw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Mar 2011 02:41:52 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:61704 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752009Ab1CDHlv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Mar 2011 02:41:51 -0500
Received: by vws12 with SMTP id 12so1769849vws.19
        for <git@vger.kernel.org>; Thu, 03 Mar 2011 23:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=l0UEdM2U/wOcdhL2uKT39iq3FJ+EmoqMpEed5rTRv7o=;
        b=UK8GBMOHwt/j9txm8SE/Jim8MfWjA3noA0qGblLoQbJ5d/0OsT2SysDry7JGT+KZoi
         4ZpBmtuRLBZ8XXyGX2Ghi4REd11gLGOtEEOjsi6gglMIjJ13cbDefvLxQFvGXTvb7lJj
         PpygkFNwWXjmOxDdx3AcSS9RRCGNHmh6rT4+g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=mQosEAu0r2/2YrHE8Hi3FhoyEHFpyThhhhLFAukQEyghUz9wTzrxBmSvPQA7QLbGVf
         V6ZOveP1JdStxaqWDntyyl0xRepQpR06OWkz6lvqef2zBF2l64dKSRlIULUWnaxDaaLz
         9La7XTJu8wCUvMG1RorslEftr2BcF0GcJ2aBw=
Received: by 10.52.72.14 with SMTP id z14mr387303vdu.68.1299224510792; Thu, 03
 Mar 2011 23:41:50 -0800 (PST)
Received: by 10.220.61.140 with HTTP; Thu, 3 Mar 2011 23:41:50 -0800 (PST)
In-Reply-To: <7vhbbj93yb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168431>

2011/3/4 Junio C Hamano <gitster@pobox.com>:
> Piotr Krukowiecki <piotr.krukowiecki@gmail.com> writes:
>
>> From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
>> Date: Thu, 3 Mar 2011 21:51:34 +0100
>> Subject: [PATCH] Improve error message when gitfile has wrong format
>>
>> Add information what format of .git file is expected.
>
> Don't do this. =A0We don't want to _add_ places that needs to be upda=
ted
> when we need to update our internal implementation.

I thought it was user-level file, like $GIT_DIR

I'm not into data duplication, but in this case the message is next to =
the
previous use:

       if (prefixcmp(buf, "gitdir: "))
               die("Invalid gitfile format: %s\nUse gitdir: <PATH>", pa=
th);


BTW I think it might be enough to have just path in the .git file. If
=2Egit has path
to a correct git repo then chances it's coincidence are quite low.
(The format does not matter if it's internal file of course)

--=20
Piotrek
