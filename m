From: Allen Hubbe <allenbh@gmail.com>
Subject: Re: [PATCH v4] send-email: Add simple email aliases format
Date: Fri, 22 May 2015 11:39:39 -0400
Message-ID: <CAJ80sateODWDUvkAf9YbMMSYv_-=nKnBopGjgDFFSkVHuQJJMQ@mail.gmail.com>
References: <9f88da801466c83331d02262855e8bef4164e5eb.1432266004.git.allenbh@gmail.com>
	<CAPig+cRLxk26p7DFaS+gRkKZxkRwf8g=4=j2QHX6AC2Uk5J++w@mail.gmail.com>
	<CAJ80satbXXBYva9qrgR1oA_f7LAHUeAm21=R-mGsWx+sDoQ9sQ@mail.gmail.com>
	<xmqqlhggfz97.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 22 17:39:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yvp33-0006AC-88
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 17:39:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964818AbbEVPjk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2015 11:39:40 -0400
Received: from mail-wg0-f46.google.com ([74.125.82.46]:34373 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756486AbbEVPjk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2015 11:39:40 -0400
Received: by wghq2 with SMTP id q2so21503739wgh.1
        for <git@vger.kernel.org>; Fri, 22 May 2015 08:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=O851NfyHlwPwNMUJb1rFxNuz5hXTyDN3Xn5vGAEbX/4=;
        b=XsKwTXWFPu/Yh9ATmJRhokwco/eW/ZmHvs2Ze6KXbCyMq0sJ1swXAvH/PNGLFoUpNc
         xGEj1cZYxtF1VmsYI/mJoNfP5cp5lQ2NE7PxllKzUGeZqkcFVfRf5LePIDz2+DE3FXqv
         rN8xYlbxMZMbtgp8qpxCdgVmiPR/huz47/ruTPCnayNZZLsH78Ii1Sbq94vnUCBg0778
         Ihq6afKQlzGFzhQeO9JwLK0VZ0V6DwnmM2U09eP2sqnYQspk9aeVmH/RLFHuWvLgqUEN
         YCwyHUex6SrS/KrOsa5cGtrrShQxIMIZwJIjmSMwnE0Rw+tIxkm6YU3HiHGhM4gTVdKI
         RvgA==
X-Received: by 10.180.206.229 with SMTP id lr5mr8850055wic.86.1432309179095;
 Fri, 22 May 2015 08:39:39 -0700 (PDT)
Received: by 10.28.59.4 with HTTP; Fri, 22 May 2015 08:39:39 -0700 (PDT)
In-Reply-To: <xmqqlhggfz97.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269728>

On Fri, May 22, 2015 at 10:44 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Allen Hubbe <allenbh@gmail.com> writes:
>
>> It depends what we want to do with this parser: accept existing
>> sendmail aliases files in git, or enforce that git alias files are
>> usable for sendmail.  I really don't expect the second to ever happen.
>> The first, maybe, but only if the alias file is edited to remove
>> aliases of pipes and maildirs etc.  The second may not work if we have
>> comments to the right, or aliases of aliases, which sendmail does not
>> claim to support.
>
> Let me step back a bit.  Earlier you said your aim is not to use an
> alias file you already have and use with the MUA/MTA, but to have a
> collection of aliases to use with git-send-email only.  Is there a
> reason to add support for a new format (whether it is compatible to
> or subset of postfix/sendmail format, or a totally new one) for that
> goal?  What makes the existing formats unsuitable?
>

It's just a matter of personal preference what is suitable or not, for
me, in my environment, etc.  Is there a reason I should use the alias
format of some email client, if I don't use that email client?

I'm not trying to force anything on anyone else by offering this, just
another option that might be suitable for someone else, in their
environment, as it is in mine.  People who don't like it can choose a
different option.  People who don't like any of the options can write
their own like I did, or is that not allowed for some reason?

I've already shown that I am willing to change the name, write the
documentation, write the tests, modify the syntax, and so on.  I've
done the work, from +6 lines to +57 lines, as requested.  I'm not
looking forward to v5, v6... v10 of what was a really really simple
patch.  If you don't like it, please don't string me along.  This is
not my job.  If you think the patch is generally ok, but could be
improved to be accepted, then let's together try to make v5 the last.
