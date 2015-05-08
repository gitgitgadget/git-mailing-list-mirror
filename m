From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 07/12] t4013: call git-merge instead of git-pull
Date: Fri, 08 May 2015 15:12:20 +0200
Organization: gmx
Message-ID: <cdd3a0b88d731a536735192317fff32b@www.dscho.org>
References: <1430988248-18285-1-git-send-email-pyokagan@gmail.com>
 <1430988248-18285-8-git-send-email-pyokagan@gmail.com>
 <a2c6df723ca5237c094ab4002e45a834@www.dscho.org>
 <CACRoPnTMgZBfeneMCZSJVowmSCGf2Ufpt-J461+w9Lh1aN-rhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 08 15:12:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yqi4s-00016T-GW
	for gcvg-git-2@plane.gmane.org; Fri, 08 May 2015 15:12:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752505AbbEHNM0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2015 09:12:26 -0400
Received: from mout.gmx.net ([212.227.15.15]:55542 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751966AbbEHNMZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2015 09:12:25 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0Lfjxq-1ZbH5j3dHO-00pJ91; Fri, 08 May 2015 15:12:21
 +0200
In-Reply-To: <CACRoPnTMgZBfeneMCZSJVowmSCGf2Ufpt-J461+w9Lh1aN-rhA@mail.gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:6zy4mMi9xV2isH1PBYMnwx/puekpgUPSXwB+ximFcPRHLqi4tbR
 fETVvqtAcTaKWwIdki8IZmwT4OegxSnDGOZTzriO8jSHALMPrcmmdudx5F7J8MFUsYEW8fB
 fRgt7yFD3LHr2uFxVFS+QT0vbCTe5jDsDsiQj67wO8arde8ZvoulKkMIDUy/KaxITfRlJG4
 Ihu8svt43HJhO4CCgO0Kg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268617>

Hi Paul,

On 2015-05-07 18:55, Paul Tan wrote:
> Hi Dscho,
> 
> On Fri, May 8, 2015 at 12:26 AM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
>> Both this patch and 9/12 change `git pull` invocations to equivalent non-pull ones, but I wonder whether it would not be a better idea to leave them as-are, so that we can make sure that scripts out there that might use similar `git pull` invocations would be unaffected by the rewrite?
> 
> In the current state[1], I'm aiming for the git-pull rewrite patch
> series to break all git-pull tests in the first patch, and then
> subsequently make them pass again in later smaller patches by
> implementing back the old features. This will make reviewing the code
> much easier, as opposed to dumping a huge patch every single re-roll
> ;-).
> 
> For both patches and test suites, if the "setup" tests fail, the whole
> test suite fails. Given that the test suites are about testing the
> diff formatting options and submodules update implementation, which is
> mostly irrelevant to git-pull, I think it would be better if the test
> suite was not affected by the rewrite, especially since it only
> requires changing one line.

Ah, that makes sense. I just failed to understand what you were telling me.

Maybe it would be better to make that patch a part of the builtin pull instead, so that we do not forget to revert it with the commit that introduces support for `-s ours` in builtin pull?

Ciao,
Dscho
