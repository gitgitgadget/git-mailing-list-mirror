From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 2/2] diff_index: honor in-index, not working-tree, .gitattributes
Date: Fri, 23 Sep 2011 12:21:55 +0200
Message-ID: <4E7C5DC3.8030409@alum.mit.edu>
References: <1316727861-90460-1-git-send-email-jaysoffian@gmail.com> <1316727861-90460-2-git-send-email-jaysoffian@gmail.com> <7v8vpgxkvb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 23 12:22:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R72tY-00026J-97
	for gcvg-git-2@lo.gmane.org; Fri, 23 Sep 2011 12:22:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752904Ab1IWKWI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Sep 2011 06:22:08 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:58700 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752147Ab1IWKWF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2011 06:22:05 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p8NALtbA026308
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 23 Sep 2011 12:21:55 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.21) Gecko/20110831 Lightning/1.0b2 Thunderbird/3.1.13
In-Reply-To: <7v8vpgxkvb.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181956>

On 09/23/2011 12:39 AM, Junio C Hamano wrote:
> [...] It
> would be a regression if the attributes mechanism is used for auditing
> purposes (as we start reading from a tree that is being audited using the
> very attributes it brings in), though.

I'm confused by this comment.

If an auditing system can be subverted by altering .gitattributes, then
I can do just as much harm by changing the .gitattributes in one commit
and making the "nasty" change in a second.  So any rigorous auditing
system based on .gitattributes would have to prevent me from committing
modifications to .gitattributes, in which case my commit will be
rejected anyway.

If by "auditing" you mean other less rigorous checks to which exceptions
are *allowed*, then it is preferable to add the exception in the same
commit as the otherwise-offending content, and therefore it is
*required* that the .gitattributes of the new tree be used when checking
the contents of that tree.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
