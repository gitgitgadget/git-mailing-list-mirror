From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: "git add -u" broken in git 1.7.4?
Date: Mon, 7 Feb 2011 14:29:23 +0700
Message-ID: <AANLkTiksXERJ1h2du7Qu27rpKh2=q0GTWix8kSoeC24Y@mail.gmail.com>
References: <4D4DEDC4.4080708@hartwork.org> <20110206051333.GA3458@sigill.intra.peff.net>
 <4D4EF7E4.7050303@hartwork.org> <vpq1v3kopn3.fsf@bauges.imag.fr>
 <7vwrlcv1ea.fsf@alter.siamese.dyndns.org> <20110207055314.GA5511@sigill.intra.peff.net>
 <7vhbcguytf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Sebastian Pipping <webmaster@hartwork.org>,
	Git ML <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 07 08:30:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmLXs-00071R-3b
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 08:30:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752303Ab1BGH3z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Feb 2011 02:29:55 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:41390 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751823Ab1BGH3y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Feb 2011 02:29:54 -0500
Received: by wwa36 with SMTP id 36so4486512wwa.1
        for <git@vger.kernel.org>; Sun, 06 Feb 2011 23:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=gvbkh6pdq4SeqSzBBbIgmlupFlwgzaY9M7Ql2TXO6vs=;
        b=suA/eslkdqUwLfW92c1hWDcV9lvYK6KMpfFrwqmWyKxLO1Xng4LYMzLB2KdiNuK/pk
         fyawsJkdnWS4RP/qPImLYlaHx9XsjmcCtMWQdtmLAVL8kCHTC5z+QQWtWGP5kfFk0rQr
         tKaS5gLPf4kWmyIfbqTvOgP4cAg9TytxuOGCw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Isj/VnyoWJxk3b7PH+hKLzFPJH93otRU2SbzZ/LQee2tHE5v932sDNbZhImD0VWhlx
         Mm/uj8pBNn80Hva3QxPLQz0LeAb+ZA43GRa6xKmvNLXhVY3hCbjOBwIfgWR/vB3kqiuH
         fAApXpA/xeNo8Z91ezkl8lc5UshtDUr3ZGXRg=
Received: by 10.216.163.69 with SMTP id z47mr13848712wek.43.1297063793647;
 Sun, 06 Feb 2011 23:29:53 -0800 (PST)
Received: by 10.216.66.144 with HTTP; Sun, 6 Feb 2011 23:29:23 -0800 (PST)
In-Reply-To: <7vhbcguytf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166239>

On Mon, Feb 7, 2011 at 1:46 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> I actually do not mind too much myself if all commands that can take
> pathspecs consistently defaulted to "full-tree" pathspec given no
> pathspec. =C2=A0But if we were to go that route, everybody should joi=
n their
> voice to defend that decision when outside people say "in 1.8.0 'git =
grep'
> run from a subdirectory shows matches from all the irrelevant parts o=
f the
> tree; with all the cruft its output is unreadable". I won't be the so=
le
> champion of such a behaviour when I do not fully believe in it.

That could be one more item for the next git survey (i.e. how do you
want the defaults to be?). Most of people in this list more or less
breath git already and therefore are bias (I think).

Personally "git add -u --full-tree" is good enough to me. It does have
the same problem that git --full-tree has: what *.h in "git grep
--full-tree -- '*.h'" means. But I'm OK with not supporting that case
until we agree on something.
--=20
Duy
