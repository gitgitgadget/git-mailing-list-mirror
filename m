From: "Octavio Alvarez" <alvarezp@alvarezp.ods.org>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Fri, 29 Jan 2010 15:05:39 -0800
Message-ID: <op.u7bg3pby4oyyg1@alvarezp-ws>
References: <ron1-2E17EF.12204629012010@news.gmane.org>
 <op.u7a909hf4oyyg1@alvarezp-ws> <ron1-1F1799.13340029012010@news.gmane.org>
 <op.u7bfjni44oyyg1@alvarezp-ws> <ron1-0EE62E.14474929012010@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
Content-Transfer-Encoding: 8bit
To: "Ron Garret" <ron1@flownet.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 30 00:05:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NazuW-00020l-OF
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 00:05:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755943Ab0A2XFu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 18:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755647Ab0A2XFt
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 18:05:49 -0500
Received: from spider.alvarezp.com ([66.150.225.106]:42255 "EHLO
	spider.alvarezp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755062Ab0A2XFt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 18:05:49 -0500
Received: from alvarezp-ws (host-193-99-in-prt.caliente.com.mx [201.139.193.99] (may be forged))
	(authenticated bits=0)
	by spider.alvarezp.com (8.13.8/8.13.8/Debian-3) with ESMTP id o0TN5f2i023710
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 29 Jan 2010 15:05:45 -0800
In-Reply-To: <ron1-0EE62E.14474929012010@news.gmane.org>
User-Agent: Opera Mail/10.20 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138397>

On Fri, 29 Jan 2010 14:47:49 -0800, Ron Garret <ron1@flownet.com> wrote:
>
> My actual use case is very complicated, but here's a simplified version:
>
> Suppose I'm using git as a back-end for a wiki.  I want to look at the
> state of the entire wiki as it was in some point in the past,

mkdir new_dir; git archive --format=tar tree-ish | tar -C new_dir -x

Of course, this is slower than just checking out the files that differ,
I agree.

> and I also
> want to be able to look at the diffs between individual pages as they
> were then and as they are now.

git diff commit-ish1 commit-ish2 file1 file2 ...

Or you could just clone it and compare whatever you want there and just
erase when done. This would allow you to do "git pull" from the origin.

> If I do a git reset --hard then I get the old version, but I lose my
> HEAD pointer so that git diff doesn't give me what I want any more.

You could tag the current version before resetting and then issue
git reset --hard the_tag, but I guess you would run into race conditions:
someone updates the wiki while the HEAD is in another commit.

Hope it helps. :-)
