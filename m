From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: branch.<branch>.merge and --format='%(upstream)'
Date: Tue, 16 Jun 2009 13:08:02 +0200
Message-ID: <adf1fd3d0906160408s668f7a3fj5725cc4e98b317fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 16 13:08:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGWWR-0007qa-IV
	for gcvg-git-2@gmane.org; Tue, 16 Jun 2009 13:08:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752005AbZFPLIC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2009 07:08:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751534AbZFPLIB
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jun 2009 07:08:01 -0400
Received: from mail-fx0-f211.google.com ([209.85.220.211]:51416 "EHLO
	mail-fx0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751361AbZFPLIA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2009 07:08:00 -0400
Received: by fxm7 with SMTP id 7so542371fxm.37
        for <git@vger.kernel.org>; Tue, 16 Jun 2009 04:08:02 -0700 (PDT)
Received: by 10.204.65.65 with SMTP id h1mr8128485bki.26.1245150482434; Tue, 
	16 Jun 2009 04:08:02 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121671>

Hi,

  I've noticed that having branch.<branch>.merge set with the branch
name, and not with the full ref, cause problems with
--format='%(upstream)'  and also with the "branch -av" and "git
status" upstream branch outputs. But git-fetch and git-pull works ok,
so it is a valid setting.

$ git clone git.git
$ cd git
$ git config branch.master.merge
refs/heads/master
$ git for-each-ref --format='%(upstream)' refs/heads/master
refs/remotes/origin/master
$ git config branch.master.merge master
$ git config branch.master.merge
master
$ git for-each-ref --format='%(upstream)' refs/heads/master

$

Best regards,
Santi
