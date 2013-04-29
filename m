From: Yann Hodique <yann.hodique@gmail.com>
Subject: Re: consistency problem on ZFS
Date: Mon, 29 Apr 2013 18:55:52 +0100
Message-ID: <m2haip6x1z.fsf@jarvis.hodique.info>
References: <m2bo8yxyg2.fsf@jarvis.hodique.info>
	<7vk3nmpcgn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 29 19:56:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWsIz-0007NK-MA
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 19:56:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758874Ab3D2Rz5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 13:55:57 -0400
Received: from mail-we0-f176.google.com ([74.125.82.176]:60572 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758854Ab3D2Rz4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 13:55:56 -0400
Received: by mail-we0-f176.google.com with SMTP id s10so5464126wey.21
        for <git@vger.kernel.org>; Mon, 29 Apr 2013 10:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:in-reply-to:references:user-agent
         :face:date:message-id:mime-version:content-type;
        bh=1cGQj6pJL+yvmvDlZ65wQS2fH3pBBoVXfNk4+y4YtZU=;
        b=Blgv97TKtWK84wS721duU/uUttgejHqQb4gMknuDjUZbryDpVvqbzQDaSLFLgrrB30
         42yEJUDCIQWUAZYkGUEuIt3qDFiPIYxXtAckv+oPXuAn6+6fVrsL9EaoH4NbgWksSslp
         aploZivnuHNU5PGJ8P5F1iWaBD0n/H5YX0gXTEQsqg/P2jp7hztKLoiGAbUMUmQ13Ymp
         Sey+1oczvHR5wPuVIedb4F4kwQCnafYAjDXacOVzOMx75rqTgNkPTmez0w7gv5rjHb5h
         10whp0XzldKmGNCEmWKB1mH71TWhG9fZXZ3fi2iladdSAASMSNskyXzCA3juLjCH38D/
         GiOg==
X-Received: by 10.180.211.50 with SMTP id mz18mr19485655wic.24.1367258155495;
        Mon, 29 Apr 2013 10:55:55 -0700 (PDT)
Received: from jarvis.hodique.info.bromium.com (cpc25-cmbg15-2-0-cust4.5-4.cable.virginmedia.com. [86.27.183.5])
        by mx.google.com with ESMTPSA id fp2sm21621872wib.7.2013.04.29.10.55.53
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 29 Apr 2013 10:55:54 -0700 (PDT)
In-Reply-To: <7vk3nmpcgn.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 28 Apr 2013 14:33:28 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (darwin)
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAAXNSR0IArs4c6QAAACpQTFRF
 HBgXPyYdPSkeMiwmRkJBYT4sik8zZF1XqWpMx2RDk42MzYRYtrGw09DVySZyaAAAAklJREFUOMuF
 0z9v00AUAPCHr/kANgowOi6hjFbOCImp1CdF6kaUCwEmkBJSdYmUSBZRGRMsske1MlKIFKVr5XAr
 U1TPSFX6XXjvnKp2KOLG97v3x3dnuP7Hgv/B+vLyLlivZkGwSP6GlXABvHmyDese0GIn2zBzNYCX
 bEGagOswycG6ewMsyMEVVTJMiyQHv2lzuTOSNrDPWfhF8FSpuGXt5IB6s6bCNfLOt8FoEMT1JAv7
 wFz25E7gtqFLqS856IJhl481/MyN27tnGe+wc1uprzn4fvS+MFYxwvDtLcyT1Y9oUhyri3ZHtTIg
 B7NP0WmDMo7VcJABKRvRtKNbq3hxC21ZKx2pMAWVgQt5H95MNSynKnMfZTzTQkSwjKLpPAN1H+CB
 zogmYaa5ED7eUzMeY+tw9HqRAcEBnoUhxYfFQZIBelRNhGjSKj6cb14kBH3hY5dCGI+XpzXTebzJ
 gY+CC47FHiGENQdXVfeBuvA55y5eYRgOnTJRdXC+6eFTiiHbHyplKVGoHGDQw1okzi5BCcUbXANn
 KL4WYAeyZJomJu0l4ALKZvlCvkrBOaG3dhOvdtlLjJt6AP2UN3DosoppOhr20v+Cwq4ncE8JwaLB
 gJpyPa/n0mQIJn0m0EExTHE5HgxUHAvnsjT41ARTnu8juAaUML5bSQHn8vkLBGYDUCkLS+tD577H
 qwjcpl8Le+BmIWgnHkrgws5BCvjTMbpaAsHPcK6+jXNhLfqGQND4XHhn4Ik5T8HCzKu+Bk98qwq+
 6AFOimPZ8Aem5xXrk2gG/wAAAABJRU5ErkJggg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222828>

>>>>> "Junio" == Junio C Hamano <gitster@pobox.com> writes:

> Yann Hodique <yann.hodique@gmail.com> writes:
>> $ git checkout next; git diff-files; git checkout next; git diff-files
>> Already on 'next'
>> :100644 100644 bd774cccaa14e061c3c26996567ee28f4f77ec80 0000000000000000000000000000000000000000 M	magit.el
>> Already on 'next'
>> $

> If you run "git update-index --refresh" between the first "checkout"
> and "diff-files", do you still see the issue?

Yes, although *way* less often. I just ran a quick experiment and have
seen the issue 2 times in 2500 tries.

Thanks,

Yann.

-- 
There exists no separation between gods and men:
one blends softly casual into the other.

  -- Proverbs of Muad'dib
