From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] send-email: add series-cc-cmd option
Date: Tue, 13 Nov 2012 02:01:59 +0100
Message-ID: <CAMP44s1gF7scb2RtZ9V9cz58y8KQuQfRk_4wsCML1JyheScP=g@mail.gmail.com>
References: <1352653463-1923-1-git-send-email-felipe.contreras@gmail.com>
	<1352653463-1923-3-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0mRKznNN7750h=k6aE3OJ7hBLVC-G51gEYi2+NuYjPWrQ@mail.gmail.com>
	<1352760759.18715.7.camel@joe-AO722>
	<7vd2zigwx6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Joe Perches <joe@perches.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Pascal Obry <pascal@obry.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 02:02:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TY4tL-0001Ss-Js
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 02:02:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753943Ab2KMBCA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2012 20:02:00 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:46360 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753914Ab2KMBB7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2012 20:01:59 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so6908705oag.19
        for <git@vger.kernel.org>; Mon, 12 Nov 2012 17:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=YeXOI3cSWNSwehdEPKnNBxhu0KkjRRWGpVtH38hPqRM=;
        b=dB/YvIKlqEJNcgyq6u4EHYCEOXzCCpDmruLCOBCYvZSnASQRyDpirvcGkHY971FU7m
         1V6o5ZUcPEyhQW/pR/SWGZhVJcI36jZbUmAvPIaF7CifcOTm8MS2lxJKMzlhIARdmBuS
         iEIVKoBYfNxJH27Jn/PJwnv3Q4OWf0Qg7eApjugqL0qbJeUl7qxqHZC22wTrwm5KoNM9
         q7s2RdJoX4dMW+4PcFvKJcvqCpJri1tM9cJSh7h/XQ4jvFMBgb0ox0t13pBkrc+zJqNu
         ll2XDPwUQpeNEH2lrkFsrBp+NMt1Hw+wqJSmA5Y6g3WRL0w3ODxoHttsu/ZMVIVAe6a1
         zlYQ==
Received: by 10.182.52.105 with SMTP id s9mr16797168obo.25.1352768519370; Mon,
 12 Nov 2012 17:01:59 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Mon, 12 Nov 2012 17:01:59 -0800 (PST)
In-Reply-To: <7vd2zigwx6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209557>

On Tue, Nov 13, 2012 at 1:37 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Joe Perches <joe@perches.com> writes:
>
>> On Tue, 2012-11-13 at 03:21 +0530, Ramkumar Ramachandra wrote:
>>> Felipe Contreras wrote:
>>> > cc-cmd is only per-file, and many times receipients get lost without
>>> > seing the full patch series.
>>>
>>> s/seing/seeing
>>>
>>> > [...]
>>>
>>> Looks good otherwise.
>>
>> s/receipients/recipients/ too
>>
>> Practically this is ok but I think it's unnecessary.
>>
>> Output from git format-patch is always in a single
>> directory.
>
> Sorry, but I do not see how the usefulness (or necessity) of this
> new option is connected to the fact that you can tell the command to
> write the patches into a single (possibly new) directory.  Care to
> explain?

Basically 'git send-email' would do something like this:
git format-patch -10 -o /tmp
for x in /tmp/*; do cc_cmd $x; done

And the cc-cmd would do something like:
cc_cmd() { do_stuff_with $(dirname $1)/*.patch }

-- 
Felipe Contreras
