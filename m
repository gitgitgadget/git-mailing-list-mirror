From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] rebase --fix: interactive fixup mode
Date: Mon, 09 Jan 2012 09:40:02 +0100
Message-ID: <4F0AA7E2.9010200@alum.mit.edu>
References: <20120108213134.GA18671@ecki.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Mon Jan 09 09:40:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkAmG-0002eP-27
	for gcvg-git-2@lo.gmane.org; Mon, 09 Jan 2012 09:40:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755006Ab2AIIkR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jan 2012 03:40:17 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:59681 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751615Ab2AIIkQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jan 2012 03:40:16 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q098e2pu009831
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 9 Jan 2012 09:40:02 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.24) Gecko/20111108 Lightning/1.0b2 Thunderbird/3.1.16
In-Reply-To: <20120108213134.GA18671@ecki.lan>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188162>

On 01/08/2012 10:31 PM, Clemens Buchacher wrote:
> Interactive rebase is frequently used not to rebase history, but to
> manipulate recent commits. This is typically done using the following
> command:
> 
>  git rebase -i HEAD~N
> 
> Where N has to be large enough such that the the range HEAD~N..HEAD
> contains the desired commits. At the same time, it should be small
> enough such that the range HEAD~N..HEAD does not include published
> commits or a merge commit. Otherwise, the user may accidentally change
> published history. Rebasing a merge commit can also have the generally
> undesirable effect of linearizing the merge history.
> 
> In order to determine a suitable range automatically, it is a reasonable
> heuristic to rebase onto the most recent merge commit. It does not
> guarantee that published commits are not included -- indeed there is no
> way to do that. But, the range is usually large enough to contain the
> desired commits. Also, this mechanism works regardless of whether or not
> branch tracking has been configured.
> 
> So instead of the above command, one can instead use the following:
> 
>  git rebase --fix

Two comments:

* The name "--fix" might be confusing because of its similarity to the
"fixup" command that can be specified in the interactive instructions file.

* I agree with you that "interactive rebase is frequently used not to
rebase history, but to manipulate recent commits".  In fact, I use
interactive rebase *only* for manipulating recent commits and
non-interactive rebase *only* for changing commits' ancestry.  I think
it is a good idea to make these two uses more distinct.  For example, it
makes me nervous that I might mis-type the <upstream> parameter when I
am trying to touch up commits and end up inadvertently rebasing the
commits onto a new parent.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
