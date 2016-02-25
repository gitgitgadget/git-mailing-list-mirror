From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v6 00/32] refs backend
Date: Thu, 25 Feb 2016 00:08:42 +0000
Message-ID: <56CE460A.4020505@ramsayjones.plus.com>
References: <1456354744-8022-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org,
	mhagger@alum.mit.edu, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Thu Feb 25 01:08:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYjUF-0002Rn-NF
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 01:08:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752208AbcBYAIw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 19:08:52 -0500
Received: from avasout01.plus.net ([84.93.230.227]:38337 "EHLO
	avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751760AbcBYAIv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 19:08:51 -0500
Received: from [10.0.2.15] ([46.208.159.221])
	by avasout01 with smtp
	id NQ8n1s0074mu3xa01Q8orY; Thu, 25 Feb 2016 00:08:49 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=bsGxfxui c=1 sm=1 tr=0
 a=Sp5fw55EgyGSOjouSGNDoQ==:117 a=Sp5fw55EgyGSOjouSGNDoQ==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10
 a=8YuhW5SfyrMn1IYIRJEA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
In-Reply-To: <1456354744-8022-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287289>



On 24/02/16 22:58, David Turner wrote:
> This version incorporates fixes for function scope from Ramsay Jones.
> 
> It breaks patches down a bit more, to make them easier to review and
> understand. Michael Haggerty had some suggestions here.
> 
> As suggested by Duy Nguyen, it replaces the resolve_ref_unsafe backend
> method with read_raw_ref, moving resolve_ref_unsafe to the common
> code.
> 
> It adds support for running tests under alternate ref backends.
> 
> It fixes two indentation errors, one reported by Eric Wong.
> 
> It updates the documentation to include info about a few more
> limitations on the LMDB backend. It incorporates other LMDB-related
> suggestions from Duy Nguyen, e.g. using MDB_NOSUBDIR.
> 
> There's a fix for non-normal ref renames, also from Duy Nguyen.
> 
> Symbolic ref splitting has a bug fix, suggested by Michael Haggerty.
> 
> There are other, more minor changes suggested by Michael Haggerty and
> Duy Nguyen.
> 
> 
> David Turner (29):
>   refs: move head_ref{,_submodule} to the common code
>   refs: move for_each_*ref* functions into common code
>   files-backend: break out ref reading
>   refs: move resolve_ref_unsafe into common code
>   refs: add method for do_for_each_ref
>   refs: add do_for_each_per_worktree_ref
>   refs: add methods for reflog
>   refs: add method for initial ref transaction commit
>   refs: add method for delete_refs
>   refs: add methods to init refs db
>   refs: add method to rename refs
>   refs: handle non-normal ref renames
>   refs: make lock generic
>   refs: move duplicate check to common code
>   refs: allow log-only updates
>   refs: don't dereference on rename
>   refs: on symref reflog expire, lock symref not referrent
>   refs: resolve symbolic refs first
>   refs: always handle non-normal refs in files backend
>   init: allow alternate ref strorage to be set for new repos
>   refs: check submodules' ref storage config
>   clone: allow ref storage backend to be set for clone
>   svn: learn ref-storage argument
>   refs: register ref storage backends
>   config: read ref storage config on startup
>   refs: break out resolve_ref_unsafe_submodule
>   refs: add LMDB refs storage backend
>   refs: tests for lmdb backend
>   tests: add ref-storage argument
> 
> Ramsay Jones (1):
>   refs: reduce the visibility of do_for_each_ref()

Ah, sorry if it wasn't clear, but there is no need to keep this
as a separate patch - it should simply be squashed into the relevant
patch in your series.

ATB,
Ramsay Jones
