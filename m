From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: A design for subrepositories
Date: Sun, 14 Oct 2012 18:15:38 +0200
Message-ID: <507AE52A.3080807@web.de>
References: <20121013163322.685276teuhqhjc82.lealanko@webmail.helsinki.fi> <7vd30m2sbr.fsf@alter.siamese.dyndns.org> <20121014002304.14167k2j2ctspiuw.lealanko@webmail.helsinki.fi> <7vzk3p1xh3.fsf@alter.siamese.dyndns.org> <20121014131928.25943ezwa6fveyls.lealanko@webmail.helsinki.fi> <507ABDF3.4040106@web.de> <20121014182746.42895rwvalv4uoz6.lealanko@webmail.helsinki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Lauri Alanko <la@iki.fi>
X-From: git-owner@vger.kernel.org Sun Oct 14 18:15:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNQr0-00074X-Vm
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 18:15:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752121Ab2JNQPk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2012 12:15:40 -0400
Received: from mout.web.de ([212.227.17.12]:51877 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751603Ab2JNQPk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2012 12:15:40 -0400
Received: from [192.168.178.41] ([79.193.81.106]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0MYNof-1Ssp2Z2qFF-00VHrx; Sun, 14 Oct 2012 18:15:38
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
In-Reply-To: <20121014182746.42895rwvalv4uoz6.lealanko@webmail.helsinki.fi>
X-Provags-ID: V02:K0:81+0DYjx8OcHQKW/Y3IzAoSGVzlgWMJzwY1e4BHWmJh
 WLcJYjlUUcJ15NTN3PJizuDsYqdKFzpzgOmuqKD9tKpWkL3+R/
 7z0Aix6o0sUa3qxIeABADk2p/5q71QFdQxH81n92Jddn5ir3xF
 Jfmv2/oeDWbyhNu7cxqrZrlgOEK7HrZCp6eDJ7ARde69/0wjbo
 SDijwmGH6/+0+xorGcSgQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207674>

Am 14.10.2012 17:27, schrieb Lauri Alanko:
> Quoting "Jens Lehmann" <Jens.Lehmann@web.de>:
>> What's wrong with making git clone all submodules together with the
>> superproject (when the user said he wants to update all submodules on
>> clone too by setting a - still to be added - config option)?
> 
> Depends on how it's done. In a previous mail I just considered various ways to do it. If I see correctly, your choice is to read .gitmodules from every branch and every tag to find the total set of submodules used by the repository. As I said already, that is certainly possible, but it's just not very scalable, if fetch operations slow down linearly in the number of tags.

Currently "git fetch" checks all newly fetched commits for changes in
gitlinks too, so that would just add another file to that. And as a
fetch is pretty much linear in the number of newly fetched commits
anyway, its performance impact should be minimal.
