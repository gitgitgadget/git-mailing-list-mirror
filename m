From: Don Zickus <dzickus@redhat.com>
Subject: Re: using git-blame with patches as input
Date: Tue, 17 Jun 2008 10:17:58 -0400
Message-ID: <20080617141758.GL16941@redhat.com>
References: <20080616213517.GE20727@redhat.com> <7vabhl9hap.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 17 16:19:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8c1c-0006E3-R8
	for gcvg-git-2@gmane.org; Tue, 17 Jun 2008 16:19:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758145AbYFQOSP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2008 10:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757995AbYFQOSP
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 10:18:15 -0400
Received: from mx1.redhat.com ([66.187.233.31]:47341 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754516AbYFQOSO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2008 10:18:14 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m5HEHxjw006961;
	Tue, 17 Jun 2008 10:17:59 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [10.16.255.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m5HEHwHD021618;
	Tue, 17 Jun 2008 10:17:58 -0400
Received: from drseuss.usersys.redhat.com (dhcp-100-19-202.bos.redhat.com [10.16.19.202])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id m5HEHwnt023944;
	Tue, 17 Jun 2008 10:17:58 -0400
Received: from drseuss.usersys.redhat.com (localhost.localdomain [127.0.0.1])
	by drseuss.usersys.redhat.com (8.14.2/8.14.1) with ESMTP id m5HEHwbo019880;
	Tue, 17 Jun 2008 10:17:58 -0400
Received: (from dzickus@localhost)
	by drseuss.usersys.redhat.com (8.14.2/8.14.2/Submit) id m5HEHwNC019879;
	Tue, 17 Jun 2008 10:17:58 -0400
X-Authentication-Warning: drseuss.usersys.redhat.com: dzickus set sender to dzickus@redhat.com using -f
Content-Disposition: inline
In-Reply-To: <7vabhl9hap.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Scanned-By: MIMEDefang 2.58 on 172.16.52.254
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85302>

On Mon, Jun 16, 2008 at 02:54:54PM -0700, Junio C Hamano wrote:
> Don Zickus <dzickus@redhat.com> writes:
> 
> > For example, if I took the top three commits from HEAD and appended them
> > into one patch file and then ran this tool with the patch as input, I
> > would hope that it gave as output the three original commits.
> 
> Unfortunately blame does not work in such an inefficient way.  The patch
> text from your second commit (that is, the diff that shows what used to be
> in the first commit and what is in the second commit) may be further
> rewritten in the third commit, so if you start blaming such a text from
> HEAD, the blame stops at the HEAD commit saying "the text you have is even
> newer".

I know, but I am trying to crawl before I run.  So I am attacking the
simple cases first to help me understand how the whole git internal
mechanisms work (I am still trying to figure out the correct way to walk
the revision list for a particular file using git-blame as a guide).  Once
my code works for the simple cases, then I can attack the more 'normal'
cases like you described above.

Cheers,
Don
