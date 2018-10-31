Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7017C1F453
	for <e@80x24.org>; Wed, 31 Oct 2018 11:14:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbeJaUMU (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 16:12:20 -0400
Received: from mout.gmx.net ([212.227.17.22]:58313 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726223AbeJaUMU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 16:12:20 -0400
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LmNHK-1fj1bQ0OH4-00ZwlT; Wed, 31
 Oct 2018 12:14:38 +0100
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LmNHK-1fj1bQ0OH4-00ZwlT; Wed, 31
 Oct 2018 12:14:38 +0100
Date:   Wed, 31 Oct 2018 12:14:50 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     chris via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, chris <chris@webstech.net>
Subject: Re: [PATCH 1/1] Use correct /dev/null for UNIX and Windows
In-Reply-To: <xmqqo9bawvpf.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1810311210410.4546@tvgsbejvaqbjf.bet>
References: <pull.59.git.gitgitgadget@gmail.com> <8159cbd1b8025f33fb9d0e254db1a3c2a066f853.1540923993.git.gitgitgadget@gmail.com> <xmqqo9bawvpf.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:7hRr2XuOS2ZK7uXaF1kECTPg97TyhOmZ9v6xgd+W9FdahjXTCi1
 2rALu3WgHu+YUI5GOFFz1dyEBCNhGYNWBGy+cAhd0lA3qbk7h3/eWEpiTe7OGbgtq4HsmR+
 Mrgmej6rxUgcor07uNsogfbJcHd/xEQ4YqT89KNDPKVRK2EkKvDjzKIGSe/rbQz2c/tO+iX
 pvQ6gEXUJLrefxSvwbvtA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HoT9jBdVe3I=:Su7KQOAsCMsSymFVpIAyVK
 VXvdWgt8RMSr9ezlkCAONXJF/5/L9mfu5EDsAu0gtUM0R3SaFDexaA4KqVuXTQcGyhvE/HdBF
 mMZhDhkfyGPGmF5kPd+fr8EDJeBSD5rBmND53cxMGnQpWyChQV/SCAoGIKOF447sqtfj4sJne
 JR5qxviRJNMDCi4SrET2PVhY80vznSU4DKKVeCrVpwjzXvc1F0VZ9sHvQ551y+npY7GkzyFgH
 hrcO2OEYJrCtmW2+3eOjLpluiUhakmRBgRUBSBLsp096tYznYGp1knKfck4wgx1oj4YBwzGpj
 AsnUgitcODH1IsU2n9DEkRZXb0GEmjXHrmJKgFsXmizZG49kmk0gVNvJbfC9qx7BYm8lSs1w8
 k05MKj4mivYUvQYOF3Ln0hciDktHdDsUtRUXnTLBiV1fSM1n0GEM9mt9B8WFdQYrFG4IgI/qe
 BfV5QfbuzBzg/iNbkqtyd10hmvVc5a9JWvN0VatV0Z0Cjs5UIpL8bqaQi141q+aOLfj1Mzal+
 Js3/XBTwdW7+Dzy6ANdEnYypbsSePxu9IgtmDxeMmg/RC/la7VnU/HKFj5tL8YkQJAsBrC3q5
 NzWs9yrtYsByi4A/bMj4vA2LgMQpwwKYvyNZ6nyg0UBz08MYNVHm1X9BWcZQTNKPKDyZjsBzQ
 ThX0tkhD7ankeesFqWjRDUMpco8iLkGitp2Be+3k9RNSiVi9ZdD39GweXUfY36O2xapxnvooA
 fOTAeWlKw08rO00bTbifjptHP3ru4mZfGZ6kMpI++lPev77ormJbYOsae4Qls7nhDrJTl+Gjs
 OTewpIuUeeuJc6NKMWmeqaL1H92Qui10TBF7ejZwAust24p0GI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, 31 Oct 2018, Junio C Hamano wrote:

> > From: chris <chris@webstech.net>
> 
> Please make this line read like
> 
> 	From: Chris Webster <chris@webstech.net>
> 
> i.e. the author should be the person who is signing off that patch.

This is most likely recorded as the commit's author in the commit
object... Chris, to fix it, make sure that your `user.name` is configured
correctly, and then call `git commit --amend --reset-author`.

> > Use File::Spec->devnull() for output redirection to avoid messages
> > when Windows version of Perl is first in path.  The message 'The
> > system cannot find the path specified.' is displayed each time git is
> > run to get colors.
> >
> > Signed-off-by: Chris. Webster <chris@webstech.net>
> > ---
> >  contrib/diff-highlight/DiffHighlight.pm | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> There are a handful more instances of /dev/null found if you do
> 
> 	$ git grep /dev/null -- \*.pl \*.pm
> 
> The one in perl/Git.pm must be shared by scripts written in Perl, so
> it may be worth giving the same tweak to it, like this patch does to
> the highlight script.

I do not think that perl/Git.pm is intended to run with any random Perl
interpreter. It has to be one that has been verified to work correctly
with the Perl code in perl/, and that code is notoriously reliant on POSIX
behavior, hence our choice to go with MSYS2 Perl (there *is* a MINGW Perl
package in Git for Windows' SDK, but it will most likely not work, in
particular because of the missing Subversion bindings).

So I would restrict the search to contrib/\*.pl, contrib/\*.perl and
contrib/\*.pm. The stuff in contrib/ is supposed to be semi-independent
from the particular Git one is using (and from whatever Perl is shipped
with it, if any).

Ciao,
Johannes

> > diff --git a/contrib/diff-highlight/DiffHighlight.pm b/contrib/diff-highlight/DiffHighlight.pm
> > index 536754583..7440aa1c4 100644
> > --- a/contrib/diff-highlight/DiffHighlight.pm
> > +++ b/contrib/diff-highlight/DiffHighlight.pm
> > @@ -4,6 +4,11 @@ use 5.008;
> >  use warnings FATAL => 'all';
> >  use strict;
> >  
> > +# Use the correct value for both UNIX and Windows (/dev/null vs nul)
> > +use File::Spec;
> > +
> > +my $NULL = File::Spec->devnull();
> > +
> >  # Highlight by reversing foreground and background. You could do
> >  # other things like bold or underline if you prefer.
> >  my @OLD_HIGHLIGHT = (
> > @@ -134,7 +139,7 @@ sub highlight_stdin {
> >  # fallback, which means we will work even if git can't be run.
> >  sub color_config {
> >  	my ($key, $default) = @_;
> > -	my $s = `git config --get-color $key 2>/dev/null`;
> > +	my $s = `git config --get-color $key 2>$NULL`;
> >  	return length($s) ? $s : $default;
> >  }
> 
