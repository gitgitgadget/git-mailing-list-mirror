From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH 4/4] clone: use --progress to force progress reporting
Date: Sun, 27 Dec 2009 11:22:22 +0800
Message-ID: <be6fef0d0912261922t230047b4v395fb2f6ce3ace4d@mail.gmail.com>
References: <1261761126-5784-1-git-send-email-rctay89@gmail.com>
	 <1261761126-5784-2-git-send-email-rctay89@gmail.com>
	 <1261761126-5784-3-git-send-email-rctay89@gmail.com>
	 <1261761126-5784-4-git-send-email-rctay89@gmail.com>
	 <1261761126-5784-5-git-send-email-rctay89@gmail.com>
	 <20091227012032.GE25474@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sun Dec 27 04:22:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NOjiF-0002NS-6w
	for gcvg-git-2@lo.gmane.org; Sun, 27 Dec 2009 04:22:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754235AbZL0DWX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Dec 2009 22:22:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754063AbZL0DWX
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Dec 2009 22:22:23 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:39480 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753933AbZL0DWW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Dec 2009 22:22:22 -0500
Received: by iwn1 with SMTP id 1so6748857iwn.33
        for <git@vger.kernel.org>; Sat, 26 Dec 2009 19:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=UY9DEV4ab7Xz5fSgswBB5ynkyK+y7wDoB9bsjcesVWI=;
        b=UW78NMuQjeltU0h1AiHSTxLZMPCqI50A1QXHPYrDEdheiqmzEnQrt5FnIXE5YMLgcL
         b5gsOLFSh52gPB1QPza0cNSwLjOqsVQpQXAQ08MXLFknfvANVGsZhAHe27t38StD3Dt0
         TcK7Y2gCbDoqo/hYjNP5ZFYPVJsM2p1PUTOYA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ZSSEWKGZSo+jw0rv5PfI0gB0lXPG0kbikU9Tk2gd8+rY218HevBksB9C1inxnIzXQj
         aO3R1iusJRy4as+/9dApThNPHqT/h2hlRKMPl9AwYGBneaMHofywEeaL8Ri5eO9wpTKM
         arn9MrrfM9lmGB/BzlPHEVZvs7Bba+NopK8v0=
Received: by 10.231.148.83 with SMTP id o19mr2439010ibv.39.1261884142140; Sat, 
	26 Dec 2009 19:22:22 -0800 (PST)
In-Reply-To: <20091227012032.GE25474@genesis.frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135699>

Hi,

On Sun, Dec 27, 2009 at 9:20 AM, Miklos Vajna <vmiklos@frugalware.org> =
wrote:
> On Sat, Dec 26, 2009 at 01:12:06AM +0800, Tay Ray Chuan <rctay89@gmai=
l.com> wrote:
>> -v/--verbose now does not force progress reporting. Make git-clone.t=
xt
>> say so.
>>
>> This should cover all the bases in 21188b1 (Implement git clone -v),
>> which implemented the option to force progress reporting.
>>
>> Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
>> ---
>> =A0Documentation/git-clone.txt | =A0 =A03 +++
>> =A0builtin-clone.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A08 ++++++--
>> =A0t/t5702-clone-options.sh =A0 =A0| =A0 =A03 ++-
>> =A03 files changed, 11 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.t=
xt
>> index e722e6c..f43c8b2 100644
>> --- a/Documentation/git-clone.txt
>> +++ b/Documentation/git-clone.txt
>> @@ -102,6 +102,9 @@ objects from the source repository into a pack i=
n the cloned repository.
>>
>> =A0--verbose::
>> =A0-v::
>> + =A0 =A0 Run verbosely.
>
> What about mentioning this "does not force progress reporting" behavi=
our
> in documentation of the "new" -v option?

Ok.

--=20
Cheers,
Ray Chuan
