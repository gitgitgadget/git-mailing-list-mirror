From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Why the default action for pull is merge, but not rebase?
Date: Wed, 27 Oct 2010 11:57:24 -0500
Message-ID: <20101027165723.GC11069@burratino>
References: <AANLkTinLbaE6He-bxA_+CT6J5uWmZSgodGs6SXO7eqnr@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 27 18:57:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PB9Jg-00035g-9D
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 18:57:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752046Ab0J0Q5a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Oct 2010 12:57:30 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:60852 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751403Ab0J0Q53 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 12:57:29 -0400
Received: by iwn10 with SMTP id 10so1069826iwn.19
        for <git@vger.kernel.org>; Wed, 27 Oct 2010 09:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=SwJGQkd1qRMkUftuhGK3ZVVmjXgXJpM/5ZQ74GTHifc=;
        b=udTn2gzAXnwddSBPGEozvmbe7jM2b+VQozHxy256iSgF2o7o+tNI9b9+YyIiHqYbx6
         Qs2jNYVHVkFrzm/T9ETYsV/dJGnYeIBRNZsshfZ/6rUWr/fDEa1/cyCzX9iI8AvzqX2P
         Vn4OrTM18kFlgJpLlabB4eLkrxyVWvaA8cT24=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=SMTNOb25agq9omyfv4GyX7NO0f1/iXoqRhH/goolXkmxD2mmTwrUvR/JQaUK12z8ZT
         UX7/RxewG6T3LWR26tAzDaSamQadbpaVFYtgR5DZ2LNHYKqwgxaHiCg/C6jnvFl/25bw
         KL3kM+vtCiTE4rOrNb27k8/jsXUDhEJgf6HSc=
Received: by 10.231.173.138 with SMTP id p10mr642994ibz.143.1288198649350;
        Wed, 27 Oct 2010 09:57:29 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id 34sm11612796ibi.20.2010.10.27.09.57.27
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 27 Oct 2010 09:57:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTinLbaE6He-bxA_+CT6J5uWmZSgodGs6SXO7eqnr@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160100>

Eugene Sajine wrote:

>               So, why not to rebase?

An interesting question.

Rebasing results in untested commits.  If this is a patch series
for submission, that's fine, because you will be extensively
testing each patch anyway or indicating to reviewers that that
needs to be done (right?).  But if it's a long-lived branch then
such repeated testing work can be a serious hassle.
https://git.wiki.kernel.org/index.php/GitFaq#What_is_the_difference_between_a_merge_and_a_rebase.3F

A public branch that is regularly rebased is hard to follow
("git log foo@{1}..foo") and build on.
http://www.kernel.org/pub/software/scm/git/docs/git-rebase.html#_recovering_from_upstream_rebase

Code consumers often want clean history, but that really means
(a) clean and (b) history.
http://thread.gmane.org/gmane.comp.video.dri.devel/34739/focus=34744

Hope that helps.
