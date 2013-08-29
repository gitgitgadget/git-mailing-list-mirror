From: worley@alum.mit.edu (Dale R. Worley)
Subject: Re: [PATCHv2] git-diff: Clarify operation when not inside a repository.
Date: Thu, 29 Aug 2013 11:44:16 -0400
Message-ID: <201308291544.r7TFiGjm023154@freeze.ariadne.com>
References: <201308211734.r7LHYwNh008859@hobgoblin.ariadne.com>
	<xmqqwqneuc69.fsf@gitster.dls.corp.google.com>
	<201308222031.r7MKVL6O028293@freeze.ariadne.com>
	<xmqqioyxqwdr.fsf@gitster.dls.corp.google.com>
	<201308231811.r7NIBeH9027848@freeze.ariadne.com> <xmqq38pt8nqm.fsf@gitster.dls.corp.google.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 29 17:44:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF4OV-0003Jw-Jf
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 17:44:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753389Ab3H2PoT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 11:44:19 -0400
Received: from qmta08.westchester.pa.mail.comcast.net ([76.96.62.80]:54504
	"EHLO qmta08.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753240Ab3H2PoT (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Aug 2013 11:44:19 -0400
Received: from omta16.westchester.pa.mail.comcast.net ([76.96.62.88])
	by qmta08.westchester.pa.mail.comcast.net with comcast
	id Jf5W1m00A1uE5Es58fkJTJ; Thu, 29 Aug 2013 15:44:18 +0000
Received: from freeze.ariadne.com ([24.34.72.61])
	by omta16.westchester.pa.mail.comcast.net with comcast
	id JfkH1m01J1KKtkw3cfkJ98; Thu, 29 Aug 2013 15:44:18 +0000
Received: from freeze.ariadne.com (freeze.ariadne.com [127.0.0.1])
	by freeze.ariadne.com (8.14.5/8.14.5) with ESMTP id r7TFiHmV023155;
	Thu, 29 Aug 2013 11:44:17 -0400
Received: (from worley@localhost)
	by freeze.ariadne.com (8.14.5/8.14.5/Submit) id r7TFiGjm023154;
	Thu, 29 Aug 2013 11:44:16 -0400
In-reply-to: <xmqq38pt8nqm.fsf@gitster.dls.corp.google.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1377791058;
	bh=RJ/9smXOTHhkp7/U9VpGK5u7hNJD6hwmcc4QfRaOcMs=;
	h=Received:Received:Received:Received:Date:Message-Id:From:To:
	 Subject;
	b=YEpbwH7I7+oHauu3C0K3E0DkGMRrukAZeGcxGScosNMwDituANhpHViI9zYeGRdYQ
	 x8W5HjTBXu5NzJPvijUJLwoSgHfQo9Cp5q1F3tw3ulSjcXBrx66iwzPphZuewJQJxH
	 /kWzBICNX4sSFoziqkE08FAFljsTnOjxaI/9J/BetBHONn9YwzpHB3moSCrjwDVnb0
	 T9JoLFjQGqlretZ/DYum+pXGVX5ppIT5GLjMxWz8ZywxnjB0VVTOYE0ILr4JfGL+cT
	 rVz56RvAElu+kl5wvTh+QI1yqfYXutcgEWoLP4XteEOS7/AvD9tI6VJh3FNFpC/C9P
	 ubCUOpK+tnBug==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233279>

> From: Junio C Hamano <gitster@pobox.com>

> diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
> index b1630ba..33fbd8c 100644
> --- a/Documentation/git-diff.txt
> +++ b/Documentation/git-diff.txt
> @@ -28,11 +28,15 @@ two blob objects, or changes between two files on disk.
>  	words, the differences are what you _could_ tell Git to
>  	further add to the index but you still haven't.  You can
>  	stage these changes by using linkgit:git-add[1].
> -+
> -If exactly two paths are given and at least one points outside
> -the current repository, 'git diff' will compare the two files /
> -directories. This behavior can be forced by --no-index or by
> -executing 'git diff' outside of a working tree.
> +
> +'git diff' --no-index [--options] [--] [<path>...]::
> +
> +	This form is to compare the given two paths on the
> +	filesystem.  You can omit the `--no-index` option when
> +	running the command in a working tree controlled by Git and
> +	at least one of the paths points outside the working tree,
> +	or when running the command outside a working tree
> +	controlled by Git.

That does break out the --no-index case in a clearer way.

Dale
