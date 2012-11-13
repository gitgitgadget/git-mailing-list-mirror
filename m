From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Launch separate program for HTTPS prompt
Date: Tue, 13 Nov 2012 16:07:25 +0100
Message-ID: <CABPQNSbpnmhmaCc8kzKn2+c_MACotOx5SxmaRMzPbnW=hiP7XA@mail.gmail.com>
References: <CAHtLG6QY-PYUKbNUicox_Ayh70bUSJOL7LGZrQQMqgbVBDmEiA@mail.gmail.com>
 <vpq6261nt0x.fsf@grenoble-inp.fr> <CABPQNSYav4K208a1VVP6rK6LhXBo+nkx-DcG4zUsiufnCJkY5g@mail.gmail.com>
 <CAHtLG6Q2LANj8WPMsRzpzKZ=zPbLysSFWs0pxSPNj1j87d_LRw@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=Big5
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: GIT Mailing-list <git@vger.kernel.org>
To: =?UTF-8?B?5LmZ6YW46Yuw?= <ch3cooli@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 16:08:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYI6A-0006Mw-2A
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 16:08:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752389Ab2KMPIH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Nov 2012 10:08:07 -0500
Received: from mail-vc0-f174.google.com ([209.85.220.174]:39639 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751434Ab2KMPIG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Nov 2012 10:08:06 -0500
Received: by mail-vc0-f174.google.com with SMTP id fk26so7434723vcb.19
        for <git@vger.kernel.org>; Tue, 13 Nov 2012 07:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=O1eqgX+bzzpKpW10MBlDopqG9qI6ouyBG564lwladE8=;
        b=A+mb3seZ3zs7cA4jadCTCjzXYUhUAIQOxEhkx34H76ugA/t8WI77Wx1I6GXOKWeb14
         FNN9KzSninQp0+ghz+Oc6QBKi435aTm5r6P+5X0xdjydBpzcUN7aLQ5GySg9uJFw4pDn
         YjE3C1VFxnjcEWNDXMvUEEYW36/7BNWmsV8rV7rZtB90feJDyO+3qpJ9VQHSo65pMP2t
         m3a+0/rOEch7rSF3K0t3G2M5qkhCMmqUAXkPZSUBQDRZRGAtRd8CesXa/cFoBhUPwkCo
         PCzf/2xwc8pvMlXRn6K6YhAF8J5ebvD/eRTDcdiBZ/U7DQnEd5Kl4W0w0zEnCNgClAJJ
         sdQQ==
Received: by 10.220.150.145 with SMTP id y17mr6201250vcv.11.1352819285514;
 Tue, 13 Nov 2012 07:08:05 -0800 (PST)
Received: by 10.58.169.106 with HTTP; Tue, 13 Nov 2012 07:07:25 -0800 (PST)
In-Reply-To: <CAHtLG6Q2LANj8WPMsRzpzKZ=zPbLysSFWs0pxSPNj1j87d_LRw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209613>

Please don't cull the CC list or top-post. Other people might be
interested, and quoting inline will make it easier to understand what
you're replying to in that case. I've restored the CC-list and fixed
the quoting for you this time.

On Tue, Nov 13, 2012 at 3:58 PM, =A4A=BB=C4=BEY <ch3cooli@gmail.com> wr=
ote:
> 2012/11/13 Erik Faye-Lund <kusmabite@gmail.com>:
>> On Tue, Oct 23, 2012 at 4:48 PM, Matthieu Moy
>> <Matthieu.Moy@grenoble-inp.fr> wrote:
>>> =A4A=BB=C4=BEY <ch3cooli@gmail.com> writes:
>>>
>>>> Hi,
>>>>
>>>> Could you launch a separate program for HTTPS prompt like SSH_ASKP=
ASS?
>>>> This allows GUI programs to answer the trust or not, not via stdin=
=2E
>>>
>>> Read about credential helpers, this is what they are meant for, and=
 they
>>> do launch separate programs.
>>>
>>
>> The prompting-support for credential helpers didn't survive the
>> inclusion; instead we have git_prompt() that consults GIT_ASKPASS an=
d
>> SSH_ASKPASS or falls back to git_terminal_prompt().
>
> Sorry, I don't understand what you mean.
>
> But I am asking for a solution of for HTTPS prompt which is similar t=
o
> the credential part.

Quote from Documentation/technical/api-credentials.txt:

"Credential helpers are programs executed by git to fetch or save
credentials from and to long-term storage (where "long-term" is simply
longer than a single git process; e.g., credentials may be stored
in-memory for a few minutes, or indefinitely on disk)."

In other words, credential helpers are not intended for prompting the
user for a username/password pair. Prompting was included in the first
credential-helper proposal, but it didn't survive into the inclusion.
But you can override credential queries by setting GIT_ASKPASS or
SSH_ASKPASS.

I don't know if the credential-system works or not when using
HTTP/HTTPS, it might be that cURL is the one that does the
credential-negotiating in that case. But that's not really related to
credential-helpers; it affects the whole credential-system.
