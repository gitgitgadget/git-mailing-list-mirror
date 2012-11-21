From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v5 15/15] fast-export: don't handle uninteresting refs
Date: Wed, 21 Nov 2012 05:22:33 +0100
Message-ID: <CAMP44s2mpxSX4oMMofffgeYD43CROsM_ruj1NHijPANgPU4d-A@mail.gmail.com>
References: <1352642392-28387-1-git-send-email-felipe.contreras@gmail.com>
	<1352642392-28387-16-git-send-email-felipe.contreras@gmail.com>
	<CAMP44s0WH-P7WY4UqhMX3WdrrSCYXUR9yCgsUV+mzLOCK5LkHQ@mail.gmail.com>
	<7vd2z7rj3y.fsf@alter.siamese.dyndns.org>
	<20121121041735.GE4634@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Max Horn <max@quendi.de>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Pete Wyckoff <pw@padd.com>, Ben Walton <bdwalton@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 21 05:22:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tb1pq-0006tx-HC
	for gcvg-git-2@plane.gmane.org; Wed, 21 Nov 2012 05:22:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753026Ab2KUEWf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2012 23:22:35 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:43939 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752748Ab2KUEWe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2012 23:22:34 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so6648505oag.19
        for <git@vger.kernel.org>; Tue, 20 Nov 2012 20:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ERlh20OrXnU+V9AhdP4vmlATn2BF0wbtiPS2453Do30=;
        b=QInP61rR3Hk9FntO/fqL/7Q3yBO5P2ECvPsjn4VIZJW+9ivttBsCnlJm//BDhCkHYf
         pA+JKV+OJS/OuQ0rBUuxa3D/c+IWCkxY4dk0LMOxoHNh7nIekJQLpg+piRepYKkKx0oO
         g7v9UwNB+xTC8gEcqwL78H8eC7uVWkNeOZcFe1MfgLqBFUFeWHiy/Ggr8R5Cbf2eRtmh
         Ee9/OFioL1HFtrZ8w5ZZxJMSljiZjrFCy5Y4Mm8KKLyiqCw+edXryxHj8XP7s8xubZUz
         O24kYrUIHw9gOsTOwxJ3UYS6D7j7FAofnLfqLiRyAmvLh8tLiZsVWjPth/MMAgDIm9qq
         uxfA==
Received: by 10.182.21.175 with SMTP id w15mr9214835obe.28.1353471753902; Tue,
 20 Nov 2012 20:22:33 -0800 (PST)
Received: by 10.60.28.232 with HTTP; Tue, 20 Nov 2012 20:22:33 -0800 (PST)
In-Reply-To: <20121121041735.GE4634@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210134>

On Wed, Nov 21, 2012 at 5:17 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Junio C Hamano wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>>> Of course, transport-helper shouldn't even be specifying the negative
>>> (^) refs, but that's another story.
>>
>> Hrm, I am not sure I understand what you mean by this.
>>
>> How should it be telling the fast-export up to what commit the
>> receiving end should already have the history for (hence they do not
>> need to be sent)?  Or are you advocating to re-send the entire
>> history down to the root commit every time?
>
> I think Felipe has mentioned before that he considers it the remote
> helper's responsibility to keep track of what commits have already
> been imported, for example using a marks file.

It's not the remote helper, fast-export does that.

> Never mind that others have said that that's not the current interface
> (I don't yet see why it would be a good interface after a transition,
> but maybe it would be).  Still, hopefully that clarifies the intended
> meaning.

The current interface is broken.

not ok 16 - pulling without marks # TODO known breakage
not ok 17 - pushing without marks # TODO known breakage

See? A remote helper without marks doesn't work.

-- 
Felipe Contreras
