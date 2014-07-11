From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v6 02/10] replace: add --graft option
Date: Fri, 11 Jul 2014 18:24:50 +0200
Message-ID: <CAP8UFD2db=ZMFSvzW6be3gBv7DP93C7Z5yfOEhs9QLNOkX0fGQ@mail.gmail.com>
References: <20140707063342.3708.83493.chriscool@tuxfamily.org>
	<20140707063540.3708.51047.chriscool@tuxfamily.org>
	<xmqqsima7f3r.fsf@gitster.dls.corp.google.com>
	<CAP8UFD2X7j2TGEQfX3h8CfiZypJ5tVPqaZ2bNE0k1-jbeJj=Zw@mail.gmail.com>
	<xmqqr41t88dz.fsf@gitster.dls.corp.google.com>
	<xmqqegxt86ba.fsf@gitster.dls.corp.google.com>
	<CAP8UFD0_m5aFVcBQr3d9pXR=9rLjAVPGrj=UsBYFcnTQFwNKGA@mail.gmail.com>
	<xmqqmwcg561j.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <chriscool@tuxfamily.org>,
	git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 18:25:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5ddm-0000rk-8m
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jul 2014 18:25:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753753AbaGKQZi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2014 12:25:38 -0400
Received: from mail-vc0-f180.google.com ([209.85.220.180]:55871 "EHLO
	mail-vc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754702AbaGKQYw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2014 12:24:52 -0400
Received: by mail-vc0-f180.google.com with SMTP id im17so2493297vcb.39
        for <git@vger.kernel.org>; Fri, 11 Jul 2014 09:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=5DfapL+CahxsLtIgv1agx2e1S/71Wg6Nb65tr0q0o5A=;
        b=JoTCx7v3XENKN6AfKk+pXegoCFRxXRg/bWyby2spVjjvpxcrOZjre7Rz4d71tsw1ap
         txxqd+bBiPA5ysFOtKtFt0Zj1sdjubC1W0U3rlRh7J9kIgFChaMtvURR11Ud+mjo4CUg
         JYzpY/iwC9a+LI8AuvAUfeMMS5njTIJvU1JOO/esDUyE1WBt/wDEpnmqdOfZFkpWk0EG
         U7f3ie3JwbsbqePlM0/R1JtIXyandXc2tP/RtXcMzODVk2GC+Lykuc7uUbsGA4a+ERlU
         aReRzWf0VAO6qGIhqC/uLP9X3+KwBf3IcTxy0nKJuOLtYRJwk8zTXhkantwYzAsbZsOa
         uI7w==
X-Received: by 10.220.114.140 with SMTP id e12mr2184262vcq.37.1405095891047;
 Fri, 11 Jul 2014 09:24:51 -0700 (PDT)
Received: by 10.58.76.137 with HTTP; Fri, 11 Jul 2014 09:24:50 -0700 (PDT)
In-Reply-To: <xmqqmwcg561j.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253287>

On Fri, Jul 11, 2014 at 4:22 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> On Thu, Jul 10, 2014 at 7:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>>>> "Making sure A's parent is B" would be an
>>>> idempotent operation, no?  Why not just make sure A's parent is
>>>> already B and report "Your wish has been granted" to the user?
>>
>> ... and here you say we should report "your wish has been granted"...
>
> Normal way for "git replace" to report that is to exit with status 0
> and without any noise, I would think.

In a similar case "git replace --edit" we error out instead of just
exiting (with status 0), see:

f22166b5fee7dc (replace: make sure --edit results in a different object)
