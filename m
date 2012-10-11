From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: filter-branch IO optimization
Date: Thu, 11 Oct 2012 20:36:14 +0200
Message-ID: <5077119E.4060702@kdbg.org>
References: <7e000a0f-9e4e-4a4d-a8ce-5d017e17939c@zcs> <fa1e05a5-54b3-47ff-bd28-dc463ebbc4bd@zcs>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: Enrico Weigelt <enrico.weigelt@vnc.biz>
X-From: git-owner@vger.kernel.org Thu Oct 11 20:36:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMNcm-0005TL-UA
	for gcvg-git-2@plane.gmane.org; Thu, 11 Oct 2012 20:36:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759062Ab2JKSgi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2012 14:36:38 -0400
Received: from bsmtp5.bon.at ([195.3.86.187]:39647 "EHLO lbmfmo03.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758820Ab2JKSgh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2012 14:36:37 -0400
Received: from bsmtp.bon.at (unknown [192.168.181.107])
	by lbmfmo03.bon.at (Postfix) with ESMTP id F214CCDFA9
	for <git@vger.kernel.org>; Thu, 11 Oct 2012 20:36:35 +0200 (CEST)
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id E76F2130049;
	Thu, 11 Oct 2012 20:36:14 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 3AC3D19F3D5;
	Thu, 11 Oct 2012 20:36:14 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120825 Thunderbird/15.0
In-Reply-To: <fa1e05a5-54b3-47ff-bd28-dc463ebbc4bd@zcs>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207502>

Am 11.10.2012 17:39, schrieb Enrico Weigelt:
> The main goal of this filtering is splitting out many modules from a
> large upstream repo into their own downstream repos.
...
> The next step I have in mind is using --subdirectory-filter, but open
> questsions are:
> 
> * does it suffer from the same problems w/ empty username/email like --tree-filter ?

I think so.

> ** if yes: what can I do about it (have an additional pass for fixing that before
>    running the --tree-filter ?

Use --env-filter.

> * can I somehow teach the --subdirectory filter to place the result under some
>   somedir instead of directly to root ?

No, but see the last example in the man page.

> * can I use --tree-filter in combination with --subdireectory-filter ? 
>   which one is executed first ?

Yes. --subdirectory-filter applies first.

-- Hannes
