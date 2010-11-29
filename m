From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFD] git glossary: define pathspec
Date: Mon, 29 Nov 2010 10:27:58 -0600
Message-ID: <20101129162758.GF8037@burratino>
References: <1291025622-15335-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 29 17:28:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PN6aO-0003Rv-LM
	for gcvg-git-2@lo.gmane.org; Mon, 29 Nov 2010 17:28:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754081Ab0K2Q2I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Nov 2010 11:28:08 -0500
Received: from mail-iw0-f194.google.com ([209.85.214.194]:53452 "EHLO
	mail-iw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751602Ab0K2Q2G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Nov 2010 11:28:06 -0500
Received: by iwn36 with SMTP id 36so435088iwn.1
        for <git@vger.kernel.org>; Mon, 29 Nov 2010 08:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=a97Ubuow+ukAWRwsbaWvb/FRifjff02YgdXH8cHMBso=;
        b=lA5jZZ2e7jo489tPiJL+JTZQygjYGJpKf7RqsW94ICVGsx9xEVGu8sG2F1ZiFtWk9M
         hxnzvWQ2OaHV+y8f/cyAS2A9jyJES4ZhT0mrQqjLr9bHRtYrWOQTJk96m+dbW+5bjllc
         Gea6yFNAaYnVTq7vrtMO5lpB4XpnNA64ZcdJE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=T3fibRxRC59mHqpq3aD00Aiq+DTnOCK/E56R1qI8qSfmNEFxTF8Y/CUu+9YcKbWUFi
         ABIlDIkc61EOd6Aehgq+BHVdtrBUaoBy6anpRqOB7ykDwe+lydi0OG1r+sIOEsbmBB+x
         19+Hj0zPSyG6P1t/jFDL6XC+MgmZDndl2Kxnk=
Received: by 10.231.35.194 with SMTP id q2mr5799380ibd.26.1291048085609;
        Mon, 29 Nov 2010 08:28:05 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.ameritech.net [68.255.109.73])
        by mx.google.com with ESMTPS id 34sm6056098ibi.14.2010.11.29.08.28.03
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 29 Nov 2010 08:28:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1291025622-15335-1-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162397>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> --- a/Documentation/glossary-content.txt
> +++ b/Documentation/glossary-content.txt
> @@ -278,6 +278,17 @@ This commit is referred to as a "merge commit", =
or sometimes just a
>  	of the logical predecessor(s) in the line of development, i.e. its
>  	parents.
> =20
> +[[def_pathspec]]pathspec::
> +	Pathspec in its simplest form is a literal path to address a
> +	file or a blob.
> +	Pathspec can end with a slash. Such pathspec is considered a
> +	directory prefix and will match everything under matched
> +	directory.
> +	Pathspec can contain wildcards such as '*', '?'... Such
> +	pathspecs, after being matched literally against the entire
> +	path, will be matched against the entire path using
> +	fnmatch(3).
> +

Perhaps worth mentioning that these are path specifiers?

 pathspec::
	Pattern used to specify paths.

	Pathspecs are used on the command line of "git ls-files", "git
	ls-tree", "git grep", "git checkout", and many other commands to
	limit the scope of operations to some subset of the tree or
	worktree.  See the documentation of each command for whether
	paths are relative to the current directory or toplevel.  The
	pathspec syntax is as follows:

	. any path matches itself
	. the pathspec up to the last slash represents a
	  directory prefix.  The scope of that pathspec is
	  limited to that subtree.
	. the rest of the pathspec is a pattern for the remainder
	  of the pathname.  Paths relative to the directory
	  prefix will be matched against that pattern using fnmatch(3);
	  in particular, '*' and '?' _can_ match directory separators.

	For example, Documentation/*.jpg will match all .jpg files
	in the Documentation subtree,
	including Documentation/chapter_1/figure_1.jpg.

Of course, I am making the semantics up. :)

Hope that helps,
Jonathan
