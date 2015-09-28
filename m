From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC/PATCH v1] Add Travis CI support
Date: Mon, 28 Sep 2015 10:21:51 -0700
Message-ID: <CAGZ79karJa0KfMcqwXopZ5Uuh1ocDizH=fFqFDS+Jw-kTc-wng@mail.gmail.com>
References: <1443131004-39284-1-git-send-email-larsxschneider@gmail.com>
	<xmqqeghnuy8t.fsf@gitster.mtv.corp.google.com>
	<1443150875.3042.3.camel@kaarsemaker.net>
	<699c08632232180166145f70c7f16645@dscho.org>
	<CAE5ih7_f8qy9WvmgRUR6-qFwB4WFhZ6Qr5iOpE0YxqJH8AsZyw@mail.gmail.com>
	<vpq7fnc83ki.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Luke Diamand <luke@diamand.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Dennis Kaarsemaker <dennis@kaarsemaker.net>,
	Junio C Hamano <gitster@pobox.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	Git Users <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Sep 28 19:22:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zgc7i-0005eC-NR
	for gcvg-git-2@plane.gmane.org; Mon, 28 Sep 2015 19:21:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934475AbbI1RVy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2015 13:21:54 -0400
Received: from mail-yk0-f171.google.com ([209.85.160.171]:36738 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934081AbbI1RVx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 13:21:53 -0400
Received: by ykdt18 with SMTP id t18so188216558ykd.3
        for <git@vger.kernel.org>; Mon, 28 Sep 2015 10:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=3DWtV/FKeR2WoQGb88e5FyQCYgbk1sjwbZ8XSuR2wtA=;
        b=SjCrD/zqAp/B9uJMPolQBC4IkF29J/o3qFuBCSExtpp56cocpmEWB9vQugnEELZlqC
         5nZeBgAoVEs5wQ9ITLxR8b4Q7cL9hgWVsl2Q/pIVp1+xc7/nLFtKiZC1QGvG8LIeuIpD
         WL70nrKdH6lD279ZegrVx6QqQgcF9SJYGOKb0ZtPcGRZELtJWuQSw1l9uYzx8K8gS1Zb
         57yolTW1fa0R3urYNoW6UbXbcF3i0VrW7bXJpDJYutxXfhBgIqWHYAd7U0KKa1z46bmv
         oLOFvtgjo5dYZw26eyus/2wz7d0s8KfCbXLvth/5wlBo85S0QpftN7i+OkvVArkop68c
         WkfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=3DWtV/FKeR2WoQGb88e5FyQCYgbk1sjwbZ8XSuR2wtA=;
        b=mDBPvpXj16CG2mm5QmoRvFdyo08X85zW/RMZJQJ8UGAKV1dIpc81Xrx+bKjc+badLV
         DamZmt4vPp6dNo7rGGsXD9fg2kzH1geUnj2PaSDzJwAchFY1hNJBXFrzkhsLasj6HRTB
         kPI+KdGx3saiuI93/kFLxCIvslsr+n6JH2g0ofGw+YDvnUqdkkZB7KsUQW8SeNcL0fIQ
         J880o5mLK/j0tyz47v8FSQ5bd/bVTjyidxK7EHd8VIns/Sd6CjNYawD6Gga0lLav4KXz
         rUJBh1QP+D22D6Cam9QASwtCXLD436DTUetfp9Hr+8aDjLNfLYxZW2tILwq+3NxFbd1x
         rXOg==
X-Gm-Message-State: ALoCoQkE+OY0sbef1xjJDZk8os2pS8synwWinwvb/oT+nki2xBPd4hwlSeyAKcT5nugwSFilRGF1
X-Received: by 10.13.211.135 with SMTP id v129mr18510114ywd.129.1443460912381;
 Mon, 28 Sep 2015 10:21:52 -0700 (PDT)
Received: by 10.37.29.213 with HTTP; Mon, 28 Sep 2015 10:21:51 -0700 (PDT)
In-Reply-To: <vpq7fnc83ki.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278731>

On Sun, Sep 27, 2015 at 5:11 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
>
> My experience with Travis-CI is that it just works

I can second that.
When I was contributing to other projects[1][2], Travis helped a lot.

Currently I have a cronjob to get https://scan.coverity.com/
running on Git a few times a week on the pu branch
(plus $gmane/271826). Additionally to that I could setup
a travis test to that, which would run daily on stefanbeller/pu
(which would be a copy of junios pu branch).

I just logged in to travis and it seems as if they don't require
write access to the repository (any more? They used to require
it, but now they ask for updated permissions which drops
write access to a repository, but then asks for more meta
data permissions, such as web hooks, my email address,
my organizations).

Having observed that there is no reason to not turn it on on
the main repository (set it and forget it).

[1] https://github.com/bjorn/tiled
[2] https://github.com/clintbellanger/flare-engine



>
>   http://docs.travis-ci.com/user/notifications/
>
>   "By default, email notifications are sent to the committer and the
>   commit author, if they are members of the repository (that is, they
>   have push or admin permissions for public repositories, or if they
>   have pull, push or admin permissions for private repositories)."
>
> In short:
>
> * If the tests always pass, nobody ever get any email from Travis-CI.
>
> * When someone sends a pull-request that fails tests, that someone gets
>   an automatic email about the failure. This saves one email round-trip
>   "X sends a patch series, Junio notices the failure, Junio sends an
>   email about the failure", and shortcuts this as "X sends a PR, and
>   gets an email, possibly even before Junio notices".
>
>> Automated testing is a Good Thing, but it's still software, so needs
>> maintenance or it will break.
>
> The point of using Travis-CI is precisely to use an externally
> maintained system. It's not just software, it's a service (based on
> software, obviously).
>
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
