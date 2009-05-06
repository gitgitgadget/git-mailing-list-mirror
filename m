From: Chris Johnsen <chris_johnsen@pobox.com>
Subject: Re: [PATCH] Fixed man entities.
Date: Tue, 5 May 2009 19:11:21 -0500
Message-ID: <2FF716E3-8C58-4FF5-B0FD-A694E36238EC@pobox.com>
References: <1241560283-13529-1-git-send-email-raorn@altlinux.org>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Dmitry V. Levin" <ldv@altlinux.org>
To: "Alexey I. Froloff" <raorn@altlinux.org>
X-From: git-owner@vger.kernel.org Wed May 06 02:12:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1UkD-0004Gg-MC
	for gcvg-git-2@gmane.org; Wed, 06 May 2009 02:12:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753656AbZEFAMH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2009 20:12:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753044AbZEFAME
	(ORCPT <rfc822;git-outgoing>); Tue, 5 May 2009 20:12:04 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:39696 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752700AbZEFAME (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 May 2009 20:12:04 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 9FD0514A1C;
	Tue,  5 May 2009 20:11:59 -0400 (EDT)
Received: from [192.168.1.241] (unknown [76.222.25.70]) (using TLSv1 with
 cipher AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 269A614A1B; Tue, 
 5 May 2009 20:11:57 -0400 (EDT)
In-Reply-To: <1241560283-13529-1-git-send-email-raorn@altlinux.org>
X-Mailer: Apple Mail (2.753.1)
X-Pobox-Relay-ID: 847DBF5C-39D2-11DE-9095-D766E3C8547C-07245699!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118320>

On 2009 May 5, at 16:51, Alexey I. Froloff wrote:
> It has to be just "\fR", "\fB", ".sp" and ".br", not weird unicode
> stuff.

Which versions of asciidoc and docbook-xsl are you using?

As the filename and comments imply, those weird Unicode characters  
were specifically for docbook-xsl 1.72.0. They were used in a  
"misguided" character replacement scheme (this behavior was reverted  
after 1.72.0). See the 'manpage' sections of the docbook-xsl release  
notes for some info on this:

<http://docbook.sourceforge.net/release/xsl/current/RELEASE- 
NOTES.html#V1.72.0_Manpages>
<http://docbook.sourceforge.net/release/xsl/current/RELEASE- 
NOTES.html#V1.73.0_Manpages>

If you are not using docbook-xsl 1.72.0, you should not be using  
manpage-1.72.xsl.

There have been some changes to the documentation generation options  
since 1.6.2. If you are able, get the most recent 1.6.3 release  
candidate, read the asciidoc and docbook-xsl comments in the  
Makefile, define your make settings accordingly, and try again  
(asciidoc 8.4.1 is broken for at least one of the pages, 8.4.2 and  
later seem OK).

-- 
Chris
