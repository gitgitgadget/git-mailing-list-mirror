From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: how to undo a git merge?
Date: Fri, 11 Jul 2008 20:36:12 +0200
Message-ID: <200807112036.13745.jnareb@gmail.com>
References: <fa7d16350807110916x689e316fr6bae01f28e2e1acb@mail.gmail.com> <m34p6we43y.fsf@localhost.localdomain> <fa7d16350807111108y3a8a7c3di19598a56dbbcdc15@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: ff <ff@member.org>
X-From: git-owner@vger.kernel.org Fri Jul 11 20:38:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHNUj-0000oe-Qa
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 20:37:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752289AbYGKSg1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 14:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753420AbYGKSg1
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 14:36:27 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:15125 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753351AbYGKSg0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 14:36:26 -0400
Received: by ug-out-1314.google.com with SMTP id h2so110266ugf.16
        for <git@vger.kernel.org>; Fri, 11 Jul 2008 11:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=gjMa1cyrKeTa2aQChvXu2d93D5LrA0gUsuHxUqeBJIA=;
        b=wsO/42mRJqdwfRP6RCos/s/vVndB1oLtMyV2EyjCZ0jf6exDexiK60mYl6miBEjhef
         wi7/uoQkCm6Hx7YrZITRLGLz5W7le9qC7H0OoE0wN60skqoF2agx7CvhOyZV54QMRmx1
         A6yqRGxj9rYD3tTdSbTl6agqoeHWQSfBargj0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=AtMuMM3D39g3UCJ8kqJBpnMToznvFUBnqHs6Gw+0iMRAf9Nu4SH93tKkVTCcH9Egjr
         41KWpn2rFMfONeBVdB4Eb8jdwwZfVQAAes3bezrGoCJcIEmr5nlLUsSUFkdCJJvh6Gbz
         GbxXowwzCbBu+DeMu8f3YGGS/J21ECv6De12g=
Received: by 10.67.87.18 with SMTP id p18mr18445ugl.85.1215801383231;
        Fri, 11 Jul 2008 11:36:23 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.227.34])
        by mx.google.com with ESMTPS id k1sm1187011ugf.21.2008.07.11.11.36.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 11 Jul 2008 11:36:21 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <fa7d16350807111108y3a8a7c3di19598a56dbbcdc15@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88152>

ff (?) wrote:
> 
> I did see the -m option in the revert man page. It talks about
> "parent" and I did not understand what that is. Is parent the commit
> id of the merge commit? 

It is _number_ of parent.


   -m parent-number, --mainline parent-number
          Usually you cannot revert a merge because you do not know which side
          of  the  merge should be considered the mainline. This option speci-
          fies the parent number (starting from 1) of the mainline and  allows
          revert to reverse the change relative to the specified parent.


Merge commit has more than one parent.  What git-revert does, it
creates commit which reverts the changes, as if applying "reversal"
diff, "git diff -R <revision>^<parent-number> <revision>".

-- 
Jakub Narebski
Poland
