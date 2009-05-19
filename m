From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: any way to apply tag across all branches in repository?
Date: Tue, 19 May 2009 12:05:29 -0500
Message-ID: <Y0WmOpNg_9ptwbJ3VHYrzAgFtDvPi5pn4Tz-0w5Phhlo9frjieUaeA@cipher.nrlssc.navy.mil>
References: <4A12DDB9.60608@nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Chris Friesen <cfriesen@nortel.com>
X-From: git-owner@vger.kernel.org Tue May 19 19:05:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6Sl7-00066x-4q
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 19:05:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752827AbZESRFf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2009 13:05:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752451AbZESRFf
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 13:05:35 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:55267 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752136AbZESRFe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2009 13:05:34 -0400
Received: by mail.nrlssc.navy.mil id n4JH5VdV027319; Tue, 19 May 2009 12:05:31 -0500
In-Reply-To: <4A12DDB9.60608@nortel.com>
X-OriginalArrivalTime: 19 May 2009 17:05:30.0028 (UTC) FILETIME=[0369EEC0:01C9D8A4]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119552>

Chris Friesen wrote:
> Hi all,
> 
> I'm hoping you can help me out...please CC me on replies, I'm not
> subscribed to the list.
> 
> We have a piece of software with a "main" branch and multiple
> architecture-specific "target" branches.  At each "official" compile,
> we'd like to tag the commits that went into that compile with an identifier.
> 
> Using tags normally requires that the tag be assigned to each branch
> individually--is there any way to apply some sort of designator to the
> head of each branch in the repository all at once rather than doing it
> separately for each branch?

If I understand you correctly, you are doing your primary development on
the "main" branch and then merging this into the architecture specific
branches which contain additional architecture specific changes.

All you need to do is tag the "main" branch.  Actually, you are tagging
the commit that the branch currently points at.  When this branch is
merged into the other branches, they will also contain this commit, and
'git describe' will use the tag you created when generating the version
string.

-brandon
