From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: [RFC] git rm -u
Date: Mon, 21 Jan 2013 09:09:42 +0100
Message-ID: <CAA01Csrv26WrrJDAo-1cr+rW6rYFGQZpYgtafEh=Wgtzswdv_g@mail.gmail.com>
References: <50FB1196.2090309@gmail.com>
	<20130119214921.GE4009@elie.Belkin>
	<vpq622s9jk1.fsf@grenoble-inp.fr>
	<7v1udfn0tm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Eric James Michael Ritz <lobbyjones@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Tomas Carnecky <tomas.carnecky@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 21 09:10:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxCSD-0007vk-Cv
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 09:10:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178Ab3AUIJo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2013 03:09:44 -0500
Received: from mail-qa0-f47.google.com ([209.85.216.47]:57396 "EHLO
	mail-qa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803Ab3AUIJn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2013 03:09:43 -0500
Received: by mail-qa0-f47.google.com with SMTP id a19so6553781qad.6
        for <git@vger.kernel.org>; Mon, 21 Jan 2013 00:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=pi4X6+30z+/SzLcPVHwR+ycJdIECrKQs7ufrd8h7EjY=;
        b=gEHLhfWSQJmo3Rv7LB/EkK+C8rvvpJCvqdHO3xmcDh0OIEthwIscTvwR0neGlF81Tq
         NhfOOgVnzm3cbMQqoxOtDfmf68ylRzmKEwTdPPFX6yV6azfLGBUKOCb4aAY4WpVwjfLK
         DmImL4zuvJ8W/g3yMoRbitHehtLpNB2fh+/MJxEe540ZYoUp2RnUbRpStAZc/0iQz2oL
         AKIt6CJ2FDJrfnzGycmGANS82F5w7UhFrOomkrvz7/7Sw6se4VBiHFa2Yngx3aGAKAAr
         dbLTUZ26E5euhmy/I5Mzvh706SABzkoYVtwnuFqU/8+K6978dPcgYccBAAzpJ1f2BmYh
         AJzQ==
X-Received: by 10.49.131.67 with SMTP id ok3mr21215817qeb.42.1358755783063;
 Mon, 21 Jan 2013 00:09:43 -0800 (PST)
Received: by 10.49.84.133 with HTTP; Mon, 21 Jan 2013 00:09:42 -0800 (PST)
In-Reply-To: <7v1udfn0tm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214090>

On Sun, Jan 20, 2013 at 7:53 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> Implementing "git rm -u" as a tree-wide command would create a
>> discrepancy with "git add -u". Implementing it as a "current directory"
>> command would make the migration harder if we eventually try to change
>> "git add -u". Perhaps "git rm -u" should be forbidden from a
>> subdirectory (with an error message pointing to "git rm -u :/" and "git
>> rm -u ."), waiting for a possible "git add -u" change.
>
> Yeah, that sounds sensible.  Start with a "'git rm -u' is forbidden
> without arguments", give advise to use either "." or ":/".  And stop
> there.
>
> The first step of "git add -u" migration plan would be to warn when
> no argument is given and update all the existing index entries, and
> give the same advise to use either "." or ":/".  Keep this for three
> cycles: 3 * (8 to 10 weeks per cycle) = 27 weeks ~ 1/2 year.
>
> The second step would be to forbid "git add -u", and keep the
> advise.  That will make it in-line with "git rm -u".

Do you mean "git add" will be disallowed without "." or ":/" argument?
Or will this change in future and "git add" without argument will me
"whole tree", same as ":/" ?

--
Piotr Krukowiecki
