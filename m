From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH v2 02/19] parse-options-cb: implement parse_opt_pass_argv_array()
Date: Wed, 10 Jun 2015 15:11:01 +0800
Message-ID: <CACRoPnRVjNseXPOxKe4_3rnKXmAYeA80iCHY3o8euWA=EUX6hA@mail.gmail.com>
References: <1433314143-4478-1-git-send-email-pyokagan@gmail.com>
	<1433314143-4478-3-git-send-email-pyokagan@gmail.com>
	<xmqqr3pkwjz6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stephen Robin <stephen.robin@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 10 09:11:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2aAO-0000XE-Hd
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 09:11:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933438AbbFJHLK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 03:11:10 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:35428 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964800AbbFJHLD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 03:11:03 -0400
Received: by labko7 with SMTP id ko7so26665451lab.2
        for <git@vger.kernel.org>; Wed, 10 Jun 2015 00:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=70GBQtrKXj928TuqSk6LUtwgt6L0jqzRn9mktjMg1Xk=;
        b=haKOeSm4DpGFluNu0uVhAFbGifp5osVZEJcL4ldIGowu0ae2ChTsC54iCfiB2S1Bjo
         a9w+9Vc/OFwJ1Ris98YH1WgSlY6ZNpVglcxFB0bLFoPwKY24SsyYfh9LEGIDpNlJrBaD
         Q8OGY84KDwULY9oaaQdxNayRvljeVTNnp5CBFNstTRsWYLS1QuAvTELnNXWPVzyZyFS9
         D6WwyRY8pzEbqKWNbug82Oq56Y6JAXcnB3Wn2ISt2W+kwyJuG7pejtk6TPX7sGUgCpup
         eGQ4ARJlRXMQOfR+c7MPQEAsUmzAaOt97T+0Nedc8GJuEAAuRL9B8jV9TbQzu7dFiiRF
         /Ssg==
X-Received: by 10.152.22.99 with SMTP id c3mr1769482laf.32.1433920261512; Wed,
 10 Jun 2015 00:11:01 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Wed, 10 Jun 2015 00:11:01 -0700 (PDT)
In-Reply-To: <xmqqr3pkwjz6.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271259>

On Wed, Jun 10, 2015 at 7:16 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Almost the same comment as 01/19 applies to this comment.
>
> I think it makes good sense to have two variants, one that lets the
> last one win and pass only that last one (i.e. 01/19) and the other
> that accumulates them into an argv_array (i.e. this one).  But it
> feels iffy, given that the "acculate" version essentially creates an
> array of (char *), to make "the last one wins, leaving a single
> string" to use strbuf.  I'd find it much more understandable if 01/19
> took (char **) as opt->value instead of a strbuf.

I don't see how it feels iffy. The purpose of using strbufs (and
argv_arrays) is to avoid error-prone manual memory management.

> In any case, these two need to be added as a related pair to the API
> documentation.

Okay, I guess I could also add their macro functions as well.

Thanks,
Paul
