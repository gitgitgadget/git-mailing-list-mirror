From: Jonathan Nieder <jrnieder@gmail.com>
Subject: jn/svn-fe (Re: What's cooking in git.git (Jan 2011, #01; Tue, 4))
Date: Tue, 4 Jan 2011 18:01:58 -0600
Message-ID: <20110105000157.GA3138@burratino>
References: <7vipy4dy8y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Barr <david.barr@cordelta.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 05 01:02:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaGpR-0006uv-JA
	for gcvg-git-2@lo.gmane.org; Wed, 05 Jan 2011 01:02:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751630Ab1AEACH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jan 2011 19:02:07 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:44285 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751623Ab1AEACG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jan 2011 19:02:06 -0500
Received: by vws16 with SMTP id 16so6290751vws.19
        for <git@vger.kernel.org>; Tue, 04 Jan 2011 16:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=uItRdDF1DuVWFqkYN4V+Anwsh/ldqGJqsg6i07xRcd0=;
        b=m9nD4fiVIAiMbnFGsLYra343VKB7DwIVw0ggxrzcfpdwJ5I2v4mRqGHOAXh8TTCSNg
         wfg+7gZnhcAI0hL9JbgPEEK7HQVnrMdgWzD8IxN1MnAyaBqWwrK5eB2Hm/SmFnU4lk8h
         0vPs0S4evwzofi08QE70V0+NSwNSG/yc+ogf8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=oQSsiJVaWHrpIUP2G31XCtIp/eu05uxXbV/Uq1tEc9Ypfdo+pRrftEXwN/Aylix+pY
         5Q4j+RdGqOcmpMFOg8lvgV8fmYo/qENfRJGLwP+AxOf5viv/rcUF3bduXKAtjMzQGMJY
         Z/J33GvI7WzSoyGGmliTMAZuxvDwqeKEQM+eo=
Received: by 10.220.177.4 with SMTP id bg4mr107890vcb.89.1294185725938;
        Tue, 04 Jan 2011 16:02:05 -0800 (PST)
Received: from burratino (adsl-69-209-72-219.dsl.chcgil.sbcglobal.net [69.209.72.219])
        by mx.google.com with ESMTPS id w7sm4739737vch.20.2011.01.04.16.02.03
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 04 Jan 2011 16:02:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vipy4dy8y.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164529>

Junio C Hamano wrote:

> * jn/svn-fe (2010-12-06) 18 commits
>  - vcs-svn: Allow change nodes for root of tree (/)
>  - vcs-svn: Implement Prop-delta handling
>  - vcs-svn: Sharpen parsing of property lines
>  - vcs-svn: Split off function for handling of individual properties
>  - vcs-svn: Make source easier to read on small screens
>  - vcs-svn: More dump format sanity checks
>  - vcs-svn: Reject path nodes without Node-action
>  - vcs-svn: Delay read of per-path properties
>  - vcs-svn: Combine repo_replace and repo_modify functions
>  - vcs-svn: Replace = Delete + Add
>  - vcs-svn: handle_node: Handle deletion case early
>  - vcs-svn: Use mark to indicate nodes with included text
>  - vcs-svn: Unclutter handle_node by introducing have_props var
>  - vcs-svn: Eliminate node_ctx.mark global
>  - vcs-svn: Eliminate node_ctx.srcRev global
>  - vcs-svn: Check for errors from open()
>  - vcs-svn: Allow simple v3 dumps (no deltas yet)
>  - vcs-svn: Error out for v3 dumps
> 
> Some RFC patches, to give them early and wider exposure.  Perhaps drop
> these during the -rc period?

The bottom one is a useful bugfix (to get an error message instead of
succeeding with nonsensical mode and blobs when the user tries to
import a --deltas dump) and should ideally be applied for v1.7.4.

The rest are a new feature (a surprisingly non-buggy one) and I don't
mind if you drop them.
