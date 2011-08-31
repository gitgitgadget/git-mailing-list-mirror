From: in-git-vger@baka.org
Subject: Re: need to create new repository initially seeded with several branches
Date: Wed, 31 Aug 2011 12:21:13 -0400
Message-ID: <201108311621.p7VGLDlm015261@no.baka.org>
References: <1314804325568-6746957.post@n2.nabble.com> <201108311540.p7VFen5S015756@no.baka.org>
        <CAKjsY4nsPNO_kvxeime8qcNrRFykgG2TOYxJ0HKbj2zR5Rwv+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ryan Wexler <ryan@iridiumsuite.com>
X-From: git-owner@vger.kernel.org Wed Aug 31 18:21:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QynXa-0004QH-4I
	for gcvg-git-2@lo.gmane.org; Wed, 31 Aug 2011 18:21:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084Ab1HaQVU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Aug 2011 12:21:20 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: from tsutomu.baka.org ([66.114.72.182]:57218 "EHLO tsutomu.baka.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932070Ab1HaQVT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Aug 2011 12:21:19 -0400
X-Greylist: delayed 2428 seconds by postgrey-1.27 at vger.kernel.org; Wed, 31 Aug 2011 12:21:19 EDT
Received: from no.baka.org (no.baka.org [IPv6:2001:470:88bb::2])
	by tsutomu.baka.org (8.14.4/8.14.4) with ESMTP id p7VGLDJ2031273
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 31 Aug 2011 12:21:16 -0400
Received: from no.baka.org (localhost [127.0.0.1])
	by no.baka.org (8.14.4/8.14.0) with ESMTP id p7VGLDlm015261;
	Wed, 31 Aug 2011 12:21:13 -0400
In-reply-to: <CAKjsY4nsPNO_kvxeime8qcNrRFykgG2TOYxJ0HKbj2zR5Rwv+Q@mail.gmail.com>
Comments: In reply to a message from "Ryan Wexler <ryan@iridiumsuite.com>" dated "Wed, 31 Aug 2011 09:10:01 -0700."
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180478>


In message <CAKjsY4nsPNO_kvxeime8qcNrRFykgG2TOYxJ0HKbj2zR5Rwv+Q@mail.gm=
ail.com>, Ryan Wexler writes:

    > # Cause git to delete all files in the internal index
    > git read-tree --reset -i 4b825dc642cb6eb9a060e54bf8d69288fbee4904
    > # Cause git to delete all files in the working directory
    > git clean -dfx

    > The only "magic" is the read-tree/git-clean stuff. =A0The 4b82=85
    > value is the SHA of an empty tree. =A0It could be replaced by
    > a:
    >
    > find . -maxdepth 1 ! -name '.git' -a ! -name '..' -a ! -name '.' =
-print0 | xargs -0 rm -rf

    I have to say that I am lost by the "magic" you describe.  I don't
    understand what you mean by the 4b82... value should be replaced by
    the find | xargs remove all command.   That command looks like it j=
ust
    deletes all the "." file names?  But when you say replace I thought
    you would mean I need to generate a new value to replace that magic
    number??  Confused...

I was just trying to explain what the git-read-tree and git-clean
commands are doing.  The long string starting with 4b825d is a special
SHA that git knows represents an empty tree.  I was saying that you
*could* (not should) replace the two commands (git-read-tree and
git-clean) with the "find | xargs rm" command I quoted.  The two sets
of commands are equivalent.

Also, if you look at the find command, I am finding everything
*except* the .git . and .. directories

					-Seth Robertson
