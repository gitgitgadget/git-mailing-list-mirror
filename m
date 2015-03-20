From: Noel Grandin <noel@peralex.com>
Subject: possible minor bug: 'git apply --reject' unnecessarily touches files
Date: Fri, 20 Mar 2015 16:01:16 +0200
Message-ID: <550C282C.6090302@peralex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 20 15:01:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYxUP-0003ec-Cl
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 15:01:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752205AbbCTOBU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 10:01:20 -0400
Received: from mail.peralex.com ([41.164.8.44]:15601 "EHLO mail.peralex.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751899AbbCTOBS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 10:01:18 -0400
Received: from [192.168.1.95] (noel1.ct [192.168.1.95])
	by mail.peralex.com (Postfix) with ESMTPSA id 34243336F51
	for <git@vger.kernel.org>; Fri, 20 Mar 2015 16:01:14 +0200 (SAST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=peralex.com;
	s=default; t=1426860074;
	bh=Pt9kzCSOVHVjixBOsrdDIGqFqNdNjWmC4UFDCFKDn4c=;
	h=Date:From:To:Subject;
	b=crI7KLEilbJs7bUtxaihN04viz6sV38E2wY14HgS4vqz8wZd1Mwm+gBBrIrQHzMEk
	 9w3zHyPA5MEFwcq5IpBb6xKbdf+JL/oUEFySEF+itT/0tH3pcg44s8fJsSH9SCoRF9
	 uyeyx7oKHENVy0ngEkhqo4XlZvO5EVvTTMcel1D4=
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.4.3 (mail.peralex.com); Fri, 20 Mar 2015 16:01:14 +0200 (SAST)
X-Scanned-By: MIMEDefang 2.74 on 41.164.8.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265904>

Hi

I'm doing some splitting of a large patch and I noticed that when I do

   $ git apply --reject large_patch.diff

and it generates a lot of .rej files, it seems to be touching the files that produced the .rej output, even if nothing 
in that particular file was actually updated.

Not a major issue, but it would help my build times, which are considerable when working on LibreOffice :-)

Thanks, Noel Grandin

Disclaimer: http://www.peralex.com/disclaimer.html
