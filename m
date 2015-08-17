From: Dave Borowitz <dborowitz@google.com>
Subject: Re: [PATCH 7/7] Add a config option push.gpgSign for default signed pushes
Date: Mon, 17 Aug 2015 15:49:31 -0400
Message-ID: <CAD0k6qRa+exs-Qf+iaRqOhcP4dYvS3Pt3AArLXx_XZucD28c=w@mail.gmail.com>
References: <1439492451-11233-1-git-send-email-dborowitz@google.com>
 <1439492451-11233-8-git-send-email-dborowitz@google.com> <xmqqy4h9et2m.fsf@gitster.dls.corp.google.com>
 <CAD0k6qTnJPc+Nh6dck0_Zx9vnyn5YVMCmy3E=7vr8bTpRSppAA@mail.gmail.com> <xmqqk2std7lt.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 21:49:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRQPs-0007Ds-HB
	for gcvg-git-2@plane.gmane.org; Mon, 17 Aug 2015 21:49:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751771AbbHQTtw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2015 15:49:52 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:34460 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751011AbbHQTtv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2015 15:49:51 -0400
Received: by igui7 with SMTP id i7so65881673igu.1
        for <git@vger.kernel.org>; Mon, 17 Aug 2015 12:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=v8zPBlTLU37xwhzx0UydcF1GbQSp5DYNdhLHbmKQ+3Q=;
        b=Ia8favR+Yt+y4IlKuzNyGf71TKaLT4E50AO5v5Jfx6ROjXazNeMlqVtBO9znfTAnTo
         vbMBK6ZnIV6bLN+eqUZysRakOBOGI10XEwszeTuR6cLApfX7LfyVnQRCMge8Y2202XhG
         FhHIi1xddbLEThDYglvKFA6KA7HAnPed/luE2hSXyy7Q4IZHHbDfs7K535WA9QzhzXgy
         jp6c9hVAdLQVHQcb/m8LoADGCH7IJj5X8VcGVQVNJpeJJvB70gXcACWx3ZJlGSRP79CB
         yhJkTvbVr6fU5InaHRSOK7c46naBF/9lUMMw0dYlNw5dH+XDt+ttpXktI2HVLB3OvEHK
         T4IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=v8zPBlTLU37xwhzx0UydcF1GbQSp5DYNdhLHbmKQ+3Q=;
        b=LbB56BayfGoGtsTOHWamXL7w4i8j6lxIswRaPaP5dq1IgbWmLkuJYNtMCJUcZN6RGX
         mvZdSYTw7Qt+9FnMLLL6t6uLoYuM6mkSifHuYyiwwj3dpOm4xQ6xrjQB80l83JjR0IQ9
         VPUtPMXlvJ1hxJvwnp0Gf2a7oLeEZmWYCLyQ3onTDMY3eNPGECWsRIz4/lJl+CRbqyyP
         GZnoSid2Z0DntdjgFnroyk0oaIshaCzNySAk/0J04xLxgfgWFpRcsD7xxB/xRehuA3ir
         BfijpepRemPIemioO81i2u4LKAAkq0WcPRJgSJb+kMwcCHGxYN3f6xX+Rf7ieP9gfY19
         KvQA==
X-Gm-Message-State: ALoCoQmgnd/PowXHDwN7rOOcAsBgxthd+1rZnwh1p31LJ9hDI8cle3sFjXlPjlNhYQjMO5f5DTSF
X-Received: by 10.50.27.39 with SMTP id q7mr17093734igg.73.1439840991222; Mon,
 17 Aug 2015 12:49:51 -0700 (PDT)
Received: by 10.107.4.201 with HTTP; Mon, 17 Aug 2015 12:49:31 -0700 (PDT)
In-Reply-To: <xmqqk2std7lt.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276085>

On Mon, Aug 17, 2015 at 3:42 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Dave Borowitz <dborowitz@google.com> writes:
>
> > The issue is that if both _ALWAYS and _IF_POSSIBLE are set,
> > git_transport_push interprets it as _ALWAYS. But, we are also supposed
> > to prefer explicit command-line options to config values.
> >
> > Suppose we parsed config first, then options. If the user has
> > push.signed = always and and passes --signed-if-possible, then the end
> > result is (_ALWAYS | _IF_POSSIBLE), aka always,...
>
> Doesn't that merely suggest that the option parsing is implemented
> incorrectly?  Why is --signed-if-possible just ORing its bits into
> the flag, instead of clearing and setting?

Yes, that would be incorrect, but the actual implementation in my
patch is not incorrect, it just solves the problem a different way.

The alternative I suggested is another correct implementation, and it
sounds like it's more in line with the convention you expect. I'll go
with that.
