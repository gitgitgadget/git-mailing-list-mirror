From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH v3 0/7] Teach fetch/pull the on-demand mode and make it the
 default
Date: Sun, 06 Mar 2011 23:09:32 +0100
Message-ID: <4D74061C.5050908@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 06 23:09:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwM95-0007a4-Jn
	for gcvg-git-2@lo.gmane.org; Sun, 06 Mar 2011 23:09:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753866Ab1CFWJn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Mar 2011 17:09:43 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:33711 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752222Ab1CFWJm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Mar 2011 17:09:42 -0500
Received: from smtp04.web.de  ( [172.20.0.225])
	by fmmailgate02.web.de (Postfix) with ESMTP id 0B03119A20BDB;
	Sun,  6 Mar 2011 23:09:41 +0100 (CET)
Received: from [93.246.45.11] (helo=[192.168.178.43])
	by smtp04.web.de with asmtp (WEB.DE 4.110 #2)
	id 1PwM8y-0002oF-00; Sun, 06 Mar 2011 23:09:41 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.14) Gecko/20110221 Thunderbird/3.1.8
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX198S8cOXHAQJO5L38hyyrRuNb9S17/A2+sQ/D0u
	qXrKr1o2dKpSMXLZMwbZaZLEiNv7o1pHoDuipKmO12GWBcmEOL
	R2ON17j1GAoeyFJmyrng==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168535>

Here is v3 of this patch series. Changes to v2 are:

*) Changed some documentation texts as proposed by Marc
*) Renamed the "--submodule-default" option to "--recurse-submodules-default"
*) Fixed some typos in the BUGS section

Jens Lehmann (7):
  fetch/pull: recurse into submodules when necessary
  fetch/pull: Add the 'on-demand' value to the --recurse-submodules
    option
  config: teach the fetch.recurseSubmodules option the 'on-demand'
    value
  Submodules: Add 'on-demand' value for the 'fetchRecurseSubmodule'
    option
  fetch/pull: Don't recurse into a submodule when commits are already
    present
  submodule update: Don't fetch when the submodule commit is already
    present
  fetch/pull: Describe --recurse-submodule restrictions in the BUGS
    section

 Documentation/config.txt        |   12 ++-
 Documentation/fetch-options.txt |   25 ++++-
 Documentation/git-fetch.txt     |    9 ++
 Documentation/git-pull.txt      |   11 ++-
 Documentation/gitmodules.txt    |    4 +-
 builtin/fetch.c                 |   48 ++++++--
 git-pull.sh                     |    3 +
 git-submodule.sh                |    5 +-
 submodule.c                     |  152 +++++++++++++++++++++--
 submodule.h                     |   11 ++-
 t/t5526-fetch-submodules.sh     |  255 +++++++++++++++++++++++++++++++++++++++
 t/t7403-submodule-sync.sh       |    2 +-
 t/t7406-submodule-update.sh     |   20 +++
 13 files changed, 520 insertions(+), 37 deletions(-)

-- 
1.7.4.1.300.g29eea0
