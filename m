From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: how to display file history?
Date: Mon, 15 May 2006 20:32:39 +0200
Message-ID: <e5bfff550605151132s4605a241sd3132aaeb2de6a39@mail.gmail.com>
References: <CFF307C98FEABE47A452B27C06B85BB670F4FD@hdsmsx411.amr.corp.intel.com>
	 <7v64k7wzzf.fsf@assigned-by-dhcp.cox.net>
	 <m1ejyv7077.fsf@ebiederm.dsl.xmission.com>
	 <Pine.LNX.4.64.0605150900510.3866@g5.osdl.org>
	 <e5bfff550605151022m7b9ddcd9y53cd745e16ff6b22@mail.gmail.com>
	 <Pine.LNX.4.64.0605151055080.3866@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	"Junio C Hamano" <junkio@cox.net>,
	"Brown, Len" <len.brown@intel.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 15 20:33:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfhsH-0001CQ-M6
	for gcvg-git@gmane.org; Mon, 15 May 2006 20:32:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964966AbWEOScm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 May 2006 14:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965138AbWEOScm
	(ORCPT <rfc822;git-outgoing>); Mon, 15 May 2006 14:32:42 -0400
Received: from nz-out-0102.google.com ([64.233.162.199]:29511 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964966AbWEOSck convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 May 2006 14:32:40 -0400
Received: by nz-out-0102.google.com with SMTP id 16so20545nzp
        for <git@vger.kernel.org>; Mon, 15 May 2006 11:32:40 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Xv6k8oarKcJiX1kN+XpEoyb4U1JbvApcBkaECxqepw6zMNyCdKdgUSE7uYGcQPAwACTDH9gTqMIpfY6uyhbwKXeiLyHgKsy7L5scOn2f1juBNBG9zs+IuNK8+zRbAcPTOhkk8vo/+QZmLKggFpOBB2Y1PKd514VEsQjFJ3fOtAg=
Received: by 10.64.24.20 with SMTP id 20mr2244451qbx;
        Mon, 15 May 2006 11:32:39 -0700 (PDT)
Received: by 10.64.131.11 with HTTP; Mon, 15 May 2006 11:32:39 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605151055080.3866@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20076>

On 5/15/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
>
> qgit would seem to prefer to have the commit counting only affect the
> "primary" commits, and not the "boundary" ones at all. Which might be
> sensible, but it's not the semantics it has now.
>
> gitk doesn't care, because it uses the boundary commits just as hints.
>

$ git-rev-list --topo-order --after="Apr 10" --before="Apr 11" HEAD |wc
     14      14     574
$ git-rev-list --topo-order --boundary --after="Apr 10" --before="Apr
11" HEAD |wc
     18      18     742

Boundary revisions in this case are _not_ passed through search
filtering. Using --boundary option we get revisions ouside given
filter range.

This does not apply to our previous example. So at least --boundary
behaviour it's a little bit inconsistent at the moment.

        Marco
