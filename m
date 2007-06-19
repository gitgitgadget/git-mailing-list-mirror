From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: StGIT rebasing safeguard
Date: Tue, 19 Jun 2007 23:18:56 +0100
Message-ID: <b0943d9e0706191518o6396a2c5u1fb4f0953dc85aa@mail.gmail.com>
References: <20070611003117.4736.33551.stgit@gandelf.nowhere.earth>
	 <20070611003330.4736.69293.stgit@gandelf.nowhere.earth>
	 <b0943d9e0706121509j5088e164iadedb561501d6a55@mail.gmail.com>
	 <20070613203821.GQ6992@nan92-1-81-57-214-146.fbx.proxad.net>
	 <20070614213032.GR6992@nan92-1-81-57-214-146.fbx.proxad.net>
	 <b0943d9e0706191512l5f19b80v5b5be9151be13025@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Yann Dirson" <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Wed Jun 20 00:20:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0m3J-0002MF-Ef
	for gcvg-git@gmane.org; Wed, 20 Jun 2007 00:19:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758327AbXFSWS6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Jun 2007 18:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758318AbXFSWS6
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jun 2007 18:18:58 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:38104 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758280AbXFSWS5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2007 18:18:57 -0400
Received: by ug-out-1314.google.com with SMTP id j3so218567ugf
        for <git@vger.kernel.org>; Tue, 19 Jun 2007 15:18:56 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Y++OmmdQhZfS5Qj4qJKhlO9XukiqmIYCq18qoP3swf4HuAXu/kTHWc70DuuhLOeZUrIeNdPNRH9hI9ZI5aqgLrSV/mmdTP2hohjDF6eUxoVnJJt8EFyZ4s+LW7x8IwGkg9QU5Triyij8/oLMcEwM1FAO/LJRQLpttaN5apgo2TM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SMS5LqIwg6zOKimFJw4Zcr11ej1hnMhUo9sJluQ82ztqBHJdUaqVCMytmGtybdaE6DfW5Ji+4SNj4zFgXlHqeq2wxbmLgjOLiiU005e99m92eBHc/OAnNf6Ozk3TFtTudPciCd9x0gKYaNVmv2c/MQL1a3fMuOvJq015Bmbu/4w=
Received: by 10.67.32.16 with SMTP id k16mr741953ugj.1182291536103;
        Tue, 19 Jun 2007 15:18:56 -0700 (PDT)
Received: by 10.66.255.6 with HTTP; Tue, 19 Jun 2007 15:18:56 -0700 (PDT)
In-Reply-To: <b0943d9e0706191512l5f19b80v5b5be9151be13025@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50515>

On 19/06/07, Catalin Marinas <catalin.marinas@gmail.com> wrote:
> On 14/06/07, Yann Dirson <ydirson@altern.org> wrote:
> > When the parent branch is a rewinding one (eg. an stgit stack), then
> > the old version of the patch will be turned to unreachable by
> > pull/rebase, and we probably have even no way of telling stgit that it
> > is indeed expected, since the parent stack is a local one.  My own
> > workflow on StGIT is affected by the issue, since my "bugs" stack is
> > forked off my "master" stack (but hopefully an hydra will help me ;).
>
> If I understand correctly, is this the case where you do a 'stg
> commit'? This command is meant for branches that are never rebased
> (i.e. my master stgit branch). For this branch one wouldn't have a
> remote branch configured and hence git fetch shouldn't do anything.

I got confused - you were talking about 'stg rebase' rather than the
'pull' strategy. But the question remains - are you referring to the
user running 'stg commit' and losing this commit after a rebase?

The rebase should be equivalent to a git-reset but with
popping/pushing of the patches one the stack. Once committed, the
patch is no longer managed by StGIT and therefore we shouldn't care.

-- 
Catalin
