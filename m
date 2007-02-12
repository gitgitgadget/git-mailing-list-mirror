From: David Lang <david.lang@digitalinsight.com>
Subject: Re: mingw, windows, crlf/lf, and git
Date: Sun, 11 Feb 2007 23:28:02 -0800 (PST)
Message-ID: <Pine.LNX.4.63.0702112325560.6287@qynat.qvtvafvgr.pbz>
References: <45CFA30C.6030202@verizon.net> <20070212042425.GB18010@thunk.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Mark Levedahl <mlevedahl@verizon.net>,
	Git Mailing List <git@vger.kernel.org>
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Mon Feb 12 08:46:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGVt8-0001MC-Vr
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 08:46:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933105AbXBLHnm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 02:43:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933088AbXBLHnD
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 02:43:03 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:62637 "HELO
	warden.diginsite.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S964774AbXBLHmo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 02:42:44 -0500
Received: from wlvims02.diginsite.com by warden.diginsite.com
          via smtpd (for vger.kernel.org [209.132.176.167]) with SMTP; Sun, 11 Feb 2007 23:42:43 -0800
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvims02.corp.ad.diginsite.com with InterScan Message Security Suite; Sun, 11 Feb 2007 23:42:34 -0800
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <20070212042425.GB18010@thunk.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39383>

On Sun, 11 Feb 2007, Theodore Tso wrote:

> Then for each file type, we implement a set of interfaces (perhaps as
> simple as a series of executables named git-<type>-<operation>) which
> if present, transforms the file from its live format to the canonical
> format which is actually checked in and back again.  Besides using
> this for the DOS CR/LF problem, it also allows for an efficient
> storage of things like OpenOffice files which are a zipped set of .xml
> files.  By decompressing them before pushing them into the SCM, it
> means that if the user makes a tiny spelling correction in their
> OpenOffice file, the delta stored in the git repository can be much
> more efficiently stored (since the diff of the .xml tree will be
> small, where as the diff of the entire compressed file is likely going
> to be close to the entire size of the .odt file).
>
> Another nice thing to provide for each file type would be a
> pretty-printer for the diffs, so it becomes easier to see the delta
> between two versions of an OpenOffice file in a textual window.
>
> So, is this idea sane or completely insane?  Hopefully it passes
> Linus's it-solves-multiple-problems-at-once test, at least.  :-)

there have been other things discussed that could use the 'do this on checkout' 
hooks, specificly on the issue of useing git to manage /etc the need to 
save/restore permissions requires a hook on checkout that doesn't exist yet. 
this sounds like it would solve that problem as well.

David Lang
