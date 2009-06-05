From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [Patch] Prevent cloning over http from spewing
Date: Fri, 5 Jun 2009 02:17:32 +0200
Message-ID: <200906050217.33728.jnareb@gmail.com>
References: <20090602174229.GA14455@infidigm.net> <m3vdnda9f7.fsf@localhost.localdomain> <7vmy8p8947.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: sparse@infidigm.net, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 05 02:17:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCN88-0000VY-5L
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 02:17:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751658AbZFEARr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Jun 2009 20:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751308AbZFEARq
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jun 2009 20:17:46 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:52960 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751202AbZFEARp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jun 2009 20:17:45 -0400
Received: by bwz9 with SMTP id 9so1144379bwz.37
        for <git@vger.kernel.org>; Thu, 04 Jun 2009 17:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=dv1NaV854yJlON9+q2CquMGHLtGQ03IipdDuiQQmqKk=;
        b=Z/06OWnHCodXPZ+kfzVaV7a1f+IGLfybxfhODPyOEsieaOKj+P55thdQcQA6tFpegz
         4cU4KBS6PWI6pnMb76LnPFj7bthL9FkfVY+jtyNE52bRlIL5l0maDELtTtd61DN35Fli
         +LwcKrMAPTRCKx5RdS4gAo+PuKnBlM2Hd3UlA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=N7EzfKOcuUGsuXJfKLVm+IoCWLtADbXp6oTYjaX8r1KxGlDx0rDF72PQmnaVIsAMjM
         d6BHs5VZ6D72XmSEkmyvB14KKNpj8QxUTSzfej6Z9RIy8dVfmRKQQTR/aPWmBHfG5uks
         3fgF5vRr+/h/ZK4hgLrv3peWU9A4R6sK6Wef8=
Received: by 10.103.172.7 with SMTP id z7mr1773231muo.129.1244161066315;
        Thu, 04 Jun 2009 17:17:46 -0700 (PDT)
Received: from ?192.168.1.13? (abvg76.neoplus.adsl.tpnet.pl [83.8.204.76])
        by mx.google.com with ESMTPS id j2sm2332142mue.12.2009.06.04.17.17.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Jun 2009 17:17:45 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vmy8p8947.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120729>

On Wed, 3 Jun 2009, Junio C Hamano napisa=B3:
> Jakub Narebski <jnareb@gmail.com> writes:
>=20
> > Finally a question: if we turn off verbose output, do we have any k=
ind
> > of progress info for git-clone over http?
[...]

> You _could_ do something like this patch.  Instead of showing "walk %=
s"
> and "got %s" lines, with occasional "Getting pack %s\n which contains=
 %s",
> it shows and recycles a single line that shows the number of packs, w=
alk
> actions and got actions.
>=20
> This is a toy patch; it hiccups for too long while getting each pack,=
 and
> it does not cleanly restore the display after it finishes, but I'll l=
eave
> it to interested readers as an exercise to properly do this using the
> progress API.

I know it is toy patch only, but I wonder if we would want to output
current format output (walk/got chains) for '--verbose' option...

--=20
Jakub Narebski
Poland
