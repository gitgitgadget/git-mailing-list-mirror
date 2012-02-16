From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv2 1/3] gitweb: Deal with HEAD pointing to unborn branch in "heads" view
Date: Thu, 16 Feb 2012 23:41:09 +0100
Message-ID: <201202162341.09712.jnareb@gmail.com>
References: <1329320203-20272-1-git-send-email-jnareb@gmail.com> <1329320203-20272-2-git-send-email-jnareb@gmail.com> <7vr4xuy12f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, rajesh boyapati <boyapatisrajesh@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 16 23:41:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RyA0s-0006mM-RH
	for gcvg-git-2@plane.gmane.org; Thu, 16 Feb 2012 23:41:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755109Ab2BPWlN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Feb 2012 17:41:13 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:45986 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754493Ab2BPWlM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Feb 2012 17:41:12 -0500
Received: by eaah12 with SMTP id h12so1088223eaa.19
        for <git@vger.kernel.org>; Thu, 16 Feb 2012 14:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=+OX4ob/AR4HSUXJIBNp4nleUhqlNixKocZJX/Liu+oc=;
        b=RoaUXdJ8N/1GAJToE/DXf7sDX7t+6DBYzyt5kfcJfzPMTSe3Rvv8DCVVgdQ9HQvGEt
         /+cc5baduJp9Mt+SoeKTlorp1mz1UlizM7ef8iOKrAzOunwFJZN8K+xGtyyE7BchgbYi
         BFr3wCZcz40eS6wStySmbvSXE6mKbBgupqAaQ=
Received: by 10.14.121.66 with SMTP id q42mr2496622eeh.84.1329432070618;
        Thu, 16 Feb 2012 14:41:10 -0800 (PST)
Received: from [192.168.1.13] (abwb118.neoplus.adsl.tpnet.pl. [83.8.225.118])
        by mx.google.com with ESMTPS id v51sm30402137eef.2.2012.02.16.14.41.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 16 Feb 2012 14:41:09 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vr4xuy12f.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190918>

On Thu, 16 Feb 2012, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > Gitweb has problems if HEAD points to an unborn branch, with no
> > commits on it yet, but there are other branches present (so it is not
> > newly initialized repository).
> 
> It would be more readable if you rephrase the vague "has problems" with a
> concrete description of what the problem is.

Sorry about this.

The problem is that gitweb would generate the following warning, writing
it in web server logs:

  Use of uninitialized value in string eq

> Also, drop the " (so it is ...)"  part, which does not add much useful
> information.  Your next paragraph describes how a repository can come to
> this state anyway.

O.K.

Anyway the description that repository might be in such a strange state
might be more important that the patch in itself...

> > This can happen if non-bare repository (with default 'master' branch)
> > is updated not via committing but by other means like push to it, or
> > Gerrit.  It can happen also just after running "git checkout --orphan
> > <new branch>" but before creating any new commit on this branch.
> >
> > This commit adds test and fixes the issue of being on unborn branch
> > (of HEAD not pointing to a commit) in "heads" view, and also in
> > "summary" view -- which includes "heads" excerpt as subview.
> 
> The reader has not seen anything more than "has problems" at this point,
> so "fixes the issue of ..." is not very helpful.  You could have just said
> "adds tests and fixes it", if you said that the unspecified "problems"
> apear in "heads" and "summary" view at the beginning of the log message.

O.K.


Should I re-roll this patch with improved commit message?
-- 
Jakub Narebski
Poland
