From: Christian Jaeger <chrjae@gmail.com>
Subject: Re: remote branches
Date: Wed, 16 Feb 2011 13:00:20 -0500
Message-ID: <AANLkTi=FYvgY-N2krTh3pdocJRXXVA5jqtBKgXj6OVEw@mail.gmail.com>
References: <4D578B6D.9090803@inria.fr> <AANLkTi=WPAYXg1NCyO+XDw8Jk5v=QBH3nM78CEHytuVQ@mail.gmail.com>
 <20110213103156.GB4202@atjola.homenet> <7vmxlzuouj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	Matthieu Imbert <matthieu.imbert@inria.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 16 19:00:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PplgF-00012z-5c
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 19:00:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754054Ab1BPSAm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Feb 2011 13:00:42 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:46585 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753234Ab1BPSAl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Feb 2011 13:00:41 -0500
Received: by qwa26 with SMTP id 26so1548554qwa.19
        for <git@vger.kernel.org>; Wed, 16 Feb 2011 10:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=nVezGQ9ya/tWWkqZ1q2C6MVsBk9H7ss+hl7995rVdoQ=;
        b=YlaJ+qPDSrwpGoO8MDuE+B/4QITa+c972Er1vomAMlMDfmMPXF4SSWcE7pGWD+kB+O
         ar1vkBOE871RvH1tQnU+CGtJXGOCf11qtQ6L1oieDpq8ALlttslZVYsdENI8gXimh/F/
         A3CVe44ORi6/KUh8tUrwN46idUv4g+dI+kLUY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=hqIr4bvQyq6nPA7WAXwr+of88bw5i1zWeenlNDFVWBBIZbS4V1W1qLQXgjezDnnKr5
         rRumpBBOH7oItTx99ZIrZsfYi3LBmJy3iMZ9UIrGtYJ4K+l8J9sSYg/gOeoykKcZW0mE
         SfKNxB4yGaOG2UTGtMX4FqA7qFayLs4vaiw6k=
Received: by 10.229.235.142 with SMTP id kg14mr1056036qcb.133.1297879240403;
 Wed, 16 Feb 2011 10:00:40 -0800 (PST)
Received: by 10.229.224.78 with HTTP; Wed, 16 Feb 2011 10:00:20 -0800 (PST)
In-Reply-To: <7vmxlzuouj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166981>

2011/2/14 Junio C Hamano <gitster@pobox.com>:
> The description in config.txt for --tags also cites another purpose,
> namely, to fetch tags otherwise totally unrelated to the branches you=
 are
> following, but in reality there is no sensible use case to require su=
ch a
> feature. =A0Yes, you may have many unrelated lines of development wit=
h
> separate set of tags on them, but then --tags to fetch _all_ tags fro=
m
> all of these unrelated lines of development is a too coarse-grained t=
ool
> to be useful.
>

=46WIW, here's my use case: I'm doing development on two separate
computers, and I'm synchronizing my work between those by fetching
from each other computer directly (not pushing through a common repo),
i.e. "git remote add other b:/home/me/foo/.git" in ~/foo/.git on
computer a and "git remote add other a:/home/me/foo/.git" on computer
b. Now I often drop partial work, rebase it etc., and make tags before
the dropping, and sometimes I want to revisit those tagged (but not
otherwise reachable) commits, and for that I want them to be available
on both computers. I too searched the config docs, tried "tagopts =3D
--tags" and then wondered why it wouldn't sync my branches anymore,
then moved to "fetch =3D +refs/tags/*:refs/tags/*".

Christian.
