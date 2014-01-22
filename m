From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: problematic git log submodule-dir/
Date: Wed, 22 Jan 2014 21:35:24 +0100
Message-ID: <52E02B8C.6040309@web.de>
References: <2550653.GHkhBQDSTk@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: pawel.sikora@agmk.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 22 21:35:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W64WI-00054J-J8
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jan 2014 21:35:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753046AbaAVUf1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Jan 2014 15:35:27 -0500
Received: from mout.web.de ([212.227.17.11]:52045 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751379AbaAVUf0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jan 2014 15:35:26 -0500
Received: from [192.168.178.41] ([84.132.152.156]) by smtp.web.de (mrweb001)
 with ESMTPA (Nemesis) id 0ML8F7-1W6LV747bF-000J7i for <git@vger.kernel.org>;
 Wed, 22 Jan 2014 21:35:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <2550653.GHkhBQDSTk@localhost.localdomain>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:S1YruFtE/Vv+UYmDmGO0rdcwtWQMMYDfnv/P+uU98XRvxyHY7Dq
 nolis0J4lmxJJY0lcFkiHig+HuUwB2LvJa0GCGuhYe+idiENlg3FHhUCp48WSW3EaBxy69J
 kLctYZK2gdvoFCW0vnZPDawWQ46fwHid4maggROFOFafSOGjF5qXuh0Q+0Er+NLCzXyAqmY
 kwvYBtlh1vw10n+2Wo/XA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240856>

Am 20.01.2014 19:25, schrieb Pawe=C5=82 Sikora:
> i've noticed that 'git log submodule-dir' and 'git log submodule-dir/=
'
> return different results (module's head changes vs. nothing). is it a=
 bug?
> looks like a trailing slash is a problem for git-log.

I think this is a bug, and for example "git diff" has similar problems.
This is especially nasty as shell auto-completion adds the '/' at the
end.

Duy, without having looked into the code myself yet: is this something
that might be easily fixed by using PATHSPEC_STRIP_SUBMODULE_SLASH*?
