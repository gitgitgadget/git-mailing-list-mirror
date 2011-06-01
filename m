From: Chengwei Ding <waterding@gmail.com>
Subject: Re: git annotate with date option not working?
Date: Wed, 1 Jun 2011 18:28:43 +0200
Message-ID: <1805632198775747949@unknownmsgid>
References: <4DE5F655.9020400@gmail.com> <20110601161638.GB7132@sigill.intra.peff.net>
Mime-Version: 1.0 (iPhone Mail 8F190)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eugene Letuchy <eugene@facebook.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 01 18:28:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRoHv-0001WE-4m
	for gcvg-git-2@lo.gmane.org; Wed, 01 Jun 2011 18:28:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758499Ab1FAQ2u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Jun 2011 12:28:50 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:61000 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754862Ab1FAQ2t convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Jun 2011 12:28:49 -0400
Received: by iyb14 with SMTP id 14so4594025iyb.19
        for <git@vger.kernel.org>; Wed, 01 Jun 2011 09:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:references:from:in-reply-to:mime-version:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=OjQTvqxsKeThCVPHDqJ2aV3c+KVdwI+fzuvbbDjCTII=;
        b=JkvZQ4i5Bu8X/b03ZhTM3t5h1eE2RevFS+5lFKXHMNKJgWQAj0ZTWeTqHvg++fyBSD
         fSLh+upOleTUtGYQPGAKPDr+WSXyQLYC57piLJSwYxNJbrq/0nFRoWNt5XT+DmE8kOKP
         VYbgnClucxSOI8/Btvw66bYRCPrBlsDMJy4VI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=references:from:in-reply-to:mime-version:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=GjcdaAE85JTHJkPbSrCCFrwSmWxTCk8fqz1SURweuXDUbQetRdbu2+eLHi3wWvomrw
         nOyFR+CHcgph+A1tHU6SwPUTbW6HVq0BsXOkuXq8xhaTkROZj9RCah3R/LVQWzklTbIn
         v9L8A8WChWHVUK2Z3aBZC7B8AHUlE0h8r/SU8=
Received: by 10.231.73.195 with SMTP id r3mr9467010ibj.50.1306945728377; Wed,
 01 Jun 2011 09:28:48 -0700 (PDT)
In-Reply-To: <20110601161638.GB7132@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174878>

Thx Peff, this really helps. So then doc on this cmd is outdated. Have
been used to emacs build-in vc which call annotate (rumor say it will
support git blame), anyway, have switch to other emacs git plugin now.

Thanks

=E5=8F=91=E8=87=AA=E6=88=91=E7=9A=84 iPhone

=E5=9C=A8 Jun 1, 2011=EF=BC=8C18:16=EF=BC=8CJeff King <peff@peff.net> =E5=
=86=99=E9=81=93=EF=BC=9A

> On Wed, Jun 01, 2011 at 10:20:37AM +0200, Chengwei Ding wrote:
>
>> can anyone confirm that this "--date" option is working for git
>> annotate cmd.
>
> This is by design:
>
>  $ git show 31653c1abc1ac80206db9efca56ff1969150d8fe
>  Author: Eugene Letuchy <eugene@facebook.com>
>  Date:   Fri Feb 20 14:51:11 2009 -0800
>  [...]
>      git annotate ignores the date format specifiers and continues to
>      uses the ISO format, as before.
>  [...]
>  +       if (cmd_is_annotate) {
>                  output_option |=3D OUTPUT_ANNOTATE_COMPAT;
>  +               blame_date_mode =3D DATE_ISO8601;
>  +       } else {
>  +               blame_date_mode =3D revs.date_mode;
>  +       }
>
> The annotate command is a historical artifact, and will remain frozen=
 in
> time in terms of output format and features. If you want to use newer
> features, use "git blame". If you really need the annotate output for=
mat
> with newer blame features, use "git blame -c".
>
> -Peff
