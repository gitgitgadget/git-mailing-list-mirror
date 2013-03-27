From: Andreas Ericsson <ae@op5.se>
Subject: Re: git status takes 30 seconds on Windows 7. Why?
Date: Wed, 27 Mar 2013 17:44:51 +0100
Message-ID: <51532203.4030303@op5.se>
References: <CAFT1WNyyXbCOQWMt8nYife7Tix_mJzDQrj5e+N=GKbDR8OyYzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jim Kinsman <jakinsman@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 27 17:45:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKtTX-0007oM-VT
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 17:45:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752607Ab3C0Qo4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 12:44:56 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:43989 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752359Ab3C0Qoz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 12:44:55 -0400
Received: by mail-la0-f48.google.com with SMTP id fq13so15874926lab.21
        for <git@vger.kernel.org>; Wed, 27 Mar 2013 09:44:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=wcIRM/+oI5KI8H1eBIHHCQVZInknYuWKZ8gd8lwNnRQ=;
        b=bJEtss5PVYboi6BrdZqAtrTdLiCVv3yDATxZZZ7LPC6Or5gtdGp34OoE+2ZE20fce1
         jpYa9MX4CkP6diGY3U5vl2UArWqa8Sz3YpFnZNAaWGd+5NP6TEJGDuf3y9wu9ob2PK6q
         njY6lBfnfWZf3tVv+50jUJrpRva6p0xcMLvtkqfi9PhCA1BLOARogx0XoZmrO2wywrWQ
         w/uTx65sk9UKTy5CV/qq3Rxr9YIF2OHgzBmxIbEoZfGJTwyBO+lDcOzKF/nzX3QYK0KZ
         ziDnRUPzNOPIgkZLkAd2Dcc2y0HSrMsTfe1USTYRgx5iUp5weDv6G7EdhQgk2H55HDg1
         6FDw==
X-Received: by 10.152.147.36 with SMTP id th4mr10744928lab.19.1364402694132;
        Wed, 27 Mar 2013 09:44:54 -0700 (PDT)
Received: from vix.int.op5.se (sth-vpn1.op5.com. [193.201.96.49])
        by mx.google.com with ESMTPS id oy10sm8442571lab.8.2013.03.27.09.44.52
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 27 Mar 2013 09:44:53 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130311 Thunderbird/17.0.4
In-Reply-To: <CAFT1WNyyXbCOQWMt8nYife7Tix_mJzDQrj5e+N=GKbDR8OyYzQ@mail.gmail.com>
X-Gm-Message-State: ALoCoQnCDR3eu9f1hxvhTzcZWdJsykqpW220lW/FG2VmYb+vSMzzmQadT1WowqYKoQ34OefohUK2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219274>

On 03/27/2013 05:39 PM, Jim Kinsman wrote:
> git status takes 30 seconds on Windows 7. Here are some stats:
> git ls-files | wc -l
> 27330
> 
> git ls-files -o | wc -l
> 4
> 
> $ git diff --name-only | xargs du -chs
> 68K     update_import_contacts.php
> 68K     total
> 
> What can I do??? This is so slow it is unbearable.
> By the way i've done git gc several times and nothing changed.

I'm guessing it's the disk that's so slow. I accidentally put a git
repo on a network-mounted drive once. With 20ms round-trip time to
the server, git operations took forever.

Could you try it on a disk you know is local? Preferrably a solid
state drive. If it's still slow there, we know for sure something's
broken inside git. If switching media causes git to become fast,
you'll know it's a hardware problem.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
