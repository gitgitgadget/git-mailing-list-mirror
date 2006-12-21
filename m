From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [RFC/PATCH] Implement poor-man's submodule support in pre-commit hook
Date: Thu, 21 Dec 2006 08:39:34 +0000
Message-ID: <200612210839.35980.andyparkins@gmail.com>
References: <200612200901.30584.andyparkins@gmail.com> <7vslfae4uv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Dec 21 09:39:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxJSt-000686-FX
	for gcvg-git@gmane.org; Thu, 21 Dec 2006 09:39:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422861AbWLUIjn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 03:39:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422833AbWLUIjn
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 03:39:43 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:24997 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422861AbWLUIjm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 03:39:42 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2546628uga
        for <git@vger.kernel.org>; Thu, 21 Dec 2006 00:39:41 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ZK9tEl2W46wWfvf5QfbpiKXZucWHGCgkxWSU4Vt/8jX94dukH+tVBLl7FIeUlgg544sNrUaohK3T1IVLuRVkX3ugATRR4PTUT4y5yaLBjcQ1skHTYmspn3u1hSIPlMw2qZXkFvCB318bZoN9sUfOhsEQO1RGJ/OHPxppTr+7f+o=
Received: by 10.66.221.6 with SMTP id t6mr10468310ugg.1166690380943;
        Thu, 21 Dec 2006 00:39:40 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id e23sm13753632ugd.2006.12.21.00.39.40;
        Thu, 21 Dec 2006 00:39:40 -0800 (PST)
To: git@vger.kernel.org
User-Agent: KMail/1.9.5
In-Reply-To: <7vslfae4uv.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35028>

On Wednesday 2006 December 20 19:37, Junio C Hamano wrote:

> I do not think these are insurmountable.

Me either.  I wasn't really sure how warmly these patches would be received, 
so thought some small patches that make the feature highly might be more 
palatable.  I actually don't think that the hook templates is the right place 
for this work; submodule support is not something you would customise 
per-repository, and so the hook scripts are manifestly the wrong place for 
this.

> As you fix them and enhance the support, I suspect you would
> want a separate command to manage .gitmodule file and submodules
> referenced by it.  I think it would be better to keep the patch
> to the template to the minimum (for example, run "git submodule
> update" if there is .gitmodules file at the toplevel), and
> implement the body of the processing in "git-submodule.sh", or
> something like that.

That's an interesting idea.  I was thinking that git-commit itself would have 
been the final target; but I certainly don't have any problem with a separate 
command.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com
