From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v4 0/6] submodule: drop the top-level requirement
Date: Mon, 17 Jun 2013 22:41:51 +0200
Message-ID: <51BF748F.7070708@web.de>
References: <cover.1371391740.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon Jun 17 22:42:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UogFT-0003q2-RI
	for gcvg-git-2@plane.gmane.org; Mon, 17 Jun 2013 22:42:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753404Ab3FQUl4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Jun 2013 16:41:56 -0400
Received: from mout.web.de ([212.227.17.11]:62570 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753244Ab3FQUlz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 16:41:55 -0400
Received: from [192.168.178.41] ([79.193.82.17]) by smtp.web.de (mrweb003)
 with ESMTPA (Nemesis) id 0LsyOA-1ULZr013KE-012ZmL; Mon, 17 Jun 2013 22:41:52
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
In-Reply-To: <cover.1371391740.git.john@keeping.me.uk>
X-Enigmail-Version: 1.5.1
X-Provags-ID: V03:K0:4fZMBn+Fimm+Ac6+4NzMQyAuhEqOenrweUhrAI1ujwIrnCkwdwT
 BnvbJ4dlQME7kGg5zOZTctDgKN0DtEGRLCdXoDGr32mkrr7J8PmZJYxTBYQJQstRVfVOSE4
 LxrzjrJ902gcXUtfUuGW2ESyzvSt076zc+/zAnmdyYmIUEVDMsVSyqjwvwEUKqTirn16mxw
 9KiNRvhka/LhkZKQmzCOg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228113>

Am 16.06.2013 16:18, schrieb John Keeping:
> Changes since v3:
> 
> * There are four new patches, three of which are style fixes for
>   existing tests and one fixes an existing error message to return a
>   more accurate path when recursing.
> 
> * You now cannot run "git submodule add <relative URL>" from a
>   subdirectory.  Because the interpretation of the URL changes depending
>   on whether or not remote.origin.url is configured, I have decided to
>   just ban this for now.  If someone comes up with a sensible way to
>   handle this then we can lift this restriction later.
> 
> * The "path" variable exported in "submodule foreach" now uses the
>   relative path and matches the "sm_path" variable.
> 
> * I audited the code again and fixed a few more cases that weren't
>   printing relative paths (notably "submodule init" and "submodule
>   foreach").
> 
> * More tests.

Thanks for working on this! This series is looking good to me.

> John Keeping (6):
>   t7401: make indentation consistent
>   t7403: modernize style
>   t7403: add missing && chaining
>   submodule: show full path in error message
>   rev-parse: add --prefix option
>   submodule: drop the top-level requirement
> 
>  Documentation/git-rev-parse.txt |  16 ++
>  builtin/rev-parse.c             |  24 ++-
>  git-submodule.sh                | 135 ++++++++++----
>  t/t1513-rev-parse-prefix.sh     |  96 ++++++++++
>  t/t7400-submodule-basic.sh      |  80 +++++++++
>  t/t7401-submodule-summary.sh    | 116 +++++++-----
>  t/t7403-submodule-sync.sh       | 388 ++++++++++++++++++++++++++--------------
>  t/t7406-submodule-update.sh     |  15 ++
>  t/t7407-submodule-foreach.sh    |  16 ++
>  9 files changed, 673 insertions(+), 213 deletions(-)
>  create mode 100755 t/t1513-rev-parse-prefix.sh
> 
