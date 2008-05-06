From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: Binary files in format-patch
Date: Tue, 6 May 2008 11:19:14 +0200
Message-ID: <200805061119.14792.robin.rosenberg.lists@dewire.com>
References: <d280d7f10805051555x67bd7e87o999a2c9e19663b92@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: "Caio Marcelo" <cmarcelo@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 06 11:20:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtJLf-0007t5-NJ
	for gcvg-git-2@gmane.org; Tue, 06 May 2008 11:20:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765226AbYEFJTl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2008 05:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765208AbYEFJTl
	(ORCPT <rfc822;git-outgoing>); Tue, 6 May 2008 05:19:41 -0400
Received: from [83.140.172.130] ([83.140.172.130]:25199 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1765191AbYEFJTj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2008 05:19:39 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id E6308147BE58;
	Tue,  6 May 2008 11:19:37 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 58e6ox4DviTK; Tue,  6 May 2008 11:19:37 +0200 (CEST)
Received: from [10.9.0.10] (unknown [10.9.0.10])
	by dewire.com (Postfix) with ESMTP id 3C473147BE57;
	Tue,  6 May 2008 11:19:37 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <d280d7f10805051555x67bd7e87o999a2c9e19663b92@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81347>

tisdagen den 6 maj 2008 00.55.06 skrev Caio Marcelo:
> Hello,
>
> I'm using "git format-patch" to generate messages for a code review
> mailing list. It work fine except when we have binary files involved.
> Their contents are not relevant for us, and doesn't help much in a
> mailing list. Taking a peek at the code I've found out this:

> In commit e47f306d4bf964def1a0b29e8f7cea419471dffd (short name: "git
> format-patch: make --binary on by default"), we add a new restriction
> on the possible options to format-patch: if you don't specify --text,
> it enables --binary. But looking at today's code, we have a path that
> is never taken for format-patch, in function builtin_diff (diff.c), at
> lines 1423 to 1433. The fprintf doesn't ever happen, because if it's
> TEXT, it dumps the contents verbatim, if it's BINARY, it encodes (to
> some baseXX) the files/diff.
>
> Wouldn't be nice to allow this code path to happen via some
> --omit-binary / --no-binary option to be checked in cmd_format_patch?
> (I could provide a patch for this, if you think it's a good idea).

Sounds reasonable.  I'd say --no-binary is the right one here.

-- robin
