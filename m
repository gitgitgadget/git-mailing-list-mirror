From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Re: What's cooking in git.git (topics)
Date: Mon, 30 Jun 2008 10:09:30 -0400
Message-ID: <1214834970.3382.4.camel@gaara.bos.redhat.com>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org>
	 <7vd4pf7h9y.fsf@gitster.siamese.dyndns.org>
	 <7vwsnjl21c.fsf@gitster.siamese.dyndns.org>
	 <7vhcehzdeg.fsf@gitster.siamese.dyndns.org>
	 <7vbq4j748l.fsf@gitster.siamese.dyndns.org>
	 <7vr6d8apjx.fsf@gitster.siamese.dyndns.org>
	 <7vhcdyfe9u.fsf@gitster.siamese.dyndns.org>
	 <7vabjm1a0q.fsf@gitster.siamese.dyndns.org>
	 <7vr6crj0jk.fsf@gitster.siamese.dyndns.org>
	 <7vmyn4hr8f.fsf@gitster.siamese.dyndns.org>
	 <7vmymsjz6x.fsf@gitster.siamese.dyndns.org>
	 <7vabijxhk4.fsf@gitster.siamese.dyndns.org>
	 <7vwslhg8qe.fsf@gitster.siamese.dyndns.org>
	 <7vhccfiksy.fsf@gitster.siamese.dyndns.org>
	 <7vod6k6zg4.fsf@gitster.siamese.dyndns.org>
	 <7v4p7xwsfp.fsf@gitster.siamese.dyndns.org>
	 <7v3anb19n7.fsf@gitster.siamese.dyndns.org>
	 <7vwskjazql.fsf@gitster.siamese.dyndns.org>
	 <7vk5ggipuw.fsf@gitster.siamese.dyndns.org>
	 <7vej6l3lp7.fsf@gitster.siamese.dyndns.org>
	 <7vod5kd3im.fsf@gitster.siamese.dyndns.org>
	 <7v3amv1e8n.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 30 16:13:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDK7h-0004vJ-3B
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 16:12:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752080AbYF3OLy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 10:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752160AbYF3OLy
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 10:11:54 -0400
Received: from mx1.redhat.com ([66.187.233.31]:39063 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752064AbYF3OLx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 10:11:53 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m5UE9k5g013040;
	Mon, 30 Jun 2008 10:09:46 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m5UE9jht015553;
	Mon, 30 Jun 2008 10:09:45 -0400
Received: from [10.16.3.198] (dhcp-100-3-198.bos.redhat.com [10.16.3.198])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m5UE9iEG000985;
	Mon, 30 Jun 2008 10:09:45 -0400
In-Reply-To: <7v3amv1e8n.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.22.0 (2.22.0-4.fc9) 
X-Scanned-By: MIMEDefang 2.58 on 172.16.52.254
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86913>

On Mon, 2008-06-30 at 02:08 -0700, Junio C Hamano wrote:
> Here are the topics that have been cooking.  Commits prefixed
> with '-' are only in 'pu' while commits prefixed with '+' are
> in 'next'.
> 
> The topics list the commits in reverse chronological order.  The topics
> meant to be applied to the maintenance series have "maint-" in their
> names.
> 
> It already is beginning to become clear what 1.6.0 will look like.  What's
> already in 'next' all are well intentioned (I do not guarantee they are
> already bug-free --- that is what cooking them in 'next' is for) and are
> good set of feature enhancements.  Bigger changes will be:
> 
>  * MinGW will be in.
> 
>  * With the default Makefile settings, most of the programs will be
>    installed outside your $PATH, except for "git", "gitk", "git-gui" and
>    some server side programs that need to be accessible for technical
>    reasons.  Invoking a git subcommand as "git-xyzzy" from the command
>    line has been deprecated since early 2006 (and officially announced in
>    1.5.4 release notes); use of them from your scripts after adding
>    output from "git --exec-path" to the $PATH will still be supported in
>    1.6.0, but users are again strongly encouraged to adjust their
>    scripts to use "git xyzzy" form, as we will stop installing
>    "git-xyzzy" hardlinks for built-in commands in later releases.
> 
>  * git-merge will be rewritten in C.
> 
>  * default pack and idx versions will be updated as scheduled for some
>    time ago.

A small detail I've suggested scheduling for 1.6 before is removing (or
rather, stop creating) the empty .git/branches directory.  How does that
sound?

cheers,
Kristian
