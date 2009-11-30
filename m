From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH v3] Give the hunk comment its own color
Date: Mon, 30 Nov 2009 08:07:22 +0100
Message-ID: <36ca99e90911292307w769913fdn1f610eeb065b41e@mail.gmail.com>
References: <7v4oogzo74.fsf@alter.siamese.dyndns.org>
	 <1259304918-12600-1-git-send-email-bert.wesarg@googlemail.com>
	 <7vhbsfi4bz.fsf@alter.siamese.dyndns.org>
	 <36ca99e90911280408v186777f1h22254744fb61bf1f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 30 08:07:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NF0M7-0004M3-8x
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 08:07:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753656AbZK3HHS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Nov 2009 02:07:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753644AbZK3HHS
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 02:07:18 -0500
Received: from mail-fx0-f213.google.com ([209.85.220.213]:53808 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753604AbZK3HHR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Nov 2009 02:07:17 -0500
Received: by fxm5 with SMTP id 5so3349875fxm.28
        for <git@vger.kernel.org>; Sun, 29 Nov 2009 23:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=e1qrjocEnyUIJzIukFfnMPMXcgYt4b4qt+UnlVXPhNA=;
        b=HVqlXna6P2JAVLLc2PTWdboWpVmQEgR6KQ37RbfOkBkvancgcJJ16LVCOoW9rliBqC
         7ljyirfIzF/SMo8TmUnhmMIcKrhe5og5Q8XURwSZcC9iEQeQy2HZe5mCCrAshIqk9ZUw
         TGkcm1AHwMKwJ7bcD800dKVxntCJvCwxx9BUw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=FnGjwgy9S0U8vYCViavRlL354t2JOqcv7wvTBa8cws+Klz/1IMH5qCQv+i9v/y+Zpf
         2g97TzB4k8vYV/77VqaWzwNH9HhMHheg17ZET/MzhaX5j45GU+BVnjhcIpDWWvT8Y8rh
         fuaimkrCHIdqi9gXXqv9jMWHYm+JQv2dXPWVQ=
Received: by 10.223.132.207 with SMTP id c15mr601302fat.56.1259564842380; Sun, 
	29 Nov 2009 23:07:22 -0800 (PST)
In-Reply-To: <36ca99e90911280408v186777f1h22254744fb61bf1f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134060>

>> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* blank before the func header */
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0for (cp =3D ep; ep - line < len; ep++)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (*ep !=3D =
' ' && *ep !=3D 't')
> Please check that its really an *ep !=3D '\t'. Its wrong in this mail=
, I
> see only an *ep !=3D 't'.
Obviously, you have not checked it. Please squash this in:

diff --git i/diff.c w/diff.c
index eaa1983..e126304 100644
--- i/diff.c
+++ w/diff.c
@@ -376,7 +376,7 @@ static void emit_hunk_header(struct emit_callback *=
ecbdata,

        /* blank before the func header */
        for (cp =3D ep; ep - line < len; ep++)
-               if (*ep !=3D ' ' && *ep !=3D 't')
+               if (*ep !=3D ' ' && *ep !=3D '\t')
                        break;
        if (ep !=3D cp)
                emit_line(ecbdata->file, plain, reset, cp, ep - cp);

Bert
