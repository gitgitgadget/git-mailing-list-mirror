From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 1/2] Add date formatting and parsing functions relative to 
	a given time
Date: Sun, 30 Aug 2009 13:17:28 +0200
Message-ID: <81b0412b0908300417x1b909242hcd13a00587d6d33c@mail.gmail.com>
References: <20090828191521.GA12292@coredump.intra.peff.net>
	 <20090828193302.GB9233@blimp.localdomain>
	 <20090828205232.GD9233@blimp.localdomain>
	 <7vk50mz41e.fsf@alter.siamese.dyndns.org>
	 <81b0412b0908300025r4eeee84fyf0bfc3b2e940ff37@mail.gmail.com>
	 <20090830091346.GA14928@blimp.localdomain>
	 <20090830091557.GA28531@coredump.intra.peff.net>
	 <20090830093642.GA30922@coredump.intra.peff.net>
	 <81b0412b0908300256l13d308d9oc30172a20a9f6108@mail.gmail.com>
	 <20090830100826.GA31543@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>,
	David Reiss <dreiss@facebook.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Aug 30 13:17:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MhiPg-00009h-Ep
	for gcvg-git-2@lo.gmane.org; Sun, 30 Aug 2009 13:17:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753225AbZH3LR1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Aug 2009 07:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752842AbZH3LR1
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Aug 2009 07:17:27 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:35215 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752766AbZH3LR1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Aug 2009 07:17:27 -0400
Received: by bwz19 with SMTP id 19so2315394bwz.37
        for <git@vger.kernel.org>; Sun, 30 Aug 2009 04:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=znA8zyqinyyYToNlU86XZOszKmvXylioNWj3fkP45OA=;
        b=gjsSaLQy8hpK7ZEbnaB++ebz78it6JirFjEaxoCXF76ANOfQt5w/lLt2Ohb+zhtf74
         ljMPi7r7JXkKeQrGkho/uGG9dovWnCfrofDc3SIbt3EEAX2kd1lEjE4uPQZ2EnWhS7aE
         We5ye7c8PBnJMY2lOQu5Nrwsm9jGpPvtY3Wbo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=q8Q3btD1q+AWPdut0QI+9HdCWAqEGm91GlqrA2GhH//fp3iW9TJ8mUo+3NIE1s15Iu
         KB3RQPiBfvzw6dfke1Ity5ZjPIusExJeaTxhyMiYJdoXAp8KoNFDjltHL0BcJrcpvqyu
         ecV8Zprt3QLWqoFK/+nauYumQKne5cx/VJOYQ=
Received: by 10.204.154.209 with SMTP id p17mr3098736bkw.104.1251631048089; 
	Sun, 30 Aug 2009 04:17:28 -0700 (PDT)
In-Reply-To: <20090830100826.GA31543@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127410>

On Sun, Aug 30, 2009 at 12:08, Jeff King<peff@peff.net> wrote:
> On Sun, Aug 30, 2009 at 11:56:37AM +0200, Alex Riesen wrote:
>>
>> check_show 630000000 '20.years.ago'?
>> (Arbitrary, non-whitespace delimiters, which was an
>> advertised feature, to make shell's life easier)
>
> This part is about checking what show_date produces (the first number is
> an offset from now in seconds, and the second is what we expect), so it
> always has spaces.
>
> See the check_approxidate section further down for an example of parsing
> what you are talking about.

Ah, I see
