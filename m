From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: Use config file or file for repository owner's name.
Date: Wed, 30 Jan 2008 18:48:43 -0800
Message-ID: <7vsl0eg16c.fsf@gitster.siamese.dyndns.org>
References: <1201670898-15076-1-git-send-email-ribas@c3sl.ufpr.br>
	<7vwsprj0sv.fsf@gitster.siamese.dyndns.org>
	<20080131023629.GB7778@c3sl.ufpr.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bruno Cesar Ribas <ribas@c3sl.ufpr.br>
X-From: git-owner@vger.kernel.org Thu Jan 31 03:49:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKPUd-0001NQ-Ls
	for gcvg-git-2@gmane.org; Thu, 31 Jan 2008 03:49:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755338AbYAaCtE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2008 21:49:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756237AbYAaCtD
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jan 2008 21:49:03 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:38795 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752435AbYAaCtB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2008 21:49:01 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id F0567347B;
	Wed, 30 Jan 2008 21:48:59 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 748FA347A;
	Wed, 30 Jan 2008 21:48:55 -0500 (EST)
In-Reply-To: <20080131023629.GB7778@c3sl.ufpr.br> (Bruno Cesar Ribas's message
	of "Thu, 31 Jan 2008 00:36:29 -0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72094>

Bruno Cesar Ribas <ribas@c3sl.ufpr.br> writes:

> On Tue, Jan 29, 2008 at 10:16:16PM -0800, Junio C Hamano wrote:
>> Bruno Ribas <ribas@c3sl.ufpr.br> writes:
>> 
>> <snip> 
>> I am not sure about the effect of this change on a large scale
>> site.  If you do not have the project list file, originally we
>> just needed a stat per project, but now you open an extra file
>> (either "owner" or "config") and read it, once per every
>> project.
>
> Opening the extra file has same problem as the description file. And, as
> gitweb allow us to create  "description" and "cloneurl" file there is no 
> problem having another file to open instead finding out who is the owner of
> the directory asking to the filesystem.

We heard the same argument when cloneurl was added, and a
newcomer who does not know that may rightly use the same
argument.  But I think we should work towards _reducing_ the
number of such ad-hoc one-line-per-information files, not using
existing ones as an excuse to add _more_ of them.
