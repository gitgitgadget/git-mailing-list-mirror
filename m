From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH v4 5/5] git-submodule summary: test
Date: Tue, 11 Mar 2008 09:57:27 +0800
Message-ID: <46dff0320803101857t435ec42g93c3605ec64d710a@mail.gmail.com>
References: <1205171657-16216-1-git-send-email-pkufranky@gmail.com>
	 <1205171657-16216-2-git-send-email-pkufranky@gmail.com>
	 <1205171657-16216-3-git-send-email-pkufranky@gmail.com>
	 <1205171657-16216-4-git-send-email-pkufranky@gmail.com>
	 <1205171657-16216-5-git-send-email-pkufranky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Ping Yin" <pkufranky@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Mar 11 02:58:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYtkk-0007Jk-Qt
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 02:58:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751544AbYCKB53 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2008 21:57:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751543AbYCKB53
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 21:57:29 -0400
Received: from an-out-0708.google.com ([209.85.132.250]:22932 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751028AbYCKB52 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2008 21:57:28 -0400
Received: by an-out-0708.google.com with SMTP id d31so527254and.103
        for <git@vger.kernel.org>; Mon, 10 Mar 2008 18:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=lA4MlgpcmFFwM9DHOhlvqKmLcUqCzCy8u4bm61ZqHyQ=;
        b=GRMRPxI29mBpv5a6B3lUO/rk7v/vxb7GNrzKAm7PPMp6YvOCC01b8aXq75eZitzGdEqkbe6qLizPSMy2NI7Ej2t4cnnhA+nx7TIxP6irjZaP/WMVbDlhgwwJUdXDnQpmiWMbQXiQJ4U2PLN42G/zq0hOCBBYZcsBoQR1XahHoEY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Dqn4AtELuSYimQv1Ev6krNDfHl36QoPOsOgjCx3yxxdOJ+g+hOFzk4asRIg1vDJC7lM6qPDg4T6PnVABUPrXsC4wfAs/uI9dU7ranermsj9UR2xRew60LandQhvaSWNmwDlITi2A8qFN4h9CLCwiiZNQ6YKK32kLBW4osu+qmrc=
Received: by 10.100.6.13 with SMTP id 13mr12157787anf.16.1205200647597;
        Mon, 10 Mar 2008 18:57:27 -0700 (PDT)
Received: by 10.100.5.18 with HTTP; Mon, 10 Mar 2008 18:57:27 -0700 (PDT)
In-Reply-To: <1205171657-16216-5-git-send-email-pkufranky@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76783>

On Tue, Mar 11, 2008 at 1:54 AM, Ping Yin <pkufranky@gmail.com> wrote:
> Signed-off-by: Ping Yin <pkufranky@gmail.com>
>  ---
>   t/t7401-submodule-summary.sh |  194 ++++++++++++++++++++++++++++++++++++++++++
>  +
>  +sleep 1s
>  +head4=$(add_file sm1 foo4 foo5) &&
>  +head4_full=$(GIT_DIR=sm1/.git git rev-parse --verify HEAD)
>  +test_expect_success 'modified submodule(backward and forward)' "
>  +    git submodule summary >actual &&
>  +    diff actual - <<-EOF
>  +* sm1 $head2...$head4 (4):
>  +  > Add foo5
>  +  > Add foo4
>  +  < Add foo3
>  +  < Add foo2
>  +
>  +EOF
>  +"

'sleep 1s' is used to just make sure the summary result just has the
same commit order as i expected (the order is undefined if not using
this because the commit time are all the same).

However, it seems ugly. I will resend this patch later by using result
from 'git log --pretty=format' as the expected result.
>  +



-- 
Ping Yin
