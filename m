From: Joe Ratterman <jratt0@gmail.com>
Subject: Re: [PATCH] Add two grep config options
Date: Mon, 28 Mar 2011 09:48:19 -0500
Message-ID: <AANLkTin_qRH54C0wKML67gftS05X98sKE+AxHJ4xo77C@mail.gmail.com>
References: <1301088071-918-1-git-send-email-jratt0@gmail.com>
	<7vlj024wal.fsf@alter.siamese.dyndns.org>
	<4D9037AA.9090601@drmicha.warpmail.net>
	<AANLkTin_qeFSqyXHddmEpu=5e4yO8cxyOkbhcXUg3efn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Mar 28 16:48:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4Dk3-0003ic-Io
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 16:48:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754227Ab1C1OsV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 10:48:21 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:49893 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753939Ab1C1OsU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 10:48:20 -0400
Received: by gwaa18 with SMTP id a18so1186192gwa.19
        for <git@vger.kernel.org>; Mon, 28 Mar 2011 07:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=VNpiyk3Vt2kI6KZfmXcuAj8NQZ94T82ZGjLm99ze6QE=;
        b=I8QNaQbwdkTqcu1uCMAbWaEJrY3kdYvPqjOOm3NIBIUEd4RTInWuyMOikcvAeo0Edq
         AmtVsalfwDXeCvhF+HyoC1UvUn9MRotDvrPrl10DAL+AI2DzP747UD1TNaKEXKUbu2e0
         24PlMU9ljiLPKNN8HZfz/HBP5VxMd/jN7z15Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=JsBXoeU3pRS7PnURQPsSrEUpEmonPQoxOB+P/EHg3fvTeGqhtffrTQzuC15DZjRIey
         d4tT6T6iIBt6dVJRETTktWqB+XLubczqa9tJKkVLBXtjO8rt7E6pmNAyRb8swst/95Dn
         18l1bHIscCM5oNf2KF9GgVzuRIDycfceNsIhg=
Received: by 10.42.132.5 with SMTP id b5mr7147825ict.484.1301323699328; Mon,
 28 Mar 2011 07:48:19 -0700 (PDT)
Received: by 10.42.218.1 with HTTP; Mon, 28 Mar 2011 07:48:19 -0700 (PDT)
In-Reply-To: <AANLkTin_qeFSqyXHddmEpu=5e4yO8cxyOkbhcXUg3efn@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170134>

On Mon, Mar 28, 2011 at 7:13 AM, Bert Wesarg <bert.wesarg@googlemail.com> wrote:
>
> On Mon, Mar 28, 2011 at 09:24, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
> > We could safeguard scripts from this by
> >
> > - checking istty and
>
> That should consider running under the pager too.
>
> I had proposed this scheme last year to TopGit as a way to
> differentiate between ui and plumbing. But as Jeff pointed out, this
> is probably not enough.
>
> Bert
>
> > - checking env for GIT_PLUMBING
> >


Thanks for looking over this and taking the time to comment.  I had
not considered the importance of the first line, nor had I noticed the
lack of hyphens in the other options--I copied the name of
grep.extended-regexp from the --extended-regexp grep option.  I can
change those things if the general idea is accepted.  I like the idea
of a single option config key have takes a list of command-line flags,
but I'm not 100% sure I know enough about git code internals to
implement it.  I'll look.

With regard to disabling the line numbering, GNU grep supports both -n
and --line-number.  Adding the latter option to git grep allows for
the long form --no-line-number.  Another option would be to use -N for
the negative, like -h and -H.  GNU grep doesn't support either of
those.


Thanks,
Joe Ratterman
