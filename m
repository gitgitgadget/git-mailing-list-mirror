From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [msysGit] [PATCH 07/14] Fix __stdcall/WINAPI placement and function prototype
Date: Fri, 21 Aug 2009 19:37:18 +0200
Message-ID: <200908211937.18296.j6t@kdbg.org>
References: <cover.1250860247.git.mstormo@gmail.com> <1c403f4a41f4a210ff15933814bba56495d812d3.1250860247.git.mstormo@gmail.com> <9e8fc158b4d4331d698d1fe4ed33a61fbb011412.1250860247.git.mstormo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: msysgit@googlegroups.com, Johannes.Schindelin@gmx.de,
	git@vger.kernel.org, lznuaa@gmail.com
To: "Marius Storm-Olsen" <mstormo@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 21 19:38:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeY4B-0006aw-4P
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 19:38:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755029AbZHURhW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 13:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752455AbZHURhW
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 13:37:22 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:61419 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932663AbZHURhV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2009 13:37:21 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id A11A810002;
	Fri, 21 Aug 2009 19:37:18 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 66D9F43611;
	Fri, 21 Aug 2009 19:37:18 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <9e8fc158b4d4331d698d1fe4ed33a61fbb011412.1250860247.git.mstormo@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126737>

On Freitag, 21. August 2009, Marius Storm-Olsen wrote:
> -static __stdcall unsigned ticktack(void *dummy)
> +static unsigned WINAPI ticktack(void *dummy)

> -static __stdcall unsigned run_thread(void *data)
> +static unsigned WINAPI run_thread(void *data)

These two are not nice. As I said in an earlier mail: The documentation says 
that the thread function pointer that is passed to _beginthreadex must have 
__stdcall calling convention. Therefore, you should not change these to 
WINAPI.

-- Hannes
