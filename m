From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "checkout --track -b" broken? (with suggested fix)
Date: Fri, 17 Oct 2008 16:57:53 -0700
Message-ID: <7vskqug4fy.fsf@gitster.siamese.dyndns.org>
References: <7vej2fohfr.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0810171113340.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jay Soffian <jaysoffian@gmail.com>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sat Oct 18 01:59:21 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqzE0-0003C1-O9
	for gcvg-git-2@gmane.org; Sat, 18 Oct 2008 01:59:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754289AbYJQX6G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Oct 2008 19:58:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754142AbYJQX6F
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Oct 2008 19:58:05 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64090 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754120AbYJQX6E (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Oct 2008 19:58:04 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id A38838B684;
	Fri, 17 Oct 2008 19:58:01 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 5B42F8B679; Fri, 17 Oct 2008 19:57:55 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6E64B824-9CA7-11DD-A451-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98501>

Daniel Barkalow <barkalow@iabervon.org> writes:

> On Thu, 16 Oct 2008, Junio C Hamano wrote:
>
>> The patch to branch.c is a quick fix for this issue.  The resulting code
>> passes all the tests, but I am not very proud of hardcoding the "HEAD" in
>> the code.  There must be a better way to do this.
>
> I agree with the change to the test. I think it would be better to 
> hard-code "refs/heads/" instead of "HEAD", and I feel like we must have a 
> "is this ref name a branch?" function, if only because someone could stick 
> "refs/tags/foo" in HEAD, and we should still say it's not something you 
> could track, despite it being something different from "HEAD".

But you can track things under refs/remotes/, so...
