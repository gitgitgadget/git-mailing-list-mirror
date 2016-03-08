From: Kevin Wern <kevin.m.wern@gmail.com>
Subject: Re: Resumable clone
Date: Mon, 7 Mar 2016 19:33:40 -0800
Message-ID: <CANtyZjRZzXabeWEhwCrwN_q_Zsrm1f_d+j2uDhTZeEjv3LjxaA@mail.gmail.com>
References: <CANtyZjSJf5_xbsBC5tUaazFT3uiEgJnx2_kHLwYwKcn50Jy_qg@mail.gmail.com>
	<CACsJy8CESL6vH22mGSLRE1OKTEbGz2Vqmsv5bY3mn_E+03wADw@mail.gmail.com>
	<xmqqoaasvkrt.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 08 04:33:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ad8P5-0001F5-RW
	for gcvg-git-2@plane.gmane.org; Tue, 08 Mar 2016 04:33:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753435AbcCHDdn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Mar 2016 22:33:43 -0500
Received: from mail-oi0-f44.google.com ([209.85.218.44]:36417 "EHLO
	mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752850AbcCHDdl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Mar 2016 22:33:41 -0500
Received: by mail-oi0-f44.google.com with SMTP id r187so2168219oih.3
        for <git@vger.kernel.org>; Mon, 07 Mar 2016 19:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=hDWFHtMwA79s4AdOAQerP5NUuLpvOZVHSjvZAcecpXw=;
        b=C2hIZHP8nhsQHhWJvO1odHTyyKeAI33oUGsJ4TAEi+xoSvynQCwLNz5DaSr3UdnInm
         K86UTk/qNEc306pVzOYQPXs29Y8wLpc53F4bH12FiCUuryJzrIn2/jtq6ZnHWck0HYyH
         jfT9oh7x28T0sKaanyILGKkI0P3wkHiWmqu/VEuCyq9SYFGk7GHfj2eajHyeg5PB/K64
         Yd/V3KEGqF4Hz0nKBjGw8RWrAywkB0md9iq8fJXjx4TpFkEZSrqfvaxz2xREia9lU3Gb
         IOI/LV8geYzK0yJ95kNkSplWollXfjCzIZ+4TQZyKxnA2oPt6NKD2XqfMq1NGT+RXFcX
         F7dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=hDWFHtMwA79s4AdOAQerP5NUuLpvOZVHSjvZAcecpXw=;
        b=GelRG7gxvDz/9CN8KlnSfph7PWhYK/uIjXg3qTMFzBabCf830SAIQtLpWvtebRi1RP
         cXlz6gUTN89fkR62/lilYVwQVlee+ADvwWi8GiLHMiVKY4EACSxYLPlOvD4dJjdab8Gf
         r5o/I+I/T02beHjBIKiLCh7XbTZSjlAHJ+DWxXjYfoXY9V2Lka7k8qH9ya6W+FckHgpJ
         pYF4vvzDRxo3U0yZxNziGJVrSiGvpSl6YONEv437Y+pyIpxSuIBT9s6SoQ+tBaa7YuxB
         qW2wSfvo2jfSbnleBaz+cDAV83Nul0sUvzSC1n9nnXwP85UXXLLYze/mXGnVAQfi+k4G
         nARA==
X-Gm-Message-State: AD7BkJLG8jvbtjCD3nKKt1S4qmyuCwMneYlGQhZK+hN3n4dzio83UmyU2VHFZpETp39GnV/1iQNgVEVDDRDASQ==
X-Received: by 10.202.48.130 with SMTP id w124mr15881582oiw.61.1457408021027;
 Mon, 07 Mar 2016 19:33:41 -0800 (PST)
Received: by 10.202.206.11 with HTTP; Mon, 7 Mar 2016 19:33:40 -0800 (PST)
In-Reply-To: <xmqqoaasvkrt.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288414>

Hey Junio and Duy,

Thank you for your thorough responses! I'm new to git dev, so it's
extremely helpful.

> - The server side endpoint does not have to be, and I think it
> should not be, implemented as an extension to the current
> upload-pack protocol. It is perfectly fine to add a new "git
> prime-clone" program next to existing "git upload-pack" and
> "git receive-pack" programs and drive it through the
> git-daemon, curl remote helper, and direct execution over ssh.

I'd like to work on this, and continue through to implementing the
prime_clone() client-side function.

>From what I understand, a pattern exists in clone to download a
packfile when a desired object isn't found as a resource. In this
case, if no alternative is listed in http-alternatives, the client
automatically checks the pack index(es) to see which packfile contains
the object it needs.

However, the above is a fallback. What I believe *doesn't* exist is a
way for the server to say, "I have a resource, in this case a
full-history packfile, and I *prefer* you get that file instead of
attempting to traverse the object tree." This should be implemented in
a way that is extensible to other resource types moving forward.

I'm not sure how the server should determine the returned resource. A
packfile alone does not guarantee the full repo history, and I'm not
positive checking the idx file for HEAD's commit hash ensures every
sub-object is in that file (though I feel it should, because it is
delta-compressed). With that in mind, my best guess at the server
logic for packfiles is something like:

Do I have a full history packfile, and am I configured to return one?
- If yes, then return an answer specifying the file url and type (packfile)
- Otherwise, return some other answer indicating the client must go
through the original cloning process (or possibly return a different
kind of file and type, once we expand that capability)

Which leaves me with questions on how to test the above condition. Is
there an expected place, such as config, where the user will specify
the type of alternate resource, and should we assume some default if
it isn't specified? Can the user optionally specify the exact file to
use (I can't see why because it only invites more errors)? Should the
specification of this option change git's behavior on update, such as
making sure the full history is compressed? Does the existence of the
HEAD object in the packfile ensure the repo's entire history is
contained in that file?

Also, for now I'm assuming the same options should be available for
prime-clone as are available for upload-pack (--strict,
--timeout=<n>). Let me know if any other features are necessary.
Also, let me know if I'm headed in the complete wrong direction...

Thank you so much for your help!
