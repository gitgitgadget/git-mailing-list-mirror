From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v15 11/13] tag.c: use 'ref-filter' APIs
Date: Wed, 02 Sep 2015 09:43:40 -0700
Message-ID: <xmqqpp20ojpf.fsf@gitster.mtv.corp.google.com>
References: <1441131994-13508-1-git-send-email-Karthik.188@gmail.com>
	<1441131994-13508-12-git-send-email-Karthik.188@gmail.com>
	<xmqq8u8oq2lq.fsf@gitster.mtv.corp.google.com>
	<CAOLa=ZQXgVXSB9FqhXnc5npOrW8HVj97i0XhNeM-k-MJHR_xfw@mail.gmail.com>
	<vpq37ywol3m.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>, Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Sep 02 18:43:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXB8U-00025R-C7
	for gcvg-git-2@plane.gmane.org; Wed, 02 Sep 2015 18:43:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755417AbbIBQnm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 12:43:42 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:34451 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753356AbbIBQnm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 12:43:42 -0400
Received: by padhy1 with SMTP id hy1so17025034pad.1
        for <git@vger.kernel.org>; Wed, 02 Sep 2015 09:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=8tYQ7W0hK7st55VSQ5MCaaGAreJFKzW8V+1HI4sQoPY=;
        b=aGDAMV8iSnDAJrO7IaOotQ4Z1bdYFDDDsgKE4rKyKRPdBPf+MR7t4aMwUP/iA9f4l0
         9EA6o+fct00zkBlkagUa6pC60TT7TgErKuLd+WdtAEzvhEClIWfQOAkMCFluvTK9xUvL
         U9hYN7EBCQRWj7Zk6/Zqx9hHEHlSCkfEs1nV6IsQODgNKEvfYT1CvyhTg6bm7SNL/hWW
         M+qMzHYEyYEUbqUdfGCJeEVbfhydlz1Ah/XRvAP7BaJlg1Qf6K/MWTDrJyeUc4OO2wKW
         w1Btp0RV28MiU5UP1mqSB50DekvBRJ61Sie2wv3BE09EaoOJK78KF1ewnBWJYGBGw/Y6
         WREw==
X-Received: by 10.68.69.108 with SMTP id d12mr58682363pbu.24.1441212221694;
        Wed, 02 Sep 2015 09:43:41 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:2414:9e5f:bc96:1638])
        by smtp.gmail.com with ESMTPSA id yt2sm7136233pbb.84.2015.09.02.09.43.40
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 02 Sep 2015 09:43:40 -0700 (PDT)
In-Reply-To: <vpq37ywol3m.fsf@anie.imag.fr> (Matthieu Moy's message of "Wed,
	02 Sep 2015 18:13:33 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277107>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> I actually found the other more readable, as it reads "display the
> refname aligned on 15 columns, and then a space",

FWIW, I too find the "15-col followed by a space" easier to
understand.  I was merely being curious when/why Karthik changed
preference, not objecting to the actual choice.
