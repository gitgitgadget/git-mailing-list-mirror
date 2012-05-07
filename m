From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH 4/4] allow recovery from command name typos
Date: Mon, 7 May 2012 23:49:25 +0800
Message-ID: <CALUzUxren063JA8NfDNWKXxf4=4jRDftpTHB76-1fFD-900XAw@mail.gmail.com>
References: <1336287330-7215-1-git-send-email-rctay89@gmail.com>
	<1336287330-7215-2-git-send-email-rctay89@gmail.com>
	<1336287330-7215-3-git-send-email-rctay89@gmail.com>
	<1336287330-7215-4-git-send-email-rctay89@gmail.com>
	<1336287330-7215-5-git-send-email-rctay89@gmail.com>
	<20120506082130.GB27878@sigill.intra.peff.net>
	<CALUzUxqXrsB8XfQL6vOiQo1pLHNRjxRUxJLRiK_mcSU8fvTSCg@mail.gmail.com>
	<878vh4con4.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon May 07 17:49:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRQBo-0001N5-3a
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 17:49:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756786Ab2EGPt1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 May 2012 11:49:27 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:40458 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756590Ab2EGPt0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 May 2012 11:49:26 -0400
Received: by werb10 with SMTP id b10so1325180wer.19
        for <git@vger.kernel.org>; Mon, 07 May 2012 08:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=hvpapdFJ4v1qcKHZ47WjCbp2V+8gKiFp+7B5F4MwrdM=;
        b=dl/F79u8XtTFmyV8UbS3WuWKORnQFEFnfMz4MX0pLM8d5uu1oR6LEPn2O4KdsgA1co
         M9hvqKvEHVOdlZkERkxGPpo8mGHhOcAe3oRcKfygb4AyFr5BqhNTS+a5CDP0KFnTe6Du
         5ay/GF4WFm+RcWxzyNG31zNkgeMS32Bp9O2QF+mQNX4qe2v3qq+piB552ylKqogfBex9
         OjK9FEkc/TkIe07dBNwsixjq/QuIawf12TZr19EqlTASMQr6SD2HXFxU0p+m50Yarcpl
         QRXTQv/fkqX1NLdyzrYT/oGup90V8FDBBjyIbwWywt4GLOPl0dnNe40+2OqtwLqL6wTA
         9R/g==
Received: by 10.216.214.82 with SMTP id b60mr820484wep.38.1336405765550; Mon,
 07 May 2012 08:49:25 -0700 (PDT)
Received: by 10.223.156.136 with HTTP; Mon, 7 May 2012 08:49:25 -0700 (PDT)
In-Reply-To: <878vh4con4.fsf@thomas.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197280>

On Mon, May 7, 2012 at 5:43 PM, Thomas Rast <trast@student.ethz.ch> wro=
te:
> Tay Ray Chuan <rctay89@gmail.com> writes:
>
>> On Sun, May 6, 2012 at 4:21 PM, Jeff King <peff@peff.net> wrote:
>>> On Sun, May 06, 2012 at 02:55:30PM +0800, Tay Ray Chuan wrote:
>>>
>>>> =A0 $ git sh --pretty=3Doneline
>>>> =A0 git: 'sh' is not a git command. See 'git --help'.
>>>>
>>>> =A0 Did you mean one of these?
>>>> =A0 1: =A0show
>>>> =A0 2: =A0push
>>>> =A0 [1/2/.../n] 1
>>>
>>> Ugh. Please protect this with a config variable that defaults to
>>> "off". =A0It is very un-Unix to prompt unexpectedly, and I suspect =
a lot
>>> of people would be annoyed by this behavior changing by default (I =
know
>>> I would be).
>>>
>>> -Peff
>>
>> While I agree there should be a config to protect this, I was hoping
>> this would be useful to users on the terminal who make the occasiona=
l
>> slip-up, without having to do any prior configuration.
>
> We already have help.autocorrect. =A0It defaults to 0, which results =
in
>
> =A0$ g rebest
> =A0git: 'rebest' is not a git command. See 'git --help'.
>
> =A0Did you mean one of these?
> =A0 =A0 =A0 =A0 =A0rebase
> =A0 =A0 =A0 =A0 =A0reset
> =A0 =A0 =A0 =A0 =A0revert
>
> But it can also be a timeout in deciseconds, after which the match is
> automatically executed (if there is only one). =A0You could hijack it=
 by
>
> * making 'ask' mean your new feature
>
> * making 'off' etc. be the same as 0 for sanity
>
> * making the default value be like 0, but with an extra message such =
as
>
> =A0 =A0Use 'git config --global help.autocorrect ask' to let me promp=
t for
> =A0 =A0the correct command.
>
> =A0though I'm sure you can improve on the wording.

Thomas, that's a brilliant idea.

Re-roll coming up.

--=20
Cheers,
Ray Chuan
