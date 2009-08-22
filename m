From: Seba Illingworth <seba.illingworth@gmail.com>
Subject: Re: git diffall, open all diff files immediatly (eg =?utf-8?b?dGFiYmVkCXdpbmRvdz9pbg==?= BC)
Date: Sat, 22 Aug 2009 02:10:15 +0000 (UTC)
Message-ID: <loom.20090822T035703-224@post.gmane.org>
References: <loom.20090821T053954-649@post.gmane.org> <20090821054044.GB32879@gmail.com> <loom.20090821T074953-77@post.gmane.org> <20090821234512.GA58248@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 22 04:10:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Meg49-0007MZ-U3
	for gcvg-git-2@lo.gmane.org; Sat, 22 Aug 2009 04:10:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933138AbZHVCKl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 22:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933131AbZHVCKl
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 22:10:41 -0400
Received: from lo.gmane.org ([80.91.229.12]:43124 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933129AbZHVCKk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2009 22:10:40 -0400
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1Meg3y-0007Kr-Kh
	for git@vger.kernel.org; Sat, 22 Aug 2009 04:10:39 +0200
Received: from 125-239-41-3.jetstream.xtra.co.nz ([125.239.41.3])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 22 Aug 2009 04:10:38 +0200
Received: from seba.illingworth by 125-239-41-3.jetstream.xtra.co.nz with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 22 Aug 2009 04:10:38 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 125.239.41.3 (Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US) AppleWebKit/530.5 (KHTML, like Gecko) Chrome/2.0.172.39 Safari/530.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126778>

David Aguilar <davvid <at> gmail.com> writes:
> I would recommend against saying 'git difftool head' on your
> blog beause that only works on OSX with its case-preserving yet
> case-insensitive filesystem....

Thanks David, understood and updated to 'HEAD'. 'head' had worked for me with my 
sloppy Windows ways ;)

I struggled with your previous suggestion for handling paths with spaces; 
I couldn't get the for-loop to split the input into individual filenames
on the line-break separator (after outer quotes expanded the result?).

But rewriting it this way seems to work well and handles spaces (Windows):

    git diff --name-only "$@" | while read filename; do
        git difftool "$@" --no-prompt "$filename" &
    done

Hope you can comment on this variation? 
And thanks for all the tips! Seba
