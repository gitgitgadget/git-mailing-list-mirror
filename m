From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH 3/3] prevent HEAD reflog to be interpreted as current branch reflog
Date: Fri, 2 Feb 2007 13:08:46 +0000
Message-ID: <200702021308.48599.andyparkins@gmail.com>
References: <Pine.LNX.4.64.0702011231300.3021@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>, Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 02 14:09:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCy9z-0008Qw-S1
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 14:09:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423045AbXBBNI5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 08:08:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423046AbXBBNI5
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 08:08:57 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:49593 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423045AbXBBNI4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 08:08:56 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1241852nfa
        for <git@vger.kernel.org>; Fri, 02 Feb 2007 05:08:55 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=HfgqPoiCtH04RPYqfmi6LCikCYFccKsEpUkRHrA36+SHBTJWirml6Vja7xIZ2y/8kTVMqzuvM78tbCYJl1NyxZxqm/lzosjEM5kM0UQYDGS/HzZZAVf6CKSLAM/5EkOypzZcWMH/XCwxUFHDLD4n/+f5FXdzWDtxKLdNfADepVE=
Received: by 10.49.8.15 with SMTP id l15mr4620991nfi.1170421733629;
        Fri, 02 Feb 2007 05:08:53 -0800 (PST)
Received: from davejones ( [194.70.53.227])
        by mx.google.com with ESMTP id e33sm5332597ugd.2007.02.02.05.08.51;
        Fri, 02 Feb 2007 05:08:51 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <Pine.LNX.4.64.0702011231300.3021@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38495>

On Thursday 2007 February 01 17:33, Nicolas Pitre wrote:

> The work in progress to enable separate reflog for HEAD will make it
> independent from reflog of any branch HEAD might be pointing to. In
> the mean time disallow HEAD@{...} until that work is completed. Otherwise
> people might get used to the current behavior which makes HEAD@{...} an
> alias for <current_branch>@{...} which won't be the case later.

I hadn't really appreciated the implications of all this HEAD reflog stuff 
until now.

Please, please, HEAD@{} should /always/ be an alias for <current_branch>@{}.

There is one special case:  when head is detached, <current_branch> would then 
be the "unnamed branch" for reflog purposes; personally I'd like that stored 
in .git/logs/DETACHED_HEAD or similar - in particular not in .git/logs/HEAD.



Andy

-- 
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com
