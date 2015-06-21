From: Charles Bailey <charles@hashpling.org>
Subject: Improvements to integer option parsing
Date: Sun, 21 Jun 2015 19:25:42 +0100
Message-ID: <1434911144-6781-1-git-send-email-charles@hashpling.org>
References: <1434705059-2793-1-git-send-email-charles@hashpling.org>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 21 20:26:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6jwf-00020R-I2
	for gcvg-git-2@plane.gmane.org; Sun, 21 Jun 2015 20:26:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754023AbbFUS0N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2015 14:26:13 -0400
Received: from host02.zombieandprude.com ([80.82.119.138]:56199 "EHLO
	host02.zombieandprude.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752945AbbFUS0M (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jun 2015 14:26:12 -0400
Received: from hashpling.plus.com ([212.159.69.125]:53881)
	by host02.zombieandprude.com with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA256:128)
	(Exim 4.80)
	(envelope-from <charles@hashpling.org>)
	id 1Z6jwY-0003T6-Kh; Sun, 21 Jun 2015 19:26:10 +0100
X-Mailer: git-send-email 2.4.0.53.g8440f74
In-Reply-To: <1434705059-2793-1-git-send-email-charles@hashpling.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272274>

This is a re-roll of the first two patches in my previous series which used to
include "filter-objects" which is now a separate topic.

[PATCH 1/2] Correct test-parse-options to handle negative ints

The first one has changed only in that I've moved the additional test to a more
logical place in the test file.

[PATCH 2/2] Move unsigned long option parsing out of pack-objects.c

I've made the following changes to the second commit:

- renamed this OPT_MAGNITUDE to try and convey something that is
both unsigned and might benefit from a 'scale' suffix. I'm expecting
more discussion on the name!

- fixed the enum ordering to put this close to OPT_INTEGER

- added documentation to api-parse-options.txt

- marginally improved the opterror message on failed parses

- noted the change in behavior for the error messages generated for
pack-objects' --max-pack-size and --window-memory in the commit message
