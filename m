From: Jon Nelson <jnelson@jamponi.net>
Subject: gc.auto bug in 1.6.5.7
Date: Wed, 6 Jan 2010 11:59:28 -0600
Message-ID: <cccedfc61001060959h72a07eb6g78f2ca231867df63@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 06 18:59:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSaAk-0000w2-Pf
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jan 2010 18:59:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756008Ab0AFR7v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2010 12:59:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755992Ab0AFR7u
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jan 2010 12:59:50 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:41124 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755963Ab0AFR7t (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2010 12:59:49 -0500
Received: by ewy19 with SMTP id 19so9872128ewy.21
        for <git@vger.kernel.org>; Wed, 06 Jan 2010 09:59:48 -0800 (PST)
Received: by 10.216.86.213 with SMTP id w63mr1399522wee.71.1262800788464; Wed, 
	06 Jan 2010 09:59:48 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136280>

It would appear that there is a bug in git, at least as of 1.6.5.7, in
the gc command.
When gc.auto is non-zero, it appears to consider packfiles as "loose"
- this conflicts with pack.packSizeLimit, insofar as I have
pack.packSizeLimit set to 2M (which appears to work).  If gc.auto is,
say, 50 - once I exceed 50 2MB packs then gc --auto repacks *every
single time* it is run. This is unexpected, at least.

-- 
Jon
