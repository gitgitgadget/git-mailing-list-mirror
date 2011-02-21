From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 02/15] tests: add GETTEXT_POISON to simulate unfriendly translator
Date: Mon, 21 Feb 2011 13:41:27 +0100
Message-ID: <AANLkTikCvaWOQaE8628RVeAsdizVBr3vHawjwKdVJK5N@mail.gmail.com>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
	<20110221040012.GB26968@elie>
	<20110221101229.GA32137@elie>
	<20110221101352.GC32137@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 21 13:41:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrV53-0004Fz-P9
	for gcvg-git-2@lo.gmane.org; Mon, 21 Feb 2011 13:41:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754270Ab1BUMl3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Feb 2011 07:41:29 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:48575 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753844Ab1BUMl2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Feb 2011 07:41:28 -0500
Received: by fxm17 with SMTP id 17so1415422fxm.19
        for <git@vger.kernel.org>; Mon, 21 Feb 2011 04:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=i3a98mz49Ys/i85DN6N71unN7P4jAcw6AIjXerSP2Wk=;
        b=Kp1B94kxz9aA/fZ0Xja5Tnigr9YjQ5NOY1vd8JQD39D9vipTuORMjW7oxETyW+MNKI
         4iLDHo9/gb4m5mW6um4RooxNJyaxJEV4+xyRsNwlNeO5sPRE2XFBW0LOdgBso6LA+50F
         vZrTmRiCx/dZnU1/bKLgN8tLvaSraFUdaYt6o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=rZeiWnubMhYNMT0PtZ9yUw6/UeiLqP6E7azRhXpnviHbzyrKclY8J0eYTyNLQnyYIq
         OURgQod/vox5PMNgmvV9o++i7bbO9rFr2W1VC9V3JT4/ZHNQfZW2mlKRh3ZwaTQp9qId
         DdYImNyrC6dv/ZHv8JOSVkLQbuuBsUKA5eeDg=
Received: by 10.223.114.209 with SMTP id f17mr1774389faq.136.1298292087239;
 Mon, 21 Feb 2011 04:41:27 -0800 (PST)
Received: by 10.223.2.201 with HTTP; Mon, 21 Feb 2011 04:41:27 -0800 (PST)
In-Reply-To: <20110221101352.GC32137@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167479>

On Mon, Feb 21, 2011 at 11:13, Jonathan Nieder <jrnieder@gmail.com> wro=
te:

> =C2=A0static inline FORMAT_PRESERVING(1) const char *_(const char *ms=
gid)
> =C2=A0{
> - =C2=A0 =C2=A0 =C2=A0 return msgid;
> + =C2=A0 =C2=A0 =C2=A0 return use_poison() ? "Malkovich" : msgid;
> =C2=A0}

Why did you change this from "# GETTEXT POISON #" to "Malkovich"?

The reason it started with a "#" is because many rebase tests were
broken otherwise.

The reason it was in all caps was so that when I run the tests in
debug mode it's really easy to see at a glance if I'm encountering
these strings.

Do those tests still pass with this new string, and is there any
reason to change this?
