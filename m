From: Junio C Hamano <gitster@pobox.com>
Subject: Re: repository corruption when pushing commits to a repository running 'git gc --prune='
Date: Wed, 14 Oct 2015 14:39:11 -0700
Message-ID: <xmqqfv1d6sg0.fsf@gitster.mtv.corp.google.com>
References: <561E5C5B.3090207@alcatel-lucent.com>
	<vpq4mhtbjma.fsf@grenoble-inp.fr>
	<xmqqoag18i6w.fsf@gitster.mtv.corp.google.com>
	<vpqmvvl8fb1.fsf@grenoble-inp.fr>
	<xmqqtwpt6usi.fsf@gitster.mtv.corp.google.com>
	<vpqtwpt6tsv.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jan Smets <jan.smets@alcatel-lucent.com>, <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Oct 14 23:39:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmTlY-0003Sx-Bl
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 23:39:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754084AbbJNVjP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2015 17:39:15 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:35087 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754130AbbJNVjN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2015 17:39:13 -0400
Received: by pacao1 with SMTP id ao1so487171pac.2
        for <git@vger.kernel.org>; Wed, 14 Oct 2015 14:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=zFBcH6Liw47i9Qjmq7pbFXr8UE15yCqt9tDQi7txI6Q=;
        b=kJO2dhtDpZnQS6AWW7ECbOgmrm75TaF7f/pMcF9gm240GhjIqzTyBl0RPxyE2q4hv0
         InbaGaoKWiQSyWun7Tq8OrZNn8jNCMlTQ2dvJ/eN9Clb0NBDOPaeOmJL0USdKT+6ffID
         vH8fmVFXWyy42RT7jeJ8rOmXsboTDM6QZW3QNYNDe/s+Vqepxi42DjDC3RBKA+qLTrvV
         ss5u0E4321tQ8T/DGuCcosXSR7ivy8aZUcjdjWOW+tLkvJ7kPGj8bOzw1Ta07nRjCQ5A
         BMPHZol/ARVydaInVzJpa1RTFCzxbp5tokYO68mRBxMpsSKc/vLxLtSpp4kGaiiLPcyT
         gSfw==
X-Received: by 10.66.185.5 with SMTP id ey5mr5911192pac.110.1444858753140;
        Wed, 14 Oct 2015 14:39:13 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:7964:41eb:7b4:cd77])
        by smtp.gmail.com with ESMTPSA id we9sm11468461pab.3.2015.10.14.14.39.12
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 14 Oct 2015 14:39:12 -0700 (PDT)
In-Reply-To: <vpqtwpt6tsv.fsf@grenoble-inp.fr> (Matthieu Moy's message of
	"Wed, 14 Oct 2015 23:09:52 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279630>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>>
>>> Looks good to me. I think the same should be added to git-prune.txt
>>> under --expire.
>>
>> I thought about it, but decided against it, as the command is not
>> even recommended to end users.
>
> Even non-"end users" can shoot themselves in the foot. Someone writting
> a script using "git prune" may actually shoot in other people's foot ...

Sure, patches welcome.

To be honest, I felt that

    --expire <time>::
            Only expire loose objects older than <time>.

is sufficiently clear for these people.
