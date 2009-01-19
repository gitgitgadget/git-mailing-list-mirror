From: thestar@fussycoder.id.au
Subject: An idea: maybe Git should use a lock/unlock file mode for
	problematic files? [Was: Re: after first git clone of linux kernel
	repository there are changed files in working dir]
Date: Tue, 20 Jan 2009 10:52:28 +1100
Message-ID: <20090120105228.xbo3gyc0odwcgcsc@webmail.fussycoder.id.au>
References: <d304880b0812101019ufe85095h46ff0fe00d32bbd0@mail.gmail.com>
	<d304880b0812101022u2abe5d68ub3bda68ed39f830b@mail.gmail.com>
	<83ocy3fmez.fsf@kalahari.s2.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	DelSp=Yes	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: rdkrsr <rdkrsr@googlemail.com>, git@vger.kernel.org
To: Hannu Koivisto <azure@iki.fi>
X-From: git-owner@vger.kernel.org Tue Jan 20 00:54:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LP3wt-0007yk-DG
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 00:54:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756763AbZASXwm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 18:52:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755315AbZASXwk
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 18:52:40 -0500
Received: from cherry.cbr.hosting-server.com.au ([203.88.118.153]:57729 "EHLO
	cherry.cbr.hosting-server.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760718AbZASXwh convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 18:52:37 -0500
Received: (qmail 30738 invoked by uid 48); 20 Jan 2009 10:52:28 +1100
Received: from  ( [unknown]) by webmail.fussycoder.id.au (Horde MIME
	library) with HTTP; Tue, 20 Jan 2009 10:52:28 +1100
In-Reply-To: <83ocy3fmez.fsf@kalahari.s2.org>
Content-Disposition: inline
User-Agent: Internet Messaging Program (IMP) H3 (4.1.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106412>

Quoting Hannu Koivisto <azure@iki.fi>:
<snip>
> Kernel source contains pairs of files whose names differ only by
> case.  Windows cannot store such pairs (at least by default) and
> apparently there is no support for such a situation in git so
> you'll only get one file from each pair to your workspace and the
> other file is shown as modified.

Could git be modified to allow such repositories to be used on windows  
by locking files that are problematic, for example, a given repository  
could have files 'AAA' and 'aAa'.

The one that correctly represents the on-disk file would be 'open for  
edit', while the other file would be locked.  To edit the other file,  
the existing file would need to be locked, and then the other file  
would then need to be open for edit.

This could even be extended to allow one to "open file AAA for edit as  
aAa.v2', giving the file an alternate name.

Such a workflow would only need to be used for such files, and could  
also be used when there are incompatible file names for that given  
partition type.
