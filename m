From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 1/8] config: Trivial rename in preparation for 
	parseopt.
Date: Tue, 17 Feb 2009 15:59:28 +0200
Message-ID: <94a0d4530902170559r74d0b9acyea9be124ece0adeb@mail.gmail.com>
References: <1234832094-15541-1-git-send-email-felipe.contreras@gmail.com>
	 <7v3aedet0j.fsf@gitster.siamese.dyndns.org>
	 <94a0d4530902161842s1d1d9fech3786cce1f1a1135d@mail.gmail.com>
	 <alpine.DEB.1.00.0902171300450.6185@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Gerrit Pape <pape@smarden.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 17 15:01:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZQVi-0004OQ-14
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 15:01:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbZBQN7b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 08:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752869AbZBQN7b
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 08:59:31 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:30776 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751255AbZBQN7a (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 08:59:30 -0500
Received: by fg-out-1718.google.com with SMTP id 16so420698fgg.17
        for <git@vger.kernel.org>; Tue, 17 Feb 2009 05:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=5xhtAEzBIKatRv1HWxxUMunQm1v2KAh6bVDoqs5rkdg=;
        b=lAAFieGYUsohzfzy3CiNoCQrY+qpr/MHuyxHsvKh3ZffvbJDoT+RSMw01v5TKy8U26
         yw1SGED+ffWNGo2cQ9Xn5ToFlp1J5HTdjhaQ6OHAAUo9kp2XVmDhgQDuCRHhqg8LMJnA
         LGAWzLaFQjfFYI/huXVnvo7jR/W9DZ4qPH6OY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=j7ds1/JyY1MIdJv3PZN+tcN45FuryN9bWv60Qid577Kz9ftRvvI8XhL5pSL/J/mjZM
         Tr4z1zs128lq1wyRDmHMQzVACN+5teLv3VhLKMMywKXgQ4mYSFyB9IxfCC5iCPX7Tj8i
         9MQRj0oxD4v3DvLkNfEKiEaxN7FcC8u7p0Lms=
Received: by 10.86.77.5 with SMTP id z5mr2071081fga.63.1234879168652; Tue, 17 
	Feb 2009 05:59:28 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0902171300450.6185@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110382>

On Tue, Feb 17, 2009 at 2:01 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Tue, 17 Feb 2009, Felipe Contreras wrote:
>
>>         free(repo_config);
>> +       if (found == 0)
>> +               error("no config file found");
>>         return ret;
>
> Err, you mean "return error(..)"?
>
> But it might be not an error at all: think of "cd / && git ls-remote $URL"
> without /etc/gitconfig nor $HOME/.gitconfig.

Yeah, I thought about that when doing the patch. I've removed the
error(), now it will only return -1. Almost nobody is checking the
return code anyways.

-- 
Felipe Contreras
