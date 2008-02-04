From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: man pages are littered with .ft C and others
Date: Tue, 5 Feb 2008 00:26:21 +0100
Message-ID: <200802050026.22262.jnareb@gmail.com>
References: <alpine.DEB.1.00.0802021055180.21831@an.sumeria> <200802031139.48752.jnareb@gmail.com> <20080204220120.GA23798@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Adam Flott <adam@npjh.com>,
	git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Tue Feb 05 00:27:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMAid-0006kT-0k
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 00:27:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755215AbYBDX0e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 18:26:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755248AbYBDX0e
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 18:26:34 -0500
Received: from fk-out-0910.google.com ([209.85.128.191]:28280 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754237AbYBDX0c (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 18:26:32 -0500
Received: by fk-out-0910.google.com with SMTP id z23so2110587fkz.5
        for <git@vger.kernel.org>; Mon, 04 Feb 2008 15:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=BiDE2Um9JKgxnVaxQOHwfrrHCndygs5aNJp705VzVHo=;
        b=MDerkgjMtLxrkFoCEYLxdTEvY2uRRl7h8R3uU0nWFmsfkxTDA07AfeAGeY/QOO5wRox6RbnkOkoc9H4ifTvJ9t0McdBuG2v7D50gFDgmV6+lXZzsF+HSqQq9XMArE5F/SYl6sKgVtNGWBxVVerbnMDjkv2jUSJyVSWYiTBZ3teM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=FZHVL/zyZIL3ouqLsiNrtP+wFl+p8YM9ht3CHm4WvkP0keTN1/lI+k5/sHFeKHK6TC3f0007CWBoQJ3ffwUbr9FeEhCoqi2VZhnMcxhMhtUXrXJp94yO+651erxIzRA9ORhduynoWoIz/OgxVvpgpE9k4tW9l6WhpKi1P9DG8RA=
Received: by 10.82.153.5 with SMTP id a5mr14087090bue.9.1202167590947;
        Mon, 04 Feb 2008 15:26:30 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.221.201])
        by mx.google.com with ESMTPS id b36sm2928677ika.2.2008.02.04.15.26.27
        (version=SSLv3 cipher=OTHER);
        Mon, 04 Feb 2008 15:26:29 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20080204220120.GA23798@diku.dk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72590>

On Mon, 4 Feb 2008, Jonas Fonseca wrote:
> Jakub Narebski <jnareb@gmail.com> wrote Sun, Feb 03, 2008:
> > Junio C Hamano wrote:
> > > Jakub Narebski <jnareb@gmail.com> writes:
> > >
> > > [From] http://thread.gmane.org/gmane.comp.version-control.git/53457/focus=53458
> > Julian Phillips:
> > > Are you using docbook xsl 1.72?  There are known problems building the 
> > > manpages with that version.  1.71 works, and 1.73 should work when it get 
> > > released.
> 
> I was able to solve this problem with this patch, which adds a XSL file
> used specifically for DOCBOOK_XSL_172=YesPlease and where dots and
> backslashes are escaped properly so they won't be substituted to the
> wrong thing further down the "DocBook XSL pipeline". Doing the escaping
> in the existing callout.xsl breaks v1.70.1. Hopefully v1.73 will end
> this part of the manpage nightmare.

I have applied this patch, and it makes manpages worse, not better.
I use DocBook XSL version 1.68.1

[...]
> > Besids, I have different set of problems; only with literal blocks.
> > So while DOCBOOK_XSL_172 is not set... let me check...
> > 
> > Hmmm...
> > 
> > Before
> > $ man git-diff-tree
> > 
> >        Example:
> > 
> >        .ft C
> >        :100644 100644 5be4a4...... 000000...... M file.c
> >        .ft
> > 
> > $ make DOCBOOK_XSL_172=YesPlease doc
> > $ man Documentation/git-diff-tree.1
> > 
> >        Example:
> > 
> >               :100644 100644 5be4a4...... 000000...... M file.cWhen -z  option  is
> >               not  used, TAB, LF, and backslash characters in pathnames are repre-
> >               sented as \t, \n, and \\, respectively.
> > 
> > So setting DOCBOOK_XSL_172 while it fixes the bug (even if docbook-xsl
> > is version 1.68.1, not 1.72), but introduces another.
> > 
> > Unfortunately I don't know enough about AsciiDoc, DocBook and XML
> > toolchain to even *try* to fix this issue.
> 
> I have no idea what this could be. The literallayout block is
> overwritten in Documentation/asciidoc.conf unless when DOCBOOK_XSL_172
> is set. Newer AsciiDoc installations seem to use a different set of
> DocBook tags than what is overwritten by git's asciidoc.conf.

Now I have in git-diff-tree(1), result of (after applying above patch)
$ man Documentation/git-diff-tree.1

       git-diff-files [<pattern>...]
              compares the index and the files on the filesystem.

              An output line is formatted this way:

              in-place   edit    :100644  100644  bcd1234...  0123456...  M  file0
              copy-edit      :100644 100644 abcd123... 1234567... C68 file1  file2
              rename-edit     :100644 100644 abcd123... 1234567... R86 file1 file3
              create         :000000 100644 0000000... 1234567... A  file4  delete
              :100644  000000 1234567... 0000000... D file5 unmerged       :000000
              000000 0000000... 0000000... U file6That is, from the  left  to  the
              right:

[...]

       Example:

              :100644 100644 5be4a4...... 000000...... M file.cWhen -z  option  is
              not  used, TAB, LF, and backslash characters in pathnames are repre-
              sented as \t, \n, and \\, respectively.


Compare this to output of "man git-diff-tree", same situation, compiled
from SRPM, without any aditional options:

       git-diff-files [<pattern>...]
              compares the index and the files on the filesystem.

              An output line is formatted this way:

              .ft C
              in-place edit  :100644 100644 bcd1234... 0123456... M file0
              copy-edit      :100644 100644 abcd123... 1234567... C68 file1 file2
              rename-edit    :100644 100644 abcd123... 1234567... R86 file1 file3
              create         :000000 100644 0000000... 1234567... A file4
              delete         :100644 000000 1234567... 0000000... D file5
              unmerged       :000000 000000 0000000... 0000000... U file6
              .ft

              That is, from the left to the right:

[...]

       Example:

       .ft C
       :100644 100644 5be4a4...... 000000...... M file.c
       .ft

       When -z option is not used, TAB, LF, and backslash characters in  pathnames
       are represented as \t, \n, and \\, respectively.


HTH.

P.S. writing subset of AsciiDoc in Perl, which would write manpages, HTML
and perhaps info/texinfo files directly, without fragile xmlto toolchain,
looks better and better...

$ asciidoc --version
asciidoc 7.1.2
$ rpm -qa docbook*         
docbook-utils-0.6.14-4
docbook-style-xsl-1.68.1-1
docbook-style-dsssl-1.79-1
docbook-utils-pdf-0.6.14-4
docbook-dtds-1.0-26
$ xmlto --version
xmlto version 0.0.18
-- 
Jakub Narebski
Poland
