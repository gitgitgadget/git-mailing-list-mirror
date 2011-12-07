From: Vijay Lakshminarayanan <laksvij@gmail.com>
Subject: Re: Query on git commit amend
Date: Wed, 07 Dec 2011 20:36:03 +0530
Message-ID: <87ehwgv2uc.fsf@gmail.com>
References: <4EDDD0E4.6040003@st.com> <87fwgxwvn9.fsf@gmail.com>
	<7vobvlfowk.fsf@alter.siamese.dyndns.org> <87wra9und4.fsf@gmail.com>
	<4EDEE988.2070902@st.com> <20111207045325.GA22990@atjola.homenet>
	<4EDEFD66.4020404@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Shiraz HASHIM <shiraz.hashim@st.com>,
	Vipin KUMAR <vipin.kumar@st.com>
To: Viresh Kumar <viresh.kumar@st.com>
X-From: git-owner@vger.kernel.org Wed Dec 07 16:06:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYJ4a-00085b-MM
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 16:06:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756251Ab1LGPGI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Dec 2011 10:06:08 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:47316 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755818Ab1LGPGG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2011 10:06:06 -0500
Received: by iakc1 with SMTP id c1so1052347iak.19
        for <git@vger.kernel.org>; Wed, 07 Dec 2011 07:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=zaI7x6tJJJQzRhZcMex/HYaIlhNEHCRCqEIG61hnPuQ=;
        b=kXA1AwdwbN3cJUF4fM03COEPbnVsj3ZtIGeCOggVHl8c8rxc2Q5oxwmehkNR1a2qkK
         AQiUk9MT7Rqxbk0CY66zoavRIiCDkgkKRLlw5Q/OrwT3RHh024SaOKPU+3mIs3OVVr53
         EGbqajC9a5+rPYQSFMC2zHU15k5LaArvZiv5Y=
Received: by 10.231.81.136 with SMTP id x8mr4653664ibk.10.1323270366252;
        Wed, 07 Dec 2011 07:06:06 -0800 (PST)
Received: from BALROG ([59.92.48.171])
        by mx.google.com with ESMTPS id ew6sm4235717igc.4.2011.12.07.07.06.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 07 Dec 2011 07:06:05 -0800 (PST)
In-Reply-To: <4EDEFD66.4020404@st.com> (Viresh Kumar's message of "Wed, 7 Dec
	2011 11:15:10 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (windows-nt)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186462>

Viresh Kumar <viresh.kumar@st.com> writes:

[snip]

> Now, whats the benefit of 
>
> GIT_EDITOR=cat git commit --amend
>
> over
>
> git commit --amend -C HEAD
>
> ?

The latter preserves the original timestamp of the commit and other
environment variables like GIT_COMMITTER_NAME GIT_COMMITTER_EMAIL
whereas GIT_EDITOR=cat (or true or :) are equivalent to opening up the
commit in an editor and so consider these variables during execution.

For instance, you could say

$ GIT_EDITOR=cat GIT_COMMITTER_EMAIL=foo@bar.baz git commit --amend

and the commiter email would be set to foo@bar.baz

-- 
Cheers
~vijay

Gnus should be more complicated.
