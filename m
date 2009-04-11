From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [PATCH RFC 09/10] send-email: Minor cleanup of $smtp_server usage 
	and send_message()
Date: Sat, 11 Apr 2009 17:13:56 -0500
Message-ID: <b4087cc50904111513j784d52aao26ae9a5569c8c7de@mail.gmail.com>
References: <1239476908-25944-1-git-send-email-mfwitten@gmail.com>
	 <1239476908-25944-2-git-send-email-mfwitten@gmail.com>
	 <1239476908-25944-3-git-send-email-mfwitten@gmail.com>
	 <1239476908-25944-4-git-send-email-mfwitten@gmail.com>
	 <1239476908-25944-5-git-send-email-mfwitten@gmail.com>
	 <1239476908-25944-6-git-send-email-mfwitten@gmail.com>
	 <1239476908-25944-7-git-send-email-mfwitten@gmail.com>
	 <1239476908-25944-8-git-send-email-mfwitten@gmail.com>
	 <1239476908-25944-9-git-send-email-mfwitten@gmail.com>
	 <loom.20090411T215335-597@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 12 00:15:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LslU5-00006D-CO
	for gcvg-git-2@gmane.org; Sun, 12 Apr 2009 00:15:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758341AbZDKWN6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Apr 2009 18:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757756AbZDKWN6
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Apr 2009 18:13:58 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:48721 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754484AbZDKWN5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Apr 2009 18:13:57 -0400
Received: by qw-out-2122.google.com with SMTP id 8so1853149qwh.37
        for <git@vger.kernel.org>; Sat, 11 Apr 2009 15:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=9nBZU/KEzEEiFc1eCQkxLqi/MJwgmr+slu5ASAPWBuM=;
        b=gS37rPVhkPp9Anr5hUGmHwZEytgQWgomw947uCgrDikcdDAQfc+JMyGq6gBjf7YDG8
         zPIuoWBNkn9nwykI0PtFcpDoV4EyMsoOpyuto+prVbaFVGtG+XMTGErHgKAX5J4cC/cj
         waGomW8JYugALLW+tZJm1GFL+gD6R/Tlt8Jyc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=qJ6egI2aCR2uI2vCod8DGLoJwdokYHOQNWXNNlPkeOw6KlKzVYWTePgCUxWDA0/lUe
         LJaJ0DFTwlVrf4rXc59YfDkSGfUO+RR57ecksXR87lb+vE3rf1BjFNqwhAsHdgYLQfSY
         a3sjiQSdiUFZbmXkld/HaV1x/uD+Mnqw3ORRo=
Received: by 10.224.54.129 with SMTP id q1mr5012191qag.275.1239488036031; Sat, 
	11 Apr 2009 15:13:56 -0700 (PDT)
In-Reply-To: <loom.20090411T215335-597@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116357>

On Sat, Apr 11, 2009 at 16:58, Stephen Boyd <bebarino@gmail.com> wrote:
> Michael Witten <mfwitten <at> gmail.com> writes:
>
>>
>>       be specified by the 'sendemail.smtpserver' configuration
>>       option; the built-in default is `/usr/sbin/sendmail` or
>>       `/usr/lib/sendmail` if such program is available, or
>> -     `localhost` otherwise.
>> +     `127.0.0.1` otherwise. Also, if <host> is the empty string,
>> +     then a built-in default is used.
>
> Does this help anyone? localhost at least doesn't change when/if ipv6 is used,
> whereas '127.0.0.1' is only for ipv4.

Ah. Good point. I'll get rid of that change.
