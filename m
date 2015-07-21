From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Question: .idx without .pack causes performance issues?
Date: Tue, 21 Jul 2015 13:48:15 -0700
Message-ID: <xmqqtwsxtey8.fsf@gitster.dls.corp.google.com>
References: <CAEtYS8QWCg5_DtrJw-e+c50vcG0OpciR6LWon-3GgyngGn+0pQ@mail.gmail.com>
	<xmqq4mkxwd77.fsf@gitster.dls.corp.google.com>
	<xmqqzj2puxu2.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>
To: Doug Kelly <dougk.ff7@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 21 22:48:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHeSg-0008KC-4S
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jul 2015 22:48:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246AbbGUUsU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2015 16:48:20 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33979 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752110AbbGUUsS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2015 16:48:18 -0400
Received: by pacan13 with SMTP id an13so127208767pac.1
        for <git@vger.kernel.org>; Tue, 21 Jul 2015 13:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=umviZN4ed1ftafgGQmBfmd6Gqs/8BICo5hc4dpdMOEY=;
        b=R1QOfB17iAeTVaaY/GjQCJ8uCAYGK/lpdWKVMFcsXVQOBdygt9bcA/LsrahuVxhZ5V
         GVe2dpasVdtEmlmbkc8kNTtaZl757xOEjvLh7S3U8EndMTg3B0MbPUALUdRK2oWPT+pD
         6QoN2SIimU3T0mI9zlVrSTZZRBurp74R/5BrpcwQ6by2siWt+36/5mDerCJ8KWtX1hjx
         rV+0YWxRYDGJ/37gtQEvO/hCHdKew8XFIDZVpzhqXi8cKQTrDS6R2aPR6sDeZoCVTtI0
         y8qfHo3Y3lelaj6aDaA+D3MkDhe2U8NQVIEXY8NNyGIJSjKOETBd99bRkFe6bOC5G9hM
         0o8w==
X-Received: by 10.70.136.196 with SMTP id qc4mr77576134pdb.150.1437511697441;
        Tue, 21 Jul 2015 13:48:17 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3977:fdee:723a:a723])
        by smtp.gmail.com with ESMTPSA id j4sm29109641pdo.62.2015.07.21.13.48.15
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 21 Jul 2015 13:48:16 -0700 (PDT)
In-Reply-To: <xmqqzj2puxu2.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 21 Jul 2015 12:15:01 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274416>

Junio C Hamano <gitster@pobox.com> writes:

> While I still think that it is more important to prevent such a
> situation from occurring in the first place, ignoring .idx that lack
> corresponding .pack should be fairly simple, perhaps like this.
> ...

Sorry for the noise, but this patch is worthless.  We already have
an equivalent test in add_packed_git() that is called from this same
place.
