From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: Git ghost references
Date: Tue, 03 Jan 2012 09:23:21 +0100
Message-ID: <4F02BAF9.1000206@kdbg.org>
References: <CAJ6vYjfpx-hfDsd+urp5_iS99p0RhmxohOc+TNv7SUWFnYe5wQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Chris Leong <walkraft@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 03 09:23:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rhzef-0005OU-2R
	for gcvg-git-2@lo.gmane.org; Tue, 03 Jan 2012 09:23:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752060Ab2ACIX0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jan 2012 03:23:26 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:39780 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751893Ab2ACIXZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jan 2012 03:23:25 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 5B75213004D;
	Tue,  3 Jan 2012 09:23:22 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id AC13919F614;
	Tue,  3 Jan 2012 09:23:21 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.24) Gecko/20111101 SUSE/3.1.16 Thunderbird/3.1.16
In-Reply-To: <CAJ6vYjfpx-hfDsd+urp5_iS99p0RhmxohOc+TNv7SUWFnYe5wQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187853>

Am 03.01.2012 00:42, schrieb Chris Leong:
> I seem to have a "ghost reference" - ie. I can check out a reference
> that doesn't appear to exist. Does anyone know what might cause this?
> 
> ~/gaf-cvs (project-membership)$ g show-ref | grep production
> ~/gaf-cvs (project-membership)$ g co production
> Note: checking out 'production'.
> ...

The most likely reason is that you have a ref 'production' directly in
the .git directory. Perhaps you or one of your scripts created it
accidentally using 'git update-ref production ae5b621', i.e., without
giving the full ref path name.

-- Hannes
