From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] editor.c: Libify launch_editor()
Date: Fri, 25 Jul 2008 01:36:53 -0700
Message-ID: <7vvdyuuzq2.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0807180313200.2906@eeepc-johanness>
 <1216380408-21671-1-git-send-email-s-beyer@gmx.net>
 <alpine.DEB.1.00.0807181405510.3932@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephan Beyer <s-beyer@gmx.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 25 10:38:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMIoO-0006zv-Q7
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 10:38:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752663AbYGYIhE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 04:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752674AbYGYIhE
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 04:37:04 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:39643 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752299AbYGYIhD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 04:37:03 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 567273A085;
	Fri, 25 Jul 2008 04:36:59 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 4250F3A083; Fri, 25 Jul 2008 04:36:55 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D8CA4078-5A24-11DD-80B8-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90012>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Fri, 18 Jul 2008, Stephan Beyer wrote:
>
>> This patch removes exit()/die() calls and builtin-specific messages from 
>> launch_editor(), so that it can be used as a general libgit.a function 
>> to launch an editor.
>
> Thanks.  Now we have to convince Junio that it is a good idea :-)

Eh, excuse me.

>> diff --git a/editor.c b/editor.c
>> index 483b62d..5d7f5f9 100644
>> --- a/editor.c
>> +++ b/editor.c
>> @@ -17,9 +17,8 @@ void launch_editor(const char *path, struct strbuf *buffer, const char *const *e
> ...
> Why not "return error()"?
>
> Rest looks obviously correct to me!

This is a patch to an existing file editor.c???
