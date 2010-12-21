From: Ken Brownfield <krb@irridia.com>
Subject: Re: Performance issue exposed by git-filter-branch
Date: Mon, 20 Dec 2010 20:49:11 -0800
Message-ID: <3800FCA0-3894-417D-847D-421693A53E75@irridia.com>
References: <41C1B4AC-8427-4D62-BEB6-689A4BE4EE5B@irridia.com> <201012170254.13005.trast@student.ethz.ch> <9A686258-A504-4CBB-9993-048B45B5EE6A@irridia.com> <m3lj4sll39.fsf@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 21 05:49:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PUuAK-0004DG-3n
	for gcvg-git-2@lo.gmane.org; Tue, 21 Dec 2010 05:49:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933564Ab0LUEta (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Dec 2010 23:49:30 -0500
Received: from endymion.irridia.com ([184.105.192.220]:59409 "EHLO
	endymion.irridia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933548Ab0LUEt3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Dec 2010 23:49:29 -0500
Received: from shrike2.sfo.corp.google.com (unknown [72.14.229.84])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by endymion.irridia.com (Postfix) with ESMTPSA id 38A1414566E
	for <git@vger.kernel.org>; Mon, 20 Dec 2010 20:49:25 -0800 (PST)
In-Reply-To: <m3lj4sll39.fsf@localhost.localdomain>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164025>

This does pretty much exactly what I want (and a lot more), but reposurgeon is now over three days into reading the fast-export stream at 100% CPU.  My guess is that it's about 30% done.

It does look like a great tool for smaller repositories.

Thanks for the suggestion, though!  It looks like git_fast_filter is my next stop.

Ken

On Dec 16, 2010, at 6:51 PM, Jakub Narebski wrote:

> Please do not toppost.
> 
> Ken Brownfield <krb@irridia.com> writes:
> 
>> I had considered this approach (and the one mentioned by Jonathan)
>> but there are no git tools to actually perform the filter I wanted
>> on the export in this form.  I could (and will) parse fast-export
>> and make an attempt a filtering files/directories... my concern is
>> that I won't do it right, and will introduce subtle corruption.  But
>> if there's no existing tool, I'll take a crack at it. :-)
> 
> You can try ESR's reposurgeon:
> 
>  http://www.catb.org/~esr/reposurgeon/
> 
> It's limitation is that it loads structure of DAG of revisions (but
> not blobs i.e. contents of file) to memory.  IIRC.  It is not
> streaming, but "DOM" based, otherwise some commands would not work.
> 
> 
> By the way, git-filter-branch documentation recomments to use
> index-filter with git-update-index instead of tree-filter with git-rm,
> and if tree-filter is needed, to use some fast filesystem, e.g. RAM
> one.
> 
> But probably you know all that.
> -- 
> Jakub Narebski
> Poland
> ShadeHawk on #git
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
