From: Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
Subject: Re: [PATCH 4/4] git-imap-send: Add method to convert from LF to CRLF
Date: Thu, 11 Feb 2010 23:37:55 +0900
Message-ID: <4B741643.1000607@dcl.info.waseda.ac.jp>
References: <7vaavj8h1k.fsf@alter.siamese.dyndns.org>	<1265717345-2118-5-git-send-email-mitake@dcl.info.waseda.ac.jp> <m31vgu9yjk.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org,
	Jeremy White <jwhite@codeweavers.com>,
	Robert Shearman <robertshearman@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 11 15:38:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfaBA-0007f7-7y
	for gcvg-git-2@lo.gmane.org; Thu, 11 Feb 2010 15:38:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755465Ab0BKOh6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Feb 2010 09:37:58 -0500
Received: from ns.dcl.info.waseda.ac.jp ([133.9.216.194]:64030 "EHLO
	ns.dcl.info.waseda.ac.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754557Ab0BKOh5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2010 09:37:57 -0500
Received: from localhost (localhost [127.0.0.1])
	by ns.dcl.info.waseda.ac.jp (Postfix) with ESMTP id 5FB5CEAF5BC;
	Thu, 11 Feb 2010 23:37:56 +0900 (JST)
X-Virus-Scanned: amavisd-new at dcl.info.waseda.ac.jp
Received: from ns.dcl.info.waseda.ac.jp ([127.0.0.1])
	by localhost (ns.dcl.info.waseda.ac.jp [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mKoYGfR2UW-h; Thu, 11 Feb 2010 23:37:56 +0900 (JST)
Received: from [192.168.11.2] (FL1-122-130-141-251.tky.mesh.ad.jp [122.130.141.251])
	by ns.dcl.info.waseda.ac.jp (Postfix) with ESMTP id EFD0EEAF5B9;
	Thu, 11 Feb 2010 23:37:55 +0900 (JST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ja; rv:1.9.1.5) Gecko/20091204 Thunderbird/3.0
In-Reply-To: <m31vgu9yjk.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139592>

(2010=E5=B9=B402=E6=9C=8810=E6=97=A5 01:15), Jakub Narebski wrote:
> Hitoshi Mitake<mitake@dcl.info.waseda.ac.jp>  writes:
>
>> Some strict IMAP servers (e.g. Cyrus) don't
>> allow "bare newlines ('\n')" in messages.
>> So I added new boolean option "lf-to-crlf" to imap section.
>> If this option enabled, git-imap-send converts LF to CRLF("\r\n").
>>
>> If you want to use it, add line:
>> 	lf-to-crlf
>> to [imap] section of your .gitconfig .
>>
>> This patch also adds description to Documentation/git-imap-send.txt =
=2E
>
>> +imap.lf-to-crlf::
>> +	If you use strict IMAP server (e.g. Cyrus),
>> +	"bare newlines ('\n')" in messages are not allowed.
>> +	If this option enabled, git-imap-send converts LF to CRLF("\r\n").
>> +
>
> If you take a look at Documentation/config.txt at the names of other
> config variables, you would see that they have
>
>    core.fileMode::
>    core.ignoreCygwinFSTricks::
>    core.quotepath::
>    core.safecrlf::
>
> names, i.e. either camelCase or allsmallcase, and not
>
>    imap.lf-to-crlf::
>
> with '-' to separate parts.  Values can and do use this syntax, like
> e.g. `blank-at-eol` for core.whitespace.
>
> The only outlier is add.ignore-errors (not add.ignoreerrors or
> add.ignoreErrors).
>
>
> The same is true for the other config variable you propsed in 3/4
> patch.

Thanks for your review, I'll rename these values
based on custom of Git.
