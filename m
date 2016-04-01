From: Christian Couder <christian.couder@gmail.com>
Subject: Re: GIT_CONFIG - what's the point?
Date: Fri, 1 Apr 2016 13:19:25 +0200
Message-ID: <CAP8UFD23w_F8UtaykyY1KqE6Hee9355GZT+C29JL8EmYQCc6Yg@mail.gmail.com>
References: <CAL20dLDQsti1qW7CrrEifPAhPp1snq9r5MgJL+mDwhLqhe6fyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Matthew Persico <matthew.persico@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 13:19:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alx70-00020E-Ku
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 13:19:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754186AbcDALTa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2016 07:19:30 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:32847 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754027AbcDALT1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2016 07:19:27 -0400
Received: by mail-wm0-f47.google.com with SMTP id f198so21648138wme.0
        for <git@vger.kernel.org>; Fri, 01 Apr 2016 04:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=PCqLt/HXL6U0DrT9IalCfBhGnSs7AsAp96JIUa0OSSU=;
        b=g2TCAXCb2oscrcmhwqSUIWFhXFB4vv+/HIOjUh6xR4YXcZwrGeJeqw0emTz4HrV2U2
         VflGzBrtfQ47TfD2k5lqLg2xLuQ4hAOJfSOwRYfFe7hcwXCiU+DIAFrnLR1uxxJxv+/e
         jfZ5Xa1F01+91CtgyKM5iMRu5yjo0ngsyIm+C95ApvMR7vdRnNXbTUJchqFUGYimSdBz
         Xt2aqI6VAqYuqjAlQdjssMwfaYDGi877CkGOKOJVzmhxpcKhNGdjkEq8gieaYma5rVUh
         tkd3ZeZ1nJ1gmGZyyYjznYDmhgNNaT8u+cgTXkOm61UXHW/MooUWqA8BQOpm/fHX5i5d
         DLmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=PCqLt/HXL6U0DrT9IalCfBhGnSs7AsAp96JIUa0OSSU=;
        b=Z1ru6ZnKhIUjzzauUs7NcGZm4oGzhbwYhn+nphLKfUzbQadOnsU3UOtUplZR5oJujh
         DrFRECXfjCgnCAX63BQ75moqu+Gv7+P423+lS9I5xPWXApneL/TiYsuFxac6ehhpwZ4d
         /w5acY3oFd43kxNNUlZPykfaU1jY0uC0/xmfc5J5BoMIPvFQHiTXEm10KeLjTIThGFcu
         Q3VxfZSFC9ZzpwlvaMb9Z/HQ6AifoyodnYeBVtK9zRVtiANXi1J9jmWCmozUEDitMxb0
         iXW/jqIfTO+0DrEIEEGDN2PlVJ1ReT84VXHP7Bg24s17Yoa0zRHO4BTdDgwS2CsKb8Od
         ttAA==
X-Gm-Message-State: AD7BkJLdXrjMIxYc0TnwYK9LjR1GJnjcjexrb4TImNI9eBJbq6gKaxBZ6Rlc4Lfz8WVkmp9jfghv9mhNLzmskg==
X-Received: by 10.194.78.37 with SMTP id y5mr8605605wjw.78.1459509565935; Fri,
 01 Apr 2016 04:19:25 -0700 (PDT)
Received: by 10.194.151.131 with HTTP; Fri, 1 Apr 2016 04:19:25 -0700 (PDT)
In-Reply-To: <CAL20dLDQsti1qW7CrrEifPAhPp1snq9r5MgJL+mDwhLqhe6fyQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290524>

On Fri, Apr 1, 2016 at 2:54 AM, Matthew Persico
<matthew.persico@gmail.com> wrote:
> Greetings.
>
> Given the GIT_CONFIG environment variable can change 'git config'
> behaves, it stands to reason that if GIT_CONFIG is defined, then ALL
> git commands obey the value of GIT_CONFIG and use that file for config
> info.
>
> As a test, exported GIT_CONFIG=/tmp/ohm, copied ~/.gitconfig to
> /tmp/ohm,

Is /tmp/ohm a directory? If that is the case, then you should probably
have exported "GIT_CONFIG=/tmp/ohm/.gitconfig", as the git config doc
says it specifies a filename.
