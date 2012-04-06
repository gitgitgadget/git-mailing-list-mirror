From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: Status shows untracked directory without any untracked file in
 it
Date: Fri, 06 Apr 2012 20:58:03 +0200
Message-ID: <4F7F3CBB.8030805@kdbg.org>
References: <CAGAhT3n3hHV+UhT+D1o60OAS23WFmx+Lxg=aqYMGC=U-LR1QUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Alexander Kostikov <alex.kostikov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 06 20:58:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGEMS-0001YD-GI
	for gcvg-git-2@plane.gmane.org; Fri, 06 Apr 2012 20:58:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757609Ab2DFS6L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Apr 2012 14:58:11 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:11605 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757471Ab2DFS6K (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2012 14:58:10 -0400
Received: from [10.35.35.108] (77.118.253.84.wireless.dyn.drei.com [77.118.253.84])
	by bsmtp.bon.at (Postfix) with ESMTP id 31A82A7EB0;
	Fri,  6 Apr 2012 20:59:17 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
In-Reply-To: <CAGAhT3n3hHV+UhT+D1o60OAS23WFmx+Lxg=aqYMGC=U-LR1QUA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194894>

Am 06.04.2012 07:19, schrieb Alexander Kostikov:
> How that is possible? Is it a bug?

I don't think so. git status normally does not look inside directories=20
that do not contain any tracked files.

> alexko@ALEXKO-LAB b:\
> =C2=BB git status --untracked-files=3Dnormal
> # On branch master
> # Untracked files:
> #   (use "git add<file>..." to include in what will be committed)
> #
> #       data/fex/lba/hi/qna/
> nothing added to commit but untracked files present (use "git add" to=
 track)

Here, git status only knows that it does not track anything inside=20
=2E../qna/, and it tells you that it found this directory.

> alexko@ALEXKO-LAB b:\
> =C2=BB git status --untracked-files=3Dall
> # On branch master
> nothing to commit (working directory clean)

Here, you ask to list files in all directories, but, alas, the director=
y=20
does not contain anything untracked. The directory itself is not listed=
,=20
because git would be unable to track an empty directory.

-- Hannes
