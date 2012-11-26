From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v5 15/15] fast-export: don't handle uninteresting refs
Date: Mon, 26 Nov 2012 13:16:21 +0100
Message-ID: <CAMP44s1ZUBopJb_RNreV9TQNzG8_yscvGRtuvTFEJWfP=DhsZQ@mail.gmail.com>
References: <1352642392-28387-1-git-send-email-felipe.contreras@gmail.com>
	<1352642392-28387-16-git-send-email-felipe.contreras@gmail.com>
	<CAMP44s0WH-P7WY4UqhMX3WdrrSCYXUR9yCgsUV+mzLOCK5LkHQ@mail.gmail.com>
	<7vd2z7rj3y.fsf@alter.siamese.dyndns.org>
	<20121121041735.GE4634@elie.Belkin>
	<7vfw43pmp7.fsf@alter.siamese.dyndns.org>
	<20121121194810.GE16280@sigill.intra.peff.net>
	<CAMP44s2B2_htR8LFbHk99WaNUcaYJCxVJPdRdj5VQ0k+fB9NOg@mail.gmail.com>
	<7v7gp9udsl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
	git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Max Horn <max@quendi.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Pete Wyckoff <pw@padd.com>, Ben Walton <bdwalton@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 13:16:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tcxc6-0000EF-Vu
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 13:16:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754862Ab2KZMQW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 07:16:22 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:45782 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754641Ab2KZMQW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 07:16:22 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so10625510oag.19
        for <git@vger.kernel.org>; Mon, 26 Nov 2012 04:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ja0sP2KufdgpQcC9JCgUfZa1CzfKYJ7BG1BPztG9pjg=;
        b=Jb7ehBeZSSAGBGow4Q5oRSdeY6lBAcKv2t7Y781qt4WvEqUIyGcBaAn5h1vdns7eFS
         GGd/uVA4J5tjsGzPQEPq/Kb4ozuqa9m4dZgv9ZZBXjrYazIcX1qmy/mEXpWS2ZB9mMwO
         byAUoL5lOw69MNBnBx9GOTJ5XoNojiEyGbOk0q+bcGTG7bCcKUO1mryRXM7Wdk9Kl2sp
         fa6fBNiQTN3ldWNIAFG8hcg5CLWmfvi87pd51+dMyUcw9BZjkjYji2aF341azYl0Or7x
         RhRrWLohVp4aoAL03AbnK821kROoehI9H7cYAG2tHlpRdZwnqcW8hHPt0zTs3+w/+UgR
         i6Vw==
Received: by 10.60.28.132 with SMTP id b4mr3530836oeh.41.1353932181739; Mon,
 26 Nov 2012 04:16:21 -0800 (PST)
Received: by 10.60.32.196 with HTTP; Mon, 26 Nov 2012 04:16:21 -0800 (PST)
In-Reply-To: <7v7gp9udsl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210434>

On Mon, Nov 26, 2012 at 6:35 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Wed, Nov 21, 2012 at 8:48 PM, Jeff King <peff@peff.net> wrote:
>> ...
>> I would like to understand that that even means. What behavior is
>> currently broken?
>
> I do not know if this is the same as what Peff was referring to, but
> I found this message in the discussion thread during my absense.
>
> From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Subject: Re: [PATCH v3 4/4] fast-export: make sure refs are updated properly
> Date: Fri, 2 Nov 2012 16:17:14 +0100 (CET)
> Message-ID: <alpine.DEB.1.00.1211021612320.7256@s15462909.onlinehome-server.info>
>
> (which is $gmane/208946) that says:
>
>         Note that
>
>                 $ git branch foo master~1
>                 $ git fast-export foo master~1..master
>
>         still does not update the "foo" ref, but a partial fix is better
>         than no fix.

First of all, do we agree that this patch does not change the
situation for this command? If so, I don't see why that would be
relevant while discussing this patch series.

Second, this is what I get:

% git log --decorate --oneline foo master~1..master
8c7a786 (tag: v1.8.0, master) Git 1.8.0

Notice that 'foo' is not there? It's not there because we explicitly
stated that we didn't want it there.

And what do you expect that command to do with 'foo'? To throw a
'reset refs/heads/foo'? To what commit? There is no mark for that
commit. 'reset :0'? That doesn't help anybody. No, that command is not
broken, it works as expected.

Notice the situation would be different with 'git fast-export
--import-marks=marks foo master~1..master', because if there's a mark
for foo, *now* we can do something about it. This particular patch
series doesn't, but the next one does.

Cheers.

-- 
Felipe Contreras
