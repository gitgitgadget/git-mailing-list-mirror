From: Mathias Lafeldt <misfire@debugon.org>
Subject: Re: [BUG] git-svn parses --pretty=medium log output, fails when log.decorate
 is true
Date: Tue, 05 Oct 2010 13:48:35 +0200
Message-ID: <4CAB1093.7000204@debugon.org>
References: <1286273926.2364.6.camel@wpalmer.simply-domain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>, Eric Wong <normalperson@yhbt.net>
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 05 13:49:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P361F-0001tJ-6F
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 13:49:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758243Ab0JELsu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Oct 2010 07:48:50 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:56102 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758209Ab0JELss (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Oct 2010 07:48:48 -0400
Received: from [172.20.2.23] (p578D1B33.dip.t-dialin.net [87.141.27.51])
	by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
	id 0MUjoe-1PFIJC22Mm-00YjMc; Tue, 05 Oct 2010 13:48:43 +0200
User-Agent: Thunderbird 2.0.0.24 (X11/20100411)
In-Reply-To: <1286273926.2364.6.camel@wpalmer.simply-domain>
X-Provags-ID: V02:K0:jSB2+NC29iaA4552q4d3T9w3RMbIv1uVAvOd7TLwIbg
 +6xLB9MAk6w+KdLlXpNOKYG5AUu2TjIz59ag/+m1Vim4hDofQ/
 oze64Pb2G5yGKyFiQX0r8R7/qo3Or28ZPx8seGxrc0xxJvIHSI
 I0PQ0DkRs0s6Aub7EsRbpFxttwCAsKRjwataEVbF4xo5QE25Ds
 tiQnnNMfJ0jGNrd8GYx7pyKCLpiLxsy1CWGefCZW7M=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158189>

Will Palmer wrote:
> I started receiving this error during "git svn dcommit" today:
> 
> Use of uninitialized value $hash in string eq
> at /home/wpalmer/libexec/git-core/git-svn line 1534.
> 
> Examining that section reveals that git-svn is running 
> "git log --no-color --first-parent --pretty=medium"
> 
> and parsing the output in order to find commit hashes and git-svn-id:
> lines. This breaks when log.decorate is true.
> 
> This could be patched-up by adding "--no-decorate" to the options
> git-svn passes, but that seems to me like it would just be adding to the
> pile, as "--pretty=medium" is a moving target. I assume the correct
> solution is to specify the format exactly as it is expected.

I recently submitted a patch adding --no-decorate:
http://article.gmane.org/gmane.comp.version-control.git/156919

And it's already in Eric's git-svn branch:
git://git.bogomips.org/git-svn

-Mathias
