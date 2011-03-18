From: Todd Zullinger <tmz@pobox.com>
Subject: [PATCH] completion: Add space to PS1 when showing upstream
Date: Fri, 18 Mar 2011 11:02:22 -0400
Message-ID: <20110318150222.GB26236@inocybe.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Andrew Sayers <andrew-git@pileofstuff.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 18 16:02:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0bCK-0005NZ-5k
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 16:02:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756402Ab1CRPCg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2011 11:02:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62773 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753295Ab1CRPCe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2011 11:02:34 -0400
X-Greylist: delayed 638 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Mar 2011 11:02:34 EDT
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A7E6D27F7;
	Fri, 18 Mar 2011 11:02:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
	:cc:subject:message-id:mime-version:content-type; s=sasl; bh=zXi
	TCEa4BlriQks/bt/Ah0pHSI4=; b=ZTXgWehLJttQpcTocJEioWoqC096abJpat0
	KfWPg9OBRaVd5lnybOaH0XlnHNHC/KJ7vxX+0eizRNENJdWzrUOvdygIr9OpP0px
	Qs4xWrg/c69UyA3vurqg+agwNZAccz3zpD0bcIgu/hQOItlkmHIryScJJbTljm4r
	GO9WRUa4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
	:subject:message-id:mime-version:content-type; q=dns; s=sasl; b=
	YnEAd3iK2+nGuUr8j1A9W4eXYbgyKkwIHqpW9tl539Ht/SVpLR/qQd1MV2iQQKug
	pqsg8GVgotjxwrY0nWwAQezZBY/BMaFpCcEvDXokWLGhEUOIJk5Aa0AgSXtjUj+t
	KfH6IARC2ACvYHnc0N7n3vFRTYv3a483aa1//Zbvy3U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D34127F6;
	Fri, 18 Mar 2011 11:02:28 -0400 (EDT)
Received: from inocybe.localdomain (unknown [98.117.251.177]) (using TLSv1
 with cipher AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CFF3F27F4; Fri, 18 Mar 2011
 11:02:24 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Pobox-Relay-ID: BDCD1048-5170-11E0-8A5C-C1F4E168B6F2-09356542!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169330>

Depending on whether other changes were present or displayed in PS1, the
prompt may have lacked a space between the branch and the upstream
marker.  Add this space as needed so the branch name and upstream state
aren't confusingly mixed.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
 contrib/completion/git-completion.bash |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 0b0b913..e5af5f6 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -312,6 +312,7 @@ __git_ps1 ()
 		fi
 
 		local f="$w$i$s$u"
+		[[ -z $f ]] && p="${p:+ $p}"
 		printf "${1:- (%s)}" "$c${b##refs/heads/}${f:+ $f}$r$p"
 	fi
 }
-- 
1.7.4.1

-- 
Todd        OpenPGP -> KeyID: 0xBEAF0CE3 | URL: www.pobox.com/~tmz/pgp
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Giving money and power to government is like giving whiskey and car
keys to teenage boys.
    -- P.J. O'Rourke
