From: Don Zickus <dzickus@redhat.com>
Subject: Re: suggestions for generating diffs through the revision list
Date: Thu, 19 Jun 2008 17:20:49 -0400
Message-ID: <20080619212049.GO16941@redhat.com>
References: <20080617214142.GM16941@redhat.com> <7v63s767mb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 19 23:27:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9Rez-0008Ip-9M
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 23:27:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751917AbYFSV0E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 17:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751904AbYFSV0D
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 17:26:03 -0400
Received: from mx1.redhat.com ([66.187.233.31]:49402 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751687AbYFSV0B (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 17:26:01 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m5JLKpxq016866;
	Thu, 19 Jun 2008 17:20:51 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [10.16.255.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m5JLKoMD009343;
	Thu, 19 Jun 2008 17:20:50 -0400
Received: from drseuss.usersys.redhat.com (dhcp-100-19-202.bos.redhat.com [10.16.19.202])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id m5JLKops014343;
	Thu, 19 Jun 2008 17:20:50 -0400
Received: from drseuss.usersys.redhat.com (localhost.localdomain [127.0.0.1])
	by drseuss.usersys.redhat.com (8.14.2/8.14.1) with ESMTP id m5JLKott016143;
	Thu, 19 Jun 2008 17:20:50 -0400
Received: (from dzickus@localhost)
	by drseuss.usersys.redhat.com (8.14.2/8.14.2/Submit) id m5JLKo1U016142;
	Thu, 19 Jun 2008 17:20:50 -0400
X-Authentication-Warning: drseuss.usersys.redhat.com: dzickus set sender to dzickus@redhat.com using -f
Content-Disposition: inline
In-Reply-To: <7v63s767mb.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Scanned-By: MIMEDefang 2.58 on 172.16.52.254
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85534>

On Tue, Jun 17, 2008 at 03:04:28PM -0700, Junio C Hamano wrote:
> Don Zickus <dzickus@redhat.com> writes:
> 
> > I am try to walk the revision history for a given path and analyze the
> > diff (as compared to its parent).  What is the proper way of doing that?
> >
> > I noticed a bunch of 'library' calls such as
> >
> > init_revsion(&revs);
> > setup_revisions(argc, argv, &revs, "HEAD");
> > prepare_revision_walk(&revs, NULL);
> > commit = get_revision(&revs);
> >
> > But what I can't find is the way to generate diffs.  I see lots and lots
> > of code to do it, but every builtin seems to do it differently.  Not
> > knowing the internals that well, I was hoping for some advice.
> >
> > I stumbled upon calls like
> >
> > run_diff_files
> > run_diff_index
> >
> > but I haven't seen how to use them correctly.
> 
> Documentation/technical/api-*.txt

Hmm. Thanks.  I was trying to keep the diffs in memory and I couldn't find
anything in the api-*.txt that did anything but dump the output the stdout
or a file.

Anyway I just copied a bunch of code from builtin-blame.c and got my tool
to do what I wanted it to do, for now.

Cheers,
Don
