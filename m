From: David Kastrup <dak@gnu.org>
Subject: Re: --exit-code (and --quiet) broken in git-diff?
Date: Sun, 12 Aug 2007 13:31:38 +0200
Message-ID: <85643lq99h.fsf@lola.goethe.zz>
References: <17875.88.10.191.55.1186873960.squirrel@secure.wincent.com>
	<46BED5AA.7050900@lsrfire.ath.cx>
	<24332.88.10.191.55.1186917895.squirrel@secure.wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
To: "Wincent Colaiuta" <win@wincent.com>
X-From: git-owner@vger.kernel.org Sun Aug 12 13:31:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKBfe-0003lO-VX
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 13:31:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760886AbXHLLbn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 12 Aug 2007 07:31:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760997AbXHLLbn
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Aug 2007 07:31:43 -0400
Received: from mail-in-11.arcor-online.net ([151.189.21.51]:47859 "EHLO
	mail-in-11.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760672AbXHLLbm convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Aug 2007 07:31:42 -0400
Received: from mail-in-09-z2.arcor-online.net (mail-in-09-z2.arcor-online.net [151.189.8.21])
	by mail-in-11.arcor-online.net (Postfix) with ESMTP id C77B110A42;
	Sun, 12 Aug 2007 13:31:40 +0200 (CEST)
Received: from mail-in-04.arcor-online.net (mail-in-04.arcor-online.net [151.189.21.44])
	by mail-in-09-z2.arcor-online.net (Postfix) with ESMTP id 7A2A528EDF4;
	Sun, 12 Aug 2007 13:31:40 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-036-190.pools.arcor-ip.net [84.61.36.190])
	by mail-in-04.arcor-online.net (Postfix) with ESMTP id 30A781C738D;
	Sun, 12 Aug 2007 13:31:39 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id AECAE1C3C79D; Sun, 12 Aug 2007 13:31:38 +0200 (CEST)
In-Reply-To: <24332.88.10.191.55.1186917895.squirrel@secure.wincent.com> (Wincent Colaiuta's message of "Sun\, 12 Aug 2007 06\:24\:55 -0500 \(CDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3934/Sun Aug 12 03:59:08 2007 on mail-in-04.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55676>

"Wincent Colaiuta" <win@wincent.com> writes:

> Ren=E9 Scharfe wrote:
>>
>> git diff passes the output through your pager by default, so you see=
 the
>> exit code of that instead of diff's.  Set PAGER=3Dcat or redirect th=
e
>> output to /dev/null to get rid of it.
>
> Ah, thanks very much Ren=E9!

I think I would call that a mistake.  However, I don't see that fixing
it would actually be useful: if a pager gets called, this means that
git-diff might die with SIGPIPE (when the user quits the pager), and
that in turn has pretty much no meaning.  So one really needs to
redirect the output, anyway.

--=20
David Kastrup, Kriemhildstr. 15, 44793 Bochum
