From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Storing notes refs outside of refs/
Date: Thu, 26 Aug 2010 09:02:09 -0600
Message-ID: <4C7681F1.3070205@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 26 17:02:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oody7-0004VT-Mk
	for gcvg-git-2@lo.gmane.org; Thu, 26 Aug 2010 17:02:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753946Ab0HZPCL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Aug 2010 11:02:11 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:34419 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752012Ab0HZPCK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Aug 2010 11:02:10 -0400
Received: (qmail 4705 invoked by uid 399); 26 Aug 2010 09:02:09 -0600
Received: from unknown (HELO ?192.168.1.2?) (jjensen@workspacewhiz.com@75.220.39.54)
  by hsmail.qwknetllc.com with ESMTPAM; 26 Aug 2010 09:02:09 -0600
X-Originating-IP: 75.220.39.54
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.8) Gecko/20100802 Lightning/1.0b2 Thunderbird/3.1.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154541>

  Every push to our server creates a note at .git/refs/notes/p4notes 
with the equivalent Perforce changelist number, so Git-controlled code 
and Perforce-controlled content can stay in sync.

gitk --all and Git Extensions (out of box) show all entries in the 
.git/refs/.  The p4notes entries are intermixed with the regular branch 
content.  This creates a HORRID visual mess.

I tried manually moving .git/refs/notes/p4notes to .git/p4/p4notes.

"git log --show-notes=p4/p4notes" fails, but assigning 
core.notesDisplayRef=p4/p4notes succeeds.

The best part is, the refs/* namespace is no longer cluttered with junk!

However, "git push origin p4/p4notes:p4/p4notes" fails with the error: 
Unable to push to unqualified destination: p4/p4notes.  The destination 
refspec neither matches an existing ref on the remote nor begins with 
refs/, and we are unable to guess a prefix based on the source ref.

Is there a way to make the "git push" work?

Thanks!

Josh
