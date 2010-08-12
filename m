From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH v2] git-am: Ignore whitespace before patches
Date: Thu, 12 Aug 2010 15:13:23 -0400
Message-ID: <AANLkTinDHvwHLZfj6DDPtV39Z2xhDZREiqwdt5cjiaLP@mail.gmail.com>
References: <1273944188-9472-1-git-send-email-avarab@gmail.com>
	<1281556645-23361-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 12 21:13:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjdDY-0005wF-0L
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 21:13:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760192Ab0HLTN0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Aug 2010 15:13:26 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:52537 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754158Ab0HLTNZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Aug 2010 15:13:25 -0400
Received: by vws3 with SMTP id 3so889142vws.19
        for <git@vger.kernel.org>; Thu, 12 Aug 2010 12:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=iMYVdod+bpEqUO+RF0j3P5lmEa7OCr8KddyNh8PvAv8=;
        b=p0iLsHI3NVqnEpQOGBGQXLWL6jEBJmCm9GktooxF2xvKVfPR9DRhf+8Q1tbnhGiIKq
         suCNUH427izJRlM2LBaxqj1sqVzJq8PKaMmFx/X139MKDjVSbNVzjX5bj/ESPrzAh87M
         5slUKi6QRfefiHIMA9UG75MS1iXHr3PSjaLrc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=bQXr9QvYHZ1qS/0d9Oy2UCdGAf/eQkUFxoHxviSXXEvkM0pU0XbASzmqCWB6vgHASZ
         BQ3jJ+7HqYs2s12SWjatmHy3Fk4Mf6WHH9I6Xg8NXnHPYzyM81QCq2CJKYFAlHJT415o
         V3IrP3CEvVw2eTeBonvxa198GX2gIZwU/3T44=
Received: by 10.220.169.21 with SMTP id w21mr394841vcy.62.1281640403339; Thu,
 12 Aug 2010 12:13:23 -0700 (PDT)
Received: by 10.220.158.12 with HTTP; Thu, 12 Aug 2010 12:13:23 -0700 (PDT)
In-Reply-To: <1281556645-23361-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153401>

On Wed, Aug 11, 2010 at 3:57 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>> Actually cut-and-paste is often a major source of whitespace breakag=
e
>> (including tabs silently being expanded), and I personally think a p=
atch
>> like this to encourage the practice is going in a wrong direction.
>
> I disagree and think git-am should be smarter. Any human looking at
> something like a GMail mail.txt download will clearly see that it's a
> patch, but git-am is pedantic and doesn't skip past whitespace at the
> beginning of the file.

The point of git-am being pedantic is to prevent the original patch
from being applied w/silent corruption (e.g., tabs-to-spaces).

Perhaps, before making git-am less strict, we should modify
format-patch to include a sha1 of the diff output so that corruption
can be reliably detected by git-am.

Just a thought.

j.
