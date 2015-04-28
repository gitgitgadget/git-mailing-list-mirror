From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Windows path limits, was Re: [PATCH v5 2/5] setup: sanity check
 file size in =?UTF-8?Q?read=5Fgitfile=5Fgently?=
Date: Tue, 28 Apr 2015 18:20:13 +0200
Organization: gmx
Message-ID: <c33a7d869ecfb49d0b548f895d0f5da3@www.dscho.org>
References: <xmqqfv7nzf56.fsf@gitster.dls.corp.google.com>
 <1430030985-14499-1-git-send-email-erik.elfstrom@gmail.com>
 <1430030985-14499-3-git-send-email-erik.elfstrom@gmail.com>
 <20150428060222.GK24580@peff.net>
 <e7c614c97eb4b1819cec25567a7adc97@www.dscho.org>
 <CAEtYS8QMSSbfd2xSCMh2YTW2NSz7uBnsmKUi9SjSCrJ1TBEH+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?Q?Erik_Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Doug Kelly <dougk.ff7@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 28 18:20:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yn8FO-0004dl-VW
	for gcvg-git-2@plane.gmane.org; Tue, 28 Apr 2015 18:20:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030442AbbD1QUb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2015 12:20:31 -0400
Received: from mout.gmx.net ([212.227.17.20]:51802 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030247AbbD1QUa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2015 12:20:30 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0M2cDB-1ZcUNG2vSf-00sJKu; Tue, 28 Apr 2015 18:20:15
 +0200
In-Reply-To: <CAEtYS8QMSSbfd2xSCMh2YTW2NSz7uBnsmKUi9SjSCrJ1TBEH+w@mail.gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:NQ1pZOEHWoNt1B5JaEGk9g2OrIGxxemJj/g96odrsbwDLKBGzET
 hDOYGUOd7Z0ivf4Yclynixp1wxSzl2iFtg5TzMRNeqTzubNZtgIhb5kBOUGlE+dfCv7opqP
 hnDLmdmornFAa2GEkKCyF/6TKBU7Q3tPdl0fMecgF69lqht/Xc+4TNXBTQJ/5jxDMtp35kU
 851/Hi2btV5j1SqRzd/4A==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267929>

Hi,

On 2015-04-28 17:33, Doug Kelly wrote:

> If you're able to do everything through the Unicode Win32 APIs, you can reach 65535 characters, assuming the filesystem supports it (NTFS does, FAT32 would not, for example).  I recall there being one function (possibly thinking of mktemp) that couldn't properly handle the long paths, but I believe that was it.

IIRC the MSDN documentation of at least one of the directory-related functions was not quite guaranteeing that it would support long paths with all Windows versions, either.

> Other apps may or may not handle the longer paths well; the core.longpaths
> switch may prevent mishaps in more than just Explorer, but the downside isn't
> disaster always either -- for example, Explorer just refuses to browse
> to that path.

The problem comes from a different angle, though: I had *a lot* of fun when working on the tests for the `core.longpaths` feature because our very own `rm.exe` would not handle the long paths. As a consequence, quite a few tests failed to remove the trash directories of previous, failed test runs.

In such a case you will have to resort to use different tools than you are used to, and *that* is the reason why we do not enable that feature by default.

Ciao,
Dscho
