From: Vasily Titskiy <qehgt0@gmail.com>
Subject: Re: [PATCH v2] Ignore dirty submodule states during stash
Date: Tue, 17 May 2016 12:38:19 -0400
Message-ID: <CABSveYgsRU+L5qvY_evwekaRU7-oL_2Mmxt6L1u2dYM7Xfq2rw@mail.gmail.com>
References: <20160517131635.GA5299@gmail.com> <xmqqmvnoy82r.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 17 18:38:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2i17-0004wM-39
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 18:38:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755717AbcEQQik (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2016 12:38:40 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:33558 "EHLO
	mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755432AbcEQQik (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2016 12:38:40 -0400
Received: by mail-yw0-f196.google.com with SMTP id y6so2952994ywe.0
        for <git@vger.kernel.org>; Tue, 17 May 2016 09:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HQfToVzoyCDNYOLoRTX5udw0FUUr193JzALnBsxwCJM=;
        b=IHfrwNCC4oADj4Ksw3xuxtAQpvfYRMzRVF1iBAxuN3G2ZnowKJXsA4XwShfQw4tF1d
         fZRvIpGyBcTXAjQAL2uXp2Pubdf0f0+bO1lbeOEOSe2ZajfEhRZXtzpolXHXUsmjjJYb
         0gLHgRLraVGTchc87RMebUna5ZiVMVxHFWwGBOSgKbZgfmMi31QgrRJ0R/U2SGYFpsHm
         Njfzh1H/d3ERe8ttKBcADMNx00PDsRGDbPrgriEPpnSmOQyZ7wod0HBrLkVYca6J8jWI
         +RFadZiZDnEnqSN2QmZTJoFmVFEJwCWMC0OdpKUg6y6LQRxj0vluNbGMPSJktidxSxQA
         krRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HQfToVzoyCDNYOLoRTX5udw0FUUr193JzALnBsxwCJM=;
        b=CxdhvhvRoUI1qLQvT20DUuaTFMdBjHzaNsE+teEYXP2Se1Zoagwn7S/vrSBFJ95IPv
         yXS45Dd4ruT0PyJKrzK+PPTnooRkMBkNUHVWdv7QxcdZyx4vndB7/pIsF/7uapP+0R3Z
         WMKf6PCg0EiLaxZZM1YglGuvIHuGD+qRQycAWz/t/Y+M5/iAsAguxwKIo39dY6dlvnL1
         tuUQTChy3AK0k9SMZB2JQj2Fod0uugrX2jxpZpYxCdaauiaco1w4oT+T9RFA1JnXTMcM
         2RTl1/CVq3ZX5yKO1d29BEH/tLQN1YdYDATFQVzNbIvzgWEUsm2vfJVNQpEuxzaI6IeP
         FKtw==
X-Gm-Message-State: AOPr4FWDaCZRhe+1w3u0Jf5H7I2Qjd6MGoGAVzj5zxKZP1qxX3MwosdP/V74TM5ID0azwTT0jUqNafstpeC1RA==
X-Received: by 10.37.66.17 with SMTP id p17mr1083345yba.97.1463503119264; Tue,
 17 May 2016 09:38:39 -0700 (PDT)
Received: by 10.37.203.145 with HTTP; Tue, 17 May 2016 09:38:19 -0700 (PDT)
In-Reply-To: <xmqqmvnoy82r.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294873>

Hi Junio,

You're right, it's redundant here. Should I resubmit the path without this line?

--
  Regards,
  Vasily Titskiy

On Tue, May 17, 2016 at 12:15 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Vasily Titskiy <qehgt0@gmail.com> writes:
>
> > diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> > index 2142c1f..1be62f3 100755
> > --- a/t/t3903-stash.sh
> > +++ b/t/t3903-stash.sh
> > @@ -731,4 +731,38 @@ test_expect_success 'stash list --cc shows combined diff' '
> >       test_cmp expect actual
> >  '
> >
> > +test_expect_success 'stash ignores changes in submodules' '
> > +     git submodule init &&
>
> Hmmmm... what is this "submodule init" needed for at this point in
> the test sequence?
>
> > +     git init sub1 &&
> > +     (
> > +             cd sub1 &&
> > +             echo "x" >file1 &&
> > +             git add file1 &&
> > +             git commit -a -m "initial sub1"
> > +     ) &&
> > +     git submodule add ./. sub1 &&
> > +     echo "main" >file1 &&
> > +     git add file1 &&
> > +     git commit -a -m "initial main" &&
> > +     # make changes in submodule
> > +     (
> > +             cd sub1 &&
> > +             echo "y" >>file1 &&
> > +             git commit -a -m "change y"
> > +     ) &&
> > +     git commit sub1 -m "update reference" &&
> > +     # switch submodule to another revision
> > +     (
> > +             cd sub1 &&
> > +             echo "z" >>file1 &&
> > +             git commit -a -m "change z"
> > +     ) &&
> > +     # everything is prepared, check if changes in submodules are ignored
> > +     echo "local change" >>file1 &&
> > +     git stash save &&
> > +     git checkout HEAD~1 &&
> > +     git submodule update &&
> > +     git stash pop
> > +'
> > +
> >  test_done
