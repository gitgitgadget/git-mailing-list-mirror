From: Jeff Epler <jepler@unpythonic.net>
Subject: Re: How can I get full =?utf-8?Q?filenames?=
	=?utf-8?Q?_from_Git_difftool_=28for_Microsoft_Word_=E2=80=9CCompare_Docum?=
	=?utf-8?B?ZW50c+KAnQ==?= feature)?
Date: Mon, 14 Dec 2009 07:11:12 -0600
Message-ID: <20091214131112.GC22735@unpythonic.net>
References: <b507cb050912132222x7e1daa9cw73b13f3db0ee22c6@mail.gmail.com> <b507cb050912132225j1bdc39c2v42a3bf6bddf1cb1a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Doug Ireton <dougireton@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 14 14:11:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKAhr-0004kr-GQ
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 14:11:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbZLNNLP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2009 08:11:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750960AbZLNNLP
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 08:11:15 -0500
Received: from dsl.unpythonic.net ([206.222.212.217]:42710 "EHLO
	unpythonic.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750850AbZLNNLO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2009 08:11:14 -0500
Received: by unpythonic.net (Postfix, from userid 1000)
	id 062281148EA; Mon, 14 Dec 2009 07:11:13 -0600 (CST)
Content-Disposition: inline
In-Reply-To: <b507cb050912132225j1bdc39c2v42a3bf6bddf1cb1a@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135207>

In the bash shell, you can convert a relative path to absolute by prepending
the directory name:
    mkabs () {
        case "$1" in
        /*) echo "$1" ;;
        *)  echo "$(pwd)/$1" ;;
        esac
    }

Using it at the shell prompt:
    $ mkabs example
    /home/jepler/example
    $ ls -l $(mkabs example)
    -rw-r--r-- 1 jepler jepler 0 2009-12-14 07:08 /home/jepler/example

If mac has a gnu-like readlink(1), then use 'readlink -f' instead of the
mkabs shell function:
    $ readlink -f example
    /home/jepler/example

You should be able to write a shell script which does the conversion
from relative to absolute using one of these patterns, and then invokes
the applescript.

It may turn out that there's a way to convert a path from relative to
absolute in applescript as well, but I wouldn't know it.

Jeff
