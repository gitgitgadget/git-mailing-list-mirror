From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 0/17] removing questionable uses of git_path
Date: Mon, 10 Aug 2015 14:06:39 +0200
Message-ID: <55C893CF.4060103@alum.mit.edu>
References: <20150810092731.GA9027@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: Jeff King <peff@peff.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 10 14:06:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOlqo-0001UY-HR
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 14:06:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751772AbbHJMGm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 08:06:42 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:45845 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750958AbbHJMGm (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Aug 2015 08:06:42 -0400
X-AuditID: 1207440c-f79e16d000002a6e-8a-55c893d1a3c0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 7C.67.10862.1D398C55; Mon, 10 Aug 2015 08:06:41 -0400 (EDT)
Received: from [192.168.69.130] (p4FC97D4D.dip0.t-ipconnect.de [79.201.125.77])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t7AC6dBW026527
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 10 Aug 2015 08:06:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
In-Reply-To: <20150810092731.GA9027@sigill.intra.peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFIsWRmVeSWpSXmKPExsUixO6iqHtx8olQg73XpC26rnQzWfxo6WF2
	YPJ41ruH0ePzJrkApihum6TEkrLgzPQ8fbsE7ozWgz9ZCl5wVfy98oypgfElRxcjJ4eEgInE
	n+uTmSFsMYkL99azgdhCApcZJfYtz+hi5AKyzzNJXJ3/lhUkwSugLfFl6juwBhYBVYmbm+cw
	gdhsAroSi3qagWwODlGBIInXL3MhygUlTs58wgJiiwgYSdz48A1svrCAg8SuP0uZIHZZSsx/
	s58RxOYUsJK4/HArWD2zgLrEn3mXmCFseYnmrbOZJzDyz0IydhaSsllIyhYwMq9ilEvMKc3V
	zU3MzClOTdYtTk7My0st0jXUy80s0UtNKd3ECAlHnh2M39bJHGIU4GBU4uGdsfl4qBBrYllx
	Ze4hRkkOJiVR3hkdJ0KF+JLyUyozEosz4otKc1KLDzFKcDArifBGVgPleFMSK6tSi/JhUtIc
	LErivKpL1P2EBNITS1KzU1MLUotgsjIcHEoSvGGTgBoFi1LTUyvSMnNKENJMHJwgw7mkRIpT
	81JSixJLSzLiQfEYXwyMSJAUD9BeU5B23uKCxFygKETrKUZFKXHeuyAJAZBERmke3FhYknnF
	KA70pTBvOUgVDzBBwXW/AhrMBDTYLhBscEkiQkqqgbHs6VHpmWsk3LedTpKf3mnd+myPsPh2
	jddvDDn2Hl7Q+vL9pnkxV9oqz0abMny/0P/lbF/7hyu8C/zCV0QdXbK6Iqd2f1J3WvVnpasb
	HJ2bT19sfdTL/XlV4f1HK1kXXf4XMdP+4Kfbkltv9JxyWrvNVEv62Q6RqE5/xoJF 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275609>

On 08/10/2015 11:27 AM, Jeff King wrote:
> [...] The problem is that git_path uses a static buffer that gets overwritten
> by subsequent calls. [...]
> 
>   [01/17]: cache.h: clarify documentation for git_path, et al
>   [02/17]: cache.h: complete set of git_path_submodule helpers
>   [03/17]: t5700: modernize style
>   [04/17]: add_to_alternates_file: don't add duplicate entries
>   [05/17]: remove hold_lock_file_for_append
>   [06/17]: prefer git_pathdup to git_path in some possibly-dangerous cases
>   [07/17]: prefer mkpathdup to mkpath in assignments
>   [08/17]: remote.c: drop extraneous local variable from migrate_file
>   [09/17]: refs.c: remove extra git_path calls from read_loose refs
>   [10/17]: path.c: drop git_path_submodule
>   [11/17]: refs.c: simplify strbufs in reflog setup and writing
>   [12/17]: refs.c: avoid repeated git_path calls in rename_tmp_log
>   [13/17]: refs.c: avoid git_path assignment in lock_ref_sha1_basic
>   [14/17]: refs.c: remove_empty_directories can take a strbuf
>   [15/17]: find_hook: keep our own static buffer
>   [16/17]: get_repo_path: refactor path-allocation
>   [17/17]: memoize common git-path "constant" files

I read through all of the patches (except for 03) and didn't see any
problems. Thanks, Peff, for defusing some grenades :-)

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
