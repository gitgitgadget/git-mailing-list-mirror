From: "Kent R. Spillner" <kspillner@acm.org>
Subject: Re: [PATCH v2 3/4] Speed up is_git_command() by checking early for internal commands
Date: Fri, 3 Jan 2014 10:49:26 -0600
Message-ID: <371D58A5-4640-4125-9B69-E9A7B03B347F@acm.org>
References: <52C58FD7.6010608@gmail.com> <52C59107.6080005@gmail.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 03 17:56:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vz833-0003sn-D6
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jan 2014 17:56:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313AbaACQ4d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jan 2014 11:56:33 -0500
Received: from smtp172.dfw.emailsrvr.com ([67.192.241.172]:59199 "EHLO
	smtp172.dfw.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750935AbaACQ4c convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jan 2014 11:56:32 -0500
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Fri, 03 Jan 2014 11:56:32 EST
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp17.relay.dfw1a.emailsrvr.com (SMTP Server) with ESMTP id 1F319268172;
	Fri,  3 Jan 2014 11:49:30 -0500 (EST)
X-Virus-Scanned: OK
Received: by smtp17.relay.dfw1a.emailsrvr.com (Authenticated sender: sl4mmy-AT-zerosphere.org) with ESMTPSA id AE6AA26816C;
	Fri,  3 Jan 2014 11:49:29 -0500 (EST)
In-Reply-To: <52C59107.6080005@gmail.com>
X-Mailer: iPhone Mail (11B554a)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239915>


> Since 2dce956 is_git_command() is a bit slow as it does file I/O in the
> call to list_commands_in_dir(). Avoid the file I/O by adding an early
> check for internal commands.

Considering the purpose of the series is it better to say "builtin" instead of "internal" in the commit message?