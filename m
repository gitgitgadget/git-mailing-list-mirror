From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [TopGit PATCH v2] tg-patch: use pretty_tree
Date: Tue, 5 Oct 2010 22:14:55 +0200
Message-ID: <AANLkTimQ6CQonVJRuUzZkzbNFPsHkt4nSD70Fp_Ug1rp@mail.gmail.com>
References: <AANLkTikXT=rzOJTTcNOsWkXctKOM3FzQ9ycVtOprLHGh@mail.gmail.com>
	<1286305486-28607-1-git-send-email-bert.wesarg@googlemail.com>
	<20101005200159.GZ11737@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Peter Simons <simons@cryp.to>, pasky@suse.cz,
	Per Cederqvist <ceder@lysator.liu.se>,
	Olaf Dabrunz <odabrunz@gmx.net>,
	Thomas Moschny <thomas.moschny@gmx.de>,
	martin f krafft <madduck@madduck.net>
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Tue Oct 05 22:15:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3Dui-00076q-0Q
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 22:15:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756874Ab0JEUO6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Oct 2010 16:14:58 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:46677 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755647Ab0JEUO5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Oct 2010 16:14:57 -0400
Received: by gxk9 with SMTP id 9so2153492gxk.19
        for <git@vger.kernel.org>; Tue, 05 Oct 2010 13:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=XMA4c96rHb+zc5h+1niAzjeyNR6lDOIzEZpXnZ31E5E=;
        b=VUh3vOOwaZU9WeUTegV1m09QNW98TYNCaO6wATuF924ep33f/krhnNBbkbLtpiPx92
         YVj90n5es3sEiqpjKUT2fgNF/wPqbQBU/vOFs4Kk/ejfLLtopOQHjKX0QIXx7J9ZwEZs
         U0a6K/hunkuNXuBLtvg0Q5bMEMBXaUJl+Xaak=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=wjp99oCK7hPjIlx60qlNavWZdFXIFU8wwj0kruO059l8BC2iv7skWzfM7HpWqzMB2I
         fBYwAqXolBZFM5MGfyUP14H0/Aim2//Rnk93re0akzHqMDyydlZzseqpfhtaoKCXq/5w
         GpxuCctlinjy74p5CLb6SYj/brAToD9vCW8cw=
Received: by 10.231.30.76 with SMTP id t12mr12551035ibc.161.1286309695836;
 Tue, 05 Oct 2010 13:14:55 -0700 (PDT)
Received: by 10.231.147.80 with HTTP; Tue, 5 Oct 2010 13:14:55 -0700 (PDT)
In-Reply-To: <20101005200159.GZ11737@pengutronix.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158231>

2010/10/5 Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>:
> On Tue, Oct 05, 2010 at 09:04:46PM +0200, Bert Wesarg wrote:
>> This applies the same treatment to tg-patch like tg-files got in v2.
>>
>> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
>>
>> ---
>>
>> Basing the decision whether to use the ui diff or the porcelain diff=
-tree
>> is probably very unorthodox, but also makes sense, doesn't it?
> Uuuuuh, I'd feel better with git diff-tree --color=3Dauto. =C2=A0Why =
did you
> decide against that?

Because there are more config options which diff-tree ignores, for
example diff.mnemonicprefix or diff.noprefix. While
diff.mnemonicprefix unfortunately should not work in our case (git
diff can't decide just from the two tree-ishs what is what) but we
could provide our own prefixes with --{src,dst}-prefix. See
diff.c:git_diff_ui_config() for the full list. I also have a small
patch in my git tree which is only recognized by the ui diff.

BTW. I accidentally removed the '(No changes)' case, which I'm working
on right now.

Bert
