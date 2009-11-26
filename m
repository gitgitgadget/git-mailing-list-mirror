From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [PATCH 1/8] git-merge-file --ours, --theirs
Date: Thu, 26 Nov 2009 16:55:29 -0500
Message-ID: <32541b130911261355y2900b0cbtbf081c93c8fb10d6@mail.gmail.com>
References: <cover.1259201377.git.apenwarr@gmail.com> <d243a513ffb8da4272f7a0e13a711f9b65195c25.1259201377.git.apenwarr@gmail.com> 
	<7vy6ltdd2l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Nanako Shiraishi <nanako3@lavabit.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 26 22:55:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDmJe-00048G-Sr
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 22:55:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753058AbZKZVzn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Nov 2009 16:55:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753050AbZKZVzn
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 16:55:43 -0500
Received: from mail-yx0-f188.google.com ([209.85.210.188]:61020 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753046AbZKZVzm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Nov 2009 16:55:42 -0500
Received: by yxe26 with SMTP id 26so925662yxe.4
        for <git@vger.kernel.org>; Thu, 26 Nov 2009 13:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=O2uIaJDEGpG8w6ChQs0zQD7TQU5PfbqkmOtLlLf0CnI=;
        b=KcP0XZ2df+lfXyFOkZfsnWJSNXO0sXHn1Acf50Mfm2vUQeV2eQC5wQCscH4XOcDBLo
         BE9JGallXds/tXzsePnsfkiAkiB2n+AaoA/r6KtOFOp8hrmP2L5C/dhY8QOquaIUq8xp
         Qg4byqO9z2LwDL0jD+/OltWB8k/4N+ftPWUJs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=PWE62hQSz+Nmje7AVwSIHMd+bEwZ1PLwTdMfSlNW5Z8O2OmLMBxRThZCFKtZhJiGJa
         KZ7Wz4nhZmvJC5Bi058dY9O89PZoTjTeAeHmZuTG1kRzDGI+ey2D31KOsfLOg1qwPW8w
         XOSMd+mCWzfyuhf3XSNuz8lyrBvvDboaOBXP0=
Received: by 10.151.2.33 with SMTP id e33mr539660ybi.58.1259272549111; Thu, 26 
	Nov 2009 13:55:49 -0800 (PST)
In-Reply-To: <7vy6ltdd2l.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133839>

On Thu, Nov 26, 2009 at 1:17 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Except for parse-optification, this one is more or less a verbatim co=
py of
> my patch, and I think I probably deserve an in-body "From: " line for=
 this
> [PATCH 1/8], [PATCH 6/8] and [PATCH 8/8] to take the full authorship =
of
> them.
[...]
> Imagine that Avery were an area expert (the subsystem maintainer) on =
"git
> merge" and downwards, and somebody who did not know that "merge" has
> already been rewritten in C, nor some parts of the system have been
> rewritten to use parse-options, submitted a patch series for review a=
nd
> Avery is helping to polish it up [*1*].

I'm quite open to doing this however you want; I definitely consider
it your patch series.  My main measurable contribution is just the
unit tests that I wrote.

However, when thinking about this, I wasn't worried so much about the
correct placement of credit as of discredit.  The merge code has
changed sufficiently since you wrote this patch series that every one
of them required quite a lot of conflict resolution.  Most of the
conflicts were pretty obvious how to resolve, but it was tedious and
error prone, and there's a reasonably high probability that I screwed
up something while doing so.

I imagined what people would expect to see when they do 'git blame' to
explain the source of a problem.  If they see your name, you might be
blamed for my errors; if they see my name with a "based on a patch by
Junio" in the changelog, then I would be (probably correctly) blamed
for the errors, while you can retain credit for the success.

Mostly, however, I didn't want to be sending out patches in your name
that weren't actually done by you.  If you'd like me to do so,
however, then I will :)

>> +/* merge favor modes */
>> +#define XDL_MERGE_FAVOR_OURS 0x0010
>> +#define XDL_MERGE_FAVOR_THEIRS 0x0020
>> +#define XDL_MERGE_FAVOR(flags) (((flags)>>4) & 3)
>
> This is a bad change. =A0It forces the high-level layer of the result=
ing
> code to be aware that the favor bits are shifted by 4 and it is diffe=
rent
> from what the low-level layer expects. =A0If I were porting it to
> parse-options, I would have kept OURS =3D 1 and THEIRS =3D 2 as the o=
riginal
> patch, [...]

Ouch, yes, that wasn't very clear thinking on my part.  I meant for
XDL_MERGE_FAVOR(flags) to return either XDL_MERGE_FAVOR_OURS or
XDL_MERGE_FAVOR_THEIRS, but clearly it doesn't.  Will fix.

Avery
