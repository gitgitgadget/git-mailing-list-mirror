From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 2/2] submodule::module_clone(): silence die() message
 from module_name()
Date: Tue, 11 Oct 2011 19:38:09 +0200
Message-ID: <4E947F01.8040600@web.de>
References: <1317978295-4796-1-git-send-email-rctay89@gmail.com> <1317978295-4796-2-git-send-email-rctay89@gmail.com> <4E9348A8.5000500@web.de> <CALUzUxo6YEEpL_MhT=O9sJSUdwcpKBpeM2O8GkbbyxvqmWCFLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 11 19:38:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDgHT-0001DJ-Vv
	for gcvg-git-2@lo.gmane.org; Tue, 11 Oct 2011 19:38:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755191Ab1JKRiM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Oct 2011 13:38:12 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:33753 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755148Ab1JKRiL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Oct 2011 13:38:11 -0400
Received: from smtp07.web.de  ( [172.20.5.215])
	by fmmailgate02.web.de (Postfix) with ESMTP id 17F8C1B0868B5;
	Tue, 11 Oct 2011 19:38:10 +0200 (CEST)
Received: from [79.247.238.142] (helo=[192.168.178.43])
	by smtp07.web.de with asmtp (WEB.DE 4.110 #2)
	id 1RDgHJ-0000gG-00; Tue, 11 Oct 2011 19:38:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
In-Reply-To: <CALUzUxo6YEEpL_MhT=O9sJSUdwcpKBpeM2O8GkbbyxvqmWCFLQ@mail.gmail.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19riieLZCtTXGsb8R3sxf/jzlNg7EP8NWDwOh0f
	09cdv2ZZqUHinN3Eandnaau3vAyYGBKh/rj/wIypkhgs6dmXQC
	XzkItVilVpiUJBiXERxQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183310>

Am 11.10.2011 10:44, schrieb Tay Ray Chuan:
> On Tue, Oct 11, 2011 at 3:34 AM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>> When cmd_foreach() passes an empty "name" variable to the
>> spawned command that might still work (and even make sense), but using the
>> empty name in cmd_sync() to access the config is looking like an error to
>> me. It might make sense to add an "|| exit" at least to the callsite in
>> cmd_sync(). Or am I missing something here?
> 
> Cc-ed David, who authored cmd_sync().
> 
> David, what do you think of Jens' analysis?
> 
> In the meantime, I'll probably reword the second paragraph to say that
> future work will be needed to analyze non- || exit callsites.

Yeah, me too thinks the missing "|| exit" should be subject of another
patch.
