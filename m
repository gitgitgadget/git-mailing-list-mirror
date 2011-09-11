From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] Support empty blob in fsck --lost-found
Date: Sun, 11 Sep 2011 18:03:21 +0200
Message-ID: <CAGdFq_hqfqdFyLY=KdA_QW5kH8Kjhx8Y18mHEga_Pdv8yzB2wg@mail.gmail.com>
References: <A3964281-B24B-46C0-AE73-0CCB4C12556F@bjhargrave.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: BJ Hargrave <bj@bjhargrave.com>
X-From: git-owner@vger.kernel.org Sun Sep 11 18:04:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R2mVu-0003fA-Ch
	for gcvg-git-2@lo.gmane.org; Sun, 11 Sep 2011 18:04:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760283Ab1IKQED (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Sep 2011 12:04:03 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:56393 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760247Ab1IKQEC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Sep 2011 12:04:02 -0400
Received: by gyg10 with SMTP id 10so2504228gyg.19
        for <git@vger.kernel.org>; Sun, 11 Sep 2011 09:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=GigKLyT+Gwf+s5Gw4NCGnpLKEuXiYe5vBbodVMnhUBc=;
        b=QwxUZBp40ksYCGxDq6t992gcnqxPcWpVDBphWu7zd+Z7MptI7f0XQ2gNx77BYBrqvt
         EPap4Kleqio+TGi6J41BhSxjFnR4DFWAccUKCazgMT7szSiXSrCIqcW+TdNorPiuTqfZ
         4Stcq6m6kdRyI6Va40DqFgpDpCtlkmg15x6RI=
Received: by 10.68.19.6 with SMTP id a6mr2958207pbe.165.1315757041241; Sun, 11
 Sep 2011 09:04:01 -0700 (PDT)
Received: by 10.68.59.39 with HTTP; Sun, 11 Sep 2011 09:03:21 -0700 (PDT)
In-Reply-To: <A3964281-B24B-46C0-AE73-0CCB4C12556F@bjhargrave.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181177>

Heya,

On Sun, Sep 11, 2011 at 17:40, BJ Hargrave <bj@bjhargrave.com> wrote:
> fsck --lost-found died when attempting to write out the empty blob.
> Avoid calling fwrite when the blob size is zero since the call to
> fwrite returns 0 objects written which fails the check and caused
> fsck to die.

Now we don't die at all if a 0-byte file couldn't be written.
Shouldn't we check errno or something?

-- 
Cheers,

Sverre Rabbelier
