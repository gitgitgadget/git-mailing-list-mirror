From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v5 08/15] remote-testgit: cleanup tests
Date: Thu, 22 Nov 2012 01:55:14 +0100
Message-ID: <CAMP44s2T_qYeEMD=yTzTD07kL6km+W0XFOiHRAh5KtKi4CqTMw@mail.gmail.com>
References: <1352642392-28387-1-git-send-email-felipe.contreras@gmail.com>
	<1352642392-28387-9-git-send-email-felipe.contreras@gmail.com>
	<7vzk2a22g8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Max Horn <max@quendi.de>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Pete Wyckoff <pw@padd.com>, Ben Walton <bdwalton@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 22 20:05:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tbc5C-00067K-H2
	for gcvg-git-2@plane.gmane.org; Thu, 22 Nov 2012 20:05:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754349Ab2KVTEh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2012 14:04:37 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:56119 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754223Ab2KVTEg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2012 14:04:36 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so8300400oag.19
        for <git@vger.kernel.org>; Thu, 22 Nov 2012 11:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=kLoD9FoUekILokxJZmzd4E+b4A1lYC8wugwaSqh/QVc=;
        b=iMxXXrH7IZkNsPhy6DzcpLwy9zef4zXiEuiLm+tTknUsQBnV3WZ5ofrU/YNLL+fEnV
         KsnDw5VfB9x7luiw0MIYDEtK0hu4vkvOHsnE3MBAmYE9yAyzsfli1aMbHms8d5m0OTrb
         cj/1v9dFIsnCKXSo4wJRHBTj2s6ReNvaRchZMcVGR3Wplh78VStZNgGlOKwcOeBpFCOR
         Oxbd+Oo7pipcM1eOdjY2KYkjrQNZ94zQNTD2tNtPf9rf+95JlXh6mwewqJFPQYqC9nIC
         ohikcfWDWgIAOzex5lHNDPc5+EWZ6ZBUax7uN8io8Qi8GDHQEPmaQTu20e5ONiPDW4KG
         PNQw==
Received: by 10.60.9.5 with SMTP id v5mr17569367oea.81.1353545714929; Wed, 21
 Nov 2012 16:55:14 -0800 (PST)
Received: by 10.60.32.196 with HTTP; Wed, 21 Nov 2012 16:55:14 -0800 (PST)
In-Reply-To: <7vzk2a22g8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210189>

On Wed, Nov 21, 2012 at 7:28 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> We don't need a bare 'server' and an intermediary 'public'. The repos
>> can talk to each other directly; that's what we want to exercise.
>
> The previous patch to remove the test (the one that covered a case
> where a bug was fixed in an older git-remote-testpy and tried to
> catch the bug when it resurfaced) made sense even with its
> ultra-short justification "irrelevant".
>
> But I am not sure if this one is so cut-and-dried.  The repos can
> talk to each other directly, but at the same time the tests were
> exercising interactions between bare and non-bare repositories,
> weren't they?  Talking to each other may be one of the things we
> want to exercise, but that does not necessarily be the only thing.
>
> If it were explained like this (note that I am *guessing* what you
> meant to achieve by this patch, which may be wrong, in which case
> the log message needs further clarification):
>
>         Going through an intermediary 'public' may have exercised
>         interactions among combinations of bare and non-bare
>         repositories a bit more, but that is not an issue specific
>         to the remote-helper transfer that we want to be testing in
>         this script.  Simplify the tests to let two repositories
>         talk directly with each other.

Right. I don't think bare vs. non-bare has anything to do with it; the
intermediary repository was there to have 3 types of repos interacting
with each other local testpy, remote testpy, local git. But this
doesn't exercise anything from transport helper.

Cheers.

-- 
Felipe Contreras
