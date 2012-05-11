From: Phil Hord <phil.hord@gmail.com>
Subject: Re: submodule update --force
Date: Fri, 11 May 2012 16:56:07 -0400
Message-ID: <CABURp0rFQ+330X8g3C2rmozQ77zxqhZhReZhaYMi1FE4uKeQtA@mail.gmail.com>
References: <CAHOQ7J8r4m2rz57BdkM9CADHdHE1yDFwExyF87u=DCEXjqzcqw@mail.gmail.com>
 <CAHOQ7J9xCYL=x=_nbq-3ksC2nF7L0=kxu9JX6M60xM-Bxmyfag@mail.gmail.com>
 <7vobpwpoyi.fsf@alter.siamese.dyndns.org> <7vk40kpnia.fsf@alter.siamese.dyndns.org>
 <CAHOQ7J_6+sfU6egjvVSPj-FAS6zjSUT=a057=kz_wYbogHLMMA@mail.gmail.com>
 <7v8vh0ozge.fsf@alter.siamese.dyndns.org> <20120510185738.GE76400@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan Zager <szager@google.com>, git@vger.kernel.org,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Lars Hjemli <hjemli@gmail.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Fri May 11 22:56:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSwt8-00010x-C9
	for gcvg-git-2@plane.gmane.org; Fri, 11 May 2012 22:56:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932908Ab2EKU4a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 May 2012 16:56:30 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:33920 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932227Ab2EKU42 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 May 2012 16:56:28 -0400
Received: by yhmm54 with SMTP id m54so3048736yhm.19
        for <git@vger.kernel.org>; Fri, 11 May 2012 13:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=4yIesaXuO/AxeJ+LLHoXgzH2ir33xM3c4QAf8cGMydY=;
        b=WCPuUTXVuA4unBi2bAGP+Tm75JmgDcSDbXzy9PYK/sfpE6EsrD/jV3iG8xgEKhmqiA
         ghZMjCHEX39dxyInhPE6RV2IAej3GZKTcw8US2BOQy2z67ZEsJ1v9YjobZTvBkrwgyq8
         hf3EqixcVIGPYeJ/BNEW9QlcIb+v5juf1vMvQiWrbAGJu22SeHofS41oLxPtk3Dw3hux
         62zjIob8Tnq4R6Dciu4E74qwDVj7iWxeYri9TKrgmcwjNF2f+bhPg8rAMcU6SqvXyPi5
         yKsCYutJY/109k3adnzLAsYfftCSzeiAXdrJa3tnCPil44dV9YHoYuYZvN49cIPQYyKN
         R6zA==
Received: by 10.236.136.33 with SMTP id v21mr1804310yhi.17.1336769788219; Fri,
 11 May 2012 13:56:28 -0700 (PDT)
Received: by 10.146.87.9 with HTTP; Fri, 11 May 2012 13:56:07 -0700 (PDT)
In-Reply-To: <20120510185738.GE76400@book.hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197697>

On Thu, May 10, 2012 at 2:57 PM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
>
> Hallo all,
>
> On Thu, May 10, 2012 at 07:58:09AM -0700, Junio C Hamano wrote:
> > Stefan Zager <szager@google.com> writes:
> >
> > > ... =A0To my mind, any
> > > `git submodule` command should *always* run on the first level of
> > > submodules. =A0If you're going to specify --no-recurse, then why =
are you
> > > running `git submodule` at all? =A0I think 'recursion' only appli=
es to
> > > moving beyond the first level of submodules.
> >
> > Very true.
> >
> > Submodule folks, any opinion on the Stefan's approach?
>
> The distinction between first level of submodules and deeper is only
> present in the "git submodule" subcommand and I think mainly for
> historical reasons. I do not see a use case where this would be helpf=
ul.

Do I understand you to mean that you think the git-submodule ...
--recursive option is archaic?  I would agree that one might expect it
to be the default option, but I do not think it should be deprecated
in any way.

> To skip uninteresting submodules one can always use the
> submodule.$name.update option set to 'none'. (I just found that its
> documentation is in the wrong place but I will send a seperate patch
> about that).
>
> In the non submodule commands we usually name this option
> --recurse-submodules=3Dalways and have another
> --recurse-submodules=3Don-demand option for the current behavior. Tho=
se
> options would either recurse or do nothing with the submodule.  Such =
a
> behavior, as pointed out, does not make sense for 'submodule update'.
> Similar options names for 'submodule update' would probably be
> --recurse=3Dalways and --recurse=3Don-demand.
>
> Nonetheless is force a term where the user probably wants to skip all
> optimizations which the sha1 equality provides. So to make the curren=
t
> behavior more consistent I would be fine with adding this change.
>
> One thing which might make force even more useful would be to also sk=
ip
> the "is the sha1 available"-check for fetch that is possibly run befo=
re
> the checkout and just always run the fetch.
>
> In the long term, once checkout has learned things 'submodule update'=
 is
> currently doing, it probably makes sense to let 'submodule update'
> always recurse into all checked out submodules. Since then it does no=
t
> make sense to run 'submodule update' for much more than resetting
> things or changing the currently registered commits anymore. So in th=
e
> bright new future the 'on-demand' part will probably move away from
> 'submodule update' and as such it does not make sense to implement
> the seperate recurse options I described above.
>
> What do others think?

I think there are three cases:

1. I want to update any sha1-mismatching submodules so
    their HEAD matches the superproject gitlink.

    git submodule update

2. Same as (1) above, but also check out files for all
    submodules which are not already checked out.

    git submodule update &&
    git submodule foreach 'git checkout HEAD || :'

3. I want to update exactly to the gitlinks in the superproject
   and discard any local or staged changes.

    git submodule update -f

(2) above is the case Junio was trying to cover.  I cannot think of an
elegant name for the switch for such an option, but I would be
surprised it to find it is not the default behavior if I also
encountered it like Stefan did.  We should try to eliminate surprises
to help dispel the notion that submodules are unwieldy.

(3) is too heavy when I really only wanted (2).

I do not understand that use case that led Stefan to the predicament
he was in where he had submodules with HEADs but with no checked out
files.  But I do not begrudge his being there.


Regards,
Phil
