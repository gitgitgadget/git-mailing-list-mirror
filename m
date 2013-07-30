From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Flatten history
Date: Mon, 29 Jul 2013 22:50:38 -0500
Message-ID: <CAMP44s2pXSN2HbpGLW9jrgJAypbLM3JtgD+nyK7LkNdvH4nsfQ@mail.gmail.com>
References: <CAE1pOi0CQ1k3h3ie=s3qvkQog9foYBOnJ++uuum-Br7vzQHRSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Users <git@vger.kernel.org>
To: Hilco Wijbenga <hilco.wijbenga@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 30 05:50:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V40xW-0006rO-CR
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jul 2013 05:50:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757217Ab3G3Dul (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jul 2013 23:50:41 -0400
Received: from mail-lb0-f180.google.com ([209.85.217.180]:44363 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757114Ab3G3Duj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jul 2013 23:50:39 -0400
Received: by mail-lb0-f180.google.com with SMTP id a16so1949589lbj.39
        for <git@vger.kernel.org>; Mon, 29 Jul 2013 20:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Cfc0cXWgBaAN9QHA/Nf3Hxm2HjvNGEHEVb1G2RXxjSY=;
        b=Zfg8rdMqTMzeB8V35MduLxNQC/naE9a0iZb3NjIIJGqCKG552fqrWufZrifCp0A4b7
         uyFmNtqiKA+NrdSSjxexzwNu+QenE+IDPM2rMPs3EiKIdLng06+CfG16DRcJ7Y6SO7wE
         NEs6ND2oYz6IcIdopvKFORLed0CLu+2A7o9EL97msGWN5WPZaXlDW0/GgIK0vpH1YzH8
         Xlk2l0VFabcOETLWluKDQY6Ma8a5+eDcsTFyZHWxHuoZYMJI0Uv3RApPWXkWXVhMoVVl
         Gyl6HEdU6Bb9y0CvsDUVCqgoKJ3jTG6CjJIW144Mhve68aik45dbYRkQFTEdKDPPm753
         MD1Q==
X-Received: by 10.112.157.226 with SMTP id wp2mr26772324lbb.65.1375156238317;
 Mon, 29 Jul 2013 20:50:38 -0700 (PDT)
Received: by 10.114.175.227 with HTTP; Mon, 29 Jul 2013 20:50:38 -0700 (PDT)
In-Reply-To: <CAE1pOi0CQ1k3h3ie=s3qvkQog9foYBOnJ++uuum-Br7vzQHRSQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231345>

On Mon, Jul 29, 2013 at 8:42 PM, Hilco Wijbenga
<hilco.wijbenga@gmail.com> wrote:
> Hi all,
>
> I have a (public) "feature" branch that has been kept up-to-date with
> "master" by regularly merging master back into it. I would now like to
> get all the changes from feature but not any of the commits.
> Basically, I want to replay all of feature's commits without creating
> those commits.
>
> I thought something like
>
> git cherry-pick -n abcd^..feature
>
> should do the trick (while on master, where abcd is the SHA-1 of the
> commit where feature was created) but I get conflicts.
>
> First, why the conflicts? I have done all the merges so cherry-pick
> should simply be able to replay them? Second, what is the correct way
> of doing this?

Perhaps

% git cherry-pick -n --no-merges --right-only --topo-order
--cherry-pick abcd^..feature

-- 
Felipe Contreras
