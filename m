From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Bug: file named - on git commit
Date: Mon, 28 Jan 2013 12:05:03 +0100
Message-ID: <87txq11sbk.fsf@pctrast.inf.ethz.ch>
References: <51065540.1090007@renemoser.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: Rene Moser <mail@renemoser.net>
X-From: git-owner@vger.kernel.org Mon Jan 28 12:05:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzmWp-0002OX-Ao
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 12:05:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754748Ab3A1LFJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2013 06:05:09 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:40894 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751800Ab3A1LFI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2013 06:05:08 -0500
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 28 Jan
 2013 12:05:01 +0100
Received: from pctrast.inf.ethz.ch.ethz.ch (129.132.153.233) by
 CAS11.d.ethz.ch (172.31.38.211) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Mon, 28 Jan 2013 12:05:03 +0100
In-Reply-To: <51065540.1090007@renemoser.net> (Rene Moser's message of "Mon,
	28 Jan 2013 11:38:56 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214831>

Rene Moser <mail@renemoser.net> writes:

>
> Found a little issue in git version 1.7.9.5 if a file named "-", causing
> "git commit" to read from stdin.
>
> (So you must hit ctrl-d or ctrl-c to finish the commit.)
>
> Everything looks ok to me after the commit. Other users reported to be
> fixed in 1.8.1.1 but haven't it tested myself.
>
> This does not work:
>
> mkdir tmp && cd tmp;
> echo foo >./-;
> git init; git add .;
> git commit -m "is this a bug?"

This was fixed by Junio around 4682d85 (diff-index.c: "git diff" has no
need to read blob from the standard input, 2012-06-27), which is
included starting with v1.7.12 and the v1.7.11.3 maint release.  Please
upgrade.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
