From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] diff,difftool: Don't use the {0,2} notation in usage
 strings
Date: Thu, 4 Nov 2010 13:38:51 -0500
Message-ID: <20101104183851.GA16865@burratino>
References: <20101021222129.GA13262@burratino>
 <20101024155121.GA9503@headley>
 <AANLkTimpJbuZAPfvVOedstV7=UiLiDMnDaYWQLVNQ+Yc@mail.gmail.com>
 <87wrp12p00.fsf@gmail.com>
 <AANLkTinyPkGmsgbGM9qpXMNcZRzOXvtjDDEkJ-i3nWXz@mail.gmail.com>
 <87fwvl2d4d.fsf@gmail.com>
 <87hbfxgg86.fsf_-_@gmail.com>
 <20101104174917.GA30628@sigill.intra.peff.net>
 <20101104180242.GA16431@burratino>
 <20101104181357.GA31016@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>,
	git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Mark Lodato <lodatom@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 04 19:39:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PE4ib-00070p-GO
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 19:39:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752509Ab0KDSjV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Nov 2010 14:39:21 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:45586 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751106Ab0KDSjT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Nov 2010 14:39:19 -0400
Received: by pvb32 with SMTP id 32so688280pvb.19
        for <git@vger.kernel.org>; Thu, 04 Nov 2010 11:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=5cOe814ogrkRxWNprK1YmuCtmlqVpqRLLc4/dam8TQU=;
        b=HiDBYrWV4vnBxZ7x2/BAyUEvrfK77sag38G2ct5KYnPBzpNbyvQxOppAa2WvKRupm1
         PJuZO5alSS6GPNabc8qIhw6GgsTUmpSQtpoeFyr9wRUxoFbS0FtPRAZlDUW39bB7+1+Z
         NGPab39Eg/xVQBBOg67KZ4jHNZHCjAAVUv/rs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=YV+l2GoIVHxhVrFM/PAHqsBHHN9O6WgvxOFGSK0ZBBlujz1sOrMnGiQHXPJnKKiKXI
         E13dYsEK9c1oI/syZN+D66OoiRJceTxlXdXVdYCoyzYgi4tiZ9V/Vjmha8ir6g7CjpbD
         ommDSzI3oeNLpLbGRUUzPqeaglCXaOlVmaGSg=
Received: by 10.42.30.8 with SMTP id t8mr639759icc.269.1288895957082;
        Thu, 04 Nov 2010 11:39:17 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id p22sm108547vcf.20.2010.11.04.11.39.14
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 04 Nov 2010 11:39:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101104181357.GA31016@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160746>

Jeff King wrote:

> 	git diff [options] [<commit>] [--] [<path>...]
> 	git diff [options] --cached [<commit>] [--] [<path>...]
> 	git diff [options] <commit> <commit> [--] [<path>...]
> 	git diff [options] [--no-index] [--] <path> <path>
> 
> which covers the four major modes.

Makes sense.  There is just one particularity of

	git diff --cached [<commit>]

I am worried about.  Namely: according to a recent patch,

	git diff --cached

should not be considered as

	git diff --cached HEAD

with the "HEAD" implicit, but a distinct operation meaning
"show me what changes git commit would store".

> On Thu, Nov 04, 2010 at 01:02:42PM -0500, Jonathan Nieder wrote:

>> I would rather treat --cached as one of the options ("instead of
>> comparing the worktree, compare its cached content in the index to the
>> specified commit"),
>
> Except it is not quite that. For the first two that I listed above,
> --cached makes that distinction. But --cached doesn't make sense at all
> in the third or fourth ones. So I think in practice it ends up defining
> a mode of operation more than simply an option.

Not sure I understand your logic.  Is your point that --cached in
those cases does not print

	fatal: --cached does not make sense in this operation mode

but

	usage: git diff <options> <rev>{0,2} -- <path>*

that implies the operation mode is not known?

>                                   There are pretty few unix programs
> that don't take [options] at the beginning, so it really is kind of
> superfluous. But it's also pretty standard, and clues the user in that
> we are a normal program.

Yes, sorry about the tangent.
