From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 2/2] check-attr: move to the top of working tree when
 in non-bare repository
Date: Sun, 16 Feb 2014 12:15:22 +0100
Message-ID: <53009DCA.2060001@alum.mit.edu>
References: <xmqqvbwsyvn8.fsf@gitster.dls.corp.google.com> <1391712033-9443-1-git-send-email-gitster@pobox.com> <1391712033-9443-2-git-send-email-gitster@pobox.com> <20140206195310.GV30398@google.com> <20140206201743.GW30398@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Lasse Makholm <lasse.makholm@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 16 12:15:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEzh6-0003ks-Gi
	for gcvg-git-2@plane.gmane.org; Sun, 16 Feb 2014 12:15:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751629AbaBPLP2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Feb 2014 06:15:28 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:63697 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751040AbaBPLP1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Feb 2014 06:15:27 -0500
X-AuditID: 1207440f-f79326d000003c9f-d4-53009dce58ed
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 98.00.15519.ECD90035; Sun, 16 Feb 2014 06:15:26 -0500 (EST)
Received: from [192.168.69.148] (p57A24C97.dip0.t-ipconnect.de [87.162.76.151])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s1GBFNKN022835
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sun, 16 Feb 2014 06:15:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <20140206201743.GW30398@google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLKsWRmVeSWpSXmKPExsUixO6iqHtuLkOwwaSJIhZdV7qZLBp6rzBb
	vL25hNHi+PzbrA4sHjtn3WX3uHhJ2ePzJrkA5ihum6TEkrLgzPQ8fbsE7ow5s1ezFWxnrTjY
	2sfewNjD0sXIySEhYCLx/9wENghbTOLCvfVgtpDAZUaJZ6/Kuhi5gOzzTBLXlu5nBUnwCmhL
	XNy6gh3EZhFQlbhw+w6YzSagK7Gop5kJxBYVCJZYffkBC0S9oMTJmU/AbBEBDYnnn76BLWAW
	yJX4N3kXI4gtLJAkceRsPzvEsjeMEmfv9oEN5RQwkHh4bC5QMwfQdeISPY1BEL06Eu/6HjBD
	2PIS29/OYZ7AKDgLybpZSMpmISlbwMi8ilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXRC83s0Qv
	NaV0EyMkuPl3MHatlznEKMDBqMTDm/D4f5AQa2JZcWXuIUZJDiYlUd5LfQzBQnxJ+SmVGYnF
	GfFFpTmpxYcYJTiYlUR4f8wAyvGmJFZWpRblw6SkOViUxHnVl6j7CQmkJ5akZqemFqQWwWRl
	ODiUJHgPzQFqFCxKTU+tSMvMKUFIM3FwggznkhIpTs1LSS1KLC3JiAdFcHwxMIZBUjxAe+1B
	2nmLCxJzgaIQracYdTlut/36xCjEkpeflyolzhsKUiQAUpRRmge3ApbKXjGKA30szHsMpIoH
	mAbhJr0CWsIEtGTV6b9BQEtKEhFSUg2MYUsa79nUirHbXY+8YlGo8bmmdLKAhMmz/9USBYw2
	J/elyzS/dFer/9RalKqnsdLRIPpKxZZfETNEGS7pRSz7wzp/8S9nI8vqI2/7zQSd 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242219>

On 02/06/2014 09:17 PM, Jonathan Nieder wrote:
> How do I use the only-look-at-HEAD mode from a non-bare repo?  If I
> want attributes with respect to some other commit instead of HEAD, is
> there a syntax for that?  The command doesn't seem to have been well
> thought out.

I agree that it would be nice for "git check-attr" to handle this case.
 Currently, I believe that one has to resort to a temporary index file
via something like

    (
        export GIT_INDEX_FILE="$(mktemp)"
        git read-tree HEAD
        git check-attr --cached ...
        rm "$GIT_INDEX_FILE"
    )

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
