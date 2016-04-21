From: Olaf Hering <olaf@aepfle.de>
Subject: Re: history damage in linux.git
Date: Thu, 21 Apr 2016 17:54:08 +0200
Message-ID: <20160421155408.GE3186@aepfle.de>
References: <20160421113004.GA3140@aepfle.de>
 <20160421131916.GB1589@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Thu Apr 21 17:54:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atGvq-0001fY-9G
	for gcvg-git-2@plane.gmane.org; Thu, 21 Apr 2016 17:54:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752261AbcDUPyO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2016 11:54:14 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:49685 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751761AbcDUPyM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2016 11:54:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1461254049; l=437;
	s=domk; d=aepfle.de;
	h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Subject:Cc:To:From:Date;
	bh=lIqYnzsjsu/FVNbPl8/eO08qOzAO39vWRijq0BlN6HM=;
	b=ClLQfDUfS2wQdllv6nFV2+OXU4H1JSaWHyIf3QYe6uZpsuK/hgo4QwZr2OCwfjjMZ2i
	H9x9+qDDrwQBw/A/k6gItiM7k/xWxqyRJJVVKVNL2+wvlHcvZbPS4Lu8SwV1QUCtsqlPz
	uNzbQOwGnmgaoEQKRVyOV+e1s2n51BsQ8Ls=
X-RZG-AUTH: :P2EQZWCpfu+qG7CngxMFH1J+yackYocTD1iAi8x+OWtrWFmrD4pjkQ2b4qvS
X-RZG-CLASS-ID: mo00
Received: from aepfle.de (charybdis-ext.suse.de [195.135.221.2])
	by post.strato.de (RZmta 37.24 AUTH)
	with ESMTPA id n00524s3LFs8Jk5;
	Thu, 21 Apr 2016 17:54:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20160421131916.GB1589@serenity.lan>
User-Agent: Mutt/1.6.0 (6623)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292118>

On Thu, Apr 21, John Keeping wrote:

> 	$ git tag --contains aed06b9cfcabf8644ac5f6f108c0b3d01522f88b

Thanks for that, I did not know this variant.

Unless git does not do it for me, I may hackup my script like that to
find the earlierst tag:

 for i in `git tag --contains aed06b9cfcabf8644ac5f6f108c0b3d01522f88b`
 do
  git log --max-count=1 --oneline --pretty=%ct:%h:$i $i | cat
 done | sort -n | sed 's@^.*:@@;q'

Olaf
