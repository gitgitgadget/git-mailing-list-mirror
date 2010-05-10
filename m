From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH] Fix a false negative in t5512 when run using sh -x
Date: Mon, 10 May 2010 15:28:53 +0800
Message-ID: <AANLkTiloDJFtaQDEsL2ZquN1moAAeHr40YAEf1RCcR9f@mail.gmail.com>
References: <1273475946-2079-1-git-send-email-j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon May 10 09:29:05 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBNQG-0006Cj-LL
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 09:29:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753129Ab0EJH24 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 May 2010 03:28:56 -0400
Received: from mail-gx0-f217.google.com ([209.85.217.217]:51016 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750958Ab0EJH2z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 May 2010 03:28:55 -0400
Received: by gxk9 with SMTP id 9so2527150gxk.8
        for <git@vger.kernel.org>; Mon, 10 May 2010 00:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=mnE7ZjthQux300iPIsbPDaaf9yggPvdZgOZCil7/aZc=;
        b=VOpEWjsUuZB0fuq6uBhm18qam/tuBpHQl0cHpik3UewntuAKVKKgKoB6DedtkF33m5
         JDg7l/bmMpB4ijZ89d42vsFc4gL4Ss4wkNTJs56CxLXcQduipobPctG2gZcWRJ8B1nXH
         XTSUKKLySwsuUSaN57UpFCf9PVOGpVtrdFbfs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=MqYm5zt4CHaMJShwEQ3FialS2t1hC++NjBaw/LuNJaSyrgp3pT/L8tcfjgIc92Ji9x
         XJol8L4kbqISLqz0dRbC0S01FLb57sZhaWYL3aiAIgy1I37BUiYU9J3eWjrN94zlX7Zy
         73quL34DzWgQvK2QS5QXzRdLrEIZwvvi1W7NI=
Received: by 10.231.147.199 with SMTP id m7mr1339228ibv.87.1273476533371; Mon, 
	10 May 2010 00:28:53 -0700 (PDT)
Received: by 10.231.13.194 with HTTP; Mon, 10 May 2010 00:28:53 -0700 (PDT)
In-Reply-To: <1273475946-2079-1-git-send-email-j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146768>

On Mon, May 10, 2010 at 3:19 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> The test compares the stderr of a git command called with test_must_f=
ail
> to some expected output. With bash (and probably other shells as well=
)
> when run with -x turned on, command trace output ends up in the captu=
red
> output. Of course, the actual output does not match the expected outp=
ut
> anymore.
>
> Use 'grep' to check for expected output.
[snip]
> @@ -103,7 +99,7 @@ test_expect_success 'confuses pattern as remote wh=
en no remote specified' '
> =A0 =A0 =A0 =A0# We could just as easily have used "master"; the "*" =
emphasizes its
> =A0 =A0 =A0 =A0# role as a pattern.
> =A0 =A0 =A0 =A0test_must_fail git ls-remote refs*master >actual 2>&1 =
&&
> - =A0 =A0 =A0 test_cmp exp actual
> + =A0 =A0 =A0 grep "does not appear to be a git repository" actual
>
> =A0'

for the sake of cross-platform/shell, I think this trade-off is accepta=
ble.

  Acked-by: Tay Ray Chuan <rctay89@gmail.com>

--=20
Cheers,
Ray Chuan
