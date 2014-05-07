From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] merge-recursive.c: Fix case-changing merge.
Date: Wed, 7 May 2014 11:13:55 -0700
Message-ID: <20140507181355.GW9218@google.com>
References: <xmqqoazaelmi.fsf@gitster.dls.corp.google.com>
 <1399417144-24864-1-git-send-email-dturner@twopensource.com>
 <xmqqd2fpbh9b.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: dturner@twopensource.com, git@vger.kernel.org,
	David Turner <dturner@twitter.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 07 20:14:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi6M0-0002Jt-Tq
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 20:14:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751765AbaEGSN7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 14:13:59 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:56864 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751298AbaEGSN7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 14:13:59 -0400
Received: by mail-pd0-f170.google.com with SMTP id v10so1363320pde.29
        for <git@vger.kernel.org>; Wed, 07 May 2014 11:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=agd+VareGz+HPM/iQ1s//wm+I2+fkUMKSDUr4e/dWCs=;
        b=0JDeOj5MG86PWuFbaUn1BCu4tG7Lbs5U1j9H+UwSeAWIaxM5U5mscBW08zeGc0ZnoF
         NXXhsXU4YI1bGaY1ie+V7osepqcacbl6jcmQJcnmAls0P8h6srfOLihvtKQXLmOafwPa
         aaGtPHp3IF92SpNoWIJ8ZQZNKNUyswKiItpdcNsBQlRTxgnYfFPAdBNJhM9fAo8LtVT3
         4SKf4+MmfPd1NePrD5NviBtRYfeQygj5vKMQdv2G0xzNQ1Jw4mxt8s7BckwK/3oTanSc
         5bJyW74zKuTaoAKIRzmmntEpGsnnfgcw9FieXdW5ay/+zxDMjlqRhv9KhwjrpHBcJY7o
         /qyw==
X-Received: by 10.66.66.135 with SMTP id f7mr21369715pat.22.1399486438466;
        Wed, 07 May 2014 11:13:58 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id iv2sm4393644pbc.19.2014.05.07.11.13.57
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 07 May 2014 11:13:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqd2fpbh9b.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248342>

Junio C Hamano wrote:
> dturner@twopensource.com writes:

>> +	test -e testcase
>
> Please make it a habit to use "test -f" when you expect "the path
> exists as a file", not merely "something exists there I do not care
> if it is a file or a directory", for which "test -e" is perfectly
> appropriate.

Or, better in tests,

	test_path_is_file testcase

which prints an error instead of just silently failing when
the path is not a file.

Thanks,
Jonathan
