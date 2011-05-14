From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 6/7] update git-stage.po
Date: Sat, 14 May 2011 14:21:54 -0500
Message-ID: <20110514192154.GA17271@elie>
References: <1305292458-3920-1-git-send-email-okano.osamu@gmail.com>
 <1305292458-3920-7-git-send-email-okano.osamu@gmail.com>
 <7vtycy7d9z.fsf@alter.siamese.dyndns.org>
 <BANLkTi=u4_vbTjDyL1JNAz06=R_1XUikvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Osamu OKANO <okano.osamu@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 14 21:22:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLKPf-0008LW-Uo
	for gcvg-git-2@lo.gmane.org; Sat, 14 May 2011 21:22:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758461Ab1ENTWE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 May 2011 15:22:04 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:56844 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757909Ab1ENTWA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 May 2011 15:22:00 -0400
Received: by iwn34 with SMTP id 34so3018830iwn.19
        for <git@vger.kernel.org>; Sat, 14 May 2011 12:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=mNkktoctG8cgz4+LFGe2WD0h4Kk3xppIKGKeJUcOZxE=;
        b=vOnKHoS7PTrPJPNNbR5a7BCBuF89NiPy+NWVGKfG2g0R4zpynoskJV+zJ3uor1nE2t
         zKYVIHUHwgSzLLh8o65PgxBirhoP3AOxYaWnneIpqjzRP0bW9jL2sEXzrP4Bt7T98D3U
         h2XZwvV5cz523u3DkzDAQBohayMUAJYDeY/rE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ArsszAIh1wnjNxIVMxxmSUdDGNH9e9y0s+WamlUfqRc9sCrdw2zR7bl86k2JjZ/n5l
         hAZFOlh/1cnGQEuhvIDzOeRr1hzyaXpzDKT51whUEWp5gxKoxFGdtqgJggNayFOzQXlu
         74EjWy50MP/qKk6l/3ZRNgd/6wOfFaUoUKiF8=
Received: by 10.42.169.67 with SMTP id a3mr3468436icz.160.1305400920426;
        Sat, 14 May 2011 12:22:00 -0700 (PDT)
Received: from elie (adsl-69-209-56-134.dsl.chcgil.sbcglobal.net [69.209.56.134])
        by mx.google.com with ESMTPS id 14sm1471200ibc.8.2011.05.14.12.21.58
        (version=SSLv3 cipher=OTHER);
        Sat, 14 May 2011 12:21:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTi=u4_vbTjDyL1JNAz06=R_1XUikvA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173601>

Osamu OKANO wrote:
> 2011/5/14 Junio C Hamano <gitster@pobox.com>:

>> Isn't this a no-op?  Translators need to be careful about these.
>
> Yes, this part has no point.
>
> Before I commit .po, I should run po4a-update
> for the sake of line feed normalization.
> Then I can avoid the crap diff.
>
> 1.2 new translation
> ====================
> $ mkdir ja
> $ cp git-stage.pot ja/git-stage.po
>  -> 0003-cp-git-stage.pot-ja-git-stage.po.patch
> $ cd ja
> $  translate .po by hand ...
> $ ../make_update  # add this procedure
>  -> 0004-translate-ja-git-stage.po.patch

I wonder if it is possible to encode this in .gitattributes
(+ .git/config) as a "clean" filter or in .git/hooks as a pre-commit
hook, for extra safety.

Another thought I have had occasionally is that it would be nice if
the versions committed did not have line numbers while the working
copy had line numbers, so an ordinary 3-way merge could be more likely
to work for integrating changes[1].  But this second thought is less
fully cooked. :)

Jonathan

[1] This could be also done with smudge/clean filters, but it's hard
to make it fast.  Maybe a pre-commit hook combined with a variant on
the trick in v1.7.2-rc0~24^2 (autocrlf: Make it work also for
un-normalized repositories, 2010-05-12) would make it bearable.
