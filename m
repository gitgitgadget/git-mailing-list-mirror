From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [PATCH] Set up argv0_path correctly, even when argv[0] is just
 the basename
Date: Sat, 26 Jul 2008 17:19:57 +0200
Message-ID: <488B409D.40709@keyaccess.nl>
References: <1217065304-27815-1-git-send-email-prohaska@zib.de> <alpine.DEB.1.00.0807261613120.26810@eeepc-johanness> <488B3A97.6000606@keyaccess.nl> <alpine.DEB.1.00.0807261709090.26810@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Steffen Prohaska <prohaska@zib.de>,
	Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jul 26 17:18:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMlXd-0005aG-7b
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 17:18:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751983AbYGZPRk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 11:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751865AbYGZPRk
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 11:17:40 -0400
Received: from smtpq1.groni1.gr.home.nl ([213.51.130.200]:47716 "EHLO
	smtpq1.groni1.gr.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751846AbYGZPRj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 11:17:39 -0400
Received: from [213.51.130.189] (port=57915 helo=smtp2.groni1.gr.home.nl)
	by smtpq1.groni1.gr.home.nl with esmtp (Exim 4.60)
	(envelope-from <rene.herman@keyaccess.nl>)
	id 1KMlWX-0003Vk-Oz; Sat, 26 Jul 2008 17:17:33 +0200
Received: from cc334381-b.groni1.gr.home.nl ([82.73.12.33]:58856 helo=[192.168.0.3])
	by smtp2.groni1.gr.home.nl with esmtp (Exim 4.60)
	(envelope-from <rene.herman@keyaccess.nl>)
	id 1KMlWX-0004Kw-HC; Sat, 26 Jul 2008 17:17:33 +0200
User-Agent: Thunderbird 2.0.0.16 (X11/20080707)
In-Reply-To: <alpine.DEB.1.00.0807261709090.26810@eeepc-johanness>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90238>

On 26-07-08 17:10, Johannes Schindelin wrote:
> Hi,
> 
> On Sat, 26 Jul 2008, Rene Herman wrote:
> 
>> On 26-07-08 16:14, Johannes Schindelin wrote:
>>
>>> When the program 'git' is in the PATH, the argv[0] is set to the
>>> basename. However, argv0_path needs the full path, so add a function
>>> to discover the program by traversing the PATH manually.
>> While not having read the context for this, this ofcourse sounds like a huge
>> gaping race-condition. If applicable here (as said, did not read context) you
>> generally want to make sure that there's no window that a path could be
>> replaced -- while perhaps not here, that's often the kind of thing that
>> security attacks end up abusing.
> 
> Yeah, and that's why you would carefully time your attack just in between 
> the command invocation and the discovery of argv[0] in the PATH.
> 
> Rather than replacing the 'git' program with an infected version right 
> away.

Adding to the PATH is generally not disallowed by user level security. 
Replacing the GIT binary generally is.

Sure maybe it's not much of a problem here; as said, I didn't read the 
context and am not a GIT person. Just commented on a git-user list when 
this was the next message on the list. Though a heads-up might still be 
in order. If it wasn't useful -- so be it, but even making a command do 
something different than a user expected can have serious implications, 
for example in this case for the tree they are working on.

Rene.
