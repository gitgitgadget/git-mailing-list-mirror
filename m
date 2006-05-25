From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: importing cvs logical modules
Date: Thu, 25 May 2006 18:16:47 +1200
Message-ID: <46a038f90605242316l4b0a0963m638f7a2e47936000@mail.gmail.com>
References: <93c3eada0605242148u4656bc31p96d84a16703f0fe0@mail.gmail.com>
	 <7vslmyzoit.fsf@assigned-by-dhcp.cox.net>
	 <93c3eada0605242302x24ca1272xd7bfc3a677b32845@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 25 08:17:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fj99z-0003ZP-EE
	for gcvg-git@gmane.org; Thu, 25 May 2006 08:17:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965019AbWEYGQw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 May 2006 02:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965022AbWEYGQw
	(ORCPT <rfc822;git-outgoing>); Thu, 25 May 2006 02:16:52 -0400
Received: from wr-out-0506.google.com ([64.233.184.224]:58651 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965019AbWEYGQv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 May 2006 02:16:51 -0400
Received: by wr-out-0506.google.com with SMTP id i7so63464wra
        for <git@vger.kernel.org>; Wed, 24 May 2006 23:16:47 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EBvDDWcxq1RslDlgV+P58Cgx4o46kgCHFheQmDXLkHJey88XezqoR7fbGNJbMdM5hqELwC07CqE5i/bBEKqK2I4BShbNAhke0N0ecD3GuXLIDbcyoem9kc6m+U0eSANsBp94yGMnImAHYqTqE+/w+fPxlMPeKLVi6T3Z17vY07g=
Received: by 10.54.109.14 with SMTP id h14mr196317wrc;
        Wed, 24 May 2006 23:16:47 -0700 (PDT)
Received: by 10.54.127.12 with HTTP; Wed, 24 May 2006 23:16:47 -0700 (PDT)
To: geoff@austrics.com.au
In-Reply-To: <93c3eada0605242302x24ca1272xd7bfc3a677b32845@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20730>

On 5/25/06, Geoff Russell <geoffrey.russell@gmail.com> wrote:
> The tight linkage is absolutely essential.
>
> When we tag the system, we
> want to tag everything (not individually tag all 300 programs)
> so that later we can to branch at that tag. Very few of our

Then you want a single git repo/tree/project. The thing is how to work
through your mangled CVS history.

Two options there...

 - Don't. Import from after the last directory reorg or from your last
interesting release. Keep the cvs tree for people who really want to
dig into the past. this has several advantages, as initial checkouts
will be faster, import times shorter, less pain overall.

 - Mangle import to match your reorganizations:
   - Generate the cvsps output file
   - Duplicate/copy files in the cvs repo so that files are in both
places if you've been mving them around.
   - Mangle the cvsps output file from each reorg onwards. This is
nasty, but it will define the history that cvsimport sees.

cheers,


martin
