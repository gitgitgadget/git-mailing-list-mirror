From: Yuri <yuri@rawbw.com>
Subject: Date format in 'git log' should be in local timezone
Date: Fri, 17 Jan 2014 16:11:08 -0800
Message-ID: <52D9C69C.2020006@rawbw.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 18 01:11:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4JVY-0001ub-CE
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jan 2014 01:11:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752734AbaARALK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jan 2014 19:11:10 -0500
Received: from shell0.rawbw.com ([198.144.192.45]:64710 "EHLO shell0.rawbw.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752022AbaARALJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jan 2014 19:11:09 -0500
Received: from eagle.yuri.org (stunnel@localhost [127.0.0.1])
	(authenticated bits=0)
	by shell0.rawbw.com (8.14.4/8.14.4) with ESMTP id s0I0B8BH014053
	for <git@vger.kernel.org>; Fri, 17 Jan 2014 16:11:08 -0800 (PST)
	(envelope-from yuri@rawbw.com)
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240639>

Currently git log mixes timezones in the date records in the same log, 
so the following dates wold appear in one log:
Date:   Thu Jan 16 17:11:28 2014 -0800
Date:   Thu Jan 16 20:10:04 2014 -0500

Timezone here doesn't help the log reader at all. It doesn't even 
reflect the actual location of the submitter. Instead, it should be 
converted to the local TZ of the client. This will make it easier to 
read and understand the time.

Even further, timezone shouldn't even be stored by the git server. It 
should just store the UTC time, following the approach how time is 
managed in most UNIX-like systems.

Yuri
