From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: How to use git attributes to configure server-side checks?
Date: Fri, 23 Sep 2011 15:31:12 +0200
Message-ID: <4E7C8A20.8050100@alum.mit.edu>
References: <33047451.27244.1316782148569.JavaMail.root@mail.hq.genarts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git discussion list <git@vger.kernel.org>,
	Jay Soffian <jaysoffian@gmail.com>, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Stephen Bash <bash@genarts.com>
X-From: git-owner@vger.kernel.org Fri Sep 23 15:31:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R75qj-00007e-Rz
	for gcvg-git-2@lo.gmane.org; Fri, 23 Sep 2011 15:31:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754048Ab1IWNbZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Sep 2011 09:31:25 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:60119 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752987Ab1IWNbZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2011 09:31:25 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p8NDVCfM013351
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 23 Sep 2011 15:31:13 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.21) Gecko/20110831 Lightning/1.0b2 Thunderbird/3.1.13
In-Reply-To: <33047451.27244.1316782148569.JavaMail.root@mail.hq.genarts.com>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181965>

On 09/23/2011 02:49 PM, Stephen Bash wrote:
> We're in the process of a similar change over (we're dealing with EOL
> rather than indents), but I attacked it from a different angle...  I
> wrote our update script to examine modified files and ensure
> compliance (diff-tree -r, iterate over blobs).  That way legacy files
> are left alone (even in master), but active development must live up
> to the current rules.  Is there a reason you need to go tree-by-tree
> rather than file-by-file?

I want to avoid code churn, especially in third-party code.  With your
solution, I believe that we would be forced to entirely clean up any
file that we needed to touch.  The resulting code churn would make
integrating future upstream releases a nightmare.

For some kinds of checks, one could only check that the *lines* changed
satisfy the new rules.

But rather than thinking up workarounds, it seems like a better idea to
fix git to handle .gitattributes correctly.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
