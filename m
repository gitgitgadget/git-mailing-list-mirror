From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: BUG: git pull --rebase on detatched head prints a lot of usage warnings
Date: Fri, 3 Dec 2010 23:16:11 +0100
Message-ID: <AANLkTimgk-jqyKD+ab=bHZLVH3F52WqCjr4v3chMY_Fv@mail.gmail.com>
References: <AANLkTimyCG6zVhc4znWPWwipd0bn-YT2FrOT=T0AgHNW@mail.gmail.com>
 <20101203190050.GB14049@burratino> <AANLkTin-9pb7cxsAvDqWj3So47_zq5co9TZRWux9ezxz@mail.gmail.com>
 <AANLkTikwdqQpmyxZu-kp7UHjYnKuVxs8urxM=9c=66H0@mail.gmail.com> <7vbp52o9c6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 03 23:16:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POdvj-0000UG-Cu
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 23:16:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753910Ab0LCWQd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Dec 2010 17:16:33 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:38146 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753384Ab0LCWQc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Dec 2010 17:16:32 -0500
Received: by qwb7 with SMTP id 7so10132155qwb.19
        for <git@vger.kernel.org>; Fri, 03 Dec 2010 14:16:32 -0800 (PST)
Received: by 10.229.212.5 with SMTP id gq5mr1669856qcb.275.1291414591989; Fri,
 03 Dec 2010 14:16:31 -0800 (PST)
Received: by 10.229.59.42 with HTTP; Fri, 3 Dec 2010 14:16:11 -0800 (PST)
In-Reply-To: <7vbp52o9c6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162868>

On Fri, Dec 3, 2010 at 10:06 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Santi B=E9jar <santi@agolina.net> writes:
>
>> I also think it fixes, but I wonder if it's the best fix. One thing =
is
>> that show-branch is an ancillary command, and not a plumbing command
>> (but there is already a call to show-branch, but it should probably =
be
>> change to merge-base now that it handles three commit as arguments).
>
> Are you sure "show-branch --merge-base A B C" and "merge-base A B C" =
are
> meant to compute the same thing?

No, I'm not sure. In fact the documentation explicit says that they
are different. But I fail to see when it matters, and more
specifically (now that I've reread the docs), what is the point of
"merge-base A B C".

Just a data point, show-branch --merge-base is only used once in the
code, in git-pull.sh, but "git merge-base A B C" is not used (at least
using my grep).

Or the equivalent is the undocumented "git merge-base --octopus A B C"?

>
> I do not think ancillary necessarily means Porcelain, but that is a
> separate issue.

Me neither. But is the promise to not change the behavior/output as
hard as with plumbing?

Santi
