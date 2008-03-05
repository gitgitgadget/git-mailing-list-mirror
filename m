From: "Imran M Yousuf" <imyousuf@gmail.com>
Subject: Re: [PATCH/RFC v2] git-submodule: multi-level module definition
Date: Wed, 5 Mar 2008 14:03:13 +0600
Message-ID: <7bfdc29a0803050003j625b21a0m1f9af3f5554ef22@mail.gmail.com>
References: <1204646661-7776-1-git-send-email-pkufranky@gmail.com>
	 <7bfdc29a0803041917j16112e80uc0b21707bdfd3fe@mail.gmail.com>
	 <46dff0320803042315t2d89eb6fl325b4b2ef8ddbc44@mail.gmail.com>
	 <46dff0320803042316m1921f657wacf63a63491bbda0@mail.gmail.com>
	 <7bfdc29a0803042340k2ea6fc1cq435205f1da71bbb0@mail.gmail.com>
	 <46dff0320803042353u7e2e1789x514a2f81b7204277@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Ping Yin" <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 05 09:03:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWobT-0000UZ-De
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 09:03:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756777AbYCEIDQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 03:03:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757512AbYCEIDQ
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 03:03:16 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:4834 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755744AbYCEIDP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 03:03:15 -0500
Received: by nf-out-0910.google.com with SMTP id g13so792159nfb.21
        for <git@vger.kernel.org>; Wed, 05 Mar 2008 00:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=N1oNF6fHp59GAKSmpiUnq9Uzogkdbb4bn74m2YUBoMg=;
        b=X2Gf7wI6q7oNUq+5v8cTBUEY/E9VkdxlmNpz8NTvkqlyrgXueY0vIly0LVhtpgHYHMXZJ+eu+ZHZbaCRBsUkUNYG5WLVLHTIkM2xQ+0fmViGMIDjQWfbOs8M8VJLeGHjIXPc/DkxNFqs3reKn3ux1nOZb1cebfPcuckjjp6aPfQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=b40zjkcUm8ost85jlIK3qNHvHYY0PJNyiAjlatTggZZppanH+sGKb9KnCcLA0cET7Lp0GIpzvj7Cyd0+LNelK8xOOhuuEdIAVgUoy9fsT8sm7Zh8fU49g7g2HZX+j4GSNV6jDxvcpm9crGgCQGsVdlLVf9UZriUsZPvP9EyLia0=
Received: by 10.78.129.16 with SMTP id b16mr5432834hud.34.1204704193798;
        Wed, 05 Mar 2008 00:03:13 -0800 (PST)
Received: by 10.78.75.8 with HTTP; Wed, 5 Mar 2008 00:03:13 -0800 (PST)
In-Reply-To: <46dff0320803042353u7e2e1789x514a2f81b7204277@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76188>

On Wed, Mar 5, 2008 at 1:53 PM, Ping Yin <pkufranky@gmail.com> wrote:
> On Wed, Mar 5, 2008 at 3:40 PM, Imran M Yousuf <imyousuf@gmail.com> wrote:
>  > On Wed, Mar 5, 2008 at 1:16 PM, Ping Yin <pkufranky@gmail.com> wrote:
>  >  >
>  >  > On Wed, Mar 5, 2008 at 11:17 AM, Imran M Yousuf <imyousuf@gmail.com> wrote:
>  >  >   > On Tue, Mar 4, 2008 at 10:04 PM, Ping Yin <pkufranky@gmail.com> wrote:
>  >  >
>  >  >  >  >  .gitmodules with with multiple level of indirection
>  >  >   >  >  ------------------------------------------------------
>  >  >   >  >  [submodule "service"]
>  >  >   >  >    submodule = crawler
>  >  >   >  >    submodule = search
>  >  >   >  >  [submodule "crawler"]
>  >  >   >  >    submodule = util
>  >  >   >  >    submodule = imcrawter
>  >  >   >  >  [submodule "search"]
>  >  >   >  >    submodule = util
>  >  >   >  >    submodule = imsearch
>  >  >
>  >  >   >
>  >  >
>  >  >  >  At this point I have few questions - Will Service have its own tree
>  >  >   >  besides its submodules?
>  >  >   Now, service itself is not a submodule, and service is just a logical
>  >  >   name for a group of moduels.
>  >  >
>  >  If I am not mistaken I can do it now as well, by "git submodule add
>  >  repo path". What would be the difference with this and your approach?
>  No difference at this point. But using logical name can help add
>  modules in batch such as "git submodule add -m service"
>

Ok I am working on something similar a recurse command for git
submodule; thats why I asked it. Hopefully will appear in mailing list
tomorrow :).

> >
>  > >
>  >  >   >
>  >  >   >  For your above example of .gitmodules hierarchy if I issue "git
>  >  >   >  submodule init -m util", can you please explain what will be the
>  >  >   >  outcome, i.e. which modules will be initialized.
>  >  >   >
>  >  >   Only the util module will be initialized using the path and url in
>  >  >   submodule.util.{path,url}
>  >  >
>  >  I got that part as thats how git-submodules currently work; Actually
>  >  what I wanted to know is as util is referenced to several logical
>  >  submodules, will they be initialized as well? that means wherever util
>  >  is referenced it will be initialized; is that what it means?
>  >  >   >
>  Since the user designate only util module, we needn't automatically
>  deduce the related modules for them. And as you have said, we can't
>  deduce well since util may be referenced by several logical modules.
>
> >  >   >  --
>  >  >
>  >  >   >
>  >  >
>  >  >
>  >  >  --
>  >  >  Ping Yin
>  >
>  > >
>  >  >
>  >  > --
>  >  >  To unsubscribe from this list: send the line "unsubscribe git" in
>  >  >  the body of a message to majordomo@vger.kernel.org
>  >  >  More majordomo info at  http://vger.kernel.org/majordomo-info.html
>  >  >
>  >
>  >
>  >
>  >  --
>  >
>  >
>  > Imran M Yousuf
>  >  Entrepreneur & Software Engineer
>  >  Smart IT Engineering
>  >  Dhaka, Bangladesh
>  >  Email: imran@smartitengineering.com
>  >  Mobile: +880-1711402557
>  >
>
>
>
>  --
>  Ping Yin
>



-- 
Imran M Yousuf
Entrepreneur & Software Engineer
Smart IT Engineering
Dhaka, Bangladesh
Email: imran@smartitengineering.com
Mobile: +880-1711402557
