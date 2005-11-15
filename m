From: =?ISO-8859-1?Q?Lukas_Sandstr=F6m?= <lukass@etek.chalmers.se>
Subject: Deprecate --cache.* ?
Date: Tue, 15 Nov 2005 23:19:52 +0100
Message-ID: <437A5F08.7020908@etek.chalmers.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Nov 15 23:22:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ec99E-0004kZ-KC
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 23:19:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932195AbVKOWT0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 17:19:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932197AbVKOWT0
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 17:19:26 -0500
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:20665 "EHLO
	pne-smtpout2-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S932195AbVKOWTZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2005 17:19:25 -0500
Received: from [192.168.0.82] (213.66.95.18) by pne-smtpout2-sn2.hy.skanova.net (7.2.060.1)
        id 4378EBDA00073EDF; Tue, 15 Nov 2005 23:19:24 +0100
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051015)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11952>

Currently, most of the remaining references to "cache" in Documantation/
are related to the --cache.* flag of four git commands.

git-dif-*index* uses --cached to mean "do not consider on-disk files at all"

git-fsck-objects uses --cache to consider index entries as head nodes for 
unreachability traces.

git-ls-files --cached shows all files recorded in the index.

git-update-*index* --cacheinfo is used to place a "fake" entry in the index

git-update-index also has the option --index-info which does something different.

My suggestion is that these cache-references be deprecated in favor of
--index, --in-index, --index-only, --insert-index, or something along those lines.

Backward compability could be ensured by having both versions of the flags
around for a while and issuing a warning when the old form is used.

Good idea? Bad? Stupid? Do we want to keep "cache" around?
