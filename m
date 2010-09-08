From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] fast-export: ensure that a renamed file is printed after
 all references
Date: Wed, 8 Sep 2010 13:26:14 -0600
Message-ID: <AANLkTimS96c1YFC+UUw0iRoPVT=COFhDRoSO1cNHYhTf@mail.gmail.com>
References: <201009072133.02930.j6t@kdbg.org>
	<AANLkTim4iuDOG9U1epcafWarckaa6ZnxCOpfJW8KJW_m@mail.gmail.com>
	<201009082047.50083.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Sep 08 21:26:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtQHm-0006iR-4T
	for gcvg-git-2@lo.gmane.org; Wed, 08 Sep 2010 21:26:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753465Ab0IHT0R convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Sep 2010 15:26:17 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60376 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753160Ab0IHT0Q convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Sep 2010 15:26:16 -0400
Received: by fxm16 with SMTP id 16so381586fxm.19
        for <git@vger.kernel.org>; Wed, 08 Sep 2010 12:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=TBabezYbQaZ1hB6yjNvg0O2R9LR4Tatewmvrdv5K4Ko=;
        b=nrNsppl/LPPSq+61wfrFkJxamkE4KPongER2jD6Xr8T+TG6Dcn9V8RaZ1KS9Enx6F9
         ZX1P75jq3zZ5Iz52eexeQav3x8uUcHHau/EpcrVt6Q+AlROHuAj4p/Uw+0EaVWYmd7/U
         UrEgMRct5aLHk9tu96k/EB+1gpWSur1myqTuk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=mlIVSnV3vHVigKjyLEHyPaiWkET9AzB56Bly3FXB6oB+RW3dDUNHePVDqHpDr/rVYa
         ON4CdSVhTv0k/XEDSvVodfttvz+OEkhaL7u0jqxHcHerDEAVsqVHoMeotBQL7iIUnYBw
         7vkkrV9ilvzRlAu4BFQc2Wg6H0YnHu/jxvT44=
Received: by 10.223.105.76 with SMTP id s12mr126679fao.107.1283973974606; Wed,
 08 Sep 2010 12:26:14 -0700 (PDT)
Received: by 10.223.50.154 with HTTP; Wed, 8 Sep 2010 12:26:14 -0700 (PDT)
In-Reply-To: <201009082047.50083.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155810>

On Wed, Sep 8, 2010 at 12:47 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> On Mittwoch, 8. September 2010, Elijah Newren wrote:
>> Patch and description looks good to me...however, I was a little
>> surprised to see no testsuite addition or additional explanation. =C2=
=A0Are
>> you seeing some t9350 tests fail on some platform despite passing on
>> linux?
>
> Yes, I see the problem in t9350 on Windows. It is impossible to write=
 a test
> for it because the test would depend on the unspecified behavior of q=
sort.

Makes sense.  Would it be worth briefly mentioning Windows in the
commit message?

Either way,
Acked-by: Elijah Newren <newren@gmail.com>

> BTW, I don't know whether the diff machinery guarantees to produce 'C=
' and 'R'
> records in this order. If there is no such guarantee, then fast-expor=
t would
> have been broken even before 060df62.
