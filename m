From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] submodules: don't stumble over symbolic links when cloning
 recursively
Date: Thu, 12 Jul 2012 19:12:21 +0200
Message-ID: <4FFF0575.3050203@kdbg.org>
References: <4FFDC1EE.8080106@web.de> <4FFDCFA4.9060602@kdbg.org> <4FFDDCAD.5080001@web.de> <4FFDE48B.7060802@kdbg.org> <4FFDEB46.6010403@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Bob Halley <halley@play-bow.org>,
	Phil Hord <phil.hord@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Jul 12 19:12:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SpMwI-0005RG-7p
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jul 2012 19:12:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161291Ab2GLRMZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jul 2012 13:12:25 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:10321 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932521Ab2GLRMY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2012 13:12:24 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id AFE3810019;
	Thu, 12 Jul 2012 19:12:21 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 7B65519F3C8;
	Thu, 12 Jul 2012 19:12:21 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:13.0) Gecko/20120601 Thunderbird/13.0
In-Reply-To: <4FFDEB46.6010403@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201366>

Am 11.07.2012 23:08, schrieb Jens Lehmann:
> Am 11.07.2012 22:39, schrieb Johannes Sixt:
>> At this point we can be in a subdirectory of the worktree. With
>> cd_to_toplevel we move up in the directory hierarchy ("cd out"). Then a
>> relative $gitdir or $sm_path now points to the wrong directory. No?
> 
> Nope, "git submodule" will refuse to run in anything but the root of
> the worktree. So we already are at the toplevel and use "cd_to_toplevel"
> only to resolve any symlinks present in $PWD. Looks like a comment
> explaining that above those lines would be a good idea ... will add one.

Ah, OK. I missed the lack of SUBDIRECTORY_OK=Yes, but noticed a few
cd_to_toplevel sprinkled throughout the script, so I thought it was OK
to be in a subdirectory.

-- Hannes
