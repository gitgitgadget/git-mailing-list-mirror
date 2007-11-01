From: Bill Lear <rael@zopyra.com>
Subject: Re: Question on git-filter-branch
Date: Thu, 1 Nov 2007 07:54:56 -0600
Message-ID: <18217.55984.327062.84306@lisa.zopyra.com>
References: <18217.52425.655322.52338@lisa.zopyra.com>
	<20071101125845.GA27567@glandium.org>
	<18217.53833.710503.667761@lisa.zopyra.com>
	<20071101133440.GA17239@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Thu Nov 01 14:55:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InaW9-0007uf-4q
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 14:55:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753566AbXKANzO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 09:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753717AbXKANzO
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 09:55:14 -0400
Received: from mail.zopyra.com ([65.68.225.25]:60595 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753551AbXKANzN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 09:55:13 -0400
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id lA1Dt2B16608;
	Thu, 1 Nov 2007 07:55:02 -0600
In-Reply-To: <20071101133440.GA17239@glandium.org>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62959>

On Thursday, November 1, 2007 at 14:34:41 (+0100) Mike Hommey writes:
>On Thu, Nov 01, 2007 at 07:19:05AM -0600, Bill Lear wrote:
>> >Just remove .git/refs/original/
>> 
>> Ok, thanks.  But, how do I remove the subdirectory?
>> 
>> % rm -rf .git/refs/original
>> % git filter-branch --index-filter 'git update-index --remove sensitive_stuff' HEAD
>> Rewrite 6711f6a50605918326f67ca0c3402eab9a4c8571 (8/8)
>> WARNING: Ref 'refs/heads/master' is unchanged
>
>git-update-index --remove will remove files, not trees, so you need to
>use something like
>git-ls-files ensitive_stuff | xargs -d "\n" git-update-index --remove
>instead.

Oh yeah, now we're cookin' with gas:

% git filter-branch --index-filter 'git-ls-files sensitive_stuff | xargs -d "\n" git-update-index --remove' HEAD
Rewrite 6711f6a50605918326f67ca0c3402eab9a4c8571 (8/8)
Ref 'refs/heads/master' was rewritten

These refs were rewritten:
blake^master ~*/sensitive.clone ls
B  D

Excellent.

Thanks for the help.


Bill
