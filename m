From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 6/9] branch: display publish branch
Date: Fri, 18 Apr 2014 18:29:53 -0500
Message-ID: <5351b571421e4_3497cdf30c78@nysa.notmuch>
References: <1397156686-31349-1-git-send-email-felipe.contreras@gmail.com>
 <1397156686-31349-7-git-send-email-felipe.contreras@gmail.com>
 <CALkWK0mSfsUrSMPMmZ+PNtZ2WBUqN4Swk_e6S1fMGuUoocJSEg@mail.gmail.com>
 <53471d0b4c8dc_d696b12f08c@nysa.notmuch>
 <20140411111750.GA28858@sigill.intra.peff.net>
 <xmqqsipjsm8c.fsf@gitster.dls.corp.google.com>
 <20140412114212.GB14820@sigill.intra.peff.net>
 <5349562bb7ae4_c9914c7308f9@nysa.notmuch>
 <20140415054356.GA4772@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Matthieu Moy <matthieu.moy@imag.fr>,
	John Szakmeister <john@szakmeister.net>
To: Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 19 01:40:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WbIOJ-0000Lq-Lr
	for gcvg-git-2@plane.gmane.org; Sat, 19 Apr 2014 01:40:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753332AbaDRXkQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Apr 2014 19:40:16 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:43097 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751691AbaDRXkM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Apr 2014 19:40:12 -0400
Received: by mail-ob0-f180.google.com with SMTP id wm4so2345142obc.11
        for <git@vger.kernel.org>; Fri, 18 Apr 2014 16:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=/g/BSJnHLN3KWcrfTFd/60OHsq5YELUq0eoYSS3E6Ww=;
        b=fYgX4Lk/bsCEayUzR2TG3MbitO1dVNSuP2cXdaB8JhjsBO2rCYBXkCESZIOp32lAzQ
         2D6Wdj4CpU0vqIVQTIu+S6XH7uywzRCf8pcBhXEOMVVN2uVmESpSvetX7e4zC8gryMaj
         q4/l/WUh/GkCVhfj/4cpjMIQHB9aqNMu/gGXpcLx6FzJKbn8t9wL7OsbrIRsI1V39VFG
         cLNTlYbtq+SNACfGhU3PaGn2AtxwOdKXkouNB4nfwr1vT7Rx7fQW6x6eesDEJ5iJHOw9
         +KZpx+kcyb6ndaGKdcVsi0jkZ7X4lTk55Ge6lkheAtl0/zZ4gma+3r64XJqgo8fEprPM
         r+Fg==
X-Received: by 10.60.134.137 with SMTP id pk9mr14469209oeb.40.1397864412177;
        Fri, 18 Apr 2014 16:40:12 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id zm8sm55409272obc.16.2014.04.18.16.40.09
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Apr 2014 16:40:10 -0700 (PDT)
In-Reply-To: <20140415054356.GA4772@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246489>

Jeff King wrote:
> On Sat, Apr 12, 2014 at 10:05:15AM -0500, Felipe Contreras wrote:
> 
> > As you can see; some branches are published, others are not. The ones that are
> > not published don't have a @{publish}, and `git branch -v` doesn't show them.
> > Why is that hard to understand?
> 
> Do you ever push the unpublished branches anywhere at all? If not, then
> you would not have a tracking branch. E.g., git _would_ push to remote
> "gh", branch "refs/heads/topic", but there is no remote tracking branch
> "refs/remotes/gh/topic", because you have never actually pushed there.
> So there is no @{publish} branch.
> 
> Or do you have some branches in a state where they are "pushed, but not
> published"? It wasn't clear to me from your example if your "pu" or
> "dev/remote/hg-extra" ever get pushed.

Sometimes I do push these branches, but I don't understand what you mean by
"pushed state". When you push something no states are changed. Say I do:

 % git push tmp wip-feature
 % git push backup wip-feature

So I pushed a branch to two different repositories, the former one might not
even exist any more. Who cares? No states have changed. The fact that this
branch was pushed doesn't change anything about the nature of the branch.

> I do not use "git branch -v" myself,

Me neither (at least not the upstream version).

> so I don't personally care that much how it behaves. But I do use a separate
> script that does the same thing, and I would want it to show the ahead/behind
> relationship between each branch and where it would be pushed to (and as I
> said, I define mine with refspecs). Right now it uses nasty hackery to guess
> at where things will be pushed, but ideally it would ask git via @{push} or
> some similar mechanism.

Yes, but you can push a branch to many locations, to which one should the
script show the tracking information? IMO it should be the one location you
explicitly configured, and in the case of "wip-feature" is "no location".

> If the former (you do not actually push them), then I think the semantics I
> am looking for and the ones you want would coincide. If not, then I think we
> are really talking about two different things.

I ask again what is so difficult about the notion that there are two kinds of branches?

A)

% git checkout ready-feature
% git push tmp ready-feature
% git push -p github ready-feature
% git push backup ready-feature

B)

% git checkout wip-feature
% git push tmp wip-feature
% git push backup wip-feature

In a haste these branches might not look very different, but conceptually they
are. One has a location where it is publicly visible, and where you wish to
push regularly, the other one doesn't.

Whether you push a branch or not is not really important, it's whether or not
the branch has a *special* place where you push to.

-- 
Felipe Contreras
