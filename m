From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH 3/3] git submodule update should give notice when run
 without init beforehand
Date: Wed, 18 Sep 2013 18:12:42 +0800
Message-ID: <CALUzUxoFLOP=-ub_VYr6LqRYQXOO7Tf1oP95mxuYZo-8_dxAZw@mail.gmail.com>
References: <1379266703-29808-1-git-send-email-rctay89@gmail.com>
 <1379266703-29808-2-git-send-email-rctay89@gmail.com> <1379266703-29808-3-git-send-email-rctay89@gmail.com>
 <52373AA2.9050807@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Sep 18 12:13:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMEkv-0006Qe-8Z
	for gcvg-git-2@plane.gmane.org; Wed, 18 Sep 2013 12:13:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751731Ab3IRKNE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Sep 2013 06:13:04 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:33566 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751698Ab3IRKND (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Sep 2013 06:13:03 -0400
Received: by mail-ie0-f175.google.com with SMTP id e14so12521841iej.34
        for <git@vger.kernel.org>; Wed, 18 Sep 2013 03:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=MnM0ld7gCHN2DSJQW8A5hTa4gLBYK+VlesgsirIlXKQ=;
        b=TXjsCoorfLL4jTKy+f1Noht8thesQItVimcDVHXnOt/oHD1vMFzy/2eDLne23EuYlv
         E3EDpN6sPQK4dSiQtC7NuR3JJb9TVfnvxu+Cr3kC3K/lDQIySv7IFFeyxUy5SOSokS5V
         2S1h83H4VRcm7ZkUsz90F4QhlvAlFreH8XQJ9IOpDcbR/10PZX1sjKG780zog81likM3
         Kz0GmcRXZg//HX2TbBZ8w94j0W3BmjuVuUhVBoZ83OCBilQdX8bJN3XWOXLUxs3RtAtM
         ZQwgtzPJ1MfOiVhiNqnRxUEYfVWMD8zgzfzgs0o14+K6obBsfqSIPByUsWNA7iPkqaFX
         86Ww==
X-Received: by 10.50.118.105 with SMTP id kl9mr2914032igb.3.1379499182270;
 Wed, 18 Sep 2013 03:13:02 -0700 (PDT)
Received: by 10.64.93.34 with HTTP; Wed, 18 Sep 2013 03:12:42 -0700 (PDT)
In-Reply-To: <52373AA2.9050807@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234961>

On Tue, Sep 17, 2013 at 1:06 AM, Jens Lehmann <Jens.Lehmann@web.de> wrote:

Thanks Jens for having a look!

> Am 15.09.2013 19:38, schrieb Tay Ray Chuan:
>> When 'update' is run with no path in a repository with uninitialized
>> submodules, the program terminates with no output, and zero status code.
>> Be more helpful to users by mentioning this.
>
> [snip] it would be rather nasty to error out on every submodule
> update.

Just to be sure we're on the right page, with this patch, the 'update'
command still exits with status code zero (non-error), so this patch
doesn't make it error out.

> After the 'autoinit' configuration (which lets upstream hint that
> certain submodules should be initialized on clone) has materialzed we
> might want to enable this error for these specific submodules.

That's cool, I'm looking forward to this. Could you point me to
somewhere detailing this?

But in the meantime, on top of the advice.* config, how about having a
submodule.<name>.ignoreUninit config to disable the message on a
per-submodule basis?

> But in
> any case the error message should contain a hint on how you can get
> rid of the error in case you know what you are doing ;-).

The message does mention that you can throw in an --init to fix the
problem. This "hint" is similar to what git-submodule prints when a
<path> is passed (see region at line 807).

-- 
Cheers,
Ray Chuan
