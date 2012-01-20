From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] mergetool: Provide an empty file when no base exists
Date: Thu, 19 Jan 2012 23:26:59 -0800
Message-ID: <CAJDDKr490XFqGe+y1pa7fnNhPMRE3ZR3=A+_XNUrCA1GZv+wkw@mail.gmail.com>
References: <7vhazqhn8u.fsf@alter.siamese.dyndns.org>
	<1327043453-80965-1-git-send-email-davvid@gmail.com>
	<7v7h0mhm8g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: jcwenger@gmail.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 20 08:27:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ro8sK-00051N-Oi
	for gcvg-git-2@lo.gmane.org; Fri, 20 Jan 2012 08:27:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751995Ab2ATH1A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Jan 2012 02:27:00 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:55401 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751591Ab2ATH07 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Jan 2012 02:26:59 -0500
Received: by yenm6 with SMTP id m6so125780yen.19
        for <git@vger.kernel.org>; Thu, 19 Jan 2012 23:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=cInuFEEALSfpbqpWvDTeQ6XI6uDJPfo+fY5kXQEiHOQ=;
        b=QlGxzjPwiYgGoW8kuZxeQi5E2DqZp7dqPklmd4SQ359yD5hGPt4k7DKIjRk6Srdu0+
         rr8nEJp6tYg9l0Y33MkWPsGd2XJVBEkApTpBZ6zYSW1kO+s6zvkyKnG38DOpKHALOa2Q
         UZVu2HewGS6kGgkxXuDuELjJbvpEezHjGDCR0=
Received: by 10.236.155.65 with SMTP id i41mr42556537yhk.124.1327044419121;
 Thu, 19 Jan 2012 23:26:59 -0800 (PST)
Received: by 10.146.151.11 with HTTP; Thu, 19 Jan 2012 23:26:59 -0800 (PST)
In-Reply-To: <7v7h0mhm8g.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188863>

On Thu, Jan 19, 2012 at 11:22 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> David Aguilar <davvid@gmail.com> writes:
>
>> + =C2=A0 =C2=A0if base_present; then
>> + =C2=A0 =C2=A0 checkout_staged_file 1 "$MERGED" "$BASE"
>> + =C2=A0 =C2=A0else
>> + =C2=A0 =C2=A0 :>"$BASE"
>
> Just a style, but please write this as either one of the following:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0>"$BASE"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0: >"$BASE"
>
> I tend to prefer the former, but if you have to write a command, we w=
ant
> to see a SP before the redirection (and no SP before the redirect tar=
get).
>
>> + =C2=A0 =C2=A0fi
>> =C2=A0 =C2=A0 =C2=A0local_present =C2=A0&& checkout_staged_file 2 "$=
MERGED" "$LOCAL"
>> =C2=A0 =C2=A0 =C2=A0remote_present && checkout_staged_file 3 "$MERGE=
D" "$REMOTE"
>
> Sorry to be ping-pong-ing like this, but wouldn't we have a similar i=
ssue
> when LOCAL or REMOTE does not exist (e.g. "they modified, we removed"=
)?

Yes.  I'll have a [PATCH v3] soon.
--=20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 David
