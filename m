From: Bo Yang <struggleyb.nku@gmail.com>
Subject: Re: What's cooking in git.git (Sep 2010, #05; Wed, 15)
Date: Thu, 16 Sep 2010 23:23:06 +0800
Message-ID: <AANLkTimd0j4toF6kEF+6H_-JcE60aA2jbM67PoLjJ=bs@mail.gmail.com>
References: <7viq266461.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 16 17:23:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwGIt-0006Yj-OY
	for gcvg-git-2@lo.gmane.org; Thu, 16 Sep 2010 17:23:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755108Ab0IPPXJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Sep 2010 11:23:09 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:61540 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754992Ab0IPPXI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Sep 2010 11:23:08 -0400
Received: by eyb6 with SMTP id 6so622828eyb.19
        for <git@vger.kernel.org>; Thu, 16 Sep 2010 08:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=zEUL5U9lrVpTveycRUUul85JZJHECa7MFOS189sRKeU=;
        b=hv8sjC2Q6Jec4deNhlgxmBgQ+7xL53dSrupb61SfowC0Kfit3Bje0hr1HrBLqA+Jrh
         ZF3SRUlUiwa+iO3FDHo0m/o8OCVoPFKh2oqO3TvLbk3rl7ZObM7r+B4l8JNON7WeAOnO
         uu9DuQ4y14rfprN0iP5mr42P1RTF/s2N8kL88=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=IwwRnCestMdcBtodg75Tudv9SfRCchXHqtrsTJ/bWZT1rPoaAVOEhPv/jLQkR4xT3I
         DrG33K/XsXMX6OUCyUocyqV8qRNyIHPDzb0/WRqRRCJxhPPSO3gFJY71/PGZYyFPQYZc
         OkemFR4mwCLnpi0iJcPHIDT1H12/WjgmSa27s=
Received: by 10.223.125.67 with SMTP id x3mr1540747far.16.1284650586990; Thu,
 16 Sep 2010 08:23:06 -0700 (PDT)
Received: by 10.220.162.1 with HTTP; Thu, 16 Sep 2010 08:23:06 -0700 (PDT)
In-Reply-To: <7viq266461.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156339>

On Thu, Sep 16, 2010 at 6:19 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> [Cooking]
>
> * by/line-log (2010-09-11) 18 commits
> =A0(merged to 'next' on 2010-09-12 at e29a029)
> =A0+ log -L: do not free parents lists we might need again
> =A0(merged to 'next' on 2010-08-26 at a160ff1)
> =A0+ Document line history browser
> =A0+ Add tests for line history browser
> =A0+ Add --full-line-diff option
> =A0+ Add --graph prefix before line history output
> =A0+ Add parent rewriting to line history browser
> =A0+ Make graph_next_line external to other part of git
> =A0+ Make rewrite_parents public to other part of git
> =A0+ Hook line history into cmd_log, ensuring a topo-ordered walk
> =A0+ Print the line log
> =A0+ map/take range to the parent of commits
> =A0+ Add range clone functions
> =A0+ Export three functions from diff.c
> =A0+ Parse the -L options
> =A0+ Refactor parse_loc
> =A0+ Add the basic data structure for line level history
> =A0+ parse-options: add two helper functions
> =A0+ parse-options: enhance STOP_AT_NON_OPTION
>
> How would one trace history of lines 440,450 in t/t7300-clean.sh star=
ting
> from the tip of 'pu'? =A0"git log -p -L 440,450 pu -- t/t7300-clean.s=
h"
> would be the most natural but it does not work (it wants "pu" to be a
> path). =A0"git log -p -L 440,450 t/t7300-clean.sh pu" doesn't work ei=
ther.

Please put the revision before the '-L' options, you can run:

git log -p origin/pu  -L 440,450 t/t7300-clean.sh

It will work.

> The command line parser of this series needs to be rethought (didn't =
I say
> that many times? =A0Perhaps I was ignored). =A0Might want to kick thi=
s out of
> 'next' and move to the stalled category after 1.7.3.

Yes, you have mentioned this many times, and I will put some time on th=
is issue.

--=20
Regards!
Bo
----------------------------
My blog: http://blog.morebits.org
Why Git: http://www.whygitisbetterthanx.com/
