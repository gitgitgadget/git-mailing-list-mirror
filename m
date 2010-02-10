From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: git cherry-pick --continue?
Date: Wed, 10 Feb 2010 23:38:28 +0100
Message-ID: <fabb9a1e1002101438v74aea1b9v482ff49fa4ddd15d@mail.gmail.com>
References: <fabb9a1e1002101237i60a0b2c5j6d1e52b33dacbaa2@mail.gmail.com> 
	<20100210210419.GA7728@coredump.intra.peff.net> <20100210212408.GB7728@coredump.intra.peff.net> 
	<7v63644uoq.fsf@alter.siamese.dyndns.org> <7vbpfw3f6t.fsf@alter.siamese.dyndns.org> 
	<fabb9a1e1002101423y79460afdn2bc31b117195ef42@mail.gmail.com> 
	<7vpr4c200i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 10 23:46:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfLKP-00027j-5K
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 23:46:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756596Ab0BJWqR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Feb 2010 17:46:17 -0500
Received: from mail-iw0-f185.google.com ([209.85.223.185]:49541 "EHLO
	mail-iw0-f185.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756477Ab0BJWqO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Feb 2010 17:46:14 -0500
Received: by iwn15 with SMTP id 15so637733iwn.19
        for <git@vger.kernel.org>; Wed, 10 Feb 2010 14:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=GuF36bP6Q+f21fyt0BoPr+RHOWXGw+X6eSR8h2BokH8=;
        b=uVelp51qh7RlhvPnTPQ3njr/eaAlupgkCAXN98Pet54UZHdUIDAxhb7SxIRf+irdhi
         56l3t8sGJEmhvbqE54RBETnXKU6I0jQcGF+CV4XI17WpZO29WWC4m77WRQbn/PJN+8BY
         Zs4iv09bc1KhCZaQ/kbAXzM6xi6rofaNS4RtU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=r80i88dOaOhozePSvhdteqt6laSQspD2bIdlkesxJFfGXY0G45Kfn8nV5CuYgXngss
         8aKk3kgwClvPbasSXPfQvDbur8ct0iQbiDpNzBfPpA1G7io73pooJEx1f++40BYbbNZ0
         KWfNFKqeYUkIafLy5Wg3JUTitQvEmXqorYC7Q=
Received: by 10.142.75.9 with SMTP id x9mr557226wfa.318.1265841528179; Wed, 10 
	Feb 2010 14:38:48 -0800 (PST)
In-Reply-To: <7vpr4c200i.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Heya,

On Wed, Feb 10, 2010 at 23:34, Junio C Hamano <gitster@pobox.com> wrote=
:
> Changing the insn to suggest using "-C topic" when the original comma=
nd
> line was "git cherry-pick topic" would be a good addition, too. =A0Cu=
rrently
> we suggest "-c" and abbreviated object name, neither of which is sens=
ible.

I think it's sensible to use '-c' instead of '-C', just like 'git
rebase -i' lets you change the commit message after you resolve a
conflict.

> While I think "--resolved" makes sense, I do not see much benefit, an=
d it
> largely depends on what you do. =A0If you are suggesting to commit wi=
th what
> is kept in $GIT_DIR/MERGE_MSG, I would actually recommend against it.=
 =A0The
> message will have "Conflicts:" information but that is meaningless un=
less
> you are recording from what context the commit was cherry-picked from=
 at
> the same time.

I'm not sure how to implement it, but I was thinking to just automate
the 'git commit -c ...' part. I don't like having to copy/paste some
instruction, so maybe we can record the original commit somewhere and
have 'git cherry-pick --resolve' be equivalent to 'git commit -c `cat
=2Egit/CHERRY_PICK_CMT`', or somesuch?

--=20
Cheers,

Sverre Rabbelier
