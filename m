From: Felipe Tanus <fotanus@gmail.com>
Subject: Re: [GSoC] Improving parallelism
Date: Wed, 21 Mar 2012 15:06:19 -0300
Message-ID: <CANELHzP+Kr99uLRRbmrfDzjrNn-eC-zgAfJy1Gct81nXfyrP0w@mail.gmail.com>
References: <CANELHzNc+28ZDiZ69zv3X0DJMf0DTkiZXQD1-32Wsy-=vtWDhw@mail.gmail.com>
 <87haxit95q.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Mar 21 19:06:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAPvr-0008Fx-BE
	for gcvg-git-2@plane.gmane.org; Wed, 21 Mar 2012 19:06:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759742Ab2CUSGm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Mar 2012 14:06:42 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:51802 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759064Ab2CUSGk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Mar 2012 14:06:40 -0400
Received: by pbcun15 with SMTP id un15so945297pbc.19
        for <git@vger.kernel.org>; Wed, 21 Mar 2012 11:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Gq7oH1uokCBYycZCvhKrbg/w0u5YKQpIE/XAcrEA7d0=;
        b=DmX+n6T1J69oI8fHyuroCAySbpUzpVJOrbH2F/lZxAtDvfwPatW+vynswSMnwSgDaM
         5gMlZBV0vlFBE4w51gYMhbhtAuN7EM9sCZkYPEA7T+fw31uJ2vVDn2tfzP31F3MfOCk9
         5zsx8DT3Xw3psmLnpt2s7BCuBdGeG9XPZL6BE4Ar/0zlY0yNV/meql+BXWHekeEhZvS/
         5F5O80Py/VvZgAFzHeXkfc4xvRyCPVFrISd5aJM+JGjFpkZEHjE/AnpBcWspukd0l7Y7
         tGJE2kMgkKj66adsTxNIuD/gkYdp+7zS4lZrirpfaHB1DTayvmke4y8Z7r/377n/Drl3
         n4pw==
Received: by 10.68.130.163 with SMTP id of3mr13354034pbb.85.1332353199943;
 Wed, 21 Mar 2012 11:06:39 -0700 (PDT)
Received: by 10.68.24.106 with HTTP; Wed, 21 Mar 2012 11:06:19 -0700 (PDT)
In-Reply-To: <87haxit95q.fsf@thomas.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193595>

On Wed, Mar 21, 2012 at 9:45 AM, Thomas Rast <trast@student.ethz.ch> wr=
ote:
> Felipe Tanus <fotanus@gmail.com> writes:
[...]
>
> =C2=A01. Rework the pack access mechanisms to allow the maximum possi=
ble
> =C2=A0 =C2=A0parallel access.
>
[...]
> I think (1.) is the most important part simply because without (1.) t=
he
> other two are totally meaningless. =C2=A0So I'd rather you not focus =
too hard
> on the command list. =C2=A0However, correctly identifying more comman=
ds where
> pack access is the hotspot, and backing that up with numbers, may be =
a
> good way to show your understanding of the matter.
>
> For further reading, you should start with the discussions surroundin=
g
> git-grep threading around
>
[...]

Hi Thomas, thank you for your answer, and more than it, thank you for
point me to the right direction :-)

I followed the discussions you pointed out and it was very helpful. If
I get it right, what you expect to be in the proposal is an analysis
of what should be modified in the pack access mechanism because it
will be used by the commands we will work on, and thus they should be
thread safe and have a better performance. To achieve this I'll have
to go through the  sha1_file.c file and come with an idea of how to
improve the parallelism on it. Is that what you expect for a good work
in this summer?

Regards,

--=20
=46elipe de Oliveira Tanus
E-mail: fotanus@gmail.com
Site: http://www.inf.ufrgs.br/~fotanus/
-----
"All we have to decide is what to do with the time that is given us." -=
 Gandalf
