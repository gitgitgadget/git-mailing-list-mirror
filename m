From: "norbert.nemec" <norbert.nemec@native-instruments.de>
Subject: Re: filter-branch ignoring gitattributes?
Date: Wed, 08 Feb 2012 09:23:11 +0100
Message-ID: <jgtbdh$ahf$1@dough.gmane.org>
References: <jgglh9$mrv$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 08 09:23:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rv2oO-0006ZG-Px
	for gcvg-git-2@plane.gmane.org; Wed, 08 Feb 2012 09:23:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755619Ab2BHIX2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Feb 2012 03:23:28 -0500
Received: from plane.gmane.org ([80.91.229.3]:37817 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755461Ab2BHIX1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Feb 2012 03:23:27 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Rv2oG-0006VS-Uz
	for git@vger.kernel.org; Wed, 08 Feb 2012 09:23:24 +0100
Received: from 46.231.181.199 ([46.231.181.199])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 08 Feb 2012 09:23:24 +0100
Received: from norbert.nemec by 46.231.181.199 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 08 Feb 2012 09:23:24 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 46.231.181.199
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:10.0) Gecko/20120129 Thunderbird/10.0
In-Reply-To: <jgglh9$mrv$1@dough.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190226>

Meanwhile, I can answer my own question:

The "text" attribute works similar to a filter.
As with filters in general, it is only applied when git detects a 
modification in the file. A file change is detected by the file 
modification time on disc. To reread all files from disk and re-apply 
the filters to all of them, you would typically delete the .git/index 
file. In filter-branch, this is not possible, so instead you have to 
"touch" all files in the --tree-filter command.


Am 03.02.12 13:55, schrieb norbert.nemec:
> Hi there,
>
> it seems that 'git filter-branch' ignores the setting in
> .git/info/attributes - is that correct?
>
> Does .gitattributes work reliably?
>
> Specifically, I tried
>
> git filter-branch \
> --tree-filter 'echo "* text=auto" > .gitattributes' \
> --tag-name-filter cat
> --prune-empty -- --all
>
> It seems to work, but I am not sure whether I missed anything.
>
> Greetings,
> Norbert
>
