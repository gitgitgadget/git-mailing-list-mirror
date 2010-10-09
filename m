From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [TopGit PATCH] t/depend-add-using-export
Date: Sat, 9 Oct 2010 13:27:44 +0200
Message-ID: <AANLkTi=Xhd8DY+f1ZYR6dEhHvC-=50iHLnhdv8GTacNX@mail.gmail.com>
References: <1286588598-4005-1-git-send-email-odabrunz@gmx.net>
	<AANLkTik6R89vPhwKyWOheHPkxQ9JPpmrQVmXon8Vn4+A@mail.gmail.com>
	<20101009105456.GA7328@santana.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Bert Wesarg <bert.wesarg@googlemail.com>,
	Olaf Dabrunz <odabrunz@gmx.net>, git@vger.kernel.org,
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>, Petr Baudis <pas
X-From: git-owner@vger.kernel.org Sat Oct 09 13:27:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4Xah-0001Lq-C1
	for gcvg-git-2@lo.gmane.org; Sat, 09 Oct 2010 13:27:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755356Ab0JIL1q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Oct 2010 07:27:46 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:44936 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755285Ab0JIL1p (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Oct 2010 07:27:45 -0400
Received: by iwn6 with SMTP id 6so1340897iwn.19
        for <git@vger.kernel.org>; Sat, 09 Oct 2010 04:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:content-type;
        bh=tTqjD6VRIViauyxM0ySe0e5fp3qra5UhFUIuFmWmyIo=;
        b=FpWjLIiiFQcb2lIrYq1ubN+U6oS1s9VD8BwtY0on3BUt9cmfyf4g86sIlyvnExJi/7
         nVR4GwBhBxkvYz/33vTTO3l1xA7+djgTK673UYkpJdiTHv2BOIz30+p2210hYvAeoGf+
         GqeOXlCOOjxOfG1d+iPgd7IxuDumfwpjcRKh0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=pybq5ez7qTqsJ8uR6/e6oqF+FjoLaJRsLqoM0hkt0Wzg983/uQlcgeM210sj4rFL5O
         fKS5LDxSeoG7bM3ZVSwjxv3RxbxSr86k1xao7E+YJjseOR4ramb7RjcgbdsXCkiMMw3g
         ZWGWQBglLei3eF8yGSKiW3RwEzL3ZMcAz5hPU=
Received: by 10.231.14.69 with SMTP id f5mr3168396iba.116.1286623664941; Sat,
 09 Oct 2010 04:27:44 -0700 (PDT)
Received: by 10.231.147.80 with HTTP; Sat, 9 Oct 2010 04:27:44 -0700 (PDT)
In-Reply-To: <20101009105456.GA7328@santana.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158582>

On Sat, Oct 9, 2010 at 12:54, Olaf Dabrunz <Olaf.Dabrunz@gmx.net> wrote:
> When the hand made tree is committed (as a hand made merge) on top of
> the base, we have a correct merge on top of the base.
>
> This actually should change everything. After such a "tg depend add", we
> have either brought in some removed dependency as well, or we did not.
> If we didn't, the removed deps in the base's history do not matter for
> subsequent merges done by "tg update". But if we did bring in a
> previously removed dep, the removed deps in the base's history _would_
> matter. But since we already made a successful merge on top of the
> base's history with a correct tree, and this merge also brings in the
> removed dep through the history from the new dep's side, subsequent "tg
> update" merges will use this hand made merge as the merge base, which is
> fine for future merges.

When I understand this correctly, this hand made merge commit on base,
has also the just removed dep as parent. But the tree does not include
any code from that dep. So git merge-base would select this commit as
the merge base.

Right?

Bert

>
> Olaf
>
> --
> Olaf Dabrunz (Olaf.Dabrunz <at> gmx.net)
>
>
