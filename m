From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH] parse-options: fix the description of defval
Date: Sun, 29 Mar 2015 21:27:11 +0800
Message-ID: <CACRoPnQFBbhH0oKDON+nwHO_MiB_ZjiQQU1Wdsu7kVaqAEk=pA@mail.gmail.com>
References: <E8C3474A-5A3A-4A51-A798-84FB9AD46A9F@gmail.com>
	<CACRoPnTjAu_pyPp2TXZGou=H8mkXBmQqgxGNusjW6u8peEfw6Q@mail.gmail.com>
	<0AC17F77-A324-40FA-9D5A-772C11E3BBDA@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: Git List <git@vger.kernel.org>
To: Ivan Ukhov <ivan.ukhov@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 29 15:27:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YcDFG-0004iT-U0
	for gcvg-git-2@plane.gmane.org; Sun, 29 Mar 2015 15:27:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752712AbbC2N1N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Mar 2015 09:27:13 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:33264 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752581AbbC2N1M convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Mar 2015 09:27:12 -0400
Received: by labto5 with SMTP id to5so100221529lab.0
        for <git@vger.kernel.org>; Sun, 29 Mar 2015 06:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=uXaTvJ9+9Kl8tNZXI/9gjicXtFcVaA+ZtDA+cygfjpY=;
        b=higjExRJ//JomgvcbxPTjL2wFSbPklY0Sv88Xn5QyzBrc+yfBx+BQ6a4J19XVFDLAF
         +DQv3djyFdbesPftqyTnoq2rvVFZDY+bN5iBWZA0HtcCjTmW1vezvU6BvxuQR0XuHSaQ
         O+SC+JqajizTFW1EYDmVI34r7FNOfQxfzn/slApaBL6Rl4Gk435/Euawhcj7yZUW6lou
         e5+vnjr95DIdkTvEUvL3vX6kZj58U5tEXZWFta0EIwq4ws2geN45GEJ1NvDe+fR9Nz7K
         fXiIyUrHA9i6wNW2IkV6ojS+eVFERB5rsiDUiX1DoMLeBaJl+wJEr3X51p75mCMTnAIE
         WtCg==
X-Received: by 10.152.36.133 with SMTP id q5mr18538313laj.35.1427635631387;
 Sun, 29 Mar 2015 06:27:11 -0700 (PDT)
Received: by 10.112.130.228 with HTTP; Sun, 29 Mar 2015 06:27:11 -0700 (PDT)
In-Reply-To: <0AC17F77-A324-40FA-9D5A-772C11E3BBDA@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266435>

Hi,

On Sun, Mar 29, 2015 at 5:28 PM, Ivan Ukhov <ivan.ukhov@gmail.com> wrote:
> I have checked the definitions of the three macros you mentioned, and it seems that none of them uses defval to store pointers. OPTION_CMDMODE stores chars and integers. OPTION_STRING does not use defval at all (pointers go in a different field of the option struct), and the same applies to OPTION_FILENAME. I am probably missing something; can you please clarify what you mean? Thank you.

For OPTION_STRING, if the PARSE_OPT_OPTARG flag is set (as the
documentation already states), the option can be provided on the
command line without any corresponding argument. If provided as so,
the string pointer of defval is used.

See get_value() in parse-options.c

I haven't used the other option types before yet (just did a grep
'defval' in parse-options.c) so I don't know what they do with defval.
That's why it would be nice if they were documented :-)

Regards,
Paul
