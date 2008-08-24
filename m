From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH] gitweb: ref markers link to named shortlogs
Date: Sun, 24 Aug 2008 21:41:23 +0200
Message-ID: <cb7bb73a0808241241q19af5fai708935c29373042d@mail.gmail.com>
References: <1219341860-4913-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <48B1B6F2.5050301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Petr Baudis" <pasky@ucw.cz>,
	"Jakub Narebski" <jnareb@gmail.com>
To: "Lea Wiemann" <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 24 21:42:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXLTq-0006vS-6y
	for gcvg-git-2@gmane.org; Sun, 24 Aug 2008 21:42:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752431AbYHXTl0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Aug 2008 15:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752470AbYHXTl0
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Aug 2008 15:41:26 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:55834 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751752AbYHXTlZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2008 15:41:25 -0400
Received: by gxk9 with SMTP id 9so1738733gxk.13
        for <git@vger.kernel.org>; Sun, 24 Aug 2008 12:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=iVaKJWQBKw4/xxXT+H7ws/qzRGzMUPovl/0LKiTkpEc=;
        b=UN9Gv/93LAqe3oEaL5RPf0zwC8Kbo0s7PFQK8xPuYCKG5MXD44M8DCuoC10y1Ju4DW
         Hq0IcuyKWizkPM+RlwJf/u0vyHgtkQqs0i9Cuzmr0sxDCIrATUJ4lo6A9Kv6MSxRFcSI
         pOR/KAqmgSio8HlaF1kRYE55w9L8O+I0GF8LQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Zg82HLvyastXV/jb+EMEfMcvHrecMBppFPP/CzUHKyy660hlXF/uKwVkjm8tqidGNK
         nPkLGXZG78+tFu2BocTGoL0XeJXM+5drEYvMq7eQ8VaV2gCNAN4/10KR3jzY1y56mZsh
         UZ8j1Hupiyau2JKjLZhS2TKBgXGqyQx3HB7YE=
Received: by 10.150.177.20 with SMTP id z20mr5733111ybe.157.1219606884197;
        Sun, 24 Aug 2008 12:41:24 -0700 (PDT)
Received: by 10.150.145.2 with HTTP; Sun, 24 Aug 2008 12:41:23 -0700 (PDT)
In-Reply-To: <48B1B6F2.5050301@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93556>

On Sun, Aug 24, 2008 at 9:30 PM, Lea Wiemann <lewiemann@gmail.com> wrote:
> Giuseppe Bilotta wrote:
>> +                     my $git_type = git_get_type($ref);
>> [...]
>> +                             $cgi->a({-href => href(action=>$view{$git_type} || $git_type, hash=>$name)}, $name) .
>
> Since some of this thread seems to be about performance, you might just
> make this a link to action => 'object' (and save the git_get_type call)
> and let gitweb Do The Right Thing when the link is followed.
>
> [Disclaimer: Haven't read the whole thread, and haven't checked if
> action=object is actually doing the right thing here.]

The object would do the right thing if we wanted 'commit' to be the
default action for commits, but we actually want shortlogs in that
case.

However, this remark of yours makes me think of a different way to
approach the problem: create an 'objectview' action that acts just
like object, but actually maps those objects to an appropriate default
view. I'd like to hear Petr's and Jakub's opinion, and if they think
it's a better approach than the latest version of my patch
http://marc.info/?l=git&m=121941177812828&w=2 (which has not received
any comments yet), I'll implemented it that way.

-- 
Giuseppe "Oblomov" Bilotta
