From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Expand ~ and ~user in core.excludesfile, commit.template
Date: Tue, 17 Nov 2009 10:30:37 +0100
Message-ID: <200911171030.38703.jnareb@gmail.com>
References: <1258366060-27966-1-git-send-email-Matthieu.Moy@imag.fr> <m3k4xqc9qj.fsf@localhost.localdomain> <7viqd9isbm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	Karl Chen <quarl@quarl.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 17 10:30:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAKOi-0000bQ-8d
	for gcvg-git-2@lo.gmane.org; Tue, 17 Nov 2009 10:30:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752905AbZKQJak convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Nov 2009 04:30:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752697AbZKQJak
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Nov 2009 04:30:40 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:36646 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752637AbZKQJai (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2009 04:30:38 -0500
Received: by bwz27 with SMTP id 27so126782bwz.21
        for <git@vger.kernel.org>; Tue, 17 Nov 2009 01:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=fzJ4e7MNyKy0bt095GXYTIXMzW743Gnj6CKRrds8Y2c=;
        b=Awmc+DbvdfX738VbrikKPg8phFIcwMhoysAp71MNVUAIBRWqQdzCbR0yoS04EXb+em
         GJvKMHuhG+ACDbHmA5vqbGh1NCe2oBrJNnIJSHGyTnNzgGgQGA1V5oxR5W7JKe6CUfBg
         n2DvXdefxwm5gTm66v8eiAPW7ymM6p9zW9dGc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=E/iaG9OSwvY8hK84wkU3pY/NATYUEXyjH/FHE9kojH44cf45E4vmwQjPzInHEyhnem
         qMuXWKzi26RulM1+p7qf/ZUosoKd2DRm9prwzIdqYkckBJHaSZ4NxSMAA/knQAsLBroh
         4DfIyC2gd652dEA1LOI2fHZxNEziKWAvwWgY8=
Received: by 10.204.154.198 with SMTP id p6mr4180056bkw.131.1258450243269;
        Tue, 17 Nov 2009 01:30:43 -0800 (PST)
Received: from ?192.168.1.13? (abwu104.neoplus.adsl.tpnet.pl [83.8.244.104])
        by mx.google.com with ESMTPS id 13sm243052bwz.6.2009.11.17.01.30.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 17 Nov 2009 01:30:42 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7viqd9isbm.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133083>

Dnia wtorek 17. listopada 2009 07:22, Junio C Hamano napisa=B3:
> Jakub Narebski <jnareb@gmail.com> writes:

> >
> > It would be nice to have an option to git-config which would do suc=
h
> > expansion, as a separate type similar to --int and --bool, e.g.:
> >
> >   git config --path section.key
> >
> > so that not only core.excludesfile could use this new feature, but =
for
> > example also core.worktree, commit.template, gitcvs.logfile,
> > mailmap.file, and perhaps also *.receivepack and *.uploadpack
>=20
> What should "git config -l" do for these (and core.excludesfile)?

Nothing (i.e. show unexpanded / not converted), just like for boolean
variables "git config -l" doesn't convert 1/on/yes to true, and 0/off/n=
o
to false, just like for integer variables "git config -l" doesn't conve=
rt
to simple decimal number taking into account optional 'k', 'm' or 'g'
suffix.


BTW. the suffix part of integer conversion should really be described
in the paragraph about --int and --bool options (which should be made
into proper description list, and not a prose paragraph).

P.S. I am a bit missing --local / --repository option to git-config to
complement --global (which should probably be named --user) and --syste=
m
options.

--=20
Jakub Narebski
Poland
