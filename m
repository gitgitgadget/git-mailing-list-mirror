From: Tay Ray Chuan <rctay89@gmail.com>
Subject: memrchr() implementation
Date: Fri, 29 Jul 2011 12:33:01 +0800
Message-ID: <CALUzUxqNGsThcWem4mj=M3EcFF_N5GpARB+x0qx+Q1Gs76Gzig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 29 06:34:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qmemo-0003qq-6Z
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jul 2011 06:34:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752230Ab1G2EdG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jul 2011 00:33:06 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:34249 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751489Ab1G2EdE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2011 00:33:04 -0400
Received: by fxh19 with SMTP id 19so1913845fxh.19
        for <git@vger.kernel.org>; Thu, 28 Jul 2011 21:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=1G8b0WejueuAhueF/KqnwGG+ccl73sgxA6JlEyewc9U=;
        b=ka66a8WG397DOCXyzSNGa3lQtNuJcSNkMC6dzW6znyiA5X0fQE3VkazQbUY5Hu82NA
         0eAg/qIXY0q6AHJ1mjZXeMoHnXCQ1rJov4oxJkqb1h40nFbL9JFlnrEnNNqesr245D3+
         G9Z3C/WpA68M5OmcSa0hvY/g9GXWy5TRArg/c=
Received: by 10.223.56.79 with SMTP id x15mr1099337fag.130.1311913982552; Thu,
 28 Jul 2011 21:33:02 -0700 (PDT)
Received: by 10.223.81.75 with HTTP; Thu, 28 Jul 2011 21:33:01 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178123>

Hi,

I'm writing a patch that requires the use of memrchr(). [1] As far as
I know, memrchr() is non-standard.

So what's the best way to get git to use memrchr()?

I was thinking of getting git to use glibc's implementation if glibc
is present, if not, use a naive implementation included in git's code
base [2].

--
Footnotes:
[1] For those interested, it's regarding content trimming to speed out
diffs. You can see memrchr() in use at
https://github.com/rctay/git/blob/tg%2Fgsoc-diff%2Ftrim-ends/xdiff/xprepare.c#L203

[2] (ISC-style license)
http://www.sudo.ws/repos/sudo/file/c1ab4b940980/compat/memrchr.c

-- 
Cheers,
Ray Chuan
