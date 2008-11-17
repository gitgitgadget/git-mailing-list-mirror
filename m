From: "Mike Ralphson" <mike.ralphson@gmail.com>
Subject: Re: [PATCH] Makefile: introduce NO_PTHREADS
Date: Mon, 17 Nov 2008 10:45:28 +0000
Message-ID: <e2b179460811170245t1845cc66h7cb2a18c43a79359@mail.gmail.com>
References: <200811121029.34841.thomas@koch.ro>
	 <371xaQfxsMMQ-9LK24q-nhcS4loEggn8Cj3J1IzfMbzzYDGE6HKbQQ@cipher.nrlssc.navy.mil>
	 <alpine.LFD.2.00.0811131630470.3468@nehalem.linux-foundation.org>
	 <alpine.LFD.2.00.0811131707090.3468@nehalem.linux-foundation.org>
	 <vzAozXmaOLEpyz-7DHx4nMusAdaTsFp7iZ8xfFsgAIraex6_wfvyuw@cipher.nrlssc.navy.mil>
	 <alpine.LFD.2.00.0811141109580.3468@nehalem.linux-foundation.org>
	 <7vtza95h01.fsf@gitster.siamese.dyndns.org>
	 <alpine.LFD.2.00.0811150915240.3468@nehalem.linux-foundation.org>
	 <e2b179460811170203v41e54ecclc3d6526bcc0fe928@mail.gmail.com>
	 <492148AD.1090604@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Linus Torvalds" <torvalds@linux-foundation.org>
To: "Johannes Sixt" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Nov 17 11:46:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L21cz-00012d-4r
	for gcvg-git-2@gmane.org; Mon, 17 Nov 2008 11:46:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752817AbYKQKpa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2008 05:45:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752290AbYKQKpa
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Nov 2008 05:45:30 -0500
Received: from qw-out-2122.google.com ([74.125.92.24]:50335 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751945AbYKQKp3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2008 05:45:29 -0500
Received: by qw-out-2122.google.com with SMTP id 3so1158179qwe.37
        for <git@vger.kernel.org>; Mon, 17 Nov 2008 02:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=49HRoSKuUPAs3v17cs8tYrM7mYZ+3eIr8Mzi6aIiWk4=;
        b=Fc6f1MQomzeO+XaBlclNTw6UeDEFfFgQCmxJJIt/MAY8Zr19MRiqQU+KzRbBrPPmUu
         RM0uuEBydLlGUG/xfvxpPn1fSgS2EXi8bPB1r2zHuDl9Ey0WWoA7jQDtPf50FEll7O3S
         dEGmV+9R7sy8bpf3U+6vxQzr2AwPyScFUoIFU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=NtoHd/k/CFrUbo6hW7d8kSSXh/786eHOfRy9putYTY15nFfFMMdLKpIq1ttIkN6zJG
         A+zY3sbyD7asbt61nZvubKbf9YXlWhklvIVapxOuzt+FgpYs1sSoLkFA8GZ2BFrV7Lz5
         WUieJGWv3C2N2nep0WrX3a1ZWvtKWSNEo9Fyg=
Received: by 10.214.184.8 with SMTP id h8mr2258859qaf.313.1226918728125;
        Mon, 17 Nov 2008 02:45:28 -0800 (PST)
Received: by 10.214.81.4 with HTTP; Mon, 17 Nov 2008 02:45:28 -0800 (PST)
In-Reply-To: <492148AD.1090604@viscovery.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101214>

2008/11/17 Johannes Sixt <j.sixt@viscovery.net>:
> Mike Ralphson schrieb:
>> 2008/11/15 Linus Torvalds <torvalds@linux-foundation.org>:
>>> On Sat, 15 Nov 2008, Junio C Hamano wrote:
>>>> This introduces make variable NO_PTHREADS for platforms that lack the
>>>> support for pthreads library or people who do not want to use it for
>>>> whatever reason.  When defined, it makes the multi-threaded index
>>>> preloading into a no-op, and also disables threaded delta searching by
>>>> pack-objects.
>>> Ack. Makes sense.
>>
>> I'd be minded to make this the default on AIX to keep the prerequisite
>> list as small as possible, then people can opt-in for the performance
>> benefits if required.
>
> Is pthreads not a standard shipment on AIX? I would set NO_PTHREADS only
> if we know in advance that there are many installations without pthreads.
> (And I don't know what the situation is.)

I should have dug a bit further, it seems to be present on my 5.3
machines but I still need to determine whether it got installed by
default. Either way it must need some other link flags...

> BTW, this needs to be squashed in, because we don't have pthreads on Windows:
>
> diff --git a/Makefile b/Makefile
> index ffc9531..3a30b8c 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -769,6 +769,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
>        NO_STRCASESTR = YesPlease
>        NO_STRLCPY = YesPlease
>        NO_MEMMEM = YesPlease
> +       NO_PTHREADS = YesPlease
>        NEEDS_LIBICONV = YesPlease
>        OLD_ICONV = YesPlease
>        NO_C99_FORMAT = YesPlease
>

Ta. Ok to add your S-o-B on a squashed patch?

Mike
