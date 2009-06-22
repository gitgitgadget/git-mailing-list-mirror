From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: git diff --chunk-pickaxe?
Date: Mon, 22 Jun 2009 14:48:44 +0200
Message-ID: <4A3F7DAC.3090709@lsrfire.ath.cx>
References: <fcaeb9bf0906220507q45a61dc3w25ad41a4a65a2d5a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 22 14:49:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIixJ-0003XC-Gi
	for gcvg-git-2@gmane.org; Mon, 22 Jun 2009 14:49:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751562AbZFVMsw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Jun 2009 08:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751501AbZFVMsv
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jun 2009 08:48:51 -0400
Received: from india601.server4you.de ([85.25.151.105]:43672 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751256AbZFVMsv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2009 08:48:51 -0400
Received: from [10.0.1.101] (p57B7CB36.dip.t-dialin.net [87.183.203.54])
	by india601.server4you.de (Postfix) with ESMTPSA id B6FE42F8066;
	Mon, 22 Jun 2009 14:48:52 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <fcaeb9bf0906220507q45a61dc3w25ad41a4a65a2d5a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122033>

Nguyen Thai Ngoc Duy schrieb:
> What I want is only show diff chunks that add or remove a line that
> does not start with '#', something like a chunk-level pickaxe. Any
> pointer where to start? It looks like I can start from
> xdi_diff_outf(). Just wanted to make sure I won't follow a wrong way
> from the beginning.

How about creating an external diff driver instead?  It could remove al=
l
lines starting with '#', or normalize such lines to just '#' in case yo=
u
need the line numbers to remain unchanged, then write the filtered
result into temporary files and compare them with diff.  Perhaps this i=
s
sufficient for your purposes?  It should be easier to implement.

(Keywords: GIT_EXTERNAL_DIFF, --ext-diff, diff.<name>.command)

Ren=C3=A9
