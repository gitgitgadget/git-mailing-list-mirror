From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 08/14] pull: fast-forward working tree if head is updated
Date: Mon, 18 May 2015 21:18:32 +0200
Organization: gmx
Message-ID: <4148931c0c9476093184fd252f8428d9@www.dscho.org>
References: <1431961571-20370-1-git-send-email-pyokagan@gmail.com>
 <1431961571-20370-9-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	Stephen Robin <stephen.robin@gmail.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 18 21:18:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuQYq-00015h-12
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 21:18:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229AbbERTSk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 15:18:40 -0400
Received: from mout.gmx.net ([212.227.15.19]:63510 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932168AbbERTSh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 15:18:37 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MfVYB-1YVzgg0A4x-00P9LT; Mon, 18 May 2015 21:18:33
 +0200
In-Reply-To: <1431961571-20370-9-git-send-email-pyokagan@gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:E7vI7I0KoN5V4NjzIdOX1h75jTDwUDq2FAozrq8wXJTW7kfgCE2
 gvRKVL6j2RvxCD/cL6MlUOgTtP9o2Eo37r6r3ipOCCJi6BKaF/9T2vISgvnlWufLaTLxmfz
 TKmDdbAiJnz1KqTmS929zXlxWoKiNG2AUd/3Zb9qHELbjvtcNiaLxx7xf/mEJ4hEoPlOUZE
 c+S6QZnb74yoG4PNyV3Ow==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269310>

Hi Paul,

On 2015-05-18 17:06, Paul Tan wrote:
> Since b10ac50 (Fix pulling into the same branch., 2005-08-25), git-pull,
> upon detecting that git-fetch updated the current head, will
> fast-forward the working tree to the updated head commit.

This is just a quick note about something I noticed while reviewing: I was surprised that this code path would only trigger when `orig_head` is different from the null SHA-1, because in my mind, it is safe to update when we are on an unborn branch. However, I verified that the shell script does the same thing, so your transcription is faithful.

Ciao,
Dscho
