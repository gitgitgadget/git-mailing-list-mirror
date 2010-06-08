From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: RFC: Making submodules "track" branches
Date: Tue, 8 Jun 2010 23:19:39 +0000
Message-ID: <AANLkTimApr6P0sQ0FQiNkzhFuftOu1e4VefQxUCXpA53@mail.gmail.com>
References: <AANLkTilBQPHgkCLJ7ppNo5TwC9Bdmqo-OMRpaDFwbQPd@mail.gmail.com>
	<201006080912.31448.johan@herland.net>
	<4C0E6A8A.70608@web.de>
	<7vbpblruj8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 09 01:19:46 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OM85C-0004QY-7k
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 01:19:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756011Ab0FHXTl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Jun 2010 19:19:41 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:47866 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755197Ab0FHXTk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Jun 2010 19:19:40 -0400
Received: by iwn37 with SMTP id 37so5195008iwn.19
        for <git@vger.kernel.org>; Tue, 08 Jun 2010 16:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=9MDTLXGhZzQEXenh4KSTzdV8LQWkPd31Vb1b9/wGMs8=;
        b=b4i0Sq9Qn3hqe2GzfWedPEALnEejPPxHsQaU72MZIYV5fl/EcZwA5MF2zVEX4X6dub
         GvKLZUQLZks762JFRRIgXWXqafkhaW7bEwf+ptFmy0pNF/GZJIImwkVeYgswMcQMQUSa
         8fnO1rvMAidx17HzsAx+ETTReACfMuLOortoM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=cj0wxyu8RUG4g2sKY5jF+C2A1h5pwsxyxxcsbwVZUWrrlN2AzgyPw1ctNnkwgv9UEt
         fSMJICsgRdY3McC2eDfRvVUKooTUtsoSg6ghUlkJh9r0HWzPPM27+7v775LCudMaJ6sV
         K9SMCTB7flifdj3PCLsopPMrMMpvKWOfawbPg=
Received: by 10.231.79.4 with SMTP id n4mr11462192ibk.16.1276039179370; Tue, 
	08 Jun 2010 16:19:39 -0700 (PDT)
Received: by 10.231.155.144 with HTTP; Tue, 8 Jun 2010 16:19:39 -0700 (PDT)
In-Reply-To: <7vbpblruj8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148732>

On Tue, Jun 8, 2010 at 23:09, Junio C Hamano <gitster@pobox.com> wrote:
> Wouldn't it be enough to say --ignore-submodules for your day-to-day =
work,
> without lying in the gitlink entry in the superproject tree? =C2=A0An=
 entry
> "submodule.foo.branch =3D fred" in your .gitmodules will still tell y=
our
> local git to update the submodule worktree to work on 'fred' branch. =
=C2=A0At
> least, an arrangement like that would allow the build infrastructure =
to
> use --no-ignore-submodules when running its equivalent of GIT-VERSION=
-GEN
> to notice that what you are building is using something different fro=
m
> what the superproject specified to use in the submodule, while not bu=
gging
> you with differences you do not care about (or you already know about=
 and
> are irrelevant to the change you are working on).

Yes I think that's even better, to have no entry in the superproject's
tree at all, and just a repo/branch pair in .gitmodules.

Less confusion and the same features.
