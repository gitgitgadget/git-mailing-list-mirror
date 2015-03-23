From: Koosha Khajehmoogahi <koosha@posteo.de>
Subject: git-send-email.perl should check the version of Perl modules it uses
Date: Mon, 23 Mar 2015 02:11:04 +0100
Message-ID: <550F6828.2090602@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 23 02:12:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZquN-0004xe-J0
	for gcvg-git-2@plane.gmane.org; Mon, 23 Mar 2015 02:11:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752043AbbCWBLz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2015 21:11:55 -0400
Received: from mx02.posteo.de ([89.146.194.165]:54115 "EHLO mx02.posteo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751965AbbCWBLy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2015 21:11:54 -0400
Received: from dovecot03.posteo.de (unknown [185.67.36.28])
	by mx02.posteo.de (Postfix) with ESMTPS id 9E61025B17F1
	for <git@vger.kernel.org>; Mon, 23 Mar 2015 02:11:53 +0100 (CET)
Received: from mail.posteo.de (localhost [127.0.0.1])
	by dovecot03.posteo.de (Postfix) with ESMTPSA id 3l9Hjj3Fbzz5vN2
	for <git@vger.kernel.org>; Mon, 23 Mar 2015 02:11:53 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266111>

On Debian Wheezy with its outdated packages, the version of Net::SMTP::SSL is 1.01. If you
try to use send-email, the script will crash with the following error:

STARTTLS failed! SSL connect attempt failed with unknown error error:14090086:SSL routines:SSL3_GET_SERVER_CERTIFICATE:certificate verify failed at /usr/libexec/git-core/git-send-email line 1294

Apparently, that is because the script is calling a subroutine (start_SSL()) that
is missing in older versions. I guess the script should check the minimum
required version before proceeding with the execution.
