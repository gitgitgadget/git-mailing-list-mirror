From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: Git and Scmbug integration
Date: Wed, 14 Nov 2007 11:27:40 +1100
Message-ID: <ee77f5c20711131627q329d45aepe48102728cf2778c@mail.gmail.com>
References: <1194980792.4106.6.camel@localhost>
	 <ee77f5c20711131500h6ee067ffv3e488ac7bde1d22c@mail.gmail.com>
	 <1194998142.4106.24.camel@localhost>
	 <ee77f5c20711131602m5b9042fx72689af53e24ddd2@mail.gmail.com>
	 <1194999404.4106.40.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: jnareb@gmail.com, git@vger.kernel.org, scmbug-users@lists.mkgnu.net
To: "Kristis Makris" <kristis.makris@asu.edu>
X-From: git-owner@vger.kernel.org Wed Nov 14 01:28:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is66t-0000rt-Mt
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 01:28:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760578AbXKNA1n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 19:27:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759116AbXKNA1m
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 19:27:42 -0500
Received: from nz-out-0506.google.com ([64.233.162.235]:57492 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752594AbXKNA1l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 19:27:41 -0500
Received: by nz-out-0506.google.com with SMTP id s18so4396nze
        for <git@vger.kernel.org>; Tue, 13 Nov 2007 16:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=dBMSZl8hvYEYbjxjBMwlxEBSPrTXLC4yu0zYkEskJ1U=;
        b=M7a8/UC36MbYdoWLAjxVbAtDUVBXjOLqokV3whXPcxHDE6rWRKm4/yA8KPd7M0/m/e/HJiTpf8EesGNMdrKyMOwa4ZpHsAyX4a0saMNTyMJhDpLzTI1Z+S6W8gQc3x4UAjln5577i019Bf4rBYheT3qcuWwPaFjgRclX/Mto6g0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KHN9SD7OEjobOic0Bk+U+i9P46QM0kr5Rw2ZI0tizhoS8gTzb04pEVwQntng2FvgzItmKurn5GE0ft/+CTg+OybV5SURn3N1yULOJo02BhY35K3dSrLhs47re7W4RZrBr1qSwDTBysonGh7tnqxDB2UicIaeYZj6gliVzFgauPY=
Received: by 10.142.142.16 with SMTP id p16mr1534288wfd.1195000060381;
        Tue, 13 Nov 2007 16:27:40 -0800 (PST)
Received: by 10.142.142.12 with HTTP; Tue, 13 Nov 2007 16:27:40 -0800 (PST)
In-Reply-To: <1194999404.4106.40.camel@localhost>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64930>

On Nov 14, 2007 11:16 AM, Kristis Makris <kristis.makris@asu.edu> wrote:
> > Unannotated tags don't make a proper new object, only a ref. If you
> > stick to annotated tags, you'll get new objects added which, I think,
> > should trigger the post-commit hook.
>
> I just tried again tagging with both:
>
> $ git tag TAG_NAME
>
> $ git tag -a TAG_NAME
>
> and I don't get the post-commit hook executed.
>
> Perhaps I missed something ?

Okay, I don't know about that. Someone else might want to weigh in on this.

> > If you have the new commit's SHA-1, it's very simple to get the parent
> > commit's SHA-1 and do whatever you want. A complexity would be with
> > handling merges, where a commit has multiple parents. If you have a
> > commit SHA-1 hash, you can just "git diff --name-only <hash>^ <hash>"
> > to get a list of the files changed by <hash>.
>
> This sounds great. If the post-commit hook could now provide the new
> commit SHA-1 hash than that should be what I need.
>
> Can the new commit SHA-1 hash be added as a parameter to the post-commit
> hook please ?

Sure -- I've got a patch for it that I'll send shortly. It's using the
existing shell git-commit, so might be suitable for maint; I haven't
followed what's happened with the builtinification of git-commit.


Dave.
