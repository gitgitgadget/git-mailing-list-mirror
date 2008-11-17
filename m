From: "Tuncer Ayaz" <tuncer.ayaz@gmail.com>
Subject: Re: [PATCH] Teach/Fix pull/fetch -q/-v options
Date: Mon, 17 Nov 2008 11:55:59 +0100
Message-ID: <4ac8254d0811170255t4706f8efu5d60f4f05cbdab4@mail.gmail.com>
References: <1226776980-9674-1-git-send-email-tuncer.ayaz@gmail.com>
	 <4ac8254d0811170237o78060cb3k4a64dceaa3a475d0@mail.gmail.com>
	 <7vy6ziy69h.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 17 11:57:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L21nF-0004LO-DP
	for gcvg-git-2@gmane.org; Mon, 17 Nov 2008 11:57:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753166AbYKQK4B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2008 05:56:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753096AbYKQK4B
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Nov 2008 05:56:01 -0500
Received: from mail-gx0-f11.google.com ([209.85.217.11]:34156 "EHLO
	mail-gx0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752835AbYKQK4A (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2008 05:56:00 -0500
Received: by gxk4 with SMTP id 4so1456407gxk.13
        for <git@vger.kernel.org>; Mon, 17 Nov 2008 02:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=kezCVVXyThr+ellivR1gsJKt7WvIZVgIKuHrGNfb6bY=;
        b=rIW6+NolScmOECrez2P0AI4439KVhfr5ZLMbtHhhnBp29AcANi95eiJ5U5nsu86clE
         IbxirG4DoOHkLkk85w07IcuJ4RZap9dAI/7+s2NxYBob3G3cgijjdG5qYBRpfRglyP1x
         kOZ78FqeeApHRxQutU+AzCqdZAipa3QEK9jtM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=jnkIKxPem2rD8G87V5zO6MyPntLzJRx/5jcS64wMqBOdL0akzegvdykX3G228BheVh
         KkLExfJtCy8xPO9zLoEe+TW1lxlUmkgUmvn8b/k0/a7ZUJrO8Q8+dvdrwR/2MUlaVOh/
         hEdSJBWMzGB+MOpGAqwfW77hHtjc6JBMuuRRg=
Received: by 10.65.97.16 with SMTP id z16mr3602233qbl.46.1226919359216;
        Mon, 17 Nov 2008 02:55:59 -0800 (PST)
Received: by 10.64.119.3 with HTTP; Mon, 17 Nov 2008 02:55:59 -0800 (PST)
In-Reply-To: <7vy6ziy69h.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101218>

On Mon, Nov 17, 2008 at 11:51 AM, Junio C Hamano <gitster@pobox.com> wrote:
> "Tuncer Ayaz" <tuncer.ayaz@gmail.com> writes:
>
>> I think you need to have something like the following applied on top of
>> what's in pu to be able to use "pull -v -v -v" and be able to count the
>> occurrences via parse-options.c. What do you think?
>
> Makes sense, except that as a futureproofing we may be better off doing
> the same for -q as well.

What's funny is that my original patch to git-pull.sh had both :).

>> --- git-pull.sh 2008-11-17 11:32:19.000000000 +0100
>> +++ git-pull.sh.b       2008-11-17 11:33:03.000000000 +0100
>> @@ -26,7 +26,7 @@
>>         -q|--quiet)
>>                 verbosity=-q ;;
>>         -v|--verbose)
>> -               verbosity=-v ;;
>> +               verbosity="$verbosity -v" ;;
>>         -n|--no-stat|--no-summary)
>>                 no_stat=-n ;;
>>         --stat|--summary)
>>
>> Signed-off-by: Tuncer Ayaz <tuncer.ayaz@gmail.com>
>
