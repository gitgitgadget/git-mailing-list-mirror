From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 07/14] revert: Introduce struct to keep command-line
 options
Date: Wed, 6 Jul 2011 07:06:16 -0500
Message-ID: <20110706120616.GQ15682@elie>
References: <1309938868-2028-1-git-send-email-artagnon@gmail.com>
 <1309938868-2028-8-git-send-email-artagnon@gmail.com>
 <20110706090915.GD15682@elie>
 <CALkWK0=gm-y3CB83TsSiWWF4qyS5hOJDhOYCz4HTWyT7iHP6MA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 06 14:06:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeQsC-0001aT-4y
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 14:06:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753175Ab1GFMGW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jul 2011 08:06:22 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:35700 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752591Ab1GFMGV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2011 08:06:21 -0400
Received: by iwn6 with SMTP id 6so6012109iwn.19
        for <git@vger.kernel.org>; Wed, 06 Jul 2011 05:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=1JXkrkEOr99BT4MmE+51VoEu8Tiz1YkcT+qor80DqRA=;
        b=VpqXpgO7cinHULoC22Ls5z1FE/DFM2DDg7Iz6enVN9ZrkQvG9JsbUIBI/TdAUvAti2
         FwS8zDBzWvlzC4v7oQDhcJQ9kNnkN2xqO/bhBzqjU27okZBRJe8ko6p0qIn1QMP8Oq7R
         fHlSJ9bWxKSubw0nsqiQB2sFbOR58jjDagafg=
Received: by 10.42.196.68 with SMTP id ef4mr9618589icb.375.1309953980712;
        Wed, 06 Jul 2011 05:06:20 -0700 (PDT)
Received: from elie (adsl-69-209-76-243.dsl.chcgil.ameritech.net [69.209.76.243])
        by mx.google.com with ESMTPS id uo2sm5465060icb.22.2011.07.06.05.06.18
        (version=SSLv3 cipher=OTHER);
        Wed, 06 Jul 2011 05:06:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0=gm-y3CB83TsSiWWF4qyS5hOJDhOYCz4HTWyT7iHP6MA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176699>

Ramkumar Ramachandra wrote:

> My justification: in later steps, we'd want to be able to mix
> "pick" and "revert" instructions in the same instruction sheet.  This
> will essentially require the parser to return a commit + a replay_opts
> struct (which will contain the action information).

Side note: is it intended to support insns like

 pick A..B

?

Anyway, the above explanation about the intended use for "struct
replay_opts" (it needs to be small, I guess?) would be a good thing
to add to the commit message, too.  Basically, whatever information a
person needs in order to understand the design is a useful thing to
add.

[...]
> Yes, I'm definitely considering exposing parse_args in the future,
> especially since I want to support command-line options in my
> instruction sheet.

Hm, I am not sure what to think about this direction (is the git
sequencer actually just a fast git shell?  in that case, why is pick
spelled "pick" instead of "cherry-pick"?).  Maybe it's a good thing.

Thanks for some useful clarifications.
