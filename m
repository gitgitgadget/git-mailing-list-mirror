From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH 4/4] allow recovery from command name typos
Date: Mon, 7 May 2012 00:07:08 +0800
Message-ID: <CALUzUxqXrsB8XfQL6vOiQo1pLHNRjxRUxJLRiK_mcSU8fvTSCg@mail.gmail.com>
References: <1336287330-7215-1-git-send-email-rctay89@gmail.com>
	<1336287330-7215-2-git-send-email-rctay89@gmail.com>
	<1336287330-7215-3-git-send-email-rctay89@gmail.com>
	<1336287330-7215-4-git-send-email-rctay89@gmail.com>
	<1336287330-7215-5-git-send-email-rctay89@gmail.com>
	<20120506082130.GB27878@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun May 06 18:07:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SR3zR-000468-Qe
	for gcvg-git-2@plane.gmane.org; Sun, 06 May 2012 18:07:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753926Ab2EFQHK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 May 2012 12:07:10 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:62091 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753864Ab2EFQHJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 May 2012 12:07:09 -0400
Received: by wibhj6 with SMTP id hj6so2746825wib.1
        for <git@vger.kernel.org>; Sun, 06 May 2012 09:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=lZB9hJagGGCGj+8+xNp0J1anUQiKx18gRPBHl1hVxGw=;
        b=a2lvWXvZrY2dTh2Ept3WTfz9tnF/xgN7U4DRPiOvzbPGxfathH0Dtqt8JeiuWv2kfp
         yY8Bl724q/GnIV4NGpeAQgMSLyCGZabGLnFUFpB6Ln88KawCEcvMJCAUMygWBhyNYdJY
         jheCJH6J2o18H5g+GGdZxHrOEkxAtEBGaK84dDzclAh10yCdKLpb9x6AkzsICA8Z6P/x
         +3fkVFeVAy1pbHkdj7zheYhru2I4t9iezryLas9D/cjOtfDupW88cOis4hKjtH2EZzdl
         7JZ766RhaMWIfTxRRCjRQr7KFXFv1VPQdhsNzqDculjITVtlRQts7uFcAIL+5HDQCwpu
         7K1w==
Received: by 10.216.45.207 with SMTP id p57mr5393537web.38.1336320428495; Sun,
 06 May 2012 09:07:08 -0700 (PDT)
Received: by 10.223.156.136 with HTTP; Sun, 6 May 2012 09:07:08 -0700 (PDT)
In-Reply-To: <20120506082130.GB27878@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197201>

On Sun, May 6, 2012 at 4:21 PM, Jeff King <peff@peff.net> wrote:
> On Sun, May 06, 2012 at 02:55:30PM +0800, Tay Ray Chuan wrote:
>
>> If suggestions are available (based on Levenshtein distance) and if =
the
>> terminal isatty(), present a prompt to the user to select one of the
>> computed suggestions.
>>
>> In the case where there is a single suggestion, present the prompt
>> "[Y/n]", such that "", "y" and "Y" as input leads git to proceed
>> executing the suggestion, while everything else (possibly "n") leads=
 git
>> to terminate.
>>
>> In the case where there are multiple suggestions, number the suggest=
ions
>> 1 to n, and accept as input one of the numbers, while everything els=
e
>> (possibly "n") leads git to terminate. In this case there is no defa=
ult;
>> that is, an empty input leads git to terminate. A sample run:
>>
>> =A0 $ git sh --pretty=3Doneline
>> =A0 git: 'sh' is not a git command. See 'git --help'.
>>
>> =A0 Did you mean one of these?
>> =A0 1: =A0show
>> =A0 2: =A0push
>> =A0 [1/2/.../n] 1
>
> Ugh. Please protect this with a config variable that defaults to
> "off". =A0It is very un-Unix to prompt unexpectedly, and I suspect a =
lot
> of people would be annoyed by this behavior changing by default (I kn=
ow
> I would be).
>
> -Peff

While I agree there should be a config to protect this, I was hoping
this would be useful to users on the terminal who make the occasional
slip-up, without having to do any prior configuration.

--=20
Cheers,
Ray Chuan
