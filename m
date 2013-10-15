From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: What's cooking in git.git (Oct 2013, #02; Mon, 14)
Date: Tue, 15 Oct 2013 21:42:14 +0200
Message-ID: <525D9A96.6050209@web.de>
References: <20131014184524.GW9464@google.com> <20131015001231.GA9464@google.com> <xmqqiowye66r.fsf@gitster.dls.corp.google.com> <20131015191656.GD9464@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Anders Kaseorg <andersk@MIT.EDU>
To: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 15 21:42:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWAVd-0002JL-Pp
	for gcvg-git-2@plane.gmane.org; Tue, 15 Oct 2013 21:42:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759563Ab3JOTmU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Oct 2013 15:42:20 -0400
Received: from mout.web.de ([212.227.15.4]:54036 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759122Ab3JOTmU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Oct 2013 15:42:20 -0400
Received: from [192.168.178.41] ([91.3.172.217]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0LoYJu-1Vz9Od3vaM-00gYJy for <git@vger.kernel.org>;
 Tue, 15 Oct 2013 21:42:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0.1
In-Reply-To: <20131015191656.GD9464@google.com>
X-Enigmail-Version: 1.5.2
X-Provags-ID: V03:K0:fGePWCKrXNmGZLJHW/HcKDz5Tazehiq9beIIoPhClTRAZteaPOF
 T47vmwtBqeZPZbnh6VBxvI1rmI2t9bqIxa4XCqa24doHqeiheuAb4EV+JsobF5rOMQSGxpg
 RZ/mh/m8LXtLOTEtlhw42q4ctunXsTxpjHBGzArHtW4AiWrMPzsQTo6fYrllmE95RggLalM
 zaQJatyf2l/PLA001xs2A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236196>

Am 15.10.2013 21:16, schrieb Jonathan Nieder:
> So I suspect this will fix more scripts than it breaks, though it may
> still break some. :/

Hmm, I'm really not sure if we should do this or not.

> It might make sense to warn when passed multiple arguments and some
> include shell metacharacters, since that's probably rare, too, except
> it's punishing people who use multiple arguments as a way to avoid
> quoting issues.  Probably there's no replacement for just advertising
> the change loudly and seeking out scripts it could break.

And maybe only change that on a major version bump where people should
not be terribly surprised about such a change in behavior and are more
likely to read release notes?

I've thought about issuing a warning on certain quoting patterns too,
but dismissed that for not helping much in the scripting case. E.g. at
$dayjob we have foreach commands running in the shell execution for
quite some jobs on our Jenkins server; nobody would see any warnings
there until we'd have the reason to dig deeper int the logs because
something breaks.
