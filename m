From: Lachlan Deck <lachlan.deck@gmail.com>
Subject: Re: git svn branch tracking + ignore paths
Date: Wed, 28 Oct 2009 16:59:19 +1100
Message-ID: <19979334-07EB-48CA-8E62-4ECC5E1FA51C@gmail.com>
References: <41F0F1D6-4F99-4828-9259-1B2BDC689747@gmail.com>  <32541b130910271616ha861d08xa4b90b822d31f0ea@mail.gmail.com>  <AC7B0CB1-1B14-4EAE-A6B6-D0845EACE626@gmail.com> <32541b130910272220p59482397wef0d51b1adf1a5bd@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 28 07:01:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N31as-0001ce-A2
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 07:01:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756708AbZJ1F73 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 01:59:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756700AbZJ1F73
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 01:59:29 -0400
Received: from mail-yw0-f202.google.com ([209.85.211.202]:37047 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756679AbZJ1F72 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 01:59:28 -0400
Received: by ywh40 with SMTP id 40so382061ywh.33
        for <git@vger.kernel.org>; Tue, 27 Oct 2009 22:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:mime-version
         :content-type:from:in-reply-to:date:cc:content-transfer-encoding
         :message-id:references:to:x-mailer;
        bh=6AVhqowYJtjUo2U9XYD9dq0QHPLI2xwqwvtRA89lmsw=;
        b=n3QHMk856Qlq5S1RZ4gZAtdU9pRER9kXRkIz8MyPa//Q/NHow762oO6tT/fUxrZ9fM
         vayVxB35bZawH65XvjEz4H5I6J5E8TbWnVZlT+LmjrRzWD+slT0uW2TnfZ+YcYA2b4HF
         1u40WlpJxmTageEacDaDhN9MhHQBkDEtxnWkQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=wa6r/n0xX5ppDYW8mqtfpDhmdVNPzNNyAyk9zirtuHHqs2R2pzO6E062wG0kL2SZsB
         Gk4H1OpOgtIonqZayx/+zq8mxDd8lAniuHU3I0XD0wSzulhW5W1hA6pTSuDHBnYj6jdG
         yjHPtB6age03TTOnujdQAD2wnvXid3ARDZYxY=
Received: by 10.150.43.3 with SMTP id q3mr6147627ybq.73.1256709573536;
        Tue, 27 Oct 2009 22:59:33 -0700 (PDT)
Received: from ip-144.ish.com.au (ip-144.ish.com.au [203.29.62.144])
        by mx.google.com with ESMTPS id 7sm283013ywc.51.2009.10.27.22.59.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 27 Oct 2009 22:59:32 -0700 (PDT)
In-Reply-To: <32541b130910272220p59482397wef0d51b1adf1a5bd@mail.gmail.com>
X-Mailer: Apple Mail (2.1076)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131406>

On 28/10/2009, at 4:20 PM, Avery Pennarun wrote:

> On Tue, Oct 27, 2009 at 11:00 PM, Lachlan Deck  
> <lachlan.deck@gmail.com> wrote:
>> :) Sure. Essentially a project that I'm contributing to has both  
>> maven poms
>> and ant/lib-based configs (with the ant ones as default for  
>> eclipse .project
>> etc files). I'd like to be able to import the projects with maven  
>> into
>> Eclipse to work on things but without committing back changes to  
>> eclipse
>> .project/.classpath/.settings/*.
>>
>> So I'm hoping for a fairly transparent process.
>
> So which are the files you don't want to import from trunk?  It
> doesn't sound like there are any... so it's getting simpler already.

There are. I've currently (as a workaround) done the following within  
the main branch:
add the following to .git/info/exclude
.settings
target
.classpath
.project

The last two of these has no effect of course because .project  
and .classpath files already exist -- and thus are marked as modified.  
So I'm currently doing a git stash && git svn rebase && git svn  
dcommit && git stash pop


I'm also wanting to exclude 'lib' folders from trunk (as these are not  
needed).

> Also, can you just simply not commit any changes to the other files?
> That would be the easiest way to deal with committing back.

That's what I'm doing now I guess - but it means I can't share the  
project setups (specific for maven, for example) with anyone.

> The other
> option (slightly messier) is to change them in a single commit, and
> use git rebase to move that commit out of the way when you're about to
> push your changes back into svn.

Yeah that'd be a bit of a slippery slope.

with regards,
--

Lachlan Deck
