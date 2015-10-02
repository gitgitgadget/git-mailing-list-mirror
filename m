From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH/RFC 1/2] sha1_file: close all pack files after running
Date: Fri, 02 Oct 2015 12:13:40 +0200
Organization: gmx
Message-ID: <763ac2b63d56d250e5e1a27f490f79db@dscho.org>
References: <1443670163-31193-1-git-send-email-max@max630.net>
 <1443670163-31193-2-git-send-email-max@max630.net>
 <33b74e875c7298f67640f5850e88c152@dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Fri Oct 02 12:13:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZhxLd-0007rx-Db
	for gcvg-git-2@plane.gmane.org; Fri, 02 Oct 2015 12:13:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750925AbbJBKNt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Oct 2015 06:13:49 -0400
Received: from mout.gmx.net ([212.227.17.22]:60479 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750709AbbJBKNs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Oct 2015 06:13:48 -0400
Received: from dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0Lu7ty-1ag0kz0yjG-011QJn; Fri, 02 Oct 2015 12:13:43
 +0200
In-Reply-To: <33b74e875c7298f67640f5850e88c152@dscho.org>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:2SY3w+aXs2AT6rTUwwb3hXDj78krMeVD68xrhf5wHE+DykLXONp
 NpJsbuFXC1nZLJ4DaPXutQc0NT7LAdprWsWkPZmH1q5jxLA8yC59NNs5yDr7QSAayeJmWr5
 YOZHMi9sFWaturj7pRe96yxtZijxHgR0FL2UN715VhfcPuqoVrLupE+kH4yy7PxuNmTkVGk
 rcgC8IqLAr/E2q2RPZn5Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:NbJ0f9Cc1Lw=:CbxF5XANVnO8Q9kmyZn/tY
 SHg4dFRltJReF4hapcW9HQHPcttjmEHvh5x4pC+nuDWaqg+9z0ARHFbNt0UEPMaQavaYPtTTM
 0eERsXwMqRx1kD1cjww6lcu7X2PeypCkwVk4bti156yRqeDEftf9WBc/0YrgRE5iluyfPf3eO
 k6DL09FGrPCC6UvbXK4Dm4J/iqaZpcdO23hp7Zo6WwGsxio70Fao4MsyxL94SfoXiXkfgLwk6
 3Eo+4esTxg5OQRf0aQzzTPrFx3/DIaN8x49YlYMixiQ7eLddVfKI59Bmkpn6gkHd1JVt3GjjO
 r0oZ+iCVMPIVMI6SSAgAqVuYgcOwfn7Q8JfB+zBnL60nEA272oW5OOJn7zPpsJLF+BuU5dJJ9
 l8tfGhKsIrF/Z6X1Jk8uXE15SE2/UPuqsV7kLEjWVcUkLVSYe4HU7xA9iHEN97QTjoNJLQT5X
 +841sG5+2BA68cDRX7PRc/3+BVftnjEx7wdLgTzfiyrmP5UPbOvOWMb8NDhK/tT7cifv9tWTF
 v1iudAClmS37PIJWtocHc3rKLJ0CiGjuF5Wqkh5lAzJdYp+J2sXH04HxhaKO4zGBOh23pDpqr
 6pIbqDJ/o3/yrboyCmOqQgNdNa1UQuu19Vtm0HdBqkScuwlxLfmcfOvcfvsuM64QWBrVpx+pT
 1Hu88aTzV5qPBd8OCXNxLZpMapEs/BWAcQspBzuFx6rFfRQoClCrGOKtpu3VckfNpR8w5aVsh
 yblSKfLMmPrb9rcWLGrBo3REU9koVynPqyc3L/1VQeTdJd6YRHMxv/Ed9HFTjxT7LZbw+FYR 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278912>

Hi Max,

On 2015-10-02 12:05, Johannes Schindelin wrote:

> On 2015-10-01 05:29, Max Kirillov wrote:
>> When a builtin has done its job, but waits for pager or not waited
>> by its caller and still hanging it keeps pack files opened.
>> This can cause a number of issues, for example on Windows git gc
>> cannot remove the packs.

Could you do me another favor? It seems that you want to work on this, so I will step back (I have to take off for the weekend very soon anyway, so I am really glad that you take care of it). But I would really love to see the line

This fixes https://github.com/git-for-windows/git/issues/446

in the commit message, as this will keep the connection between the fix and the original report.

Thanks,
Dscho
