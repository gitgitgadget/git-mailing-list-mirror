From: Stefan Bienert <bienert@zbh.uni-hamburg.de>
Subject: pre-commit hook and Aspell
Date: Fri, 30 Jul 2010 10:51:28 +0200
Message-ID: <4C529290.7040509@zbh.uni-hamburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 30 11:01:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OelSx-0008LT-Nj
	for gcvg-git-2@lo.gmane.org; Fri, 30 Jul 2010 11:01:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755987Ab0G3JBO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jul 2010 05:01:14 -0400
Received: from mailhost.uni-hamburg.de ([134.100.32.155]:58742 "EHLO
	mailhost.uni-hamburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754432Ab0G3JBN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jul 2010 05:01:13 -0400
X-Greylist: delayed 580 seconds by postgrey-1.27 at vger.kernel.org; Fri, 30 Jul 2010 05:01:13 EDT
Received: from localhost (localhost [127.0.0.1])
	by mailhost.uni-hamburg.de (Postfix) with ESMTP id 7268390F66
	for <git@vger.kernel.org>; Fri, 30 Jul 2010 10:51:32 +0200 (CEST)
X-Virus-Scanned: by University of Hamburg (RRZ/mailhost)
Received: from mailhost.uni-hamburg.de ([127.0.0.1])
	by localhost (mailhost.uni-hamburg.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id TK3ZeDb+Li6d for <git@vger.kernel.org>;
	Fri, 30 Jul 2010 10:51:32 +0200 (CEST)
Received: from wendelstein.zbh.uni-hamburg.de (wendelstein.zbh.uni-hamburg.de [134.100.209.3])
	by mailhost.uni-hamburg.de (Postfix) with ESMTP id 5E8C090126
	for <git@vger.kernel.org>; Fri, 30 Jul 2010 10:51:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by wendelstein.zbh.uni-hamburg.de (Postfix) with ESMTP id 4506020101
	for <git@vger.kernel.org>; Fri, 30 Jul 2010 10:51:32 +0200 (CEST)
Received: from wendelstein.zbh.uni-hamburg.de ([127.0.0.1])
 by localhost (wendelstein [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 30117-01 for <git@vger.kernel.org>; Fri, 30 Jul 2010 10:51:28 +0200 (CEST)
Received: from [134.100.209.86] (worms.zbh.uni-hamburg.de [134.100.209.86])
	by wendelstein.zbh.uni-hamburg.de (Postfix) with ESMTP id C7D13164B50
	for <git@vger.kernel.org>; Fri, 30 Jul 2010 10:51:28 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.24 (X11/20100228)
X-Enigmail-Version: 0.96.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152233>

Hi gits,

as instructed by the wiki, I just sent an request to the list without
being subscribed...

I'm trying to setup a hook for my project which forces me to check the
spelling of text (here: TeX) files, whenever they change. As
spellchecker I use Aspell, which is giving me a headache at the moment.
The problem is: Running the pre-commit script in the shell works,
started as hook does not.

Here is my script (cut down to a minimalist version resembling the problem):

# SNIP
#!/bin/sh

for my_p in $(git status --porcelain | awk '{ if ($0 ~ /\.(tex|sty)$/) {
print $2 } }')
do
    aspell -c -l en_GB -p $(pwd)/${my_cdup}share/dict/aspell.corb.pws
$my_p || exit 1
done
# SNAP

regards,

Stefan

-- 
Stefan Bienert
Zentrum fuer Bioinformatik
Universitaet Hamburg
Bundesstrasse 43
20146 Hamburg
Germany

Email: bienert@zbh.uni-hamburg.de
Phone:  +49 (40) 42838 7345
Fax:    +49 (40) 42838 7332
