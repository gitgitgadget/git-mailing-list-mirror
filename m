From: Samuel GROOT <samuel.groot@grenoble-inp.org>
Subject: Re: [PATCH v4 3/6] send-email: shorten send-email's output
Date: Tue, 14 Jun 2016 00:19:16 +0200
Message-ID: <9f16b48f-3f74-d408-8309-3072904f43b7@grenoble-inp.org>
References: <20160607140148.23242-1-tom.russello@grenoble-inp.org>
 <20160608130142.29879-1-samuel.groot@grenoble-inp.org>
 <20160608130142.29879-4-samuel.groot@grenoble-inp.org>
 <vpqr3c6x4vz.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, tom.russello@grenoble-inp.org,
	erwan.mathoniere@grenoble-inp.org, jordan.de-gea@grenoble-inp.org,
	gitster@pobox.com, aaron@schrab.com, e@80x24.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 14 00:19:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCaCa-0002tk-0c
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 00:19:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422674AbcFMWTU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 18:19:20 -0400
Received: from zm-smtpout-1.grenet.fr ([130.190.244.97]:56683 "EHLO
	zm-smtpout-1.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161258AbcFMWTT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 18:19:19 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id A063C25BE;
	Tue, 14 Jun 2016 00:19:17 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f0kXXvnH2qYO; Tue, 14 Jun 2016 00:19:17 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 8F71625A0;
	Tue, 14 Jun 2016 00:19:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 8C7B12066;
	Tue, 14 Jun 2016 00:19:17 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9odXpmEk5PAz; Tue, 14 Jun 2016 00:19:17 +0200 (CEST)
Received: from localhost.localdomain (che44-2-88-185-231-114.fbx.proxad.net [88.185.231.114])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 939AC2064;
	Tue, 14 Jun 2016 00:19:16 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
In-Reply-To: <vpqr3c6x4vz.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297252>

On 06/09/2016 08:17 AM, Matthieu Moy wrote:
> Samuel GROOT <samuel.groot@grenoble-inp.org> writes:
>
>> @@ -647,10 +647,10 @@ test_expect_success $PREREQ '--suppress-cc=all' '
>>  test_expect_success $PREREQ 'setup expect' "
>>  cat >expected-suppress-body <<\EOF
>>  0001-Second.patch
>> -(mbox) Adding cc: A <author@example.com> from line 'From: A <author@example.com>'
>> -(mbox) Adding cc: One <one@example.com> from line 'Cc: One <one@example.com>, two@example.com'
>> -(mbox) Adding cc: two@example.com from line 'Cc: One <one@example.com>, two@example.com'
>> -(cc-cmd) Adding cc: cc-cmd@example.com from: './cccmd'
>> +Adding cc: A <author@example.com> from From: header
>> +Adding cc: One <one@example.com> from Cc: header
>> +Adding cc: two@example.com from Cc: header
>> +Adding cc: cc-cmd@example.com from: './cccmd'
>
> This hunk differs from the others a bit. I totally agree that removing
> the (mbox) prefix makes sense, but you're removing (cc-cmd) here, which
> did carry some information.
>
> I'd write it as
>
> Adding cc: cc-cmd@example.com from --cc-cmd: ./cccmd

Indeed it's clearer, I will change that.

> It might make sense to split this into two patches: one for (mbox) +
> headers and one for (cc-cmd) and (to-cmd). Spotting special-cases like
> the above inside a long patch is hard for reviewers.

I will split in the future patch series dedicated to clean send-email.
