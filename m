From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH v7 00/10] interactive git clean
Date: Mon, 13 May 2013 10:34:47 +0800
Message-ID: <CANYiYbFo+_048_1r1vmPzuRjibnrCuG19pCQg-UtXsBE2Cpyug@mail.gmail.com>
References: <cover.1368011946.git.worldhello.net@gmail.com>
	<CAPig+cR6aa+xODi=8DoiBpqQZM1eBHkGBvGzMGB2PSiT3osMEw@mail.gmail.com>
	<7vwqr9fo9b.fsf@alter.siamese.dyndns.org>
	<vpq8v3khzty.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Thomas Rast <trast@inf.ethz.ch>, Git List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon May 13 04:35:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbibN-0001Fc-3v
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 04:35:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753554Ab3EMCeu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 May 2013 22:34:50 -0400
Received: from mail-wg0-f43.google.com ([74.125.82.43]:59201 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752148Ab3EMCet (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 May 2013 22:34:49 -0400
Received: by mail-wg0-f43.google.com with SMTP id c11so5935045wgh.22
        for <git@vger.kernel.org>; Sun, 12 May 2013 19:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=s1B9z/S8sM9Uy10Pd7+yGkupXfLnVXbCQ65bZbw5SBI=;
        b=gC+bXpwTg+DeC2+DibJsW1d9BJwIW5VriX0poyx9vEjlcR88oPh6MKntmN2ZSXnDuc
         26vC1zHCVXjwkm/8cc5w3k2v+fKOEo6X98hsxmeUIvkHCM55v6bNQyZHqNybLn2AZtlp
         ddwJtLFSeTdpLBZ59SZW1n/qk4weGgs8StbsDHxEulM6LlSroBibc7uFrIn7zJJP48jP
         oA27yjhKwC3f8CyYkMbEEelntWICcqtSPMsfDAQ07Jzb1nO6WF6XRZYG7XtKKV5o3svF
         SfgBjdsWUJIdNVlx8U7WcJiM4WxSA5OxKgP7lLfRc5X12ezGeTLFYPRti9lKxXhmRGBv
         TC5Q==
X-Received: by 10.194.133.198 with SMTP id pe6mr36817459wjb.9.1368412487770;
 Sun, 12 May 2013 19:34:47 -0700 (PDT)
Received: by 10.194.175.72 with HTTP; Sun, 12 May 2013 19:34:47 -0700 (PDT)
In-Reply-To: <vpq8v3khzty.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224075>

2013/5/13 Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Cleaning all unneeded files inside a single interactive session
>> should *never* be the goal---that will lead to an over-engineered
>> design (e.g. switching "clean -x" flags in the middle? why?).  I
>> think Jiang's latest series is already way over-engineered,
>
> I didn't read the end of the series in detail, but I tend to agree with
> you. Maybe it's time to remember the YAGNI principle, and keep the
> number of options small at least for now (e.g. drop 11/12 git-clean: add
> toggle flags interactive action). When users (including us) will have
> used "git clean -i" for a while, we'll have a better idea of what is
> really needed.

My initial intention for flags toggle is for git newbies, who are not clear
about how to use -x/-d/-X/-ff options. I feel it may have values for these
people. But since most people feel it may bring trouble, I can withdraw
patch 9/12, 10/12, and 11/12.

Another improvement I want to hear your opinions. When the user execute
"git clean --interactive --dry-run", the current implement is ignore the
"--interactive" option, and do dry-run only. How about we combine them
together? First show the user the interactive interface, and when user
choose to clean, do cleaning in dry-run mode.

-- 
Jiang Xin
http://www.worldhello.net/
