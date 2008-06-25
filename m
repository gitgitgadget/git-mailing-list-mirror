From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: [PATCH] cmd_reset: don't trash uncommitted changes unless told to
Date: Wed, 25 Jun 2008 16:58:09 -0400
Message-ID: <32541b130806251358n3ab6cfc8y7a90d898b9308e12@mail.gmail.com>
References: <20080624222105.GA24549@dervierte> <486220CE.3070103@viscovery.net>
	 <alpine.DEB.1.00.0806251334060.9925@racer>
	 <20080625135100.GF20361@mit.edu>
	 <7v63rx2zwf.fsf@gitster.siamese.dyndns.org>
	 <20080625195003.GB15077@mit.edu>
	 <32541b130806251304u39c8ffdenc52904391aebd089@mail.gmail.com>
	 <7vlk0tz33n.fsf@gitster.siamese.dyndns.org>
	 <32541b130806251322l478faa87gc9f2016254689022@mail.gmail.com>
	 <7vd4m5z1f8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Theodore Tso" <tytso@mit.edu>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Johannes Sixt" <j.sixt@viscovery.net>,
	"Boaz Harrosh" <bharrosh@panasas.com>,
	"Steven Walter" <stevenrwalter@gmail.com>, git@vger.kernel.org,
	jeske@google.com
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 22:59:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBc57-0003xG-7X
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 22:59:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751406AbYFYU6M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 16:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751762AbYFYU6M
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 16:58:12 -0400
Received: from fk-out-0910.google.com ([209.85.128.189]:64093 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751000AbYFYU6L (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 16:58:11 -0400
Received: by fk-out-0910.google.com with SMTP id 18so3386517fkq.5
        for <git@vger.kernel.org>; Wed, 25 Jun 2008 13:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=zOdNN96K5mCf+IzOwl9sJoR8v1xcXXCetNVbT3FbOIs=;
        b=jULQ4C1VffUtyxFgWXjDyJSsAWXNi8BFA6Wn7Ptnp3Dr3pJ/1z+E0LE8n1lN1keaMv
         MAFg9GpKa/ZvX5gAKudQS+pUGWM3JUGEFA9t5638uP04ocI7oh0py/aaUx43bWm6ZPLj
         aHjmvOprcOAGzzxIll8N+Q2T+vKnWARHjI20w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=bozZak9kStBveHPFmUvauSMbse8/nZZw2ytJrVqQ86/rtvu3udASSSzzFdvp2mqnHi
         zrt93j+GIn4OQYtxZxL9PrrkUSxRtV5d8OSqgSOW5BfARqwS/2GrRUxnqDfMnzXhh1sp
         wzWMuAWL8SxBS9Z50PPNIXWKWR4OMf2lQiq6g=
Received: by 10.82.185.3 with SMTP id i3mr671041buf.27.1214427489589;
        Wed, 25 Jun 2008 13:58:09 -0700 (PDT)
Received: by 10.82.175.10 with HTTP; Wed, 25 Jun 2008 13:58:09 -0700 (PDT)
In-Reply-To: <7vd4m5z1f8.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86350>

On 6/25/08, Junio C Hamano <gitster@pobox.com> wrote:
> "Avery Pennarun" <apenwarr@gmail.com> writes:
> >>   * You say "git checkout -- file" when you want to "check out the file
>  >>    from the index";
>  >
>  > The real question here is the --.  Is it strictly needed?  It's
>  > optional in things like git-diff, which just do their best to guess
>  > what you mean if you don't use the --.
>
> No, I wrote -- only for clarity, because you can happen to have a branch
>  whose name is the same as the file.  Otherwise you can safely omit it,
>  just like git-diff and any other commands that follow the -- convention.

Oops, I got mixed up.  Only git-reset requires the --.  Would it make
sense to bring git-reset into line with everything else, then?

Thanks,

Avery
