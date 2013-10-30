From: Karl Wiberg <kha@treskal.com>
Subject: Re: Show patch in gitk --first-parent ?
Date: Wed, 30 Oct 2013 18:10:43 +0100
Message-ID: <CAFAOj7orccjudOu4czDpaN-TZBCFb=T-Qo8f9eo_1dnKBGXJ4g@mail.gmail.com>
References: <CAFAOj7p49pQo=hXZT3TmMFF+KThKY-PZ2cgsZasH=e8rgjri1A@mail.gmail.com>
	<1lbk7r8.1khd6h5pbrifuM%lists@haller-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Paul Mackerras <paulus@samba.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Stefan Haller <lists@haller-berlin.de>
X-From: git-owner@vger.kernel.org Wed Oct 30 18:10:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbZIA-0004PU-C2
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 18:10:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752136Ab3J3RKq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 13:10:46 -0400
Received: from mail1b.space2u.com ([194.218.23.146]:57802 "EHLO
	mail1.space2u.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750865Ab3J3RKp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Oct 2013 13:10:45 -0400
Received: from mail-we0-f170.google.com (mail-we0-f170.google.com [74.125.82.170])
	(authenticated bits=0)
	by mail1.space2u.com (8.14.5/8.14.4) with ESMTP id r9UHAhhr006646
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
	for <git@vger.kernel.org>; Wed, 30 Oct 2013 18:10:43 +0100
Received: by mail-we0-f170.google.com with SMTP id u57so1603854wes.29
        for <git@vger.kernel.org>; Wed, 30 Oct 2013 10:10:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=hBsm/gGFwzkdHtyE+VspmyhhlWvvtTcpUvFnvMZaOrA=;
        b=QpqFuveuAdZxhne/7s4WbSFYhw99DVuU3oJQI3yBV0xBbU5g8cUu1Qk9EIBzAhlJaR
         j5H1onXIuArzjBnf5LzDNxjNdfgF07tHMQPeEw1LNbho+oquSBn+Fpc/NrGKIbeQHuSt
         UFjGw2udZCw1ggJYi5TVc0KpQBoH7E9VYSWFeKxJi2FMzbE9Xs/NRxMnTcwoGJTX4vst
         7bTw4rzzeO7qdw2Fj7pradWDBDCgNaUz7n9aL9RHH3gC/yC/GBmdOtt+aCFwXAXJvJm2
         vZJyAVnstXGMxZve863dZtZyN1lUQvUFxl4/nLjrILopXeuquLWp+y+6pUN5NYxFP9LZ
         WNCw==
X-Received: by 10.194.239.40 with SMTP id vp8mr3464241wjc.45.1383153043349;
 Wed, 30 Oct 2013 10:10:43 -0700 (PDT)
Received: by 10.216.207.141 with HTTP; Wed, 30 Oct 2013 10:10:43 -0700 (PDT)
In-Reply-To: <1lbk7r8.1khd6h5pbrifuM%lists@haller-berlin.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237038>

On Wed, Oct 30, 2013 at 3:30 PM, Stefan Haller <lists@haller-berlin.de> wrote:

> I once posted a patch that adds a "First parent" checkbox to gitk's
> window:
> <http://comments.gmane.org/gmane.comp.version-control.git/160920>
>
> The patch no longer applies today, but I can send an updated version
> that does, if there's interest.

Please do. I don't have the time to attempt to drive inclusion of the
patch (I'd have to start by reading up on tcl and gitk), but if you
have a patch ready, I'd like to try it.

> The topic didn't go anywhere for two reasons:
>
> 1) There's the confusion about history traversal option (the
> existing --first-parent command-line option) versus diff option (the
> new check box); they have similar names, but control different
> things (and it should be possible to control these independently).
>
> 2) Space is short in the diff pane; you need to make the window
> rather wide to see them all.
>
> I didn't have the energy to drive these to a resolution back then;
> if you could do that, it would be great. Personally I'm using my own
> gitk with my patch applied, and I do use the "First parent" checkbox
> rather often.

Hmmm, I wonder... a related feature I'd like to have is to see the
combined diff of two or more commits. I guess the fully general form
of this is to allow the user to select one "after" commit and zero or
more "before" commits, and then present the resulting diff.

For example, when the user clicks on the shortlog of a commit, gitk
could automatically select its parents (by painting their dots in the
DAG differently, say). The user could then click on any commit dot in
the dag to toggle it between being included in and excluded from the
"before" set. (A simpler variant would be to limit the "before" set to
exactly one commit as soon as the user changes it at all.)

As I said, I don't have time to do this myself; I just thought I'd
toss the idea out there, since good ideas are so scarce and competent
programmers with free time on their hands are so plentiful.

-- 
Karl Wiberg, kha@treskal.com
   subrabbit.wordpress.com
   www.treskal.com/kalle
