From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: rfc - Changing the way gitk and git-gui are managed
Date: Sat, 24 Jul 2010 15:18:09 -0400
Message-ID: <AANLkTi=R2-=TNXyFq4OCo6LsYOMNgVga+=6QrAfCoHRx@mail.gmail.com>
References: <7vocdygbw0.fsf@alter.siamese.dyndns.org> <20100724110239.GA13067@vidovic> 
	<20100724125408.GA17481@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 24 21:18:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OckF6-0005cA-Ug
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 21:18:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756089Ab0GXTSb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Jul 2010 15:18:31 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:40244 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755852Ab0GXTSa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Jul 2010 15:18:30 -0400
Received: by wyf19 with SMTP id 19so1207488wyf.19
        for <git@vger.kernel.org>; Sat, 24 Jul 2010 12:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=UpldUFisJ8dFSrBUMycExxZF6svkhfMDUguUWv6yWQA=;
        b=AIYgklWXR2WE8XIo/V6pMl30fCueZ0ZsRPDEARUCjsc3b4+BlCfyJAsEvGmLEy7Gag
         FQxtzjCahU4nZbFsM36f+yXqvNrM6omLjlQYXG3H7au/KLFLQISre1rEvLIHIWa5/fum
         nzgD9HYxM8mwjqYXyT1DC/rgqXTWTK+48ZPSE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=cl6NV0O9GjdI+2J3gtLOEZLfmDxGytGWr6MWglS7Mn9bmc7/fgjYk3ts/PppISISGv
         EOHiPGftyq9dAhFnY6ILQmNoyKDBXLgbshctpqYVasLZvETXFUFhN6ARVSV++hdq1njF
         A+m/bvyq/AzCJNPeGNRy/HoDEfwbwDUS7aYFg=
Received: by 10.227.136.17 with SMTP id p17mr5214181wbt.54.1279999109155; Sat, 
	24 Jul 2010 12:18:29 -0700 (PDT)
Received: by 10.216.235.202 with HTTP; Sat, 24 Jul 2010 12:18:09 -0700 (PDT)
In-Reply-To: <20100724125408.GA17481@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151663>

On Sat, Jul 24, 2010 at 8:54 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Nicolas Sebrecht wrote:
>> What is the issue with the current status?
>
> Here is one:
>
> =A0$ git log --oneline -SListbox.font -- gitk-git/gitk
> =A0$ git log --oneline --follow -SListbox.font -- gitk-git/gitk
> =A062ba514 Move gitk to its own subdirectory
> =A0$ git log --oneline -SListbox.font -- gitk-git/gitk gitk
> =A0207ad7b gitk: Set the font for all listbox widgets
> =A0$

This is a bug in git log --follow, not a reason to completely redesign =
the repo.

=46WIW, I previously tracked the bug down to the fact that it doesn't
track file renames that happen during a merge commit, which is what
subtree merge produces.  I don't have the time or knowledge required
to fix it.

Have fun,

Avery
