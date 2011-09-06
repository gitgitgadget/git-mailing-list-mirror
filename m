From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: "Your local changes ... would be overwritten" bug
Date: Tue, 6 Sep 2011 09:34:36 +0200
Message-ID: <20110906073436.GA28490@ecki>
References: <8362l73qi6.fsf@kalahari.s2.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Hannu Koivisto <azure@iki.fi>
X-From: git-owner@vger.kernel.org Tue Sep 06 09:37:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0qDS-0003kq-IP
	for gcvg-git-2@lo.gmane.org; Tue, 06 Sep 2011 09:37:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753227Ab1IFHhB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Sep 2011 03:37:01 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:12897 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752825Ab1IFHhA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Sep 2011 03:37:00 -0400
Received: from localhost (p5B22CD62.dip.t-dialin.net [91.34.205.98])
	by bsmtp.bon.at (Postfix) with ESMTP id 08FE510024;
	Tue,  6 Sep 2011 09:36:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <8362l73qi6.fsf@kalahari.s2.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180774>

Hi,

On Mon, Sep 05, 2011 at 07:25:53PM +0300, Hannu Koivisto wrote:
> 
> I have a problem where "git checkout origin/another-branch" in master
> should remove a set of files but instead I get:
> 
> error: Your local changes to the following files would be overwritten by checkout:
>         file1
>         file2
>         ...
> Please, commit your changes or stash them before you can switch branches.
> Aborting

Could you set a breakpoint in add_rejected_path and send us the
backtrace? Like this:

$ gdb --args git checkout origin/another-branch
>> break add_rejected_path
>> r
... wait for break ...
>> bt

Thanks,
Clemens
