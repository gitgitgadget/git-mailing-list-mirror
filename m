From: "Jacob Helwig" <jacob.helwig@gmail.com>
Subject: Re: Git - Pushing to a production website
Date: Fri, 9 Jan 2009 22:41:54 -0800
Message-ID: <8c9a060901092241y23e56cbbr6aa7f322afaa2f6b@mail.gmail.com>
References: <20090109222344.3539138a@family.dyweni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: 4jxDQ6FQee2H@dyweni.com
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jan 10 07:43:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLXZ2-0000rI-Sn
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 07:43:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411AbZAJGl4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2009 01:41:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751005AbZAJGl4
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jan 2009 01:41:56 -0500
Received: from qw-out-2122.google.com ([74.125.92.24]:52928 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750718AbZAJGlz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2009 01:41:55 -0500
Received: by qw-out-2122.google.com with SMTP id 3so8858063qwe.37
        for <git@vger.kernel.org>; Fri, 09 Jan 2009 22:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=dTsN19oRtMzymOzhYSRv1LL/Fg1To0tZZtqZhH1vjvA=;
        b=GU3+1rwdhq+xC3ZPHKgBRb+nUjH6eUWM3O5kOkvYhAXCGFVNfEnA+spiRv0bNL98+i
         UrYtIVdMPuUJe2m86mVENNYqtjR4o1jAOsy74PjIziBIYzLDVwTxt0foQuONs+lSm/Ab
         c/zrQI2wzqWiwQq/heU1AcaxW1oaCr03GEMEU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=odhu2F9wAeFTLfZmdC18Vk4OJ/cZvjGvs0dN9NL6wyo8X8jE6/1Wku6+PetjH2t46l
         mPYZrnicLGqf+BIH8SmjpfT1XuU/Km9G+51w3cXExdzRMOyZ0lkrAtDI3EUoNmRnnjQZ
         lHS+0rBYPyBcNZ1sIP7lXko1o9ZqU089bO08Q=
Received: by 10.214.116.7 with SMTP id o7mr23685552qac.133.1231569714504;
        Fri, 09 Jan 2009 22:41:54 -0800 (PST)
Received: by 10.214.243.1 with HTTP; Fri, 9 Jan 2009 22:41:54 -0800 (PST)
In-Reply-To: <20090109222344.3539138a@family.dyweni.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105080>

On Fri, Jan 9, 2009 at 20:23,  <4jxDQ6FQee2H@dyweni.com> wrote:
> Hi,
>
> Our company's website is stored in a GIT Repository.
>
> The repository is coded for our test server.  When we push updates to
> the production server, have manually run a script to patch several
> files to make the code work on the production server (i.e. port
> numbers, etc).
>

Are these all static pages?  If they're Perl/PHP/Ruby/whatever, why
not add tests for the Live vs. Dev?  Check for an environment
variable, or a file on disk, etc, etc?  That way any checks described
below won't get "confused" by the (no longer necessary) patches, and
you won't have to worry about rebasing commits, and any potential
conflicts there.

> I'd like to write a script to email me whenever someone changes files
> on the production server without checking those changes back into git
> (i.e. running 'git status | grep "nothing to commit" ...').
>
> However, this approach get confused by the files patched to work
> correctly.
>
> Is there any way to 'save' those patched files so they don't get
> reported by 'git status', yet not mung up the git history every time
> we push out an update?
>
> Thanks!
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
