From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH 0/2] submodules: Use relative paths to gitdir and work tree
Date: Wed, 08 Feb 2012 23:08:18 +0100
Message-ID: <4F32F252.7050105@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Antony Male <antony.male@gmail.com>,
	Phil Hord <phil.hord@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 08 23:08:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvFgh-0007si-5M
	for gcvg-git-2@plane.gmane.org; Wed, 08 Feb 2012 23:08:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756004Ab2BHWIW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Feb 2012 17:08:22 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:38297 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755711Ab2BHWIV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Feb 2012 17:08:21 -0500
Received: from moweb002.kundenserver.de (moweb002.kundenserver.de [172.19.20.108])
	by fmmailgate02.web.de (Postfix) with ESMTP id 964AC1C0B4CFA
	for <git@vger.kernel.org>; Wed,  8 Feb 2012 23:08:20 +0100 (CET)
Received: from [192.168.178.20] ([91.3.188.62]) by smtp.web.de (mrweb001) with
 ESMTPA (Nemesis) id 0McneT-1SD3eU1bRh-00I5H3; Wed, 08 Feb 2012 23:08:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:10.0) Gecko/20120129 Thunderbird/10.0
X-Provags-ID: V02:K0:Zgi/GLwZucpYd8EI8iSahaoZwIaOVcXPoYRuLNOlO4c
 a78BUbZPvaEyzCFIAjuAkjMIAHL76RurCCMsnRkdW0vKwhg0Ex
 FuvzdzecJBD0/nVmucGLYZ8F4VDsQGsj+KVFjjB7tgRBed7GMg
 h+ubVfnCB07iTGJ2b6WhVIx0D3bjBWNOIiQkizKeN+vOTTKPCV
 h+VvtcQ5DgeOLI3Rr6/wQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190258>

This patch series replaces all absolute paths pointing from submodule work
trees to its gitdir and back with relative paths as discussed in $gmane/187785.

The motivation is to make superprojects movable again. They lost this ability
with the move of the git directory of submodules into the .git/modules directory
of the superproject. While fixing that a bug which would hit when moving the
submodule inside the superproject was also fixed.

Jens Lehmann (2):
  submodules: always use a relative path to gitdir
  submodules: always use a relative path from gitdir to work tree

 git-submodule.sh           |   23 ++++++++++++++++-------
 t/t7400-submodule-basic.sh |   22 ++++++++++++++++++++++
 2 files changed, 38 insertions(+), 7 deletions(-)

-- 
1.7.9.190.gb17a42.dirty
