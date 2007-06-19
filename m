From: Bill Lear <rael@zopyra.com>
Subject: Re: Errors building git-1.5.2.2 on 64-bit Centos 5
Date: Tue, 19 Jun 2007 09:48:22 -0500
Message-ID: <18039.60598.264803.940960@lisa.zopyra.com>
References: <18039.52754.563688.907038@lisa.zopyra.com>
	<Pine.LNX.4.64.0706191359160.4059@racer.site>
	<20070619132456.GA15023@fiberbit.xs4all.nl>
	<18039.57099.57602.28299@lisa.zopyra.com>
	<20070619143000.GA15352@fiberbit.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Marco Roeland <marco.roeland@xs4all.nl>
X-From: git-owner@vger.kernel.org Tue Jun 19 16:48:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0f0Z-00018n-0V
	for gcvg-git@gmane.org; Tue, 19 Jun 2007 16:48:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752985AbXFSOsh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Jun 2007 10:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752693AbXFSOsg
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jun 2007 10:48:36 -0400
Received: from mail.zopyra.com ([65.68.225.25]:60176 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752106AbXFSOsg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2007 10:48:36 -0400
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l5JEmV501182;
	Tue, 19 Jun 2007 09:48:31 -0500
In-Reply-To: <20070619143000.GA15352@fiberbit.xs4all.nl>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50486>

On Tuesday, June 19, 2007 at 16:30:00 (+0200) Marco Roeland writes:
>On Tuesday June 19th 2007 at 08:50 Bill Lear wrote:
>> 
>> I checked and there is no iconv package (rpm).  I really don't want
>> to have to temporarily rename a header.  I can't hand this out to
>> the rest of the company, some of whom do not have root access to
>> be able to rename header files.
>
>You might at least investigate if there is somehow another iconv.h
>header besides the system one under /usr/include, that might have been
>used by the compiler instead of the standard one from GNU libc.

Ok, I moved all the *iconv* stuff in /usr/local/<blah> and now
it builds ok.

However, I still get this:

install -d -m755 '/opt/git-1.5.2.2/share//git-core/templates/'
(cd blt && tar cf - .) | \
	(cd '/opt/git-1.5.2.2/share//git-core/templates/' && tar xf -)
tar: This does not look like a tar archive
tar: Skipping to next header
tar: Archive contains obsolescent base-64 headers
tar: Error exit delayed from previous errors

So, I did a make -k and it worked ok, aside from this error.

I copied this line:

(cd blt && tar cf - .) | \
	(cd '/opt/git-1.5.2.2/share//git-core/templates/' && tar xf -)

into a file, chmod +x'd that file, and cd'd into templates and ran
the script.  I got the same error.  I then tried running it by
hand from the command line:

% cd templates
% (cd blt && tar cf - .) | (cd /opt/git-1.5.2.2/share/git-core/templates && tar xf -)

and it worked fine.


Bill
