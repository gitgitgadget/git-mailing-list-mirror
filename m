From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH v9 5/5] Speed up log -L... -M
Date: Sat, 23 Mar 2013 06:58:48 +0100
Message-ID: <87k3oyzmg7.fsf@pctrast.inf.ethz.ch>
References: <cover.1363865444.git.trast@student.ethz.ch>
	<72a500432c0e6fde830f505204a1d02180710656.1363865444.git.trast@student.ethz.ch>
	<CAPig+cSG1gYohpZQZxnCpKgkUPs=Dwfokx+3OhiqdGKX8fajBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Thomas Rast <trast@student.ethz.ch>,
	Git List <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	Bo Yang <struggleyb.nku@gmail.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Will Palmer <wmpalmer@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sat Mar 23 06:59:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJHUB-0003LK-LL
	for gcvg-git-2@plane.gmane.org; Sat, 23 Mar 2013 06:59:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755694Ab3CWF6y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Mar 2013 01:58:54 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:18471 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751536Ab3CWF6x (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Mar 2013 01:58:53 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sat, 23 Mar
 2013 06:58:47 +0100
Received: from pctrast.inf.ethz.ch.ethz.ch (129.132.211.48) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sat, 23 Mar
 2013 06:58:50 +0100
In-Reply-To: <CAPig+cSG1gYohpZQZxnCpKgkUPs=Dwfokx+3OhiqdGKX8fajBw@mail.gmail.com>
	(Eric Sunshine's message of "Thu, 21 Mar 2013 17:11:28 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.211.48]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218887>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Thu, Mar 21, 2013 at 8:52 AM, Thomas Rast <trast@student.ethz.ch> wrote:
>> This is a bit hacky and should really be replaced by equivalent
>> support in --follow, and just using that.  However, in the meantime it
>
> s/using/use/

I'm not a native speaker, but I really think 'using' is more correct
here.  But feel free to suggest a better wording.  The intention is that
we should proceed in two steps: 'git log --follow' first needs to learn
to adjust its pathspec filter as it walks revisions, much like I did
here.  Then this patch should be reverted in favor of just enabling
--follow.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
