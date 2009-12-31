From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: [Updated PATCH 2/2] Improve transport helper exec failure
 reporting
Date: Thu, 31 Dec 2009 18:59:04 +0200
Message-ID: <20091231165904.GA24243@Knoppix>
References: <1262170338-11574-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <1262170338-11574-3-git-send-email-ilari.liusvaara@elisanet.fi>
 <4B3CC6E5.7090404@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Dec 31 17:59:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQOMk-0000yI-RJ
	for gcvg-git-2@lo.gmane.org; Thu, 31 Dec 2009 17:59:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752752AbZLaQ7K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Dec 2009 11:59:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752675AbZLaQ7J
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Dec 2009 11:59:09 -0500
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:36887 "EHLO
	emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752663AbZLaQ7J (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Dec 2009 11:59:09 -0500
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh03-2.mail.saunalahti.fi (Postfix) with SMTP id 7355BEBE38;
	Thu, 31 Dec 2009 18:59:07 +0200 (EET)
Received: from emh07.mail.saunalahti.fi ([62.142.5.117])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A045236C45D; Thu, 31 Dec 2009 18:59:07 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh07.mail.saunalahti.fi (Postfix) with ESMTP id 534C01C63AC;
	Thu, 31 Dec 2009 18:59:05 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <4B3CC6E5.7090404@kdbg.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135958>

On Thu, Dec 31, 2009 at 04:44:37PM +0100, Johannes Sixt wrote:
> Ilari Liusvaara schrieb:
> >@@ -31,13 +31,19 @@ static struct child_process *get_helper(struct transport *transport)
> 
> You should set helper->silent_exec_failure = 1 when you give your
> own error message for the ENOENT case.

Ah yeah, might matter for Win32.

> BTW, which error message do you see without your change in this
> case? You only say "pretty much useless", but do not give an
> example.

git: 'remote-foo' is not a git-command. See 'git --help'.

And as first line of output, such thing is utterly confusing.

> >+		else
> >+			die("Unable to run helper %s: %s", helper->argv[0],
> >+				strerror(errno));
> 
> You shouldn't write an error message here because start_command has
> already reported the error.

Its not printed on Unix.

-Ilari
