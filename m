From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH] t9824: fix broken &&-chain in a subshell
Date: Sun, 24 Apr 2016 18:50:50 +0200
Message-ID: <06ED366B-E957-4908-A5A9-E59838F3666A@gmail.com>
References: <1461096530-82448-1-git-send-email-larsxschneider@gmail.com> <1461498621-25422-1-git-send-email-szeder@ira.uka.de> <78046710-31FD-43D8-820E-95D56564C3F5@gmail.com> <20160424183729.Horde.yxK_t3vqDHiCc6kvoXJqwst@webmail.informatik.kit.edu>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?iso-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sun Apr 24 18:50:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auNFL-0002qL-0O
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 18:50:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752942AbcDXQuz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Apr 2016 12:50:55 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:36831 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752911AbcDXQuy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Apr 2016 12:50:54 -0400
Received: by mail-wm0-f54.google.com with SMTP id v188so72814125wme.1
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 09:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ONBkHY+NGWPN6FbFL5rrbly5c9drCvAYt0/lZnlqvnQ=;
        b=StYSKqpt0nzHpVIs6D2EusLTqutFu9hQ6+v9gUWpffIpMHFLayslR+ycdTIb7lhYkb
         ksLZzy76psBH+ojUM11tzCV5i44RNGLOb5N0IJM75lX6hZ9MmtyvcR3EGhQgx9okn27Q
         9lmzZUHSvaNJ+AkZg2og1+tLpDye+Y7Ud4eaYRZ2GVlrsdRmwKxjaBvDgbBNhWPrwt7y
         t0bIOkHbZmdTKiLXoD9/rW3Prer8kX7DGYiAQo48nam+CWB+Urxx3Wx40JxOtkLvc6o6
         w1FJXJ1di//vCZRruIZxCQz/Nl/hUabrjo8EQW6QdwlkkhXX2qq0CC8hKYUJdWsG4n9C
         tyzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ONBkHY+NGWPN6FbFL5rrbly5c9drCvAYt0/lZnlqvnQ=;
        b=Rp07kEz+JBoraYmF6Nr6W9QBn9iUqWK3QDEBRJI5SQK6AHLvrhaXvQ3q//B1qnyCAg
         sb/qUOGysKa3e//lbeDd4y8BmzsHlmPLn4mVsMvHXo6JjFuQdD5NG7mXUCq/7uoQgfyX
         /eSntf4GOCPtJ/aHsAQ9XR7pLJ5TTlO00koNplIWwnkmUyUXmU+HWNjW3dVceypsD/fu
         IES72u36OnjgpZhf1/cvvujfhQQQCwBz2pR1+N9IzBuhvKvN9jpzqsmDWlsOtfrZ4lhQ
         6V+f50dpFMOtmsDMsr+TjuZ0TL/jVduxlFtczF9noBccA5rqPBQqRFmqlSIQHx6SQvxy
         G0JQ==
X-Gm-Message-State: AOPr4FVdjdn1gmP5FBlqRn08te4CLK4lYRYQ40JixEul0DkyhapgePh6aqkYtnjK4AjV5w==
X-Received: by 10.28.211.136 with SMTP id k130mr7483718wmg.81.1461516653474;
        Sun, 24 Apr 2016 09:50:53 -0700 (PDT)
Received: from slxbook3.fritz.box (p508BA7B8.dip0.t-ipconnect.de. [80.139.167.184])
        by smtp.gmail.com with ESMTPSA id 186sm14559466wmk.2.2016.04.24.09.50.51
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 09:50:52 -0700 (PDT)
In-Reply-To: <20160424183729.Horde.yxK_t3vqDHiCc6kvoXJqwst@webmail.informatik.kit.edu>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292420>


On 24 Apr 2016, at 18:37, SZEDER G=E1bor <szeder@ira.uka.de> wrote:

>=20
> Quoting Lars Schneider <larsxschneider@gmail.com>:
>=20
>> On 24 Apr 2016, at 13:50, SZEDER G=E1bor <szeder@ira.uka.de> wrote:
>>=20
>>> Signed-off-by: SZEDER G=E1bor <szeder@ira.uka.de>
>>> ---
>>>=20
>>> As far as I can tell after eyeballing the test script, this was the
>>> only case where the &&-chain was broken.
>>>=20
>>> t/t9824-git-p4-git-lfs.sh | 2 +-
>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>=20
>>> diff --git a/t/t9824-git-p4-git-lfs.sh b/t/t9824-git-p4-git-lfs.sh
>>> index 0b664a377c45..64f8d18216d4 100755
>>> --- a/t/t9824-git-p4-git-lfs.sh
>>> +++ b/t/t9824-git-p4-git-lfs.sh
>>> @@ -265,7 +265,7 @@ test_expect_success 'Add big files to repo and
>>> store files in LFS based on compr
>>> 		# We only import HEAD here ("@all" is missing!)
>>> 		git p4 clone --destination=3D"$git" //depot &&
>>>=20
>>> -		test_file_in_lfs file6.bin 13 "content 6 bin 39 bytes XXXXXYYYYY=
ZZZZZ"
>>> +		test_file_in_lfs file6.bin 13 "content 6 bin 39 bytes XXXXXYYYYY=
ZZZZZ" &&
>> Thanks! I believe I remember some script/flag to detect broken &&-ch=
ains.
>> Do I imagine that or can anyone point me to it?
>=20
> It was introduced in bb79af9d0970 (t/test-lib: introduce --chain-lint
> option, 2015-03-20) and is enabled by default.  Unfortunately, it
> can't "see" inside subshells, that's why it couldn't detect this case=
=2E

That explains it. Thank you!

- Lars
