From: Michael Witten <mfwitten@gmail.com>
Subject: Re: In favor of "git commit --no-parent"
Date: Fri, 30 Sep 2011 00:51:20 +0000
Message-ID: <CAMOZ1BuUvuyrf3Tio+9EZR_-b3zy-RWpq36+0rmDO+QKWaVmxQ@mail.gmail.com>
References: <1316960136073-6829212.post@n2.nabble.com> <1316961212.4388.5.camel@centaur.lab.cmartin.tk>
 <7vaa9r2jii.fsf@alter.siamese.dyndns.org> <1317073309.5579.9.camel@centaur.lab.cmartin.tk>
 <vpq39fi9gf5.fsf@bauges.imag.fr> <69d6fb3199bc4f74b25dae7992a9f132-mfwitten@gmail.com>
 <vpqsjni6kkk.fsf@bauges.imag.fr> <553B5FA1A43748B1ADD759572EADA6FF@PhilipOakley>
 <e4f46b39e9ed4203bfab8a81e25eb600-mfwitten@gmail.com> <7vaa9oz9rl.fsf@alter.siamese.dyndns.org>
 <271cc2ed03774b4988bb61cb3e79750e-mfwitten@gmail.com> <7vmxdnte0j.fsf@alter.siamese.dyndns.org>
 <CABURp0q8YhTS-GDYOANEa19P-V2wf_EUTo=RHqnhDB619w=y-w@mail.gmail.com>
 <7vd3ejrqin.fsf@alter.siamese.dyndns.org> <7v4nzvrp3k.fsf@alter.siamese.dyndns.org>
 <CABURp0rjBdx+=_8R5g16fNKWis3=GgJw9SQ9D53H6xu_-Tq3Uw@mail.gmail.com> <7vd3ejq74z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Phil Hord <phil.hord@gmail.com>,
	=?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@elego.de>,
	vra5107 <venkatram.akkineni@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Raible <raible@nextest.com>,
	Philip Oakley <philipoakley@iee.org>,
	Jeff King <peff@peff.net>, Jay Soffian <jaysoffian@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 30 02:51:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9RKW-00018e-1J
	for gcvg-git-2@lo.gmane.org; Fri, 30 Sep 2011 02:51:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754605Ab1I3Avv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Sep 2011 20:51:51 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:64780 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751507Ab1I3Avu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2011 20:51:50 -0400
Received: by iaqq3 with SMTP id q3so1248756iaq.19
        for <git@vger.kernel.org>; Thu, 29 Sep 2011 17:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Z5yclEJUlpN/0GqrQCNE1+uXSis3+EMPev2vs0RWH+w=;
        b=GcBz3E3SJvbdewk6eT/D+Hly8NtC2MQbieyjorG4rfVwcy8rU3cTkPYZuLyvSme6fR
         lwEa/t1OwOwby50GBZadeNPOWMIpdbmIo1MZVsSXGvApHSVMP90XJAaTTHWmSSMg6nxk
         V8g7QmSo3FeP9Si9bf2/rXfe4PSoJIwSsJmoM=
Received: by 10.42.18.202 with SMTP id y10mr1741883ica.19.1317343910055; Thu,
 29 Sep 2011 17:51:50 -0700 (PDT)
Received: by 10.42.171.194 with HTTP; Thu, 29 Sep 2011 17:51:20 -0700 (PDT)
In-Reply-To: <7vd3ejq74z.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182457>

On Thu, Sep 29, 2011 at 23:08, Junio C Hamano <gitster@pobox.com> wrote:

> The branch switching semantics of Git is designed to work well when all
> the branches you check out in the working tree are somewhat related
> content-wise. You create a new file, or make modifications to an existing
> file, realize that the change wants to go to a branch different from the
> current one. You _can_ switch to the branch the change should belong to,
> because the contents in the working tree is defined to be not tied to any
> branch, but is floating on top of the current branch.

That's exactly why "git commit --no-parent" is so useful.

Look at the difference:

  Creating a Hidden History (git commit --no-parent)

    $ cd repo
    $ git checkout -b hidden-history
    $ # Hack away as usual or not
    $ git status # As with any other commit.
    $ git commit --no-parent

  Creating a Hidden History (git checkout --orphan):

    $ cd repo
    $ git checkout --orphan hidden-history
    $ # Hack away as usual or not
    $ git status # lots of "new file" notifications obscuring my changes
    $ git commit

The main issue with "git commit --no-parent" is [supposedly] safety, but it
can be made pretty safe:

  $ cd repo
  $ # Hack away as usual or not
  $ git status # As with any other commit.
  $ git commit --no-parent
  Error! There must be another branch head directly referencing the
  same commit that is directly referenced by the current branch head!
  $ git checkout -b hidden-history
  $ git commit --no-parent

In the vast majority of cases, that rule will prevent people from
losing history inadvertantly, and no extra "--force" is required.
