From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] t3703: skip more tests using colons in file names on Windows
Date: Wed, 8 Jun 2011 12:44:01 +0200
Message-ID: <BANLkTikL-cBw95RMqcU7-B6mL0qfTVQ-5A@mail.gmail.com>
References: <BANLkTik3K2GVZ5rzegYSXRrvROU_bzBdVw@mail.gmail.com> <4DEF152C.5060005@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Jun 08 12:44:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUGFP-0004pt-KW
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 12:44:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754510Ab1FHKoX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Jun 2011 06:44:23 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:61073 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753910Ab1FHKoW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jun 2011 06:44:22 -0400
Received: by bwz15 with SMTP id 15so299315bwz.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 03:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=ycpPwOlA/pTpTdSYsEL8irsuQw1HpY6htfuWjF9yKu0=;
        b=MNKBm+NEJFRaAQTqjglSAWZBZBtlhE6qAv5pmj05LVZS4DcBinreEPR1+0GyS/vaiv
         gL3mVNDdiydkcd7/7pmLcCtL8k1a5OObdC1J6iYZmtxZnSQsQck3SzrnyOtrv8dMVtoD
         GzDi5Y/eOQQ1J26SbLgmYrkm2ktWl9nPrqLMs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=hEw/+K0L6KV85I3NqKEfgfr2qQiux297EkWuf5tmDO6euhvCeg4X41JaQZ0r2kuK9n
         hxKo56USqMt/F1JrJGR+Bfn0PqR1wD04KnC+niTzT+5MczasJ6PZ40crpPqPvSivcViI
         zbNjL81xLCwSlc95PiNClEF8N4GNXzu3y+7Ek=
Received: by 10.204.154.147 with SMTP id o19mr886119bkw.83.1307529861081; Wed,
 08 Jun 2011 03:44:21 -0700 (PDT)
Received: by 10.204.62.9 with HTTP; Wed, 8 Jun 2011 03:44:01 -0700 (PDT)
In-Reply-To: <4DEF152C.5060005@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175352>

On Wed, Jun 8, 2011 at 08:22, Johannes Sixt <j.sixt@viscovery.net> wrot=
e:
>> -test_expect_success 'a file with the same (long) magic name exists'=
 '
>> - =C2=A0 =C2=A0 : >":(icase)ha" &&
>
> ":foo" is the name of an alternate data stream on the current directo=
ry.

Ah, right. Forgot about that "feature". For some reasons, Cygwin does n=
ot
allow use of alternative data streams on "." or "" (zero-length string)=
=2E

> Therefore, the test passes. This is on Windows XP with NTFS.

Same here, just under Cygwin.
