From: Clark Williams <clark.williams@gmail.com>
Subject: Re: Odd problem in repository
Date: Tue, 24 Apr 2007 12:44:32 -0500
Message-ID: <462E4200.7080206@gmail.com>
References: <462E3D32.60804@gmail.com> <20070424173048.GA5942@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Apr 24 19:44:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgP4L-0008Gp-VF
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 19:44:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422857AbXDXRoj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Apr 2007 13:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422863AbXDXRoj
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Apr 2007 13:44:39 -0400
Received: from nz-out-0506.google.com ([64.233.162.237]:43359 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422857AbXDXRog (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2007 13:44:36 -0400
Received: by nz-out-0506.google.com with SMTP id o1so527774nzf
        for <git@vger.kernel.org>; Tue, 24 Apr 2007 10:44:34 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=UBbify5i/yJ+deNH3WxiFM+f594PlixSJ6mfoAEWspGXbv5Sb2IYK2PDjw3mujnGFJfPSsV4/Kt7UzNv7eI7IeuOiQPJ+w0rlHQBDBc0FDTug9a7dcuObpGpIBFQcJLudtqekbPdiCqH4C+AjjwozZT9C1WKLWbgjW/XLcw+MIY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=uIhErruCe2J2OGV6lFYZXHvS47whgcxZlgW2lhvpKivUJLfkhHhVnN9RyiAwRQcg4AnPv4ThK7IvjiVC6fvXVPzyY0rB6um07k6lCOQxtGE8FZzVrk1ywE+qVkCumal6+NA7n/K2vicKoQWvfcPAeZXU13bpEf9kwioYfdQcelI=
Received: by 10.114.161.11 with SMTP id j11mr3260738wae.1177436674486;
        Tue, 24 Apr 2007 10:44:34 -0700 (PDT)
Received: from ?172.16.16.120? ( [66.187.231.200])
        by mx.google.com with ESMTP id 3sm8028284wrh.2007.04.24.10.44.33;
        Tue, 24 Apr 2007 10:44:34 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.0 (X11/20070419)
In-Reply-To: <20070424173048.GA5942@spearce.org>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45479>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Shawn O. Pearce wrote:
> Clark Williams <clark.williams@gmail.com> wrote:
>> One of my collaborators cloned the repository the other day and found
>> that it didn't have any branches in it. I cloned a temp copy of it and
>> found that the files that normally would be in refs/heads to identify
>> the branches had somehow been moved to the directory
>> refs/remotes/origin. In my local repository (which was cloned
>> immediately after the CVS import), if I list what's in refs/heads, I get
>> this:
>>
>> $ ls -F refs/heads
>> master  mock  mock-0-6-branch  mock-0.7  origin
>>
>> on the whacky cloned copy, I get this:
>> $ ls -F refs/heads
>> master
>>
>> and if I look in refs/remotes/origin:
>> $ ls -F refs/remotes/origin
>> HEAD  master  mock  mock-0-6-branch  mock-0.7  origin
> 
> This is a change in Git versions.  Pre Git-1.5.0 we used to put all
> of the branches from the remote system into refs/heads, but now in
> 1.5.0 and later we put them in refs/remotes/origin.
> 
> Nothing screwed up on the central repository, its just the
> new layout.  refs/heads is reserved for *this* local repository,
> while refs/remotes/$name is reserved for the heads of $name remote
> repository.
> 

Ah, so I'm not totally inept, just unable to read release notes. Sigh.

But, I'm still confused. After you clone the central repository, with
the new layout, why can't I 'mock checkout -f mock-0-6-branch'? Do I
need to further qualify it, or create a local branch from it?

Probably a better question is: what man-page/web-page/mail-thread should
I read to figure this out?

Clark

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFGLkIAqA4JVb61b9cRAn8VAJ9Q7U4ZxP4Jc6OSyd1rcVufbBOO6wCfdDUn
Pmo7URBzl8PcCSRXu5BqYc0=
=yl7q
-----END PGP SIGNATURE-----
