From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/5] "best effort" checkout
Date: Wed, 28 May 2008 17:17:20 -0700
Message-ID: <1212020246-26480-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 29 02:18:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1Vqk-0004Dn-95
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 02:18:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751982AbYE2ARj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2008 20:17:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752487AbYE2ARi
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 20:17:38 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52618 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751550AbYE2ARi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2008 20:17:38 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id DCB5A24F5
	for <git@vger.kernel.org>; Wed, 28 May 2008 20:17:36 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 6601F24F4 for <git@vger.kernel.org>; Wed, 28 May 2008 20:17:35 -0400
 (EDT)
X-Mailer: git-send-email 1.5.6.rc0.43.g823ea
X-Pobox-Relay-ID: A43B1CDE-2D14-11DD-B0EA-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83157>

I consider the first one is not part of the series but a bugfix.

The remainder is to teach "git checkout" not to punt in the middle once it
has started touching the work tree.

It does _not_ attempt to autorename a file whose name is NUL to something
else.  Partly because I personally think that sort of magic (or "a cute
hack") makes the system unnecessarily complex and fragile while not adding
much to the usability, but more importantly because I do not think we are
ready to adopt that kind of complexity yet, before fixing more basic issue
like this series addresses.

[PATCH 1/5] "git checkout -- paths..." should error out when paths cannot be written
[PATCH 2/5] checkout: make reset_clean_to_new() not die by itself
[PATCH 3/5] checkout: consolidate reset_{to_new,clean_to_new|()
[PATCH 4/5] unpack_trees(): allow callers to differentiate worktree errors from merge errors
[PATCH 5/5] checkout: "best effort" checkout
[PATCH 6/5] NUL hack to create_file()
