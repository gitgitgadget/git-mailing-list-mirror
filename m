From: "David Tweed" <david.tweed@gmail.com>
Subject: Re: [Bug] vfat: Not a git archive
Date: Mon, 2 Jun 2008 11:37:49 +0100
Message-ID: <e1dab3980806020337x4d62dcablcf8d4385466b1b2f@mail.gmail.com>
References: <873anwt9ya.fsf@debian.erik.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Thomas Christensen" <thomasc@thomaschristensen.org>
X-From: git-owner@vger.kernel.org Mon Jun 02 12:38:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K37R9-0003yy-2I
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 12:38:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751770AbYFBKhv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 06:37:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751993AbYFBKhv
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 06:37:51 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:19498 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751577AbYFBKhu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 06:37:50 -0400
Received: by yw-out-2324.google.com with SMTP id 9so466205ywe.1
        for <git@vger.kernel.org>; Mon, 02 Jun 2008 03:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=PzMviOsFr/MI59sIsPyYjtlqfF6mLOWnvFizmNKiVSY=;
        b=XCGgZnKarBYIJ+3QJ2dpwsWA9oUQsl/9xsy+UG64eVJDKUFC/ncmlrYJUSjupQ8RGplus1LSDMWZHFnqxBRgjsb6tTWjuVvmcHTuWCC2IuZ9J20ZKWhi/rsGkTdXqFVgUfOFt/Qp0mOU7iTZKgQv62cT+VCkeqFvMhYxhwSBiyk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AicGqObaZNVi0IpYzLgF/sM+2lC+pflgXeV96zJHGBhOxZF/XrCD9rdibHWXF0jRN+t0TyBHlc4gICCtrpcMvDgACaz0KGH6AJUKDPnNLh446dNN5f2boXT/rhcJk4WA/QvcURgvvSL67TsrQQGII4R7/cxb3rFjemPf4NcXFfE=
Received: by 10.151.145.21 with SMTP id x21mr10588990ybn.66.1212403069178;
        Mon, 02 Jun 2008 03:37:49 -0700 (PDT)
Received: by 10.150.145.6 with HTTP; Mon, 2 Jun 2008 03:37:49 -0700 (PDT)
In-Reply-To: <873anwt9ya.fsf@debian.erik.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83509>

On Mon, Jun 2, 2008 at 11:20 AM, Thomas Christensen
<thomasc@thomaschristensen.org> wrote:
> Hi,
>
> I am having this issue on Debian with kernel 2.6.25 (2.6.24 works fine)
> and git 1.5.5.3.
>
>  $ git push /media/KINGSTON/foo.git
>  fatal: '/media/KINGSTON/foo.git': unable to chdir or not a git archive
>  fatal: The remote end hung up unexpectedly
>
> A notable difference between these 2 kernels is this line:
>
>  [   62.575939] FAT: utf8 is not a recommended IO charset for FAT
>  filesystems, filesystem will be case sensitive!
>
> which appears in 2.6.25.

I don't remember if it gives this particular error message, but some
vfat mounting options cause the file 'HEAD' to appear to the
filesystem as 'head' which git doesn't like. (I don't think there any
other basic git files which have uppercase.)It's worth having a look
and see if that's happened.

-- 
cheers, dave tweed__________________________
david.tweed@gmail.com
Rm 124, School of Systems Engineering, University of Reading.
"while having code so boring anyone can maintain it, use Python." --
attempted insult seen on slashdot
