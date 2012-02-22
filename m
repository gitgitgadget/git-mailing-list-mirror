From: Matt McClure <matthewlmcclure@gmail.com>
Subject: Re: Manual hunk edit mode + emacs + ^G == garbage
Date: Wed, 22 Feb 2012 21:43:34 +0000 (UTC)
Message-ID: <loom.20120222T222339-97@post.gmane.org>
References: <39CB17A9-2717-491B-8E01-F3E855F90649@sb.org> <AANLkTimM92SdY_+v5JcOx2kYbDKBJJzBofFm0FLF_S6K@mail.gmail.com> <buomxqhayqc.fsf@dhlpc061.dev.necel.com> <EDCC7CB3-4DFF-45B8-9E23-E12045CC29D7@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 23 00:05:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0LFM-0003mf-Hz
	for gcvg-git-2@plane.gmane.org; Thu, 23 Feb 2012 00:05:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752386Ab2BVXFJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Feb 2012 18:05:09 -0500
Received: from plane.gmane.org ([80.91.229.3]:42810 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751013Ab2BVXFI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2012 18:05:08 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1S0LFC-0003en-9t
	for git@vger.kernel.org; Thu, 23 Feb 2012 00:05:06 +0100
Received: from c-24-91-16-82.hsd1.ma.comcast.net ([24.91.16.82])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 23 Feb 2012 00:05:06 +0100
Received: from matthewlmcclure by c-24-91-16-82.hsd1.ma.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 23 Feb 2012 00:05:06 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 24.91.16.82 (Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_2) AppleWebKit/535.11 (KHTML, like Gecko) Chrome/17.0.963.56 Safari/535.11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191308>

Kevin Ballard <kevin <at> sb.org> writes:

> I'm still very much interested in finding a solution to why ^G kills
> emacs when it's invoked by git. As I said earlier, it appears that emacs
> shares the same process group with the perl process that called it, even
> though Andreas Schwab says it puts itself into its own process group and
> invoking emacs from the shell does just that. Does anyone know why this
> might be happening?

Kevin,

I was having the same problem you described on Mac OS X Lion and found this
old thread. A workaround that works for me is:

~/bin/emacs.sh:

#!/bin/bash -i

emacs "$@"

-- cut --

git config --global core.editor ~/bin/emacs.sh

Matt
