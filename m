From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] clone: Warn if clone lacks LICENSE or COPYING file
Date: Sun, 22 Mar 2015 18:56:52 +0100
Message-ID: <CACBZZX67igE67+y7Tme=_OC7JiT726qB4X18+8Mvg1ewssQ_ug@mail.gmail.com>
References: <E1YZNn7-0002Lc-7O@rmm6prod02.runbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: dwheeler@dwheeler.com
X-From: git-owner@vger.kernel.org Sun Mar 22 18:57:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZk7i-0005Eo-V1
	for gcvg-git-2@plane.gmane.org; Sun, 22 Mar 2015 18:57:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751803AbbCVR5P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2015 13:57:15 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:34357 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751763AbbCVR5N (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2015 13:57:13 -0400
Received: by obbgg8 with SMTP id gg8so108809662obb.1
        for <git@vger.kernel.org>; Sun, 22 Mar 2015 10:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Awvklg19U3WbJlVY0yyPds/dL5rME8M2k/ooVjyvGc0=;
        b=NK08uVTlOV8HwqbpUX6kXD5xMKZ65aKXh6mpui0zqKDB1OP7Tqu3R8hH4HLa/VDcYi
         ISKoC9Dgc8LSq6KoN4tz/xtLgZs2Y5GPzx9NK7JhkXDQKzgcjgvgDNG94VNtTEREGu04
         6G8hes/PiN4Jfw0x40AXQPCXtuXmAkM8/G1Pf/DM7+y29YEKMXjPWGSA7Op+MQwNgm0/
         e0dgdmPiUfm3QyILVhhlzBK2ilK+OnaoHPef8fD3+j6p6G+KxF6fAx5PNYbzBwpXJwDb
         oP9HpkCBS27vqfX7SfNLLn7f7PM/hmAywdrePzQzyjo9TIc1mFS1750kbUz/0reZYkyl
         2ulQ==
X-Received: by 10.202.191.194 with SMTP id p185mr68972618oif.128.1427047033080;
 Sun, 22 Mar 2015 10:57:13 -0700 (PDT)
Received: by 10.76.82.1 with HTTP; Sun, 22 Mar 2015 10:56:52 -0700 (PDT)
In-Reply-To: <E1YZNn7-0002Lc-7O@rmm6prod02.runbox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266074>

On Sat, Mar 21, 2015 at 7:06 PM, David A. Wheeler <dwheeler@dwheeler.com> wrote:
> Warn cloners if there is no LICENSE* or COPYING* file that makes
> the license clear.  This is a useful warning, because if there is
> no license somewhere, then local copyright laws (which forbid many uses)
> and terms of service apply - and the cloner may not be expecting that.
> Many projects accidentally omit a license, so this is common enough to note.
> For more info on the issue, feel free to see:
> http://choosealicense.com/no-license/
> http://www.wired.com/2013/07/github-licenses/
> https://twitter.com/stephenrwalli/status/247597785069789184

As others have indicated here this feature is really specific to a
single lint-like use-case and doesn't belong in clone as a built-in
feature.

However perhaps an interesting generalization of this would be
something like a post-clone hook, obviously you couldn't store that in
.git/hooks/ like other githooks(5) since there's no repo yet, but
having it configured via the user/system config might be an
interesting feature.

If you're still interested in getting this functionality perhaps a
patch to have some general post-clone hook mechanism would be
accepted, then you could check license files or anything else you
cared about.

You could also just have a shell alias that wrapped git-clone...
