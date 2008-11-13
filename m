From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH v2 00/11] gitweb: display remote heads
Date: Thu, 13 Nov 2008 23:49:06 +0100
Message-ID: <1226616555-24503-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 13 23:50:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0l0s-0004Vv-OU
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 23:50:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751696AbYKMWsz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 17:48:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752007AbYKMWsz
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 17:48:55 -0500
Received: from mu-out-0910.google.com ([209.85.134.184]:43326 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751608AbYKMWsy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 17:48:54 -0500
Received: by mu-out-0910.google.com with SMTP id g7so1096018muf.1
        for <git@vger.kernel.org>; Thu, 13 Nov 2008 14:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=vziuVhQfxnCna2Y/VCzMwIjlwXzNTxuobUfrQ/K/Alk=;
        b=sTKjB2jnO7x3NQl5xsMYz7N1oGG7uoqVQYlpXSPfUir0omBpTgYrzr5/c/xFVUH8sv
         P5ttXVQUZtOhb2b2hS3NeDFLFuLXqhzl1Fsmnix69k2DUQvZ3QoFL+ee7AzCM/kSSlUa
         DJ+VfCv1GsZvrFJGNx1CvKZAGkNUDfKy2LpoA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=sXexUByIZkdgF22I7KqjTGeUXsOExqRkZjhbpE3Th12apfGgYyweHG/+oCuJTujO61
         N5Y/sXuz8l2OCj4OGIVontGEHujYNMZPPJ+BA/kkHf97OxF851IgI5PHrnn59J31PMmx
         ZO41A5W/MJaqFFM+P3NnzSMv7R+uWZrRhtb/w=
Received: by 10.181.218.14 with SMTP id v14mr68731bkq.111.1226616532223;
        Thu, 13 Nov 2008 14:48:52 -0800 (PST)
Received: from localhost ([78.15.2.247])
        by mx.google.com with ESMTPS id f31sm5890345fkf.0.2008.11.13.14.48.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 13 Nov 2008 14:48:51 -0800 (PST)
X-Mailer: git-send-email 1.5.6.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a patchset I presented about a year ago or so, but after a lively
discussion it dropped into silence. I'm now presenting it again, with minor
cleanups and adjustements.

Giuseppe Bilotta (11):
  gitweb: introduce remote_heads feature
  gitweb: git_get_heads_list accepts an optional list of refs.
  gitweb: separate heads and remotes list in summary view
  gitweb: optional custom name for refs in git_heads_body
  gitweb: git_split_heads_body function.
  gitweb: use CSS to style split head lists.
  gitweb: add 'remotes' action
  gitweb: display HEAD in heads list when detached
  gitweb: git_is_head_detached() function
  gitweb: add HEAD to list of shortlog refs if detached
  gitweb: CSS style and refs mark for detached HEAD

 gitweb/gitweb.css  |   15 ++++++
 gitweb/gitweb.perl |  138 ++++++++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 143 insertions(+), 10 deletions(-)
