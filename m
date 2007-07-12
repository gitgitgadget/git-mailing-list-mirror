From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: git .pack expansion question
Date: Thu, 12 Jul 2007 16:58:44 -0400
Message-ID: <873AE37B-16EA-409B-A488-96DFF2581B43@silverinsanity.com>
References: <5ed683f50707121203q52084b72o106616f1c8710141@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ryan Moszynski <ryan.m.public@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 12 22:58:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I95kT-0002vi-4X
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 22:58:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757141AbXGLU6u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 16:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758889AbXGLU6u
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 16:58:50 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:51004 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757099AbXGLU6t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 16:58:49 -0400
Received: from [192.168.1.3] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id C54381FFC003;
	Thu, 12 Jul 2007 20:58:48 +0000 (UTC)
In-Reply-To: <5ed683f50707121203q52084b72o106616f1c8710141@mail.gmail.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52334>


On Jul 12, 2007, at 3:03 PM, Ryan Moszynski wrote:

> hopefully this is the right list for this:
>
> am i understanding this right?
>
> if i run the command:
> git-repack
> this creates an .idx and a .pack file that together hold all the files
> and other metadata for my git directory.

You're not understanding it correctly.  The .pack files hold all the  
data from the git repository, but none of the metadata.  The .idx  
file is an index into the pack for speed and can be re-created from  
the pack itself.

What you're looking for is git-bundle (added just after v1.5.0 it  
looks like).  `git bundle create <file-name> --all` will bundle up  
all the branches from your repository.  It doesn't seem to want to  
take the tags when I do it that way, but it's definitely the right  
start.

~~ Brian
