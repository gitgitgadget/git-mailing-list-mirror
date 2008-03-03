From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Re: git fetch: where are the downloaded objects stored?
Date: Mon, 3 Mar 2008 15:33:23 +0100
Message-ID: <4d8e3fd30803030633nf6266d5qab0df4ba4c539e0b@mail.gmail.com>
References: <4d8e3fd30803030440s7239c83cj8bf69401dd76bad@mail.gmail.com>
	 <vpqskz82bm3.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Matthieu Moy" <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Mar 03 15:34:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWBju-0006z2-S5
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 15:34:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752781AbYCCOdZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 09:33:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752696AbYCCOdY
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 09:33:24 -0500
Received: from wf-out-1314.google.com ([209.85.200.175]:53652 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751847AbYCCOdY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 09:33:24 -0500
Received: by wf-out-1314.google.com with SMTP id 28so68162wff.4
        for <git@vger.kernel.org>; Mon, 03 Mar 2008 06:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=PdBu3DINUTq5Ha4UOoHMaqmT43b4gV6137UGTwPlHRQ=;
        b=ncj+5uC88zBsFdCXkJ6GbljVeQRchgW7AZRpxx0mBq7bnti9B9f7TgWySB0ZMMljJR6+ZSSfFGy4mpjcy8MCRdNSvxoKwRVzRZ3/h2mhs6rxKZuhmz5sY8SgDBEOqSvRXLhr9lBgF9qd9dFKDVPwIlKjgZ8EbWsMs7irsdmKI78=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NO7bHuIA0XpC/OLalx4LkUM/uLEThvjs2G/K9ALB+WDfO06QTmpNWLuaTuOn4XTVmjqoYhp+tq3ByDXWAqRuKC8Ces/S3ThTMxCbYasxwiHFfHUjMnClTQ6ZCDzB1jSkE8WZvb7kof0A6qXlKiBlq9196bRrQBiWacdVUZVaS3I=
Received: by 10.142.245.10 with SMTP id s10mr5150525wfh.200.1204554803318;
        Mon, 03 Mar 2008 06:33:23 -0800 (PST)
Received: by 10.143.196.10 with HTTP; Mon, 3 Mar 2008 06:33:23 -0800 (PST)
In-Reply-To: <vpqskz82bm3.fsf@bauges.imag.fr>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75929>

On Mon, Mar 3, 2008 at 2:14 PM, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com> writes:
>
>  > What is still not clear to me is where git is storing
>  > the objects downloaded during a git fetch operation.
>
>  git fetch downloads the objects to the object database, i.e.
>  .git/objects/, usualy as a pack.

Ok, thanks.

>  Now, just "having" the objects locally doesn't change much, an object
>  starts being really interesting if you have a reference (typically, a
>  branch) pointing to it. "git fetch" will update the remote references
>  (for example, origin/master), but won't touch the working tree, and
>  won't do any merge, fast-forward or not, to a local branch. So, most
>  likely, "git fetch" will be followed by either a merge or a rebase.

Yes, your explanation perfectly match my understanding.

I was, and I'm still, confused by the following sentence in the git merge
documentation:
"A merge is always between the current HEAD and one or more remote
branch heads"

If I think to the following scenario:

 git fetch
 git diff (to look at what I downloaded via git fetch)
 gir merge

I don't see a merge between the current HEAD and a _remote_ branch.

Ciao,
-- 
Paolo
http://paolo.ciarrocchi.googlepages.com/
