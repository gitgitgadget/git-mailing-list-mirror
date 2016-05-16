From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v6 3/3] bisect--helper: `write_terms` shell function in
 C
Date: Mon, 16 May 2016 15:16:49 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605161508230.3303@virtualbox>
References: <1462546167-1125-1-git-send-email-pranit.bauva@gmail.com> <1463031127-17718-1-git-send-email-pranit.bauva@gmail.com> <1463031127-17718-4-git-send-email-pranit.bauva@gmail.com> <CAPig+cS=zcSVLwARZ5A8hdiE0wqgYPU2Jwnr0OcjDXZFO--cZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Pranit Bauva <pranit.bauva@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon May 16 15:17:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2IOR-0004zE-Hm
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 15:17:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752875AbcEPNRC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 09:17:02 -0400
Received: from mout.gmx.net ([212.227.15.15]:50416 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750785AbcEPNRA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 09:17:00 -0400
Received: from virtualbox ([88.128.80.193]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MPDaC-1axufP0EzI-004SLQ; Mon, 16 May 2016 15:16:47
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <CAPig+cS=zcSVLwARZ5A8hdiE0wqgYPU2Jwnr0OcjDXZFO--cZw@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:IxBeVR2/+2uCs+F+2IbU3cAIUnzl9Viyz7hdn1Rr6hpEz9k99cU
 GmgA4AtZTQic5xBmU+l2jRE29y5519OGvA3VKOeEzFR9gcvB1lBy8ofYSSVz4gK0tS5+7hv
 CIqZk8nSrEoE09p9N6llgMaur2qlUeH2CXtWsocHCt/mSOm/JZEN2CJDhe5ASDFzmpEbbVT
 itr/bkJcXszzvra/pBnCw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:B9TThgzD010=:oktNPodml01BjskdA9BIVk
 vX0fAq+jQuuAXAfrhHnbDg0JrwMMdaLEk8DJG5dlTf8eWF74zXPertVQ9F0QY/YRulkDAmXUz
 gDTWa9NL5PYrluJ/dcQE1aeVMSxWXq6I2NPGuCca2r43LAyrscv25V7RB2gAJhXmQjrNdqqdQ
 tj+Fd84Pa8U1ZYvxxKRzoeUMZIFCtMl9sNvGWwVUMo2UZLd9E13f5xLo7qRSD4cHuTnscZlZx
 rdGhJQ4jNfquy8oO4iCbgFubGqFNPJnzP+GkkDkFW/pLartW+BJF6+9T+bG9WjeCwCccu6lab
 hNRKj/+AZA4l1eaIVoLJCNElnBeRO/AvLbBhDqo3TVxUDiY9ykAQ3K9knqmqPCGZUYNFYjwIl
 k78D+In4jzG9GLd+vZtBGI1zKqC8F4vSEKYAAy/ompX6gXwjfRiulDlXR/iKkwaEEoT+RWKIE
 7hRruJmdy5AfLXAROtcD1s6p3IzfiQCADx+kyU4AF+VK+8j8PfTrkQaT7E83wNagxo/sfDxnw
 RRxkATFV30uKUPCj8o4lVHURpl4NF+jLCmxNqwxnBQ3RAG+7L0YwMIh61GsBeXl3P/+KyV9Yi
 s5eoKDKvWJbcDqFMUdmiL3xutDNEWguDb9a9NwPtxGzNWAwr7nyk36lpNrQbnXVTsaaj3+b77
 E/TdxOQ2Ftsev/paUDYLp1fppSpQ0c8zYw8+5RrhYbl4o0R1Sf8MaLRNvta+OCyve3rBemOW0
 cuQU6IcZcl3Wk76trHduFZg58HtWLZGY0BblSOKspV7mnESnVepFW6WK6sLVjPRobl8gN29K 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294734>

Hi,

On Mon, 16 May 2016, Eric Sunshine wrote:

> On Thu, May 12, 2016 at 1:32 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> 
> > +       fp = fopen(".git/BISECT_TERMS", "w");
> 
> Hardcoding ".git/" is wrong for a variety of reasons: It won't be correct
> with linked worktrees, or when GIT_DIR is pointing elsewhere, or when ".git"
> is a symbolic link, etc. Check out the get_git_dir(), get_git_common_dir(),
> etc. functions in cache.h instead.

Maybe in this case, `git_path("BISECT_TERMS")` would be a good idea. Or even
better: follow the example of bisect.c and use
`GIT_PATH_FUNC(bisect_terms_path, "BISECT_TERMS")`.

> > +               strbuf_release(&content);
> > +               die_errno(_("could not open the file to read terms"));
> 
> "read terms"? I thought this was writing.
> 
> Is dying here correct? I thought we established previously that you
> should be reporting failure via normal -1 return value rather than
> dying. Indeed, you're doing so below when strbuf_write() fails.

The rule of thumb seems to be that die()ing is okay in builtin/*.c, but not
in *.c. So technically, it would be okay here, too. However, I think that
this code should be written with libification in mind, so I would also
prefer it to error() and return, to give the caller a chance to do other
things after an error occurred.

Ciao,
Dscho
