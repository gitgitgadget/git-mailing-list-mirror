From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] Fix expected values of setup tests on Windows
Date: Sat, 1 Jan 2011 10:46:54 +0700
Message-ID: <AANLkTinWdGDtxPk24OBQnJP8fdHW9gYNDn46YKRGTWoB@mail.gmail.com>
References: <201012302205.13728.j6t@kdbg.org> <AANLkTi=uCCfBFBpC=+V9RpaXRXiiPYp-tZXBxAVNB7+e@mail.gmail.com>
 <201012311711.06989.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat Jan 01 04:54:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PYsY0-0006mS-3c
	for gcvg-git-2@lo.gmane.org; Sat, 01 Jan 2011 04:54:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752412Ab1AADr0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Dec 2010 22:47:26 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:53253 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751901Ab1AADrZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Dec 2010 22:47:25 -0500
Received: by wwa36 with SMTP id 36so12839399wwa.1
        for <git@vger.kernel.org>; Fri, 31 Dec 2010 19:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=ac1bXJ13Ba7AM4x8fXbQMDz45FUoyjXYXPwPthOC6S0=;
        b=qG83Ag0dOGIDqG4v48/SziwO6+o16zksPRGLpztO0ls44yWEoJ7JqMLrCyR+gUC2NX
         B8U62wxsnhIpuyfLTsNApx4kChJn732WASBzCpTC9zyYqDq2JmrAtu/BcJQLAAwcTXNl
         hONdqmZMPIVwIiyn+xUupgQTd6XRSI99V7DQE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=eH3SrXHqAtySzvusM0vbaKqmm8ihVZUfve1Cm2P3/m4iXzn+ag4csWvn6IKpPyvz6R
         wZ4uhCzDCIeO+04gGUEQ7MN1EMJFEm9THr2mEV9aBmCw4OR0nluO6rmqphgVqHaKh0Cg
         MBFydAnjwcWAlmIe0rZ9/GEZKjA5WW5w8+smY=
Received: by 10.216.24.134 with SMTP id x6mr2857949wex.34.1293853644410; Fri,
 31 Dec 2010 19:47:24 -0800 (PST)
Received: by 10.216.63.14 with HTTP; Fri, 31 Dec 2010 19:46:54 -0800 (PST)
In-Reply-To: <201012311711.06989.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164400>

On Fri, Dec 31, 2010 at 11:11 PM, Johannes Sixt <j6t@kdbg.org> wrote:
>> in your patch does not. Does bash auto convert value in
>> TRASH_DIRECTORY="$TE..." line?
>
> No. When this line is executed:
>
> TEST_DIRECTORY=$(pwd)
>
> $(pwd) still has its default behavior to return the POSIX style path. pwd is
> redefined to pwd -W only later.
>
> I'm hesitant to redefine pwd earlier in test-lib.sh, though, because we would
> have to audit all uses of TEST_DIRECTORY for whether POSIX style paths or
> drive-letter paths are needed.

Ah I missed that. Thanks. Ack from me.
-- 
Duy
