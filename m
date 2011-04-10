From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/5] Replace has_wildcard with PATHSPEC_NOGLOB
Date: Sun, 10 Apr 2011 14:23:21 +0700
Message-ID: <BANLkTikT7pz_nSJRAOb3rtYePBuVc2YX0Q@mail.gmail.com>
References: <1302368060-23827-1-git-send-email-pclouds@gmail.com>
 <1302368060-23827-3-git-send-email-pclouds@gmail.com> <7vbp0fylox.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 10 09:24:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8p0B-0007pq-Sl
	for gcvg-git-2@lo.gmane.org; Sun, 10 Apr 2011 09:24:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754220Ab1DJHXx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Apr 2011 03:23:53 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:49382 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753696Ab1DJHXw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Apr 2011 03:23:52 -0400
Received: by bwz15 with SMTP id 15so3767668bwz.19
        for <git@vger.kernel.org>; Sun, 10 Apr 2011 00:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=XKZ4eDZzy9zsiUVNDk2WOEVawL99m2XCmVzKiSfw6EI=;
        b=lZ19C3yzzGx0pPpzY7sxNiIQk2qU0cO59t3LI6ouzkP+wJngngy3OEn5CjRuytvOtv
         FZGl6x867JYvW4UCohyWtWBlsizcdtW7REu4U61VjfXEqUGohpAb0mBwVjREN8Mbf98K
         kZDp3FHdnN9ytYBecY/pvujFBt4gBSDq660kU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=iiANtnYKKQ7VfqCQIQwjpZmESnpxj++UbM1TmxiDopq6x6DdHvDYPRKE0UM9hgg43P
         Td8jAwQp4eFvmHF3NzUlxjh1hjopQOTHtBJN7zFwnWVHlwSeK9NQeduJP2lp3LXHSaSz
         frcHXCoA6VAzsERIj5iM+pAhPrx8EHr0tdW1U=
Received: by 10.204.75.88 with SMTP id x24mr1302940bkj.158.1302420231093; Sun,
 10 Apr 2011 00:23:51 -0700 (PDT)
Received: by 10.204.139.210 with HTTP; Sun, 10 Apr 2011 00:23:21 -0700 (PDT)
In-Reply-To: <7vbp0fylox.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171239>

2011/4/10 Junio C Hamano <gitster@pobox.com>:
>> +/*
>> + * Magic pathspec
>> + *
>> + * NEEDSWORK: These need to be moved to dir.h or even to a new
>> + * pathspec.h when we restructure get_pathspec() users to use the
>> + * "struct pathspec" interface.
>> + *
>> + * Possible future magic semantics include stuff like:
>> + *
>> + * =C2=A0 { PATHSPEC_NOGLOB, '!', "noglob" },
>> + * =C2=A0 { PATHSPEC_RECURSIVE, '*', "recursive" },
>> + * =C2=A0 { PATHSPEC_REGEXP, '\0', "regexp" },
>> + *
>> + */
>
> Gaah, why did you butcher this to heve only the whole comment and str=
uct
> type declaration here, without moving the "Possible future magic" com=
ment
> that clearly belongs to the structure definition you still have in di=
r.c
> to where it belongs? =C2=A0Also if NOGLOB is no longer "Possible futu=
re", why
> is it still here?

Carelessness, I guess. Will move it (with the NOGLOB future line
removed) to dir.c, close to get_pathspec().
--=20
Duy
