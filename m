From: David Kastrup <dak@gnu.org>
Subject: Re: Shell script cleanups/style changes?
Date: Thu, 02 Aug 2007 23:02:01 +0200
Message-ID: <85ir7xzm46.fsf@lola.goethe.zz>
References: <86bqdqkygp.fsf@lola.quinscape.zz>
	<7vlkctvfk9.fsf@assigned-by-dhcp.cox.net>
	<fcaeb9bf0708021356v57b29a70yb69a2fa000bd5b55@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 02 23:02:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGhoG-0005IS-0h
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 23:02:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755181AbXHBVCN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 17:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755012AbXHBVCN
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 17:02:13 -0400
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:54568 "EHLO
	mail-in-02.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754333AbXHBVCM (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Aug 2007 17:02:12 -0400
Received: from mail-in-04-z2.arcor-online.net (mail-in-04-z2.arcor-online.net [151.189.8.16])
	by mail-in-02.arcor-online.net (Postfix) with ESMTP id 3866036658C;
	Thu,  2 Aug 2007 23:02:10 +0200 (CEST)
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net [151.189.21.47])
	by mail-in-04-z2.arcor-online.net (Postfix) with ESMTP id 29EB6ABE0E;
	Thu,  2 Aug 2007 23:02:10 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-017-172.pools.arcor-ip.net [84.61.17.172])
	by mail-in-07.arcor-online.net (Postfix) with ESMTP id 07308292B65;
	Thu,  2 Aug 2007 23:02:09 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 864B11D0344E; Thu,  2 Aug 2007 23:02:01 +0200 (CEST)
In-Reply-To: <fcaeb9bf0708021356v57b29a70yb69a2fa000bd5b55@mail.gmail.com> (Nguyen Thai Ngoc Duy's message of "Thu\, 2 Aug 2007 16\:56\:48 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3848/Thu Aug  2 22:22:06 2007 on mail-in-07.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54610>

"Nguyen Thai Ngoc Duy" <pclouds@gmail.com> writes:

> On 8/2/07, Junio C Hamano <gitster@pobox.com> wrote:
>> Non POSIX substitions such as ${parameter/pattern/string} and
>> ${parameter:offset} are not to be used.  We do not want to
>> depend on bash.
>
> There is in a test (t5300-pack-objects.sh) but I guess the
> restrictions do not apply on tests.

Oh, but they definitely should.  Precisely on those platforms with
shells not generally in use by the developers it becomes _most_
important to reliably be able to trace failed tests to problems with
the _commands_, not problems with the tests.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
