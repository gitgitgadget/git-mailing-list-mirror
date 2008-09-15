From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] help git-upload-pack find git
Date: Mon, 15 Sep 2008 12:34:07 -0700
Message-ID: <7vzlm9b3v4.fsf@gitster.siamese.dyndns.org>
References: <d3a045300809150130w6f78edd8xf599d1c7f639b77d@mail.gmail.com>
 <d3a045300809150130w6f78edd8xf599d1c7f639b77d@mail.gmail.com>
 <1221495891-12600-1-git-send-email-git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Sep 15 21:35:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfJr5-00069l-11
	for gcvg-git-2@gmane.org; Mon, 15 Sep 2008 21:35:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752864AbYIOTeS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2008 15:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752920AbYIOTeS
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Sep 2008 15:34:18 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:48762 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751707AbYIOTeR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2008 15:34:17 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 83EBA6119C;
	Mon, 15 Sep 2008 15:34:12 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 63D2661199; Mon, 15 Sep 2008 15:34:09 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 464772AE-835D-11DD-83C1-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95930>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> The corresponding bug was reported by Paul Johnston who wondered why
> "git clone" failed when specifying --upload-pack for an out-of-$PATH
> installation of git.  I'm not sure whether we should encourage this, but
> the --upload-pack option clearly gives the impression that
> git-upload-pack is all that is needed.

Another possibility would be to teach exec_cmd.c:setup_path() to add the
directory specified by $(bindir) to PATH after we add GIT_EXEC_PATH to
it.  That should cover the case David Miller reported, shouldn't it?
