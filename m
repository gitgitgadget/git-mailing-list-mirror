From: "Dan McGee" <dpmcgee@gmail.com>
Subject: Re: [PATCH] rebase: standardize on $() for command substitution
Date: Thu, 1 Nov 2007 00:27:59 -0500
Message-ID: <449c10960710312227s6688cc5fne9ff246e042cdc3c@mail.gmail.com>
References: <1193892608-31322-1-git-send-email-dpmcgee@gmail.com>
	 <7vr6jaczps.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 01 06:28:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InSbL-00029X-4m
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 06:28:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756844AbXKAF2E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 01:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756228AbXKAF2B
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 01:28:01 -0400
Received: from rv-out-0910.google.com ([209.85.198.188]:10232 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755063AbXKAF2A (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 01:28:00 -0400
Received: by rv-out-0910.google.com with SMTP id k20so357498rvb
        for <git@vger.kernel.org>; Wed, 31 Oct 2007 22:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ZEWHWpe21UYIpTNW7bXumk8byKmltUAEoWrEScdheUo=;
        b=MWVskJqepHX8VQ+VTkTLWAwWIoe8jjcrUPdHg2ehpxEJexGEoaBqU0uoyUJmLMXBVIYNrR2xmKT5DDZuUzNSYA3gMEbaj7wd/cKU4TikFNVpmRIsyBM6wrTWm8CuOKhQfNWUlykOxeNTO6nrJLaps97BWEkbpG0LZ0vHTiWhkgY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Kus9024QYl9FdgLXvmJw05kwS5y8jQWmWkcQ4ynm61fUrR2GNwUMeKSzV+wEBYzAJ/7usv1FmAon9SLzHJhxiqXAyrIO3t9t99dRCNMG9tH6041DXyL6Q8rUauxsVD+IK/k2KAQXGYsK9GZQ1nMYEDARO58lqmiwYh9Q+h+kPHs=
Received: by 10.114.27.20 with SMTP id a20mr205799waa.1193894879995;
        Wed, 31 Oct 2007 22:27:59 -0700 (PDT)
Received: by 10.114.74.12 with HTTP; Wed, 31 Oct 2007 22:27:59 -0700 (PDT)
In-Reply-To: <7vr6jaczps.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62918>

On 11/1/07, Junio C Hamano <gitster@pobox.com> wrote:
> Dan McGee <dpmcgee@gmail.com> writes:
>
> > Commit 889a50e909dba5f4416049afc5eeae601fe133bc changed several `` to $()
> > format for command substitution, so we should standardize on one format
> > for clarity.
> > ...
> > @@ -203,7 +203,7 @@ do
> >       -s|--s|--st|--str|--stra|--strat|--strate|--strateg|--strategy)
> >               case "$#,$1" in
> >               *,*=*)
> > -                     strategy=`expr "z$1" : 'z-[^=]*=\(.*\)'` ;;
> > +                     strategy=$(expr "z$1" : 'z-[^=]*=\(.*\)'` ;)
> >               1,*)
> >                       usage ;;
> >               *)
>
> The patch might have meant well, but it is a rather unnecessary
> code churn without fixing anything and introducing a bug X-<.

Wow, back to the drawing board here. I've been up too long today.

-Dan
