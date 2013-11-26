From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Git issues with submodules
Date: Tue, 26 Nov 2013 11:51:26 -0800
Message-ID: <20131126195126.GC4212@google.com>
References: <CALkWK0muxsRUtO6KYk5G3=RVN0nqd=8gOZn=jsNbTc4B9KCATQ@mail.gmail.com>
 <528FC638.5060403@web.de>
 <20131122215454.GA4952@sandbox-ub>
 <20131122220953.GI4212@google.com>
 <52910BC4.1030800@web.de>
 <20131124005256.GA3500@sandbox-ub>
 <52922962.3090407@web.de>
 <xmqq1u24xkjq.fsf@gitster.dls.corp.google.com>
 <5294EC11.2010405@web.de>
 <xmqq1u23vty1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sergey Sharybin <sergey.vfx@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 26 20:51:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VlOfX-0000mc-1h
	for gcvg-git-2@plane.gmane.org; Tue, 26 Nov 2013 20:51:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382Ab3KZTvb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Nov 2013 14:51:31 -0500
Received: from mail-yh0-f42.google.com ([209.85.213.42]:36280 "EHLO
	mail-yh0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753617Ab3KZTva (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Nov 2013 14:51:30 -0500
Received: by mail-yh0-f42.google.com with SMTP id z6so4344308yhz.1
        for <git@vger.kernel.org>; Tue, 26 Nov 2013 11:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=qX11vp+Elgz2cM2/PfT9yeAim4arfYTW2cHTM0zi4cY=;
        b=BWpqdOXUPVLEnLVsXbYXQNdOEAnfzQE+ogMtAbtdqhgZcpr/uS2kVC605coUNO51VH
         /8Xgdr5968zAYvf2dxSwL+ctUQpL7vf1PksjjwzTYrDRIOCzEveVu+5nk8JP1gAPZAWR
         5qxJN3knd6k9HWftqkmtbSWAAeIYEIZzRNRnRYEcZkH+qwWJa921K0ORP+S91JDJa5hP
         LNyJmEY3RVzAwdd3G8Rm2HK/8GeII0m14PlyQjo35BHLM/RNBEBLS7xoatNqYvU61Si8
         z4LQLxdwQpuRG1f+CCg2RPWaCYI6fSER2Ky2ozl2fmiZBoUbv+PJoKe+WUDrY9eWFkau
         FsgA==
X-Received: by 10.236.58.233 with SMTP id q69mr809190yhc.176.1385495489446;
        Tue, 26 Nov 2013 11:51:29 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id m68sm14643062yhj.22.2013.11.26.11.51.28
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 26 Nov 2013 11:51:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <xmqq1u23vty1.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238392>

Junio C Hamano wrote:

>                                          I have a feeling that the
> current "not copy to fix it to a stable value, but look into
> .gitmodules as a fallback" was not a designed behaviour for the
> other properties, but was done by accident and/or laziness.

It was designed.  See for example the thread surrounding [1]:

| And when you are on a superproject branch actively developing inside a
| submodule, you may want to increase fetch-activity to fetch all new
| commits in the submodule even if they aren't referenced in the
| superproject (yet), as that might be just what your fellow developers
| are about to do. And the person setting up that branch could do that
| once for all users so they don't have to repeat it in every clone. And
| when switching away from that branch all those developers cannot forget
| to reconfigure to fetch-on-demand, so not having that in .git/config is
| a plus here too.

Thanks,
Jonathan

[1] http://thread.gmane.org/gmane.comp.version-control.git/161193/focus=161357
