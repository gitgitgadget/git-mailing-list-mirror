From: "Clifford Caoile" <piyo@users.sourceforge.net>
Subject: Re: [msysGit] [PATCH] Git.pm: Make _temp_cache use the repository directory
Date: Thu, 13 Nov 2008 07:06:27 +0900
Message-ID: <1f748ec60811121406j7ac72c7eqcfbe68132b2ebfc0@mail.gmail.com>
References: <491AE80A.5060807@svanfeldt.com>
Reply-To: piyo@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: msysgit@googlegroups.com, git@vger.kernel.org,
	"Eric Wong" <normalperson@yhbt.net>
To: developer@svanfeldt.com
X-From: git-owner@vger.kernel.org Wed Nov 12 23:08:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0NsK-0003iO-Ng
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 23:07:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754653AbYKLWGa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 17:06:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754566AbYKLWGa
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 17:06:30 -0500
Received: from yx-out-2324.google.com ([74.125.44.29]:20220 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753461AbYKLWG2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 17:06:28 -0500
Received: by yx-out-2324.google.com with SMTP id 8so301260yxm.1
        for <git@vger.kernel.org>; Wed, 12 Nov 2008 14:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :sender:to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=HQkMRCSc3EfvA7IZtKvMvpHD+lBJ3dJNgZkdMazRyw8=;
        b=IIXPb2yX295sYfnH6u9bEZfuagOtQRsPi0Cc3lrdfaCRX1vo/UqLNeo9ALb2YOPlho
         cPJXKMYEDM/Pg6ZiyHtV+CNA3LNwRKpVJuqb1LDvxfuErWvUoq2vS8k1cNgud9NcJK+R
         e5LfXXDEb0v2veVxPOYaCY398jIZFiiiZQq6E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:sender:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references:x-google-sender-auth;
        b=jDv++U/eR6nvmOdv/cnFCZ9HKRoq8x/WygvI3XyS6PEU+CZfhVtYXY9/kUqHslD7Xk
         cjE7bzD55HkMn+cnrnJRGpK4+P3JZa/TGfHM+4lsCBsf91LhsMjLv6phf9jAYTIKKn+o
         sBa1N3/fKeXGFud9JVQFphurHGlPSk/X7THrM=
Received: by 10.100.125.12 with SMTP id x12mr4277318anc.4.1226527587473;
        Wed, 12 Nov 2008 14:06:27 -0800 (PST)
Received: by 10.100.254.9 with HTTP; Wed, 12 Nov 2008 14:06:27 -0800 (PST)
In-Reply-To: <491AE80A.5060807@svanfeldt.com>
Content-Disposition: inline
X-Google-Sender-Auth: 74ea153406aeff8b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100819>

Hi Marten Svanfeldt:

On Wed, Nov 12, 2008 at 11:28 PM, Marten Svanfeldt (dev)
<developer@svanfeldt.com> wrote:
>
> Update the usage of File::Temp->tempfile to place the temporary files
> within the repository directory instead of just letting Perl decide what
> [snip]
> +
> +               my $tmpdir;
> +               if (defined $self) {
> +                       $tmpdir = $self->repo_path();
> +               }
> +

I suppose if I wanted to used ${workingdir}/.git instead of
${workingdir}, I should replace the $tmpdir line above with $tmpdir =
$self->repo_path() . "/.git" ?

Best regards,
Clifford Caoile
