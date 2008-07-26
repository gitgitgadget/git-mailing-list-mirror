From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [PATCH] Set up argv0_path correctly, even when argv[0] is just
 the basename
Date: Sat, 26 Jul 2008 16:54:15 +0200
Message-ID: <488B3A97.6000606@keyaccess.nl>
References: <1217065304-27815-1-git-send-email-prohaska@zib.de> <alpine.DEB.1.00.0807261613120.26810@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Steffen Prohaska <prohaska@zib.de>,
	Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jul 26 16:53:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMl8n-0005uh-U3
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 16:53:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752083AbYGZOwA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 10:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752071AbYGZOwA
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 10:52:00 -0400
Received: from smtpq1.groni1.gr.home.nl ([213.51.130.200]:44853 "EHLO
	smtpq1.groni1.gr.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752065AbYGZOv7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 10:51:59 -0400
Received: from [213.51.130.188] (port=44199 helo=smtp3.groni1.gr.home.nl)
	by smtpq1.groni1.gr.home.nl with esmtp (Exim 4.60)
	(envelope-from <rene.herman@keyaccess.nl>)
	id 1KMl7f-00014J-PX; Sat, 26 Jul 2008 16:51:51 +0200
Received: from cc334381-b.groni1.gr.home.nl ([82.73.12.33]:59423 helo=[192.168.0.3])
	by smtp3.groni1.gr.home.nl with esmtp (Exim 4.60)
	(envelope-from <rene.herman@keyaccess.nl>)
	id 1KMl7f-000642-IG; Sat, 26 Jul 2008 16:51:51 +0200
User-Agent: Thunderbird 2.0.0.16 (X11/20080707)
In-Reply-To: <alpine.DEB.1.00.0807261613120.26810@eeepc-johanness>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90232>

On 26-07-08 16:14, Johannes Schindelin wrote:

> When the program 'git' is in the PATH, the argv[0] is set to the
> basename. However, argv0_path needs the full path, so add a function
> to discover the program by traversing the PATH manually.

While not having read the context for this, this ofcourse sounds like a 
huge gaping race-condition. If applicable here (as said, did not read 
context) you generally want to make sure that there's no window that a 
path could be replaced -- while perhaps not here, that's often the kind 
of thing that security attacks end up abusing.

Rene.
