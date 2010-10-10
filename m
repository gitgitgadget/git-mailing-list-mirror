From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v3 12/14] mingw: import poll-emulation from gnulib
Date: Sun, 10 Oct 2010 21:34:15 +0200
Message-ID: <AANLkTimxFm+hgJBM2B+Eui6+fStM1JSfkyMsKRoqCXd-@mail.gmail.com>
References: <1286716854-5744-1-git-send-email-kusmabite@gmail.com>
 <1286716854-5744-13-git-send-email-kusmabite@gmail.com> <AANLkTim1BZR89M22tAkT0qtfk70QeN0QuyKi5Q2KQQKR@mail.gmail.com>
 <AANLkTikR4FMK31oJP24B+9QxLypSbO7PL8G5vEtUp=my@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, msysgit@googlegroups.com, j6t@kdbg.org
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 10 21:34:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P51fR-0006CT-IX
	for gcvg-git-2@lo.gmane.org; Sun, 10 Oct 2010 21:34:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750927Ab0JJTei convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Oct 2010 15:34:38 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:62523 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750823Ab0JJTeh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Oct 2010 15:34:37 -0400
Received: by vws2 with SMTP id 2so552279vws.19
        for <git@vger.kernel.org>; Sun, 10 Oct 2010 12:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=F7d5eAiXPVIP4NNPEZ33eAERT4szuW4zWLTsl+1Cus4=;
        b=vTOTe/GiPSlZDhLBQjMLcndqrawvuceiRhx6vP2XxlpiaX5FkkTah6ZD44NLmMvzZQ
         gFTO5XEKQhV0qtRWa0PE67EpOih8zmEW7XI5rcPEPLNPbJ2/sFfcOj/BwreD1Anws0/7
         MYAFysU8eualMhUu1YYrz4SH/ctB0r13QAzM8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=uGwMgQUCE9nBms2PgJnsA1iYxhcTzXgYqbE7qoSjl+F3MYe9+oiaStm5O6ZvRbGwVT
         NebQQT8p5DR24dBejbIM/buXumZ2jAI/jVmOYzOPgroobDiyQDMQTLPLGR2KLyr3rytR
         zjtVj33ZTyBP8tJKZvdYQ9vQu0l/jM9Sasdc8=
Received: by 10.220.181.133 with SMTP id by5mr1645108vcb.182.1286739275652;
 Sun, 10 Oct 2010 12:34:35 -0700 (PDT)
Received: by 10.220.45.196 with HTTP; Sun, 10 Oct 2010 12:34:15 -0700 (PDT)
In-Reply-To: <AANLkTikR4FMK31oJP24B+9QxLypSbO7PL8G5vEtUp=my@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158688>

On Sun, Oct 10, 2010 at 4:28 PM, Erik Faye-Lund <kusmabite@gmail.com> w=
rote:
> On Sun, Oct 10, 2010 at 4:15 PM, =C6var Arnfj=F6r=F0 Bjarmason
> <avarab@gmail.com> wrote:
>> On Sun, Oct 10, 2010 at 13:20, Erik Faye-Lund <kusmabite@gmail.com> =
wrote:
>>> lib/poll.c and lib/poll.in.h imported from 0a05120 in
>>> git://git.savannah.gnu.org/gnulib.git
>>
>> Having fought with importing things from gnulib myself using their
>> tools it would be useful to note in the commit message *how* you
>> imported this. Did you use the gnulib command with some archane
>> options so it wouldn't touch the build system while it was at it, or
>> did you just copy the relevant files manually?
>>
>
> Sorry if that was unclear - I just copied the files (verbatim).
> Patching to make it compile for us comes in the next patch.
>
> I didn't even know that there was a gnulib tool to extract code, but =
a
> quick google-search shows that there is. I'll look into using the too=
l
> instead for the next round.
>

I've had a quick look at it, and it really doesn't seem like
gnulib-tool is suited for us here. It seems to be intended on pure
autoconf-projects, and starts including all kinds of things that we
don't need. We only care about poll-emulation on Windows, and we don't
need autoconf to tell us if it should be used or not.

So I'm not in favor of using gnulib-tool, and going with the current
method of verbatim copy with a separate fix-up commit. But perhaps I
should clarify the commit message so other people can easily upgrade
the emulation later...
