From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: git-show / tig: no indention for commit message
Date: Sun, 24 Jul 2011 21:29:10 -0400
Message-ID: <CAFuPQ1JY29w+iBsVY_sOLksbz_tTL_JJpe_vpbWWu0Lx3D5mMA@mail.gmail.com>
References: <20110511113655.GB24644@nibiru.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: weigelt@metux.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 25 03:29:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ql9zE-0002z8-U4
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jul 2011 03:29:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752772Ab1GYB3c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jul 2011 21:29:32 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:49897 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751845Ab1GYB3b (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jul 2011 21:29:31 -0400
Received: by fxd18 with SMTP id 18so8141273fxd.11
        for <git@vger.kernel.org>; Sun, 24 Jul 2011 18:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:content-type;
        bh=TyYhCVwdNRTVumpY7+fJ06EBkdnxwNuzbO5VS11Lupo=;
        b=pToWLNgFCcmR3huXgKRsW1+kFYgYME2wUEQrmYIsiPbx/OSkk+oojQkBVHzkue0IS7
         mUAioGCsacWCT4Crh0YhJRXX+NYz8cEExVIdTWPIv32BoJwk2RqbKgAGZVeJxC9cOQti
         KP41E/oo0fZ9GpV04r3BRI9dQKg/H7KM4aR2M=
Received: by 10.223.28.65 with SMTP id l1mr6012084fac.136.1311557370166; Sun,
 24 Jul 2011 18:29:30 -0700 (PDT)
Received: by 10.223.79.13 with HTTP; Sun, 24 Jul 2011 18:29:10 -0700 (PDT)
In-Reply-To: <20110511113655.GB24644@nibiru.local>
X-Google-Sender-Auth: GMQqMTu83mGAAkAyUr8iewRZGQk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177780>

On Wed, May 11, 2011 at 07:36, Enrico Weigelt <weigelt@metux.de> wrote:
> I often have to copy+paste commit messages from tig (when putting
> changes into TFS manually ;-o), and the 4-spaces indention is quite
> unhandy here. Is there a way to switch it off ?

Why not configure a keybinding to run a small shell script, where you
can use xclip or something similar to copy to the clipboard?

The following .git/config example abuses a git alias (in place of a
shell script) to output the raw commit text when P is pressed:

[tig "bind"]
  generic = P !git copy-commit-message %(commit)
[alias]
  copy-commit-message = !"git log --format=%B -1"

-- 
Jonas Fonseca
