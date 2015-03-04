From: Mason <slash.tmp@free.fr>
Subject: Re: Salvaging borked project history
Date: Wed, 04 Mar 2015 15:49:25 +0100
Message-ID: <54F71B75.7000104@free.fr>
References: <54EB5DD7.7050202@free.fr>	<xmqq7fv8to7e.fsf@gitster.dls.corp.google.com>	<54EF098B.4080803@free.fr> <xmqqh9u8mrha.fsf@gitster.dls.corp.google.com> <54EF814D.1020105@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 04 15:49:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTAcE-0001lh-2D
	for gcvg-git-2@plane.gmane.org; Wed, 04 Mar 2015 15:49:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758350AbbCDOt2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2015 09:49:28 -0500
Received: from smtp2-g21.free.fr ([212.27.42.2]:47735 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757895AbbCDOt1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2015 09:49:27 -0500
Received: from [172.27.0.114] (unknown [83.142.147.193])
	(Authenticated sender: shill)
	by smtp2-g21.free.fr (Postfix) with ESMTPSA id 6F6804B021C
	for <git@vger.kernel.org>; Wed,  4 Mar 2015 15:48:49 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:35.0) Gecko/20100101 Firefox/35.0 SeaMonkey/2.32.1
In-Reply-To: <54EF814D.1020105@free.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264761>

Mason wrote:

> I was planning to write 'git diff -q commit^ commit'
> to test for empty commits. Looks like I'll be needing
> 'git diff commit^ commit | wc -l' instead?

I wrote a script to generate the list of empty commits.

git log --format="%h" --reverse 413cb08.. | while read H
do
   if git diff --quiet $H^ $H; then echo $H; fi
done >empty_commits

But it turns out all this is unnecessary, as git-rebase
will automatically filter empty commits! :-)
Unless given the --keep-empty option, I presume.

Thanks to everyone involved in making this great tool.

Regards.
