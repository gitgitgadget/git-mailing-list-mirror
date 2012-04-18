From: =?UTF-8?B?TWljaGHFgg==?= Kiedrowicz <michal.kiedrowicz@gmail.com>
Subject: Re: [PATCH] git-merge: Reduce heads before trying to merge them
Date: Wed, 18 Apr 2012 20:14:26 +0200
Message-ID: <20120418201426.7070315f@gmail.com>
References: <CA+55aFzGwPYNn2baFhEr4msBTV7__nkTSUqAZ7=PRVoYrchV5w@mail.gmail.com>
	<1334687118-5386-1-git-send-email-michal.kiedrowicz@gmail.com>
	<7vzkaambre.fsf@alter.siamese.dyndns.org>
	<CA+55aFzLFA535CtjLJe1p62H=nunQ=vrL_mPYsYJB0e8U7mpdg@mail.gmail.com>
	<7vvckym6ec.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 18 20:14:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKZOo-0003fq-9r
	for gcvg-git-2@plane.gmane.org; Wed, 18 Apr 2012 20:14:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753070Ab2DRSOe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Apr 2012 14:14:34 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:53128 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752102Ab2DRSOd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Apr 2012 14:14:33 -0400
Received: by wgbdr13 with SMTP id dr13so7792534wgb.1
        for <git@vger.kernel.org>; Wed, 18 Apr 2012 11:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=8SYHRPM1A+uIUAlLTSEOmAltolJOsv1u2GxDeBrPaH0=;
        b=TXnSuZ09nGh1JcjMm9H0kLdUjiKuW2R613BLbDqUdPC/0h6tYarCNb8J9Q/krC+5jP
         MJBc2H5/hT8TN163msZvUyJcu6r54PnxF05fkljgGHj547/NmLHV/vrJzRcrDOduWIoa
         MSo+X9WHLnfCARP5akQlGyxVbsBKUdL9Gpnr1a1a+YbzPxCwbIMeCK1hOqjY9FrlBSML
         c9/KSd9Upxch9BIiFBc71jPgzX4CWVlJGob9qoF2odyJo6JP6VoZODXuYZrDg29qoZN8
         YbMxeQWnPx19j0PWnFVXQCT8pMUqtLpY3rGvwWwRAXexwNWOoVq8fvGkl4FvHhADbx/E
         8+uw==
Received: by 10.216.214.84 with SMTP id b62mr2083387wep.20.1334772872059;
        Wed, 18 Apr 2012 11:14:32 -0700 (PDT)
Received: from localhost (77-177-78-94.net.stream.pl. [94.78.177.77])
        by mx.google.com with ESMTPS id n20sm57831560wiw.5.2012.04.18.11.14.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 18 Apr 2012 11:14:31 -0700 (PDT)
In-Reply-To: <7vvckym6ec.fsf@alter.siamese.dyndns.org>
X-Mailer: Claws Mail 3.8.0 (GTK+ 2.24.8; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195877>

Junio C Hamano <gitster@pobox.com> wrote:
=20
> I was cooking a fix on-and-off since yesterday evening, and sent it o=
ut a
> few minutes ago. I think the spirit is almost the same as Micha=C5=82=
's updated
> patch, but it reduces the heads even earlier to catch cases where Mic=
ha=C5=82's
> updated patch may misdiagnose arity of the resulting merge due to its=
 use
> of remoteheads->next before the list is reduced (namely, the choice o=
f the
> default strategy based on how many we are merging).

I like your patches, especially how reducing heads is now done in
collect_parents() instead of doing it twice (before merging and in
finish_automerge()).  And that you got rid of global remoteheads too.
