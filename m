From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH v1] Add Travis CI support
Date: Sun, 04 Oct 2015 10:59:13 -0700
Message-ID: <xmqqio6m1pn2.fsf@gitster.mtv.corp.google.com>
References: <1443131004-39284-1-git-send-email-larsxschneider@gmail.com>
	<xmqqeghnuy8t.fsf@gitster.mtv.corp.google.com>
	<1443150875.3042.3.camel@kaarsemaker.net>
	<699c08632232180166145f70c7f16645@dscho.org>
	<CAE5ih7_f8qy9WvmgRUR6-qFwB4WFhZ6Qr5iOpE0YxqJH8AsZyw@mail.gmail.com>
	<vpq7fnc83ki.fsf@grenoble-inp.fr> <vpq4mie1m3n.fsf@grenoble-inp.fr>
	<xmqqlhbqcrf7.fsf@gitster.mtv.corp.google.com>
	<CAFY1edZSNKepx_+2U=C-raOBiVK3Zh2r_Y_NO2-RtbhH_n-tdg@mail.gmail.com>
	<CAPc5daXkn=C-D5RQCw2w+JrHn7XZA6X-P4F-PugRe-S4Z2RO0g@mail.gmail.com>
	<vpq1tdb83nt.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Roberto Tyley <roberto.tyley@gmail.com>, Jeff King <peff@peff.net>,
	Luke Diamand <luke@diamand.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Dennis Kaarsemaker <dennis@kaarsemaker.net>,
	Lars Schneider <larsxschneider@gmail.com>,
	Git Users <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Oct 04 19:59:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZinZC-0001Xa-Lq
	for gcvg-git-2@plane.gmane.org; Sun, 04 Oct 2015 19:59:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751747AbbJDR7Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Oct 2015 13:59:16 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:36482 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751611AbbJDR7P (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Oct 2015 13:59:15 -0400
Received: by pablk4 with SMTP id lk4so152395365pab.3
        for <git@vger.kernel.org>; Sun, 04 Oct 2015 10:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=EZQWp79RMckd9IpeU1z2Xo3Ppu8eCXhTeR3rAN2/5qU=;
        b=0KNolQtIa9BCsb66aPZ59keDIrlCmMWteyy5u4JE8dUbc6iFRGYpSV3x3NZGysnvjV
         dAhFxd2Z+CXlKFoYKkJvDBJ+Vox8H+x7XfA+K0/JSq7iZSPmr3G1vHZkietvM2va9hA7
         j8OmyR3d+a2jkeJqn2VNcO+CW9sIfBHd29iNQ3BIStguJu4s/9/GNb6GiP6hd+36ZXq/
         NSV81z7SDoicoRpFzSQHsy6CQyXFjfqM9xlecHLO6QqYY5RNow4GQQ5mwFNyFVF3ZzUD
         Ba2XQUzboQoZIUihSrOLPcsm0POMU6yHGfH+dJZXnpZm3QaxS3Zj/PcLjZfT12qwuRCD
         afoQ==
X-Received: by 10.68.69.35 with SMTP id b3mr35336256pbu.22.1443981555200;
        Sun, 04 Oct 2015 10:59:15 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:cd5:dd7c:35c8:15e])
        by smtp.gmail.com with ESMTPSA id rx8sm23025813pbb.90.2015.10.04.10.59.14
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 04 Oct 2015 10:59:14 -0700 (PDT)
In-Reply-To: <vpq1tdb83nt.fsf@grenoble-inp.fr> (Matthieu Moy's message of
	"Sun, 04 Oct 2015 09:59:50 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279008>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Currenty, to mimick this flow, we would need something like
>
> 1) User activates Travis-CI on his repo (each user would have to do
>    this, not just once)
>
> 2) User commits .travis.yml on top of the code to submit
>
> 3) User pushes to his repo
>
> 4) Travis-CI triggers a build
>
> 5) User removes the commit introducing .travis.yml, force-pushes
>
> 6) User submit the resulting code.

I do not think it has to be so convoluted.  I know this would appear
to be more or less a moot point, as the long term direction would be
to enable one on git/git and do PR-initiated tests, but I am writing
it here because I would really prefer that the CI configuration file
that will be added to my tree is a "battle tested" one.

A motivated user who wants to send a patch to add it to my tree can:

 (1) Fork from an ancient place, e.g. v2.0.0, and add the CI
     configuration file.  Call that branch "travis".

 (2) Prepare topics that he wants to test (not related to "add CI
     integration to Git" topic) on its own topics, branching from my
     'master' or 'maint' depending on the target track.

 (3) Keep a branch that merges (2) with (1).  This could be a set of
     branches, one per topics in (2).

 (4) Have the CI monitor (3).

 (5) Make sure tests pass.  Send (2) out via whatever means,
     e.g. via SubmitGit.

And keep the set-up for a few months to make sure everything looks
good, before sending (1) out via SubmitGit.
