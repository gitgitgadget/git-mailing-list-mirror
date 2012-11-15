From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] Add tcsh-completion support to contrib by using git-completion.bash
Date: Thu, 15 Nov 2012 03:40:17 +0100
Message-ID: <CAMP44s2Nsxu9CsTxAXiSamjA5SqxwB2qWx72vu8Mit1ruLMWJg@mail.gmail.com>
References: <CAFj1UpE6OtJEojaED1_DZJD0kU=nVsFE_w8xa0oJE-6auCU2rw@mail.gmail.com>
	<CAFj1UpFd9X8Jq5o7B4m35i=merBDvOo4NOtwth=UnG2S5X_rGw@mail.gmail.com>
	<CAMP44s3imos4DksroRkZ3K6una5H916gvtqttJQna8yGG8XhsQ@mail.gmail.com>
	<20121114001159.GA14631@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Marc Khouzam <marc.khouzam@gmail.com>, git@vger.kernel.org
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu Nov 15 03:41:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYpON-0002kn-SI
	for gcvg-git-2@plane.gmane.org; Thu, 15 Nov 2012 03:41:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992510Ab2KOCkT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Nov 2012 21:40:19 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:42818 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992461Ab2KOCkS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Nov 2012 21:40:18 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so1218854oag.19
        for <git@vger.kernel.org>; Wed, 14 Nov 2012 18:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=7BG39Bcq52VttqidbIYP24oASLV8rPRMyezfRZSduJY=;
        b=jbmUn+XItoi4wBBKX7mU1DqjwgRlL1w0MqtxQK+8YAhnYUvjNfxfwliMYtTuvVdSgF
         R1U3NSC4zsQfdbpcAqh8jCqL029MZCH9c3j4v2RzdIxqT+O/xpapKDXHCm4560qGkjkV
         l99PEABzN3SL5jTBXi2sCRTR1X/T09+7QeEblpxyIYdelEZQRkJWFdoQaSfle81UdZBd
         ETA5tg6N0y+fRHa8bEo9q73UggXemUzeKFw/z/IsQvbsxDd/4nahitsSymqfUeOifyi+
         a88jYX072VZWRpkwNPC3fwUQYaN+LyUU0LzxSLyLZO20SfKQz5gUG2xbvkghKr0SLQhM
         PTPg==
Received: by 10.60.31.241 with SMTP id d17mr21929014oei.107.1352947217659;
 Wed, 14 Nov 2012 18:40:17 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Wed, 14 Nov 2012 18:40:17 -0800 (PST)
In-Reply-To: <20121114001159.GA14631@goldbirke>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209793>

On Wed, Nov 14, 2012 at 1:11 AM, SZEDER G=C3=A1bor <szeder@ira.uka.de> =
wrote:
> On Tue, Nov 13, 2012 at 07:31:45PM +0100, Felipe Contreras wrote:
>> On Mon, Nov 12, 2012 at 9:07 PM, Marc Khouzam <marc.khouzam@gmail.co=
m> wrote:
>> > +       # Call _git() or _gitk() of the bash script, based on the =
first
>> > +       # element of the command-line
>> > +       _${COMP_WORDS[0]}
>>
>> You might want to use __${COMP_WORDS[0]}_main instead.
>
> That wouldn't work.  __git_main() doesn't set up the
> command-line-specific variables, but the wrapper around it does.

Yeah, but you can set those command-line-specific variables manually,
like the zsh completion wrapper does.

The problem with the _git wrapper is that it will call the
bash-specific complete command.

>> > +# Make the script executable if it is not
>> > +if ( ! -x ${__git_tcsh_completion_script} ) then
>> > +       chmod u+x ${__git_tcsh_completion_script}
>> > +endif
>>
>> Why not just source it?
>
> The goal is to re-use a Bash script to do completion in tcsh.  They
> are two different breeds, tcsh doesn't grok bash.  So sourcing the
> completion script is not an option, but we can still run it via Bash
> and use it's results.

I see, but the tcsh script can do something like this:

bash <<\EOF
echo $BASH
\EOF

Cheers.

--=20
=46elipe Contreras
