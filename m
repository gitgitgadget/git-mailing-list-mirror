From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Running git-archive recursively over submodules
Date: Tue, 16 Feb 2010 11:01:42 +0100
Message-ID: <201002161101.42493.trast@student.ethz.ch>
References: <201002152156.17132.trast@student.ethz.ch> <4B7A4B60.3090401@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Feb 16 11:02:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhKFd-000893-3L
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 11:01:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756870Ab0BPKBp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 05:01:45 -0500
Received: from gwse.ethz.ch ([129.132.178.237]:17763 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756851Ab0BPKBp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 05:01:45 -0500
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.234.1; Tue, 16 Feb
 2010 11:01:42 +0100
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Tue, 16 Feb
 2010 11:01:42 +0100
User-Agent: KMail/1.13.0 (Linux/2.6.31.12-0.1-desktop; KDE/4.4.0; x86_64; ; )
In-Reply-To: <4B7A4B60.3090401@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140088>

On Tuesday 16 February 2010 08:38:08 Michael J Gruber wrote:
> Thomas Rast venit, vidit, dixit 15.02.2010 21:56:
> > while git ls-files -s | grep -q ^160000; do
> >     read_one_level
> > done
> 
> Am I blind, not seeing a recursion, or is there simply none? I reckon
> you're reading the super project and one level of submodules into the
> temporary index - which is fine for most purposes, of course. I would
> say this is iterating over the submodules of the super project.

Well, the while condition reads "while there are submodule entries in
my index".  The read_one_level function then replaces those submodules
with their corresponding trees, which of course may again contain
submodule entries.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
