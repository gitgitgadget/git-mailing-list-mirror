From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: Trouble with cat-file on tags
Date: Fri, 1 Apr 2016 12:00:44 +0200
Message-ID: <ndlgsc$ed7$1@ger.gmane.org>
References: <ndlesh$dj1$1@ger.gmane.org> <ndlf7q$ghe$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 01 12:01:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alvtD-0001JM-Pw
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 12:01:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754660AbcDAKA6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2016 06:00:58 -0400
Received: from plane.gmane.org ([80.91.229.3]:35134 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754119AbcDAKA5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2016 06:00:57 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1alvso-00019B-2a
	for git@vger.kernel.org; Fri, 01 Apr 2016 12:00:50 +0200
Received: from 131.228.216.133 ([131.228.216.133])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 01 Apr 2016 12:00:50 +0200
Received: from sschuberth by 131.228.216.133 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 01 Apr 2016 12:00:50 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 131.228.216.133
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <ndlf7q$ghe$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290514>

On 4/1/2016 11:32, Sebastian Schuberth wrote:

> However, I still get information about the commit oject iintsead of the
> tag object. Is this expected?

Solved this one, too: Yes it is. I was misreading the docs:

"If <type> is specified, the raw (though uncompressed) contents of the 
<object> will be returned."

This means

$ git cat-file tag refs/tags/v0.1.2

displays the *contents* of the tag, not the tag itself. Which leads me 
to the next question: For a given name of an annotated tag, how to get 
the hash of the tag object? The solution I found for now:

$ git show-ref --tags -- v0.1.2
92b67e2b0626519ef8cd4e9cacb2bdafba6d53f0 refs/tags/v0.1.2

Regards,
Sebastian
