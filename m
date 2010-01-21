From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] Fix memory corruption when .gitignore does not end by \n
Date: Thu, 21 Jan 2010 08:38:48 +0700
Message-ID: <fcaeb9bf1001201738x5cd374c2o280ec42d6d65c0f7@mail.gmail.com>
References: <fcaeb9bf1001200458v436a8adeq5cfc6753900e6c0c@mail.gmail.com>
	 <1263996556-9712-1-git-send-email-pclouds@gmail.com>
	 <7v3a20367d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jonathan del Strother <maillist@steelskies.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 21 02:38:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXm0b-0003IW-O0
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 02:38:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753704Ab0AUBiu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Jan 2010 20:38:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752447Ab0AUBit
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 20:38:49 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:47708 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751774Ab0AUBit convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jan 2010 20:38:49 -0500
Received: by pwj9 with SMTP id 9so3588606pwj.21
        for <git@vger.kernel.org>; Wed, 20 Jan 2010 17:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=omOu1Y0TnKhH8IgPYXPDVT5Y/wjEMSQB4/gGmq5gAWk=;
        b=MMj/lxmkF5rWscgAF8vr9GvVga63WGJTH2BrMB7t7dMea1V5gSkBQTyfIeT75CJmR6
         aMgJj4R3XyubGHk553HbTcqEjFA+iCHIanwwdVkO6JF5qW5Q1AzDXbTHOohWzkwziEsg
         ZRYd/uP6OQHUCpbfMDF13XLPCRbrZ+okoGgLY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=TPTiva5TlOH2Z6MSthtttPubH4bR1IFwbqzY4W+bNbNeLEShe6uphPRsLbJQtQj4yN
         WyydQYnsHZQZTtAGh8Cv6dluR6DYPDzX1rPUhrIp0Tl/Y/TLLuzKz3J4bWPZhIF9ihS5
         gZLv9Q3v8vC4Iw5xG3WBOogXcfcWTImfrtHRo=
Received: by 10.114.48.10 with SMTP id v10mr555018wav.11.1264037928222; Wed, 
	20 Jan 2010 17:38:48 -0800 (PST)
In-Reply-To: <7v3a20367d.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137613>

On 1/21/10, Junio C Hamano <gitster@pobox.com> wrote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>  >  This patch causes a crash for me. Not sure if it does for anybody=
 else.
>
>
> I am puzzled.  What do you mean by this?  If this patch makes the cod=
e
>  crash, then it is not a fix.  Is this meant as "Jonathan, can you tr=
y this
>  patch and tell me what happens, so that I can diagnose the issue bet=
ter?"
>  patch?

I mean the t3001 patch in comment part, which removes \n at the end of
=2Egitignore and crashes the unmodified git.

IOW I found a problem and this patch (not the t3001 one) should fix
it. Not sure if this causes Jonathan problem though.

>  Is it better/safer to revert the entire nd/sparse topic from the mas=
ter in
>  the meantime before we know what is going on?

I would wait for Jonathan response. If this is not the cause, probably
safer to revert it.
--=20
Duy
