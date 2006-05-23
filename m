From: "Morten Welinder" <mwelinder@gmail.com>
Subject: Re: [PATCH 2/2] cvsimport: cleanup commit function
Date: Tue, 23 May 2006 13:47:01 -0400
Message-ID: <118833cc0605231047o2012deefh5e77b8496da1e673@mail.gmail.com>
References: <46a038f90605220042v369e9ff5o3dc7841472171d02@mail.gmail.com>
	 <46a038f90605220554y569c11b9p24027772bd2ee79a@mail.gmail.com>
	 <44720C66.6040304@gentoo.org>
	 <46a038f90605221241x58ffa2a4o26159d38d86a8092@mail.gmail.com>
	 <Pine.LNX.4.64.0605221256090.3697@g5.osdl.org>
	 <20060522214128.GE16677@kiste.smurf.noris.de>
	 <7v8xotadm3.fsf@assigned-by-dhcp.cox.net>
	 <46a038f90605221615j59583bcdqf128bab31603148e@mail.gmail.com>
	 <20060523065232.GA6180@coredump.intra.peff.net>
	 <20060523070007.GC6180@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Tue May 23 19:47:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiayL-0004BA-FB
	for gcvg-git@gmane.org; Tue, 23 May 2006 19:47:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750888AbWEWRrG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 13:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbWEWRrG
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 13:47:06 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:43535 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750888AbWEWRrE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 May 2006 13:47:04 -0400
Received: by nf-out-0910.google.com with SMTP id b2so183992nfe
        for <git@vger.kernel.org>; Tue, 23 May 2006 10:47:03 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=E87zdo+QDPHkHRjxqmRTbtPtMnvz3YA6oVyLqwanPk6kGvbJd8x26TByZHcuYkMItem5KGhD+z1KQ1YnYX78k5AQZayiDYfiGvOguXzZB510w8hAGhnvCw2i1GXkL5eOy/JtJrWpAfuu5iW/Z7gbKsdsx7lT7WdGdZbUE6BUUyY=
Received: by 10.49.8.4 with SMTP id l4mr4961392nfi;
        Tue, 23 May 2006 10:47:01 -0700 (PDT)
Received: by 10.49.12.11 with HTTP; Tue, 23 May 2006 10:47:01 -0700 (PDT)
To: "Martin Langhoff" <martin.langhoff@gmail.com>,
	"Junio C Hamano" <junkio@cox.net>,
	"Matthias Urlichs" <smurf@smurf.noris.de>, git@vger.kernel.org
In-Reply-To: <20060523070007.GC6180@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20614>

Why run "env" and not just muck with %ENV?

M.


> +       my $pid = open2(my $commit_read, my $commit_write,
> +               'env',
> +               "GIT_AUTHOR_NAME=$author_name",
> +               "GIT_AUTHOR_EMAIL=$author_email",
> +               "GIT_AUTHOR_DATE=$commit_date",
> +               "GIT_COMMITTER_NAME=$author_name",
> +               "GIT_COMMITTER_EMAIL=$author_email",
> +               "GIT_COMMITTER_DATE=$commit_date",
> +               'git-commit-tree', $tree, @commit_args);
