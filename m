From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: non-US-ASCII file names (e.g. Hiragana) on Windows
Date: Sat, 28 Nov 2009 21:00:22 +0100
Message-ID: <200911282100.23000.j6t@kdbg.org>
References: <4B1168D4.5010902@syntevo.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Thomas Singer <thomas.singer@syntevo.com>
X-From: git-owner@vger.kernel.org Sat Nov 28 21:00:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NETTJ-0003Sl-HU
	for gcvg-git-2@lo.gmane.org; Sat, 28 Nov 2009 21:00:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753561AbZK1UAd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Nov 2009 15:00:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753268AbZK1UAd
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Nov 2009 15:00:33 -0500
Received: from [93.83.142.38] ([93.83.142.38]:50248 "EHLO dx.sixt.local"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753226AbZK1UAc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Nov 2009 15:00:32 -0500
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 449E919F632;
	Sat, 28 Nov 2009 21:00:23 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <4B1168D4.5010902@syntevo.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133980>

On Samstag, 28. November 2009, Thomas Singer wrote:
> I've created a file with unicode characters in its name (using Java):
>
>  new File(dir, "\u3041\u3042\u3043\u3044").createNewFile();
>...
> $ git add .
> fatal: unable to stat '????': No such file or directory
>
> What should I do to make Git recognize these characters?

You cannot on a German Windows.

You can switch your Windows to Japanese (not the UI, just the codepage 
aka "locale"; yes, that's possible, I have such a setup), but even then the 
characters of the file name will be recorded in Shift-JIS encoding, not UTF-8 
or Unicode. When you later switch back to German, these bytes will be 
interpreted as cp850 or cp1252 text and displayed accordingly.

-- Hannes
