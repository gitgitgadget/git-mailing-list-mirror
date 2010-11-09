From: public_vi <public_vi@tut.by>
Subject: How to build git-remote-http properly?
Date: Tue, 09 Nov 2010 03:42:18 +0200
Message-ID: <4CD8A6FA.8030506@tut.by>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 09 02:43:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFdF7-0002oQ-Nm
	for gcvg-git-2@lo.gmane.org; Tue, 09 Nov 2010 02:43:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754240Ab0KIBnU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Nov 2010 20:43:20 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:41006 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753386Ab0KIBnU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Nov 2010 20:43:20 -0500
Received: by ewy7 with SMTP id 7so3309688ewy.19
        for <git@vger.kernel.org>; Mon, 08 Nov 2010 17:43:18 -0800 (PST)
Received: by 10.213.23.3 with SMTP id p3mr4946844ebb.52.1289266997038;
        Mon, 08 Nov 2010 17:43:17 -0800 (PST)
Received: from [0.0.0.0] ([80.83.124.150])
        by mx.google.com with ESMTPS id b52sm583758eei.19.2010.11.08.17.43.14
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 08 Nov 2010 17:43:15 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.12) Gecko/20100913 Icedove/3.0.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161009>

I have built git from sources, but git-remote-http[s] does not work: it 
sends invalid data.

https://gist.github.com/667250

While normal (the one from deb package) sends a thing like this: %%%
0084f4ff491badd7290e3bcc83b7e783b0b34b8fa5ce 
157b8e24592ee8a587da4aa19ae0d2b5395308dc refs/heads/master. 
report-status side-band-64k0000PACK..........x....<truncated>

(http://vi-server.org/vi/d/git_http_push_failure.cap)

%%% from-souce git-remote-http sends things like this: %%%
0084f4ff491badd7290e3bcc83b7e783b0b34b8fa5ce 
157b8e24592ee8a587da4aa19ae0d2b5395308dc 
refs/heads/master.....!..........I0..I...I............!............... 
...8...P...h..................I.......................I.......................I............`...`......I.......................I.......................I.......................I.....................................................a..............(.......p...http.....

(http://vi-server.org/vi/d/git_http_push_failure.cap)

%%% which causes http backend to reject the garbage and remote-http 
hangs or reports error.

What cause it? How to investigate/fix? May be there should be a test for 
git-remote-http integrity?

Additional information is in https://gist.github.com/667250
