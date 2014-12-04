From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv3 00/13] the refs-transactions-reflog series
Date: Thu, 4 Dec 2014 10:32:31 -0800
Message-ID: <20141204183231.GA2649@google.com>
References: <1417681763-32334-1-git-send-email-sbeller@google.com>
 <54809577.4080302@alum.mit.edu>
 <20141204181404.GD9992@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Haggerty <mhagger@alum.mit.edu>, ronniesahlberg@gmail.com,
	gitster@pobox.com, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 04 19:32:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwbCg-0008K1-0h
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 19:32:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932655AbaLDSce convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Dec 2014 13:32:34 -0500
Received: from mail-pd0-f202.google.com ([209.85.192.202]:35928 "EHLO
	mail-pd0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932464AbaLDScd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Dec 2014 13:32:33 -0500
Received: by mail-pd0-f202.google.com with SMTP id w10so2495583pde.5
        for <git@vger.kernel.org>; Thu, 04 Dec 2014 10:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent
         :content-transfer-encoding;
        bh=1nYnOQ1hSERdeEBgcRGuuwZ+I8BIFJo0/u5ACas3PbE=;
        b=opnOgqvV7DVYveu0E/Iyptaz/cgjeqFaKq7oCUX4IACzZtASFya9BuuedEpkGuVyO7
         MHter+z2cV1c5OlqVBVz66tc+8TQuwzZfEj5eNYXgQsQvr71KtuRakI5RJ2Ca4BJAu4z
         ejt9KtqyDsf+QYwgOT6sKxVdh7CtMKPdEe8xIrxXDruQCf3DuZIW4aj2rPh5Cp9Hwo7W
         CgyG0zysUb1FHsGU+mIXy6zhnHVlgRkLRZ2+B5YNScH6ghy/73HJ8Sw6RyFFT78Tuj7h
         82wRRy9P5ENsqEkF/tXWYzKZk0eaz4AXBuVKHwkb+EVo5qmwZ1UIrR/5Ie9QeBIiM73P
         8h/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent:content-transfer-encoding;
        bh=1nYnOQ1hSERdeEBgcRGuuwZ+I8BIFJo0/u5ACas3PbE=;
        b=LPXPjq8+CdaZMkJ98xJIZfCrGlNXlTfnAIwKf3hMoQRY4q9gTDdudzDmjolBZF/2z8
         ct6btMEMwKsEQ9pyyjI5BDr5/BL9d7YhOzzbJ8btiUypky731cHO6QHRqbgpv3sNtA7t
         jUpkFYwGGsYRHKljt36HqEN5fAkmXU/wFDWKYJHNTws5PPN0bKU3yRvxuChxTVqjVnut
         e3zmzXQ8WXd9psSTr0pCj24py6jS82FHUZw4OSGbsXOo5ihwsYAG2ai3ZWjfq65j7K0F
         YnM3jHcYjWZyo8zrcUHMerGjleNZ8LIFwm8ySTYr4dit5W9HtWkJQaHntCaMo98TZDTY
         WlNg==
X-Gm-Message-State: ALoCoQl3HzJfqACTtAEAkUmYaqeAjY3xAZIMFHLKsu1Eh0iFoo13IeglpwcbonZcgiDiOYpgn9Lv
X-Received: by 10.68.203.170 with SMTP id kr10mr14262204pbc.0.1417717952660;
        Thu, 04 Dec 2014 10:32:32 -0800 (PST)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id n63si1163162yho.5.2014.12.04.10.32.32
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Dec 2014 10:32:32 -0800 (PST)
Received: from sbeller.mtv.corp.google.com ([172.27.69.125])
	by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id gFmhO5YB.1; Thu, 04 Dec 2014 10:32:32 -0800
Received: by sbeller.mtv.corp.google.com (Postfix, from userid 279346)
	id A6978142ABE; Thu,  4 Dec 2014 10:32:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20141204181404.GD9992@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260777>

On Thu, Dec 04, 2014 at 10:14:04AM -0800, Jonathan Nieder wrote:
> Michael Haggerty wrote:
>=20
> > I am still unhappy with the approach of this series, for the reason=
s
> > that I explained earlier [1]. In short, I think that the abstractio=
n
> > level is wrong. In my opinion, consumers of the refs API should bar=
ely
> > even have to *know* about reflogs, let alone implement reflog expir=
ation
> > themselves.
>=20
Ok, what is a consumer for you? In my understanding the builtin/reflog.=
c is
a consumer of the refs API, so there we want to see clean code just tel=
ling the
refs backend to do its thing.

I think Jonathan made a good point by saying our=A0patch series have=20
different goals.

So I really like the code, which leads to=20

=A0 =A0 reflog_expiry_prepare(refname, sha1, cb.policy_cb);
=A0 =A0 for_each_reflog_ent(refname, expire_reflog_ent, &cb);
=A0 =A0 reflog_expiry_cleanup(cb.policy_cb);

but look at the surrounding code:
   =20
	if (!(flags & EXPIRE_REFLOGS_DRY_RUN)) {
		if (hold_lock_file_for_update(&reflog_lock, log_file, 0) < 0)
			...
	}


	if (!(flags & EXPIRE_REFLOGS_DRY_RUN)) {
		if (close_lock_file(&reflog_lock)) {
			...
		}
	}

That part should also go into the refs.c backend, so in the expire_refl=
og
function you can just write:

	transaction_begin(...)  // This does all the hold_lock_file_for_update=
 magic=20
				// lines 457-464 in mhagger/reflog-expire-api

 	reflog_expiry_prepare(refname, sha1, cb.policy_cb);
	for_each_reflog_ent(refname, expire_reflog_ent, &cb);
	reflog_expiry_cleanup(cb.policy_cb);

	transaction_commit(...) // This does all the close_lock_file/rename/wr=
ite_in_full
				// lines 470-488 in mhagger/reflog-expire-api


>=20
> So *both* are making good changes, with different goals.

If you want to I can rebase the reflog series on top of yours to show
they can work together quite nicely.

Thanks for your draft series and feedback,
Stefan
