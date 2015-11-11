From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: git submodule sync / git submodule rm
Date: Wed, 11 Nov 2015 21:02:32 +0100
Message-ID: <56439ED8.2030705@web.de>
References: <8C0042D8869AEA4AA334B49AFBBCEF8294713B41@TUT-EX02-PV.KSTG.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: "Boettger, Heiko" <Heiko.Boettger@karlstorz.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 11 21:02:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZwbbN-00084v-Fi
	for gcvg-git-2@plane.gmane.org; Wed, 11 Nov 2015 21:02:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752640AbbKKUCh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2015 15:02:37 -0500
Received: from mout.web.de ([212.227.17.11]:64730 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752597AbbKKUCg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2015 15:02:36 -0500
Received: from [192.168.178.41] ([79.211.127.69]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0MVchv-1Zukhq2Hol-00Z09i; Wed, 11 Nov 2015 21:02:33
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <8C0042D8869AEA4AA334B49AFBBCEF8294713B41@TUT-EX02-PV.KSTG.corp>
X-Provags-ID: V03:K0:bW/53QqwU9m5OWiabgq7bYQ+TPYWkNQfN0G0+12bAIjvBUePPGE
 xPPdATZROksj+jtwhC2ZeBuevsJyUi5hZo+Zm8jg6N9FFb0g+NO52IXwxRr9hXqdYPvjZas
 PxlHubIcaVd3dLonGB0VhZYXkazybvWXX71ywSyGrf3tEPPLkMNBfF8wvJkmS1c0yu3Q8UC
 Dpzd5p70JI9t7uZ/mb6Kw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RxDY5GUz1aM=:4cj9gfI7KJV66yDaZq6VQq
 Nxbd5IW9DTjTsZwQHYyDJ+Frh2DyCacWrb7tNHmb5bAzz/FKYOXCbqc9WKLdO++GC1jP4Q9y4
 gfLcAAByD1tuclSsxZ5YfM/e50Zejyu0A+mR3mc99QzeE8VYe18Dou0zmMz0HpicZsTxRsZ7y
 xnDHyHdlfrwky26VaxQ3nNIlKBIqonzrGrpvA9m9xmct1d2hVkvBfJ9BnalgOHEmRG+hSzovn
 M8Oj+4bfAh69wIzJY2oeJzHQ2beCyneSUxtDvYEsiOwiTkTv+GZzOdNcC+b9QWmJ7zE9fdviV
 YloAxUG+WStynyXPU3DT7gpt8KD0amwaGZUhajl8NZ4AOOmIHrevy+lgxtSrH3jiEyc4ZfCM/
 LJYL9VZPRw7H8XN36GjoWvISaddCdqFJ6V1nqo/p4S/CSF+aGlyLPqrhUfaZTkgRnb+gisVqN
 ntYvh2EtkyMzCBtny4E5Wc0qv7WtVxa3QgT2U5ElrkYq17QPAMKY1RerowJYpq3fYBeysWZag
 /K205UAhRvOcI/VYJKpjZkVsHBAOEKxKXb6Bt5X+GQNV89SmN26Rs7jdMgEL3NOv7ETUOKQZ8
 ZzV9rRjXlUmBwE0ipaXznD4tvzX3IyzeCQd3kUW3eJFbqSfAjPcJFWrFUbMkAp0HZV915Tvo3
 vuDNYX//2ShNvPDoRppIYGBjFcUSV3t5U+AKZMZX867HMPm5AIzdulDzEm+cj37GVnHNlP3mx
 nG86/bSr9x+W3TJRUohlzHW670AuBSOWdK5Y1m+1RklaBUPrQxiy1xgmxmJwV4HR1+XD3UAW 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281193>

Am 11.11.2015 um 11:18 schrieb Boettger, Heiko:
> i'm currently on a migration from svn to git and also have the task to convert the svnexternal to git submodules. During the migration step I am doing an automatic verification which needs a reliable way to switch the working tree to another branch include the submodules.
> When the submodule definition changes I miss a reliable command to update the .git/config:
>
> 1. the git submodule sync seems to do nothing if a module was removed

That's on purpose. In case you check out an older commit which still
contains the submodule in the superproject later the old config is
active again.

> 2. git submodule update complains about the missing entry in .gitmodules
> 3. git submodule deinit doesn't work either and complains about missing path in .gitmodules as well

Not sure what you are talking about here, what exactly did you do to
get into this situation? I assume you just removed the submodule entry
from .gitmodules but did not remove it from the index?

> These issues are partially described in the git book under https://git-scm.com/book/en/v2/Git-Tools-Submodules in section "Issues with Submodules". Now what I am really missing is a way to keep the .git/config and references in sync with the .gitmodules file which at best is integrated into git checkout. It is clear that I could write a script for that by myself, but it would be much better to have an integrated command for that which I though is git submodule sync, but unfortunately it doesn't do a complete sync of all settings.
>
> In the google forum there was someone asking for a git submodule remove command:
>
> https://groups.google.com/forum/#!searchin/git-users/submodule/git-users/Md72iVvPHqw/H_j3mT7bRq4J
>
> I don't think that it is strictly required to remove the untracked file, this can be archived by a git clean as well, but is there any progress on this.

Did you check "git rm <submodule>"? ;-)
