From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH/RFC v2] git-submodule: multi-level module definition
Date: Wed, 5 Mar 2008 15:53:07 +0800
Message-ID: <46dff0320803042353u7e2e1789x514a2f81b7204277@mail.gmail.com>
References: <1204646661-7776-1-git-send-email-pkufranky@gmail.com>
	 <7bfdc29a0803041917j16112e80uc0b21707bdfd3fe@mail.gmail.com>
	 <46dff0320803042315t2d89eb6fl325b4b2ef8ddbc44@mail.gmail.com>
	 <46dff0320803042316m1921f657wacf63a63491bbda0@mail.gmail.com>
	 <7bfdc29a0803042340k2ea6fc1cq435205f1da71bbb0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Imran M Yousuf" <imyousuf@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 05 08:53:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWoRm-00060f-NR
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 08:53:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764096AbYCEHxQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 02:53:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764016AbYCEHxP
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 02:53:15 -0500
Received: from ti-out-0910.google.com ([209.85.142.184]:53955 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763865AbYCEHxO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 02:53:14 -0500
Received: by ti-out-0910.google.com with SMTP id 28so1711075tif.23
        for <git@vger.kernel.org>; Tue, 04 Mar 2008 23:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ZurDADimtuK8nQzpRCZ00ZpGyJWxryTfF7zq40/d8M4=;
        b=nLtFXMnaJgqoHN4hpjrda08mqGg1Qo2P1smg555ESdi2v1bsAEM8Dqp1Fae5gjkBx3M3XzN45tXY1tLxY2e8JCpP8c6Yvs+Q+BixRb7meQDTGRWNpwfbdcGBBz0W7MmXENJRlYm02lqwMvZ/7+MLXnZaOVkH5UcAlhqQdN4QfBE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iHnGt7repUStkJpY0qMm8q/EvJv2j7+9WKQZyzs+kkJkfckDp3hhTk5QfzJ9tiHOMQ2fYjT9eEmAcuHd6sJBIpZ6DapiZUkJvz7Wf6B6yMpjgn23qm4g3lhx/00UlH4BrzkIsSzmtZcSevih1nlxxz8/yRpkR+pDWKtfEeXtKws=
Received: by 10.151.38.12 with SMTP id q12mr988021ybj.124.1204703587929;
        Tue, 04 Mar 2008 23:53:07 -0800 (PST)
Received: by 10.150.218.21 with HTTP; Tue, 4 Mar 2008 23:53:07 -0800 (PST)
In-Reply-To: <7bfdc29a0803042340k2ea6fc1cq435205f1da71bbb0@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76186>

On Wed, Mar 5, 2008 at 3:40 PM, Imran M Yousuf <imyousuf@gmail.com> wrote:
> On Wed, Mar 5, 2008 at 1:16 PM, Ping Yin <pkufranky@gmail.com> wrote:
>  >
>  > On Wed, Mar 5, 2008 at 11:17 AM, Imran M Yousuf <imyousuf@gmail.com> wrote:
>  >   > On Tue, Mar 4, 2008 at 10:04 PM, Ping Yin <pkufranky@gmail.com> wrote:
>  >
>  >  >  >  .gitmodules with with multiple level of indirection
>  >   >  >  ------------------------------------------------------
>  >   >  >  [submodule "service"]
>  >   >  >    submodule = crawler
>  >   >  >    submodule = search
>  >   >  >  [submodule "crawler"]
>  >   >  >    submodule = util
>  >   >  >    submodule = imcrawter
>  >   >  >  [submodule "search"]
>  >   >  >    submodule = util
>  >   >  >    submodule = imsearch
>  >
>  >   >
>  >
>  >  >  At this point I have few questions - Will Service have its own tree
>  >   >  besides its submodules?
>  >   Now, service itself is not a submodule, and service is just a logical
>  >   name for a group of moduels.
>  >
>  If I am not mistaken I can do it now as well, by "git submodule add
>  repo path". What would be the difference with this and your approach?
No difference at this point. But using logical name can help add
modules in batch such as "git submodule add -m service"
>
> >
>  >   >
>  >   >  For your above example of .gitmodules hierarchy if I issue "git
>  >   >  submodule init -m util", can you please explain what will be the
>  >   >  outcome, i.e. which modules will be initialized.
>  >   >
>  >   Only the util module will be initialized using the path and url in
>  >   submodule.util.{path,url}
>  >
>  I got that part as thats how git-submodules currently work; Actually
>  what I wanted to know is as util is referenced to several logical
>  submodules, will they be initialized as well? that means wherever util
>  is referenced it will be initialized; is that what it means?
>  >   >
Since the user designate only util module, we needn't automatically
deduce the related modules for them. And as you have said, we can't
deduce well since util may be referenced by several logical modules.
>  >   >  --
>  >
>  >   >
>  >
>  >
>  >  --
>  >  Ping Yin
>
> >
>  >
>  > --
>  >  To unsubscribe from this list: send the line "unsubscribe git" in
>  >  the body of a message to majordomo@vger.kernel.org
>  >  More majordomo info at  http://vger.kernel.org/majordomo-info.html
>  >
>
>
>
>  --
>
>
> Imran M Yousuf
>  Entrepreneur & Software Engineer
>  Smart IT Engineering
>  Dhaka, Bangladesh
>  Email: imran@smartitengineering.com
>  Mobile: +880-1711402557
>



-- 
Ping Yin
