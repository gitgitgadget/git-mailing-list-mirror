From: Russell Steicke <russellsteicke@gmail.com>
Subject: Re: Cloning into an existing directory
Date: Mon, 16 Feb 2009 07:31:55 +0000
Message-ID: <c1b8b6670902152331p9bbdb8fo7bf7048039b5301c@mail.gmail.com>
References: <e38bce640902152310x195a14e5p445817bdfc6e319f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Brent Goodrick <bgoodr@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 16 08:33:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYxyo-0002Ms-4R
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 08:33:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753253AbZBPHb6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 02:31:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753076AbZBPHb5
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 02:31:57 -0500
Received: from ti-out-0910.google.com ([209.85.142.188]:30561 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751790AbZBPHb5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 02:31:57 -0500
Received: by ti-out-0910.google.com with SMTP id d10so1630689tib.23
        for <git@vger.kernel.org>; Sun, 15 Feb 2009 23:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=un56XLvISZg0+1R6S+cE+F5SMuQDHWm4WAF2tawobL8=;
        b=O84bdTtXkTamyAEZPm9RB1DOeY5MxP45pD8qMR5JNHM0zWaA0VdxKlv8cNvaLNJz5T
         7wrPyA+6LzXQzgn41jUDGB4qaJ/UFbSVAX+yxo6m5lWzHcyNI3JyNDF65BabVQ89Q0Ix
         2no3fWCrLj9xR4sRUqwbZxmZoEkdAi1reZ+7A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=a2apTkSwcdxbMzllbBDaUQIPcrkJ3Inteki1Xipu7UaTTLiMJYDe6qn5KtiJEx+K4U
         lsx7oHDlbI06J+tA66b42pwj4r0/OuRyqKpnLjvivza3hGA21SrMFqeTntMAKDt3BQU5
         zNEFvfEhK0ow2AjQzOoJ4jNa7ILnJH9eD5HO0=
Received: by 10.110.40.8 with SMTP id n8mr8201407tin.28.1234769515539; Sun, 15 
	Feb 2009 23:31:55 -0800 (PST)
In-Reply-To: <e38bce640902152310x195a14e5p445817bdfc6e319f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110143>

On 2/16/09, Brent Goodrick <bgoodr@gmail.com> wrote:
> Hi,
>
>  I would like to manage my startup scripts such as .bashrc and other
>  setup files relative to my HOME directory using Git. However,
>  git-clone disallows cloning into the existing "." directory, but only
>  allows cloning into a subdirectory that does not yet exist.  If my
>  home directory is /home/brentg and my remote repository is on
>  remote_machine:~brentg/my_setup.git then git clone in my home
>  directory on the local machine creates /home/brentg/my_setup with
>  files such as .bashrc inside it, which is not what I want. I want them
>  checked out and managed _in_ the current working directory, and not to
>  mess with other files or directories that already exist that are never
>  to be managed by git.

cd
git init
git remote add origin remote_machine:~brentg/my_setup.git
git fetch
git branch master origin/master
git checkout master

You may have to delete .bashrc and others before git will overwrite
them on checkout.



-- 
Virus found in this message.
