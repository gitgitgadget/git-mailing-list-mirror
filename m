From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: git pull on Linux/ACPI release tree
Date: Tue, 10 Jan 2006 12:34:39 +1300
Message-ID: <46a038f90601091534s7f4b36a5he05778f1ed82f34@mail.gmail.com>
References: <20060109225143.60520.qmail@web31807.mail.mud.yahoo.com>
	 <Pine.LNX.4.64.0601091502200.5588@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Luben Tuikov <ltuikov@yahoo.com>,
	"Brown, Len" <len.brown@intel.com>,
	"Luck, Tony" <tony.luck@intel.com>,
	Junio C Hamano <junkio@cox.net>,
	"David S. Miller" <davem@davemloft.net>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	akpm@osdl.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 10 00:34:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ew6XF-0001eJ-TK
	for gcvg-git@gmane.org; Tue, 10 Jan 2006 00:34:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751627AbWAIXem (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jan 2006 18:34:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751632AbWAIXem
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jan 2006 18:34:42 -0500
Received: from wproxy.gmail.com ([64.233.184.194]:6762 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751626AbWAIXel convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 9 Jan 2006 18:34:41 -0500
Received: by wproxy.gmail.com with SMTP id i34so3272953wra
        for <git@vger.kernel.org>; Mon, 09 Jan 2006 15:34:40 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fakAguRs4pwGHboUA4pikf/Let0YSnSwKeyNH2f6CpaaKT8/v0QM4juIHKerqZSYN0pZ5iFdG60eESY8iUny6OSLxN4s6lAfl71xeQjBYYYJcPXYqasAgeCOK1e2ZsK2jZtG3EmSJDhvnf1GfTnv/68a6+2Gur/d9yYKlmVOdy0=
Received: by 10.54.114.7 with SMTP id m7mr8842463wrc;
        Mon, 09 Jan 2006 15:34:39 -0800 (PST)
Received: by 10.54.71.5 with HTTP; Mon, 9 Jan 2006 15:34:39 -0800 (PST)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0601091502200.5588@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14387>

On 1/10/06, Linus Torvalds <torvalds@osdl.org> wrote:
> Using many branches in the same tree is
> definitely the better approach for _distribution_, but that doesn't
> necessarily mean that it's the better one for development.
(...)
> So git certainly supports that kind of behaviour, but nobody I know
> actually does it that way

Hrm! We do. http://locke.catalyst.net.nz/gitweb?p=moodle.git;a=heads
shows a lot of heads that share 99% of the code. The repo is ~90MB --
and we check each head out with cogito, develop and push. It is a
shared team repo, using git+ssh and sticky gid and umask 002.

Works pretty well I have to add. The only odd thing is that the
fastest way to actually start working on a new branch is to ssh on to
the server and cp moodle.git/refs/heads/{foo,bar} and then cg-clone
that bar branch away. Perhaps I should code up an 'cg-branch-add
--in-server' patch.

regards,


martin
