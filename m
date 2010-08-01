From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: hooks not fired by a merge's auto-commit
Date: Sun, 1 Aug 2010 19:27:28 -0400
Message-ID: <AANLkTikXRRB4nqWP1VEUv2V86bR4MRr2PE0MQp_PvPRC@mail.gmail.com>
References: <AANLkTindr-y0uAu46FVEqtB5BLw9ZjB0y0ETwmW+8+PV@mail.gmail.com>
	<7vzkxatepy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Richard Bronosky <Richard@bronosky.com>
X-From: git-owner@vger.kernel.org Mon Aug 02 01:27:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OfhwX-00022X-Jw
	for gcvg-git-2@lo.gmane.org; Mon, 02 Aug 2010 01:27:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751794Ab0HAX1a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Aug 2010 19:27:30 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:36904 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751506Ab0HAX13 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Aug 2010 19:27:29 -0400
Received: by iwn7 with SMTP id 7so3497932iwn.19
        for <git@vger.kernel.org>; Sun, 01 Aug 2010 16:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=xhpnjF3jqTvhv5QRAsGAhWk9ziw32bCjbAV5IUl9WxA=;
        b=dw47Ug52Vc13afit8UhQQkjNXySBMUMeDUnLIqemeG/wd6LAU3JRDCwpIrhDRsrx67
         SmXB2DaXwTmtRf9B5l36zKyc2SQMVBSgOsoJ96iz428n1WTzdhyP33LMqKXWQ3zOMGTB
         JODGJlud16io1Y7Q0jsANvIIgq+WM+ulT9Y7o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=H0/Qj1GkCcSQOySFxbBqBJae2sgcsOXtaTh4ZQ4e9ulqQdjW1p2yOdMlHjUt0D2d4L
         +lv1mJrLtoeINnI45yLyL+40rOIpmiegOF/Y533EXNDVTobVlLv4Ep4ElHsNAx32vOwf
         3DGVFtA3Ri5NMcKmmVa5ZKxsHamgbsyOwlH/8=
Received: by 10.231.85.206 with SMTP id p14mr6078536ibl.89.1280705248660; Sun, 
	01 Aug 2010 16:27:28 -0700 (PDT)
Received: by 10.231.155.74 with HTTP; Sun, 1 Aug 2010 16:27:28 -0700 (PDT)
In-Reply-To: <7vzkxatepy.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152386>

On Thu, Jul 29, 2010 at 12:50 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Richard Bronosky <Richard@Bronosky.com> writes:
>
>> Using git 1.7.1 it seems that a merge (more specifically the
>> auto-commit) does not fire any of the following hooks:
>> pre-commit =C2=A0prepare-commit-msg commit-msg
>>
>> Is that by design?
>
> I would probably call it an unintended design that now has long been
> established that changing it may break people's existing setups rathe=
r
> badly.
>
> Especially pre-commit hooks that look for and prevent common mistakes=
 from
> happening for individual developers may not want to run, when you are
> pulling in other people's work that already has the mess they created=
=2E
> Such problems are often either too late to fix or you are in no posit=
ion
> to reject their pull requests. =C2=A0So you would break _my_ workflow=
 (and
> others who play similar roles as me, making changes themselves and me=
rging
> others work) if you did such a change.
>
> You _could_ add pre-merge to introduce it as a new feature. =C2=A0For=
 people
> who want to apply the same check for merges and individual commits
> (e.g. those who never merge other's work), pre-merge can just invoke
> pre-commit.

Also see http://thread.gmane.org/gmane.comp.version-control.git/151297/

j.
