From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 3/8] xread_nonblock: add functionality to read from fds
 without blocking
Date: Tue, 15 Dec 2015 07:12:49 +0100
Message-ID: <566FAF61.1050704@kdbg.org>
References: <1450121838-7069-1-git-send-email-sbeller@google.com>
 <1450121838-7069-4-git-send-email-sbeller@google.com>
 <CAPig+cSiE8rJD8ohgW99SBJMFE8cJ6UrHKeAucj4fTEmUW7Ntg@mail.gmail.com>
 <xmqqio40hbam.fsf@gitster.mtv.corp.google.com>
 <20151214235736.GA26133@sigill.intra.peff.net>
 <CAGZ79kZGjCy-o=2hO22=4=n2JqUsEG+dqOZFP4Hhf5E72B-_JA@mail.gmail.com>
 <20151215001642.GA26409@sigill.intra.peff.net>
 <CAGZ79kbLHNtxcwhZz=tHpJB2XnxMeuEJBG=PmoAbcVF4Wzno2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <ericsunshine@gmail.com>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 15 07:13:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8irP-00049i-DI
	for gcvg-git-2@plane.gmane.org; Tue, 15 Dec 2015 07:13:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752601AbbLOGMy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2015 01:12:54 -0500
Received: from bsmtp8.bon.at ([213.33.87.20]:47555 "EHLO bsmtp8.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751588AbbLOGMx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2015 01:12:53 -0500
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp8.bon.at (Postfix) with ESMTPSA id 3pKTlk5zygz5tlF;
	Tue, 15 Dec 2015 07:12:50 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id BE65C53B4;
	Tue, 15 Dec 2015 07:12:49 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
In-Reply-To: <CAGZ79kbLHNtxcwhZz=tHpJB2XnxMeuEJBG=PmoAbcVF4Wzno2g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282465>

Am 15.12.2015 um 01:25 schrieb Stefan Beller:
> I was actually thinking about using {without-x}read, just the plain system call.
> Do we have any issues with that for wrapping purposes for Windows?

xread() limits the size being read to MAX_IO_SIZE, which is needed on 
some systems (I think that some Windows configurations did fall into 
this category).

-- Hannes
