From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 0/6] Allow custom merge strategies, take 2
Date: Mon, 28 Jul 2008 03:21:04 +0200
Message-ID: <cover.1217207602.git.vmiklos@frugalware.org>
References: <cover.1217037178.git.vmiklos@frugalware.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 28 03:21:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNHQr-000771-Su
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 03:21:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751012AbYG1BUq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jul 2008 21:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750936AbYG1BUq
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jul 2008 21:20:46 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:41570 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750736AbYG1BUq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jul 2008 21:20:46 -0400
Received: from vmobile.example.net (catv-5062e651.catv.broadband.hu [80.98.230.81])
	by yugo.frugalware.org (Postfix) with ESMTP id 731861DDC5C
	for <git@vger.kernel.org>; Mon, 28 Jul 2008 03:20:43 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 1F3CB1AA738; Mon, 28 Jul 2008 03:21:11 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.rc0.14.g95f8.dirty
In-Reply-To: <cover.1217037178.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90385>

Hi,

This is just a resend of my series, on top of Dscho's "Avoid chdir() in
list_commands_in_dir()" (f5d600e), including the suggestions I received
from Jonathan Nieder and Dscho.

Miklos Vajna (6):
  builtin-help: make is_git_command() usable outside builtin-help
  builtin-help: make list_commands() a bit more generic
  builtin-help: make it possible to exclude some commands in
    list_commands()
  builtin-merge: allow using a custom strategy
  builtin-merge: avoid non-strategy git-merge commands in error message
  Add a new test for using a custom merge strategy

 Makefile                |    1 +
 builtin-merge.c         |   32 +++++++++++++++++++++------
 help.c                  |   55 ++++++++++++++++++++++++-----------------------
 help.h                  |   19 ++++++++++++++++
 t/t7606-merge-custom.sh |   45 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 118 insertions(+), 34 deletions(-)
 create mode 100644 help.h
 create mode 100755 t/t7606-merge-custom.sh
