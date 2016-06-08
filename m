From: Samuel GROOT <samuel.groot@grenoble-inp.org>
Subject: Re: [PATCH v4 4/6] send-email: create email parser subroutine
Date: Wed, 8 Jun 2016 21:42:08 +0200
Message-ID: <2d60a12f-5709-687c-4fc4-b6a0b4719b13@grenoble-inp.org>
References: <20160607140148.23242-1-tom.russello@grenoble-inp.org>
 <20160608130142.29879-1-samuel.groot@grenoble-inp.org>
 <20160608130142.29879-5-samuel.groot@grenoble-inp.org>
 <xmqq8tyfmuk4.fsf@gitster.mtv.corp.google.com>
 <CAPig+cTO+-aATxyNBt2HtctH_ofgqEc8ik3OLSN+THVgu6dhKQ@mail.gmail.com>
 <xmqqr3c7lefw.fsf@gitster.mtv.corp.google.com>
 <116d56ee-afdf-b1f2-f141-7449e6503f30@grenoble-inp.org>
 <xmqqbn3blbpc.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>, tom.russello@grenoble-inp.org,
	erwan.mathoniere@grenoble-inp.org, jordan.de-gea@grenoble-inp.org,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>, aaron@schrab.com,
	Eric Wong <e@80x24.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 21:42:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAjMv-0001QR-4a
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 21:42:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755235AbcFHTmO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 15:42:14 -0400
Received: from zm-smtpout-1.grenet.fr ([130.190.244.97]:37756 "EHLO
	zm-smtpout-1.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753503AbcFHTmL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 15:42:11 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 0DECE2591;
	Wed,  8 Jun 2016 21:42:08 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UiNNG8K6GDYT; Wed,  8 Jun 2016 21:42:07 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id F1D00222F;
	Wed,  8 Jun 2016 21:42:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id EB3D82066;
	Wed,  8 Jun 2016 21:42:07 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b_OQEDjjSmFg; Wed,  8 Jun 2016 21:42:07 +0200 (CEST)
Received: from wificampus-030012.grenet.fr (wificampus-030012.grenet.fr [130.190.30.12])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id C63E92064;
	Wed,  8 Jun 2016 21:42:07 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
In-Reply-To: <xmqqbn3blbpc.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296846>

On 06/08/2016 09:31 PM, Junio C Hamano wrote:
> Samuel GROOT <samuel.groot@grenoble-inp.org> writes:
>
>> I think it's the best way to do it indeed. Furthermore, we did trim
>> CRs and LFs in header fields, but not in the message, making the
>> subroutine inconsistent.
>>
>> Should we rename the subroutine to `parse_header` or leave it as it is?
>
> If it lives inside git-send-email, then parse_header is sufficient
> as everybody would know it is about e-mail without being told.  If
> it is in Git.pm, then parse_email_header would be more appropriate.

It currently lives in Git.pm, following Eric Wong's advice to have a 
more packaged code.
