From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Experience with Recovering From User Error (And suggestions for improvements)
Date: Mon, 16 Feb 2015 19:37:40 +0700
Message-ID: <CACsJy8B3wT5r+bSNHjEtwMcx6aVBGS9Ff++w5JU0NFN=KX4V=A@mail.gmail.com>
References: <54E1C96D.2080109@active-4.com> <CACBZZX4NkkMymnG5ZWtO1ya2xzVhxuqh4d3tU2U+mPU49n=m8g@mail.gmail.com>
 <CACBZZX7Kjf2owiAyVzRVMs36Vj4-aYVgQ13amiJRHH91HW3RWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Armin Ronacher <armin.ronacher@active-4.com>,
	Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 16 13:38:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNKwK-0007aO-30
	for gcvg-git-2@plane.gmane.org; Mon, 16 Feb 2015 13:38:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755486AbbBPMiM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Feb 2015 07:38:12 -0500
Received: from mail-ig0-f172.google.com ([209.85.213.172]:44408 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752565AbbBPMiL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Feb 2015 07:38:11 -0500
Received: by mail-ig0-f172.google.com with SMTP id l13so23202175iga.5
        for <git@vger.kernel.org>; Mon, 16 Feb 2015 04:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=bBvJ9kAy0+IGX1kU4ev1JW2ORMPWkDomAsABuSumpeQ=;
        b=KoKKXljuA7JvoJ9OqjJut9AYJRguuRC02LO501JGXexJuI5nT6ULn4dZrBOrtRNFya
         H8yP4YKBZWDBuIU0RBN7svcV/YXTkOrzTrKqESDXFF5irqWb/Wiypw9RHHJNlvLBEn2W
         iKQNx2BWNK849ksfX5wPugnM203GNilXuij2fqos8LtltdBJQtO38rQwZYra9FaHJV9W
         Pl69maI173M/309f9gwa8mrHaKyWwqVC5U1bmbWL0XEQ/2Op8tOAe40ILTxd2g6jrlp4
         P3Qf+jKlgxpum9eQuyHvyBCWZDXRQ3jDxkzDa1RyrhlkjhJRUtYLK/cHpPHyagRPllum
         gagA==
X-Received: by 10.107.168.207 with SMTP id e76mr28438542ioj.60.1424090291188;
 Mon, 16 Feb 2015 04:38:11 -0800 (PST)
Received: by 10.107.131.155 with HTTP; Mon, 16 Feb 2015 04:37:40 -0800 (PST)
In-Reply-To: <CACBZZX7Kjf2owiAyVzRVMs36Vj4-aYVgQ13amiJRHH91HW3RWA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263897>

On Mon, Feb 16, 2015 at 7:10 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>> We should definitely make recovery like this harder, but is there a
>> reason for why you don't use "git reset --keep" instead of --hard?
>> It'll keep any local changes to your index/staging area, and reset t=
he
>> files that don't conflict, if there's any conflicts the operation wi=
ll
>> be aborted.
>
> "Recovery like this easier", i.e. make it easier to get back
> previously staged commits / blobs.

I started with git-undo (or what's its name) a while back (*). The
idea is for dangerous commands like this we could save some data back,
which would be pruned after some time. Saving stuff in index is quite
easy because they are already in object database. For this reset
--hard, we may need to hash/store some more blobs. I think it's worth
the safety. Not sure if anyone's interested in continuing that work.

(*) found it: http://thread.gmane.org/gmane.comp.version-control.git/23=
1621/focus=3D231879
--=20
Duy
