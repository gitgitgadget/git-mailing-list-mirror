From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: renames in StGIT
Date: Tue, 24 Oct 2006 11:25:07 +0100
Message-ID: <b0943d9e0610240325v5bc23078w7fc977e091e99779@mail.gmail.com>
References: <20061022013943.GA16341@diana.vm.bytemark.co.uk>
	 <b0943d9e0610230947j79449a4dm8736f480f039c230@mail.gmail.com>
	 <20061023125344.f82426ad.seanlkml@sympatico.ca>
	 <20061024081732.GA29265@diana.vm.bytemark.co.uk>
	 <b0943d9e0610240148s15d6ec5ch6114360a603fcd71@mail.gmail.com>
	 <20061024091620.GB29265@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sean <seanlkml@sympatico.ca>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 24 12:25:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GcJTd-0004fS-TM
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 12:25:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030267AbWJXKZm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 24 Oct 2006 06:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030270AbWJXKZm
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 06:25:42 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:41109 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1030267AbWJXKZl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Oct 2006 06:25:41 -0400
Received: by py-out-1112.google.com with SMTP id z74so163092pyg
        for <git@vger.kernel.org>; Tue, 24 Oct 2006 03:25:07 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VlflButpLhiP1WeYPzNcRpOu6XYBZnOnduNcpa7RbsT9xHfQU/UnyD2yzxfhcFcPfFsurGmFsmL36blD4W1jAlgBe8uC5bR8R/xgNkI2qJMynMsN7Wm0QJWZHXIbnF/oSG31zZYzpx8yFuJisKBA8kAg7oTUZrRWfzeIK1XNPqg=
Received: by 10.35.83.6 with SMTP id k6mr8552411pyl;
        Tue, 24 Oct 2006 03:25:07 -0700 (PDT)
Received: by 10.35.103.18 with HTTP; Tue, 24 Oct 2006 03:25:07 -0700 (PDT)
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
In-Reply-To: <20061024091620.GB29265@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29961>

On 24/10/06, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> On 2006-10-24 09:48:44 +0100, Catalin Marinas wrote:
> > Step 3 above is handled per file by the
> > stgit.gitmergeonefile.merge() function. This is the place where we
> > should have the rename detection. Since, the majority of the patche=
s
> > don't rename files and, in most cases, the push finishes at step 2,
> > it is probably safe to extend this function and the users won't
> > notice a speed difference.
> >
> > I'll add it to the TODO list.
>
> Sounds good. I had a feeling it ought to be basically free in the
> majority of cases, so I'm glad to learn I'm right. :-)

Might be even simpler for 'push' but I need to do more tests - instead
of calling git-read-tree in git.merge(), just call git-merge-recursive
which handles renames and it's fully tested. My simple test detected
renames when pushing patches (both rename in base and rename in
patch). I still have to do some tweaking and write proper tests (and
probably make it less verbose).

--=20
Catalin
