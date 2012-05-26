From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH] t7403-*.sh: Avoid use of the nonportable '==' operator
Date: Sun, 27 May 2012 08:21:48 +1000
Message-ID: <CAH3AnrqgfjjpN3V10y0v1tMGZ3f5G-RjL5LV9he-0sdbvrMLNQ@mail.gmail.com>
References: <4FC10A0B.5080407@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sun May 27 00:22:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYPNY-0001Mq-LS
	for gcvg-git-2@plane.gmane.org; Sun, 27 May 2012 00:22:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755247Ab2EZWVu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 May 2012 18:21:50 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:45910 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755250Ab2EZWVu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2012 18:21:50 -0400
Received: by wibhj8 with SMTP id hj8so602330wib.1
        for <git@vger.kernel.org>; Sat, 26 May 2012 15:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=k/ZiCvfn80VXkOX4mOrZBkmtalLL0MI4uwE5wXN+fwU=;
        b=B1Z5LnNG2ypK2oJiA4Enayvzr46DAryuSCo3Kl8FxCWalw1u/onNphsE/k9ayMK9Jz
         jmRMuQmldVicB/zL10dvXFsehj2gpPd2gHP9MrIwgKd14FW/t/0IptqBgHq9InL2w029
         N5y+ZghBRqUSMoT0SPRlHWBSnh0OdG+1JFeravKt4B6OvIDvkybLfmKAcpleq4ZDEzmh
         IT+3COTpJTBZN36Jr7dWCQeziGwD1Sa1fqX41tX0d9zCs4K3hgW876wA5Xf8Diw0nnVo
         UaAsIKzYfzj3vYpKR5jGF7UoYGIoxeBi/xj6kpaB3g8OCVj7U+J4RnMy3YCLR/zIloOh
         7b7Q==
Received: by 10.180.98.39 with SMTP id ef7mr5465743wib.21.1338070908785; Sat,
 26 May 2012 15:21:48 -0700 (PDT)
Received: by 10.180.146.166 with HTTP; Sat, 26 May 2012 15:21:48 -0700 (PDT)
In-Reply-To: <4FC10A0B.5080407@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198572>

On Sun, May 27, 2012 at 2:51 AM, Ramsay Jones
<ramsay@ramsay1.demon.co.uk> wrote:
>
> Some shells, including dash, do not support using the '==' string
> equality operator. This results in the failure of tests 7-12 with
> 'test' complaining of an "unexpected operator".
>
> In order to suppress the errors, we replace the '==' operator with
> '=', which must be supported by any POSIX shell.
>

Thanks. I take it than an example of such a shell is dash?

BTW: the next iteration is more of a re-write than a re-roll because I
noticed some other issues (e.g. preventing git://hostname/repo being
silently transformed to git://subrepo in the case of a pathological
use of a submodule URL of the form ../../subrepo) and fixing this
required a change that required a more extensive suite of tests.


jon.
