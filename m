From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Code reorgnization
Date: Thu, 17 Mar 2016 14:32:39 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1603171431000.4690@virtualbox>
References: <20160317111136.GA21745@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 14:32:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agY2j-0000zK-I3
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 14:32:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030622AbcCQNcp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2016 09:32:45 -0400
Received: from mout.gmx.net ([212.227.17.21]:51843 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030618AbcCQNco (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2016 09:32:44 -0400
Received: from virtualbox ([37.24.143.87]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MEKZg-1aZuBk2I48-00FSPA; Thu, 17 Mar 2016 14:32:40
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <20160317111136.GA21745@lanh>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:CwJ3Ugledq1y/HHChjASmbJalMHkrSLdySb9rC8MgpdZ7tJphUC
 BovQqkXYUmyAz6elGyez/adpzNFh3PgSf6qsN7N0xDR+cKhz8KoUoTMfOJ7cO9JpqiZcaaM
 slljPvErNF8d0f6NlkcnsmagXIMQQ5X1HsMMmO9wy+cfV2SuGePIUK4zcuOLFZNSZpC1UNP
 4L76sPuR5hcboGt3rXfzQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MnU4Mhi6BLE=:uh/JII35WkWWwxbXkeE4z3
 5cDDYhyZEjeqrSDY/75EgIpCl6/Fe1w+wyjrI2YMf32RfhwwgKTaAIeyaq87xfBKqCQOPbCYj
 wOku3WqCFJm4USXq3Umfod5nru7DsSfAchOH1fxYwS5MSzHhx1vqeLfHMNecRMv+u857Ix7RA
 WnUbyas/fc5DiWJwl9FemfRgzbY8mgN6DA84Qzma1nZsEtAIvtXFcXt9jyZGw6YOAuIeDMOmI
 4jLUKTIJIapSY8VT7Kyx7RtXmccjsQyVf2alGElJHMHbi4FU4LuPSvdR2voTnQZibIYfy7DfI
 8SnIFgSxz+ZK3JUvDOxALFayN/DuqQjkog3kUYVHa2t8JdRDDtk4IQvSIp3TXLoX+UBqeQrDw
 2UyVoRzSFP1PV4JzGfEFqROpypQFThEUuZAsq8lCC+0DwMumrzBCTE/+W+ROL27LkjE0DZIMi
 cRWgGAwVjVwxi6ATDtbcqRr1vGPcQO13IrBeg9E8HPepVgSMN88ejT/STzk22Exapj3BTljgB
 tXobf55AMqzVWqqD6uzQLImuUE9BVdgI0ZhqLR6tbKhWm+QS9pLSLfbhcCRPKH+ink2UBheR+
 prsxNk1cPOEzKWdJS4X0PqIBKxoqNGK+Vq4Jp9cqJjnSd33pAe+I7Kras3D6xUXRBLFnRhIxY
 x2gl3tTiot/TGsrD5/0ZQ3lEOGP1Jddtkq/56YxcfgPvAANZUw2UaS+ec/2PuBZqyNF6Xb3RF
 Q3qX3NskogqLKUS7JW1x4sb+r66dLdHYOYeOWbRSdq2a2UOHGbjF3XpP5JsQXW7u0GNzpJeD 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289113>

Hi Duy,

On Thu, 17 Mar 2016, Duy Nguyen wrote:

> Git's top directory is crowded and I think it's agreed that moving
> test-* to t/helper is a good move. I just wanted to check if we could
> take this opportunity (after v2.8.0) to move some other files too. I
> propose the following new subdirs
> 
> lib
> ---
> This contains files that are about data structures or algorithms. Very
> general purpose. This directory includes
> 
> argv-array.[ch] base85.c column.[ch] delta.h diff-delta.c hashmap.[ch]
> hex.c khash.h kwset.[ch] levenshtein.[ch] mergesort.[ch] patch-delta.c
> prio-queue.[ch] sha1-array.[ch] sha1-lookup.[ch] strbuf.[ch]
> string-list.[ch] url.[ch] urlmatch.[ch] utf8.[ch] varint.[ch]
> versioncmp.c wildmatch.[ch]

The name "lib" makes it sound as if this contains the source code of
libgit.a. Maybe "generic" or "common" or "util" would be better (my
favorite would be "util").

> odb
> ---
> The grouping of object database files is to easily make connections
> between them. Unlike, for example, diff-related files which either
> start with "diff" or has that word in the file name to make
> connections.
> 
> alloc.c blob.[ch] bulk-checkin.[ch] commit-slab.h commit.[ch]
> object.[ch] pack.h pack-revindex.[ch] replace_object.c sha1_file.c
> streaming.[ch] tag.[ch] tree.[ch]
> 
> index
> -----
> For the same reason of odb subdir. This directory contains
> 
> cache-tree.[ch] name-hash.c preload-index.c read-cache.c
> split-index.[ch] unpack-trees.[ch]
> 
> sys (or maybe util or support)
> ------------------------------
> These are still general purpose but is usually system-related. They
> are still far away from git's core logic. I want to separate them to
> make it easier to spot "important" files at top dir.
> 
> abspath.c color.[ch] copy.c csum-file.[ch] ctype.c date.c editor.c
> exec_cmd.[ch] gettext.[ch] gettext.h gpg-interface.[ch] ident.c
> lockfile.[ch] mailinfo.[ch] mailmap.[ch] pager.c parse-options-cb.c
> parse-options.[ch] pathspec.[ch] pkt-line.[ch] progress.[ch]
> prompt.[ch] quote.[ch] run-command.[ch] sideband.[ch] sigchain.[ch]
> symlinks.c tar.h tempfile.[ch] thread-utils.[ch] trace.[ch]
> unix-socket.[ch] usage.c userdiff.[ch] wrapper.c write_or_die.c zlib.c
> 
> Good? Bad? Ugly?

Disruptive. Probably a change for 3.0?

Ciao,
Dscho
