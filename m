From: Richard Weinberger <richard@nod.at>
Subject: Re: git ate my home directory :-(
Date: Mon, 25 Mar 2013 23:27:10 +0100
Message-ID: <5150CF3E.9020808@nod.at>
References: <5150C3EC.6010608@nod.at> <20130325214343.GF1414@google.com> <7vboa7w2vm.fsf@alter.siamese.dyndns.org> <5150CB34.1030008@nod.at> <7v38vjw28v.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 25 23:27:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKFrj-0000xm-Ec
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 23:27:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933496Ab3CYW1O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 18:27:14 -0400
Received: from a.ns.miles-group.at ([95.130.255.143]:47834 "EHLO radon.swed.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933461Ab3CYW1N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 18:27:13 -0400
Received: (qmail 25248 invoked by uid 89); 25 Mar 2013 22:27:13 -0000
Received: by simscan 1.3.1 ppid: 25240, pid: 25244, t: 0.0601s
         scanners: attach: 1.3.1 clamav: 0.96.5/m:
Received: from unknown (HELO ?192.168.0.18?) (richard@nod.at@212.186.22.124)
  by radon.swed.at with ESMTPA; 25 Mar 2013 22:27:12 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
In-Reply-To: <7v38vjw28v.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219113>

Am 25.03.2013 23:20, schrieb Junio C Hamano:
> Richard Weinberger <richard@nod.at> writes:
>
>> Okay, I have to set GIT_DIR _and_ GIT_WORK_TREE to make my scripts safe again?
>> I've always set only GIT_DIR because it just worked (till today...).
>
> That means you never run your script inside a subdirectory ;-)
>
> If your $GIT_DIR is tied to a single working tree, a simpler way
> would be to add
>
> 	[core]
> 		worktree = /path/to/the/work/tree/

I've used GIT_DIR in my scripts because changing the current working directory
within bash scripts often causes problem with other commands.
That's why I've used patters like:
export GIT_DIR=/path/to/repo/.git
git fetch ...
do_this
do_that
git reset --hard FETCH_HEAD
do_foo
git whatever

export GIT_DIR=/path/to/another/repo/.git
git fetch ...
...

But from now on I'll simply cd into the git repo...

Thanks,
//richard
