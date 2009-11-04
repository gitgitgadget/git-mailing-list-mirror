From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: [PATCH 0/2] Set Makefile variables from configure
Date: Wed,  4 Nov 2009 13:05:58 -0500
Message-ID: <1257357960-12763-1-git-send-email-bwalton@artsci.utoronto.ca>
References: <20091103222123.GA17097@progeny.tock>
Cc: Ben Walton <bwalton@artsci.utoronto.ca>
To: gitster@pobox.com, jrnieder@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 04 19:06:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5kFN-0006we-6c
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 19:06:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbZKDSGE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 13:06:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932209AbZKDSGD
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 13:06:03 -0500
Received: from www.cquest.utoronto.ca ([192.82.128.5]:49367 "EHLO
	www.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932182AbZKDSGD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 13:06:03 -0500
Received: from ntdws12.chass.utoronto.ca ([128.100.160.253]:59405 ident=93)
	by www.cquest.utoronto.ca with esmtp (Exim 4.43)
	id 1N5kFC-0001Px-EE; Wed, 04 Nov 2009 13:06:06 -0500
Received: from localhost
	([127.0.0.1] helo=ntdws12.chass.utoronto.ca ident=505)
	by ntdws12.chass.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1N5kFC-0003KT-BY; Wed, 04 Nov 2009 13:06:06 -0500
Received: (from bwalton@localhost)
	by ntdws12.chass.utoronto.ca (8.13.8/8.13.8/Submit) id nA4I665b012797;
	Wed, 4 Nov 2009 13:06:06 -0500
X-Mailer: git-send-email 1.6.5
In-Reply-To: <20091103222123.GA17097@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132105>

Ok, a second attempt, taking into account Jonathan's feedback and
proposed updates.  The revised macro allows for specified help text.

I opted to use a more 'dry' approach to the macro instead of repeating
the boilerplate AC_WITH_ARG bits when calling this feature.

Additionally, I only WARN when 'yes' or 'no' is passed.  Bailing on
errors in most cases is reasonable, but I don't think it's globally
appropriate.

As to why I want this...It's cleaner, in my opinion, to do all build
configuration through a single mechanism than to do most with
./configure and the rest with variables passed to make.  In other
words, this is purely a style issue.

I like the extension of config.mak.in to support more of the autoconf
variables as well and would like to see it applied.

Ben Walton (2):
  configure: add macro to set arbitrary make variables
  configure: add settings for gitconfig, editor and pager

 configure.ac |   43 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 43 insertions(+), 0 deletions(-)
