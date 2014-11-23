From: Javier Domingo Cansino <javierdo1@gmail.com>
Subject: Re: Fwd: Add git ignore as builtin
Date: Sun, 23 Nov 2014 20:25:15 +0100
Message-ID: <CALZVapm0VJ9JsT3Ur86F-vYFMoRtKgDiJ3PO_aYPRyNFgz6iEw@mail.gmail.com>
References: <CA+mQAOXPZSv2B8tVfC=4eJ7X_2j8Di4BkuE=z43=U2+VNpdQQg@mail.gmail.com>
 <CA+mQAOU_UnPuSk0f9d1sUnxBj8M4zEX7bwa4Dw_z_PJV3Lp4LA@mail.gmail.com>
 <loom.20141117T010932-213@post.gmane.org> <20141117205957.GB15880@peff.net> <xmqq8uj9y0ck.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Ryan Jacobs <ryan.mjacobs@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 23 20:25:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xscmz-0004Z5-7e
	for gcvg-git-2@plane.gmane.org; Sun, 23 Nov 2014 20:25:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752070AbaKWTZh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Nov 2014 14:25:37 -0500
Received: from mail-wi0-f179.google.com ([209.85.212.179]:48588 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751559AbaKWTZh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Nov 2014 14:25:37 -0500
Received: by mail-wi0-f179.google.com with SMTP id ex7so3857141wid.0
        for <git@vger.kernel.org>; Sun, 23 Nov 2014 11:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=EBI/V8b24zdbglsSfH5H4jHulmcCbbk86Ds6yH1bWOc=;
        b=c9pD2DNwPFDo9M5Vmplv5G3Xc6AKO30jEWyb6m2Mk+ExP0/xL8e18+Qo8n/CchvqQz
         D07ztEYY5kSgpEufiPfKvIMcmjZ0ZpOCLt+Xkv2Rr6OZA3bbpppJuxZDP+NpPPyGBWXa
         q323VVPZ56Yf5BrJSREKXCn6GafAKrSW7JyjYg3reRF284PRqBBHKcptbXvS7Rol5QSj
         WUokGQrpr2E+3RvlJmJWuxBxLE95gppFuhtxqGJFZUgdlNh25CTvKZwx/g3iDfx4fqX+
         hoFD5j5Pe6DRxbCCpHQ/EcTvJNhZQYExDTyPdzQSAoyYk0DCfEI3HS62VvOtmP0G9PE4
         1j0g==
X-Received: by 10.180.96.42 with SMTP id dp10mr5617923wib.38.1416770735903;
 Sun, 23 Nov 2014 11:25:35 -0800 (PST)
Received: by 10.27.203.85 with HTTP; Sun, 23 Nov 2014 11:25:15 -0800 (PST)
In-Reply-To: <xmqq8uj9y0ck.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260100>

I would love to have such tool included in the toolchain, but being
able to use it to edit all the ignore chain, defaulting to .gitignore.
Explain the reason in my case.

Usually, when ignoring stuff, you will probable ignore already your
IDE/Editor files using a global gitignore. And most of the times in a
per-project basis, you will be ignoring their output files. I only use
.git/info/exclude when I have something really special that I don't
want to share publicly, such as a data/ folder to run the project or
so.

That way, most of the times I will be modifying .gitignore, sometimes
my global gitignore and very occasionally, .git/info/exclude.

That's my case, and that I know of, people have that usage order,
.gitignore > global gitignore > local gitignore.

For sake of uniformity, I would use the same context specifiers as in
git-config. Defaulting to --repo for .gitignore, using --local for the
.git/info/exclue, using --global for the global gitignore, and
--system for the system one.

Also, about adding and excluding, I would recommend using verbs
instead of arguments, which would be in consonance with git remote.

git ignore exclude ....
git ignore include ....

You could also make it "smart" by allowing to use it as the Cisco
managing commands, or the ip tool (ip a == ip address, ip a a == ip
addr add, etc.), resulting in the following:
git ignore e ....
git ignore i ....

-- 
Javier Domingo Cansino
