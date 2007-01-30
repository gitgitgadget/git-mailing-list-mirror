From: "Aneesh Kumar" <aneesh.kumar@gmail.com>
Subject: Re: blameview and file contents
Date: Tue, 30 Jan 2007 12:52:19 +0530
Message-ID: <cc723f590701292322q7365f99bg3b7c76834f6fbad8@mail.gmail.com>
References: <cc723f590701292246v282408d0o27a0d8320c027743@mail.gmail.com>
	 <20070130065417.GA32640@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jan 30 08:22:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBnJw-0007Q7-BF
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 08:22:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965368AbXA3HWV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 02:22:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965256AbXA3HWV
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 02:22:21 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:11939 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965368AbXA3HWU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 02:22:20 -0500
Received: by nf-out-0910.google.com with SMTP id o25so123537nfa
        for <git@vger.kernel.org>; Mon, 29 Jan 2007 23:22:19 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XQgZKTtMDQdMiKnq/A2uSodXD7Eij06Vqht18TAyqAAUAqu6/pqUrvz0VinSCJ1NI+ut9gV7xz5GFkXp7YukJWLVnWwaeIdRzLcAnkaxSIPQFFu6FttPxMBBBL+/VvC8LN6gO3ssE0E4yZ5gMAyAVzHNcPfEa1YeNEs8nnwHG4k=
Received: by 10.49.41.3 with SMTP id t3mr339289nfj.1170141739077;
        Mon, 29 Jan 2007 23:22:19 -0800 (PST)
Received: by 10.48.210.15 with HTTP; Mon, 29 Jan 2007 23:22:19 -0800 (PST)
In-Reply-To: <20070130065417.GA32640@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38126>

On 1/30/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> Aneesh Kumar <aneesh.kumar@gmail.com> wrote:
> > I guess blame view need to pull the file content from the repository
> > rather than opening it directly. If i have a working copy that is not
> > yet committed it gives wrong results. I tried some changes as below.
> > But i guess there should be a much easier way.
>
> > -open(my $fh, '<', $fn)
> > -  or die "unable to open $fn: $!";
> > +$fh = get_file_handle("HEAD", $fn);
> >  while(<$fh>) {
> >    chomp;
> >    $fileview->{data}->[$.] = ['HEAD', '?', "$fn:$.", $_];
>
> Doesn't the following work just as well, and use a lot less code?
>
>   open(my $fh, '|-', 'git', 'cat-file', 'blob', "HEAD:$fn")
>
> ?
>

See i said that there should be a simple way. Can we get this
documented in git-cat-file man page

-aneesh
