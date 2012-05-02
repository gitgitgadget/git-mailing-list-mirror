From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 2/2] index-v4: document the entry format
Date: Wed, 2 May 2012 10:13:44 -0700
Message-ID: <CAJo=hJukfmnfvuU5TWk6ftJ9pG+bSMa2t1ETH=0v=ZKwsbQ2wA@mail.gmail.com>
References: <1333493596-14202-1-git-send-email-gitster@pobox.com>
 <xmqqzk9w93zu.fsf@junio.mtv.corp.google.com> <xmqqpqas93sa.fsf_-_@junio.mtv.corp.google.com>
 <87vckhuofj.fsf@thomas.inf.ethz.ch> <7vlilcczzb.fsf@alter.siamese.dyndns.org>
 <CAJo=hJvFfVbYRKtPDJbd8MXKFDAyk==Sbm8oTgypbpE2O4o1=w@mail.gmail.com> <7vlilaikfo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Thomas Gummerer <t.gummerer@gmail.com>,
	David Michael Barr <davidbarr@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 02 19:20:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPdDq-0006US-V0
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 19:20:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755272Ab2EBRUI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 May 2012 13:20:08 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:56601 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754535Ab2EBRUH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2012 13:20:07 -0400
X-Greylist: delayed 361 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 May 2012 13:20:07 EDT
Received: by dady13 with SMTP id y13so101667dad.5
        for <git@vger.kernel.org>; Wed, 02 May 2012 10:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=JonggS8P91Nbg0oQRtmYFbEuXunmOesAjiTTn44SsKo=;
        b=WNRRm4z/gXIfo4HztxudC8kq4Z7h32tZLV1R12TXfpDvCV46mS72Oo8vDopGWxFI7m
         YheG9ZmnbTzLJXbj+oRVCA51vIes1mekuwxVnIi4Nhel7oCc+3bIiqvSZjoSbwTKmG+8
         7aqoDwBUB0Cygkii/JVWS3gW3rUFP5twE7AK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-gm-message-state;
        bh=JonggS8P91Nbg0oQRtmYFbEuXunmOesAjiTTn44SsKo=;
        b=bcgmLU7s+nu88hJ8g4g3yUv6A12uS10SL2lqDvwxcmISLKyt7k6c2rr0pJK/U0V58p
         bbuCjqRZ2etIVrNX3kfszHNA5ndbIg8AIyJ8wDjSZerhuM6SeuTpznhWP+ZL7zNnqYLA
         DTldVuha9+z7TzpOsjXL7/T83SgXR3lj4qXZudcWggk4Q2vkgSDdHN0n9oueaG5WshFa
         RcoYOp+fSs4aqIXwqacjT/KFuuREI4og3KPaeNF5wIxGc2fm2UWJ3IlndjknB/N702md
         smZc2S0xmfKpXR/9W40xxZvyMetQKHsMxdgzreKdv4Hyqz5XWiyrh87rouVJgqYCdDHZ
         WtUg==
Received: by 10.68.220.134 with SMTP id pw6mr10695374pbc.149.1335978844528;
 Wed, 02 May 2012 10:14:04 -0700 (PDT)
Received: by 10.68.211.74 with HTTP; Wed, 2 May 2012 10:13:44 -0700 (PDT)
In-Reply-To: <7vlilaikfo.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQl9LaJE1G5EaHOPKxzjoePCO8+vIjYJ3GBgyi9JGmqswnthJnN5pAeKXnTh79kAolaiJAL9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196845>

On Wed, May 2, 2012 at 10:04 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
>
>> IMHO, keep this in next to avoid releasing it until we know the
>> outcome of the GSoC project. The handful of WebKit developers that use
>> Git that really benefit from index v4 can use it by building and
>> installing their own next.
>> ...
>> Its only a few months to wait and see where "v5" goes. If v5 is
>> successful, v4 will just be a minor footnote in the history of Git,
>> and other tools won't need to support v4, they can go straight to v5.
>
> You may not have noticed this, but there is no practical difference
> between keeping it in 'next' and releasing it to 'master' from the
> third-party tool's point of view.
>
> There is _only_ one way to end up with v4 version of index: running "git
> update-index --index-version 4".

Thanks, I did miss this in the series. I hereby retract my complaint. :-)
