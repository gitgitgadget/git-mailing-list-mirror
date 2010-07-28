From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH] hash: Remove useless init_hash()
Date: Wed, 28 Jul 2010 00:33:55 -0700
Message-ID: <4C4FDD63.9050303@gmail.com>
References: <1280208970-23394-1-git-send-email-bebarino@gmail.com>	<m3fwz5kykn.fsf@localhost.localdomain>	<AANLkTimrKzDOlJzGpzaHWF24lwfr67bmh8RrKj6uMYWB@mail.gmail.com>	<20100727194946.GA11682@coredump.intra.peff.net> <AANLkTikHLZlBQW8DSZrxeA-RDOh2Iy6hc0p821tDQoN8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 28 09:34:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oe19Z-000560-8s
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 09:34:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754141Ab0G1HeI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Jul 2010 03:34:08 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:63442 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754086Ab0G1HeE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jul 2010 03:34:04 -0400
Received: by pvc7 with SMTP id 7so767519pvc.19
        for <git@vger.kernel.org>; Wed, 28 Jul 2010 00:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=f1H/lhZiXHlUQysoZBhxzDH3QZo92Rf9JvBbTPvXIsw=;
        b=eLEanL++F6Oggl8WHtqTPmSs0hWA1pTP+VmSNjbh2wqZxiy5scXZJU29cxkGVz/tum
         S4TX9jz9zPTPgYGdco0Jtopgklt144QQMZ4EKX9zqS11RBw1BWcGk3rn+FG9yssMcDrc
         TZFfbWJLqioMThvSrwr1GivYlN3DMOLq4F6aE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=QCraOBIzcIAT/LLG+/bFt2Lskjo+aiIK9bZDab9V+GgD5wF7IsKNjNm14dPDMw2OZg
         s5eFPFbwWJXEogTV8NQmGrDjgzybHs9StJMw6nJLrRnazAV0rJ1k6J1+BC/m6n/zzlP8
         buRsrUJSdsPTNERzOO4QnfX1kh1yfo9v0ZlPA=
Received: by 10.142.185.15 with SMTP id i15mr1881892wff.10.1280302442174;
        Wed, 28 Jul 2010 00:34:02 -0700 (PDT)
Received: from [192.168.1.101] ([75.85.182.25])
        by mx.google.com with ESMTPS id z1sm6719568wfd.15.2010.07.28.00.33.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 28 Jul 2010 00:34:00 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.4) Gecko/20100713 Thunderbird/3.1
In-Reply-To: <AANLkTikHLZlBQW8DSZrxeA-RDOh2Iy6hc0p821tDQoN8@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152047>

  On 07/27/2010 12:58 PM, =C6var Arnfj=F6r=F0 Bjarmason wrote:
>
>> That being said, I agree with the comments that removing init_hash
>> actually makes the code _less_ readable. You could just replace thes=
e
>> three lines with a memset, but why? It's just code churn.
> Yeah, and for the record it also missed this part in hash.c:
>
>      void free_hash(struct hash_table *table)
>      {
>      	free(table->array);
>      	table->array =3D NULL;
>      	table->size =3D 0;
>      	table->nr =3D 0;
>      }
>
> Have fun everyone :)

Ok, seems like nobody thinks this is a good idea so I'm fine with dropp=
ing it. The minimal savings (if at all) doesn't seem worth the code chu=
rn. One less patch in the queue ;-)
