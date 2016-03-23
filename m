From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] bisect--helper: convert a function in shell to C
Date: Wed, 23 Mar 2016 12:24:05 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1603231223520.4690@virtualbox>
References: <010201539a8d2b8a-9f168d7a-d4c6-4c23-a61f-1ef6ee22f774-000000@eu-west-1.amazonses.com> <010201539d57ae98-ce4860a6-f7b6-4e06-b556-3c1340cd7749-000000@eu-west-1.amazonses.com> <alpine.DEB.2.20.1603221552100.4690@virtualbox>
 <xmqqh9fyjy9w.fsf@gitster.mtv.corp.google.com> <CAFZEwPOMdozVafJzRYJmhhAAAAVfLJ74dSGVbsHreFFKD1Vobg@mail.gmail.com> <CAGZ79kZvi+qJKPkgzHP5LgoyTJd2btJZ6zCc4hkSKAhjoOiYFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Pranit Bauva <pranit.bauva@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 12:24:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aigtd-00016r-Uj
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 12:24:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751067AbcCWLYP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 07:24:15 -0400
Received: from mout.gmx.net ([212.227.15.19]:62675 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751852AbcCWLYN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2016 07:24:13 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0Lz3rc-1ZeiAw3NNQ-014GgW; Wed, 23 Mar 2016 12:24:06
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <CAGZ79kZvi+qJKPkgzHP5LgoyTJd2btJZ6zCc4hkSKAhjoOiYFg@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:y+WSpldWUhcqK/MBb1tLe8tyZO0LX7LDVvd2S+oDaRRJYdGkPX2
 KOW0IlcAbIZKu9YqGeFwTvBWsszCo6iaexiUQ7jLH8LIRGbUesHNifroDupxlZ+KfxusgbQ
 M+fansQDWKjuI0C8wSN+XKfZS/kOZ3wd8MUNNkgsTXAicAQSR49oczGLh93rF1g7Yf/5ag+
 muYMSFiu4qAa4AC84T0Mw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Ph5I9QBdFcQ=:wAAQxPficowuEesihuDrbW
 ccibggUkvSoZ80CwS9bjvYdXdfQdrFzjBQejfFkhAC7rbhwgdNoCC9A31UjhSiFWPRScZFmkt
 K2F7yl/2nkuhmQfaqYRDYbxwO6jPEfLRRWdHCEbb4YEXVHluNm6FxvNxjutAQPynFUNvV40wN
 YdYoDCpA/B4SfhoMZqGxch7ZdZaAcYeWf09knkowzpbcoMErmT8MzsvdQLhRWJQv8PNhH1Hll
 Az/nh5L82ldG8jw+jyXwDMM8lxpn4J1uFKyic0/IbH4un2D30k7T0Uqk2bevsmgf7aby0r3Mx
 HKvN0N8f5Mi/+0iHi4nfxIt/IedVC5dY3tN1+q/gocLH7UQobIWB0xIx6bRbvafO9BF70vfa1
 wewYOzxKu7p+Y0EtwPDSIom+WixcnOxnpaebIiHebrX7v2/ubVX7BKHwFSrTz1tiOGFcgSLvw
 rMI/tVCSfqExG/gsW1e184YtLZlTuBrKawlQ/Uvbc37xGPl75Hq/MGYldHJsfLgZaGB7/8y1x
 tbUK4T2CCDqR/Hvyry6uHBW6LaWRIQWpYjDZZFLxI1EywT7qUL/cujdrlPovUM7jDIVCB50Mb
 LpLRBhyto1vjxKatS4IGXriJnYvzOw3rTylI9CKExbbCbFxUFm2n2BtrD89ugcjeT8Z+RZzhM
 WBFggGLuAv7O05ypczFLPsbDtMKmR4dfq0FnusXMEe9RwT3Kc4D0YdDcl7/T+igh5fZkpHG07
 8+yBl/gFSwfy5Kb3M0REL7ZennfSFpl7V6UJnJVVnvp4TlR5qiTd3ucjWOAA7dnPogO4bn0C 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289652>

Hi,

On Tue, 22 Mar 2016, Stefan Beller wrote:

> On Tue, Mar 22, 2016 at 10:52 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> > OPT_CMDMODE() is actually a better option. I also noticed that it
> > isn't mentioned in Documentation/technical/api-parse-options.txt .
> > Should I send a patch to include it there just to make it easier for
> > someone who is new and isn't aware of the changes ?
> 
> Patches to outdated documentation are most awesome. ;)

Yes!

Thanks,
Johannes
