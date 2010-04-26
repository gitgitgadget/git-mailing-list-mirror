From: Albert Dvornik <dvornik+git@gmail.com>
Subject: Re: [PATCH] start_command: close cmd->err descriptor when fork/spawn 
	fails
Date: Mon, 26 Apr 2010 07:47:10 -0400
Message-ID: <z2n9f74dc2c1004260447y12b522d8if37cad56548738f1@mail.gmail.com>
References: <1272244540-5960-1-git-send-email-dvornik+git@gmail.com>
	 <4BD53749.6040708@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, msysgit@googlegroups.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 26 13:47:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6MmV-0004f6-Lj
	for gcvg-git-2@lo.gmane.org; Mon, 26 Apr 2010 13:47:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751614Ab0DZLrO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Apr 2010 07:47:14 -0400
Received: from mail-qy0-f179.google.com ([209.85.221.179]:53606 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751434Ab0DZLrN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Apr 2010 07:47:13 -0400
Received: by qyk9 with SMTP id 9so17177428qyk.1
        for <git@vger.kernel.org>; Mon, 26 Apr 2010 04:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=PY5azyrPWsIYqas+EfdQG/lxKO6n0aZ9nw7X76f3O3A=;
        b=OrdpV1aH/REKf1WrOg/qjzqRRc6q82eonjqhqmjIvgLSd3JgQH24bdjeH5xZuPEazO
         k6/zMF8eBEQibeCoZC6/IX41CeNxZbimO+ku09Ahj10vl5K/sZuazBuD2qGVjYVcr19W
         Nc2Hd6xLCjmETqZnsL1ZAs0M4H8bGtlOire+M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=tJIJMun247wX1nZMNS4zNQsU7Wg2Kb04KklSaboh7LUnSOqunmL6vWaiQd/SOiT8NL
         OBrMHGCpMgWjoSXMWfj53ohB7pxfjXLO913Wr1wrWq9rR3swATgntauG0Ua9YwXVlZSN
         1WM0ZV1+HFDJoWLziwCiyAMOXyjM67xMXeEVQ=
Received: by 10.229.241.194 with SMTP id lf2mr4820570qcb.75.1272282430973; 
	Mon, 26 Apr 2010 04:47:10 -0700 (PDT)
Received: by 10.229.74.193 with HTTP; Mon, 26 Apr 2010 04:47:10 -0700 (PDT)
In-Reply-To: <4BD53749.6040708@viscovery.net>
X-Google-Sender-Auth: da0e40fca29c7e44
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145813>

On Mon, Apr 26, 2010 at 2:48 AM, Johannes Sixt <j.sixt@viscovery.net> w=
rote:
> Am 4/26/2010 3:15, schrieb bert Dvornik:
[...]
>> I'm not sure why (or if) this problem hasn't cropped up under Linux.
>> The non-Windows code *does* try to check for execve() failures in th=
e
>> child, in addition to the fork() failures.
>
> The problem does show up on Linux if you trigger the right error, suc=
h as
> with this patch:
[...]
> + =A0 =A0 =A0 echo "#!/bin/frobnicuty" >testrepo/.git/hooks/pre-recei=
ve &&
> + =A0 =A0 =A0 echo exit 1 >>testrepo/.git/hooks/pre-receive &&

Ah, that makes sense!  Thank you for clearing up the mystery.

Junio: would you like me to resend with an updated commit message, and
maybe the addition of Hannes's test as well?

--bert
